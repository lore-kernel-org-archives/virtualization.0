From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: RFC: Attaching threads to cgroups is OK?
Date: Wed, 20 Aug 2008 16:41:56 +0900 (JST)
Message-ID: <20080820.164156.102927127.taka__22584.3162778348$1219218265$gmane$org@valinux.co.jp>
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
To: yoshikawa.takuya@oss.ntt.co.jp
Cc: containers@lists.linux-foundation.org, =?iso-8859-1?Q?Fernando=5FLuis=5FV=E1@smtp1.linux-foundation.org?=, fernando@oss.ntt.co.jp, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> Hi everyone,
> 
> I have a question about cgroup's policy concerning the treatment of 
> threads. Please consider that we want to attach an application which has 
> some threads already to a certain cgroup. If we echo the pid of this 
> application to the "tasks" file connected to this cgroup the threads 
> belonging to this application will NOT be moved to the new group. Is it 
> right? If so, is it OK?
> 
> I mean, in the current implementation, threads created before the 
> attachement of the parent process are not treated eaqually to those 
> created after.
> 
> Could you tell me if you know something about the rules of attachement 
> of pid, or tid, to cgroups? -- what ID is OK to write to "tasks" file 
> and what we can expect as a result?

FYI, it won't happen anything in case you just move a process or thread
since the current implementation of the memory controller haven't 
supported this feature yet.

This restriction won't be removed unless we make pages be able to move
between cgroups.

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
> Thanks,
> -- Takuya Yoshikawa

Thank you,
Hirokazu Takahashi.
