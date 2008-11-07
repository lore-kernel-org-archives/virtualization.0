From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 1/4] io controller: documentation
Date: Fri, 7 Nov 2008 11:32:09 +0900
Message-ID: <20081107113209.a6011c67.kamezawa.hiroyu__5902.6958806955$1226025395$gmane$org@jp.fujitsu.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.743458085@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106153135.743458085@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vgoyal@redhat.com
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Hirokazu@smtp1.linux-foundation.org, containers@lists.linux-foundation.org, balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, Andrea@smtp1.linux-foundation.org, ngupta@google.com, fernando@oss.ntt.co.jp, Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 06 Nov 2008 10:30:23 -0500
vgoyal@redhat.com wrote:
> +ISSUES
> +======
> +- IO controller can buffer the bios if suffcient tokens were not available
> +  at the time of bio submission. Once the tokens are available, these bios
> +  are dispatched to elevator/lower layers in first come first serve manner.
> +  And this has potential to break CFQ where a RT tasks should be able to
> +  dispatch the bio first or a high priority task should be able to release
> +  more bio as compared to low priority task in same cgroup.
> +
> +  Not sure how to fix it. May be we need to maintain another rb-tree and
> +  keep track of RT tasks and tasks priorities and dispatch accordingly. This
> +  is equivalent of duplicating lots of CFQ logic and not sure how would it
> +  impact AS behaviour.
> 
Why you don't isolate RT tasks into other cgroup ?
   /cgroup/bio-cgroup/group_for_usual/...usual tasks.
                     /group_for_RT/ ...RT tasks. you can use high-speed path.

How about adding RT flag to bio-cgroup and skip buffering at bio-cgroup if RT
flag is set ? I think handling an usual process and RT process in "a" cgroup
just makes the code complex.

Looking into a cpu-scheduler, which is the first module handling RT, it has
some tweaks to handle RT in the system.
 - special RT scheduler.
 - isolated RT domain
 - maximum execution time allowed to RT
 ....

Maybe handling RT in following way is usual way...(if we do something in this layer)

  - Allow RT-bio-cgroup to skip limit check.
  - But RT-bio-cgroup calculates io-throuput, execution time, statistics...
  - When RT tasks in RT-bio-cgroup does excessive I/O which starves the whole system
    too long, raise safeguard-limitter. and tell users Warning or kill it.

Hmm ?

Thanks,
-Kame
