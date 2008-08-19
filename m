From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: RFC: Attaching threads to cgroups is OK?
Date: Tue, 19 Aug 2008 20:22:37 +0900
Message-ID: <20080819202237.edd75933.kamezawa.hiroyu__31821.1022801281$1219144804$gmane$org@jp.fujitsu.com>
References: <48AAA296.8050802@oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48AAA296.8050802@oss.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Cc: "menage@google.com" <menage@google.com>, containers@lists.linux-foundation.org, "balbir@linux.vnet.ibm.com" <balbir@linux.vnet.ibm.com>, fernando@oss.ntt.co.jp, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 19 Aug 2008 19:38:14 +0900
Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp> wrote:

> Hi everyone,
> 
> I have a question about cgroup's policy concerning the treatment of 
> threads. Please consider that we want to attach an application which has 
> some threads already to a certain cgroup. If we echo the pid of this 
> application to the "tasks" file connected to this cgroup the threads 
> belonging to this application will NOT be moved to the new group. Is it 
> right? If so, is it OK?
> 
Added Paul and Balbir to CC:.

I think it is OK ...means it works as designed
(now, see below about future.)

> I mean, in the current implementation, threads created before the 
> attachement of the parent process are not treated eaqually to those 
> created after.
> 
> Could you tell me if you know something about the rules of attachement 
> of pid, or tid, to cgroups? -- what ID is OK to write to "tasks" file 
> and what we can expect as a result?
> 

Any PID is ok for "tasks". IIRC, Paul proposed "procs" file, which support
moving all threads of the same PIDs.
This mail from Paul explains some : http://lwn.net/Articles/289930/


> 
> Tsuruta-san, how about your bio-cgroup's tracking concerning this?
> If we want to use your tracking functions for each threads seperately, 
> there seems to be a problem.
> ===cf. mm_get_bio_cgroup()===================
>            owner
> mm_struct ----> task_struct ----> bio_cgroup
> =============================================
> In my understanding, the mm_struct of a thread is same as its parent's.
> So, even if we attach the TIDs of some threads to different cgroups the 
> tracking always returns the same bio_cgroup -- its parent's group.
> Do you have some policy about in which case we can use your tracking?
> 
It's will be resitriction when io-controller reuse information of the owner
of memory. But if it's very clear who issues I/O (by tracking read/write
syscall), we may have chance to record the issuer of I/O to page_cgroup
struct. 

Thanks,
-Kame


> Thanks,
> -- Takuya Yoshikawa
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/containers
> 
