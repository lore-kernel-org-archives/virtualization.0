From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 14 Nov 2008 11:05:25 -0500
Message-ID: <20081114160525.GE24624__20166.4401604377$1226678965$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>
	<20081113.180558.519459540419535699.ryov@valinux.co.jp>
	<20081113155834.GE7542@redhat.com>
	<af41c7c40811131041t1b8491b6la5574ebe75f89000@mail.gmail.com>
	<20081113214642.GG7542@redhat.com>
	<af41c7c40811131457w472e4a86tb5344cc1d3d366fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <af41c7c40811131457w472e4a86tb5344cc1d3d366fb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Divyesh Shah <dpshah@google.com>
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, Fabio Checconi <fchecconi@gmail.com>, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, Nauman Rafique <nauman@google.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 13, 2008 at 02:57:29PM -0800, Divyesh Shah wrote:

[..]
> > > > Ryo, do you still want to stick to two level scheduling? Given the problem
> > > > of it breaking down underlying scheduler's assumptions, probably it makes
> > > > more sense to the IO control at each individual IO scheduler.
> > >
> > > Vivek,
> > >      I agree with you that 2 layer scheduler *might* invalidate some
> > > IO scheduler assumptions (though some testing might help here to
> > > confirm that). However, one big concern I have with proportional
> > > division at the IO scheduler level is that there is no means of doing
> > > admission control at the request queue for the device. What we need is
> > > request queue partitioning per cgroup.
> > >     Consider that I want to divide my disk's bandwidth among 3
> > > cgroups(A, B and C) equally. But say some tasks in the cgroup A flood
> > > the disk with IO requests and completely use up all of the requests in
> > > the rq resulting in the following IOs to be blocked on a slot getting
> > > empty in the rq thus affecting their overall latency. One might argue
> > > that over the long term though we'll get equal bandwidth division
> > > between these cgroups. But now consider that cgroup A has tasks that
> > > always storm the disk with large number of IOs which can be a problem
> > > for other cgroups.
> > >     This actually becomes an even larger problem when we want to
> > > support high priority requests as they may get blocked behind other
> > > lower priority requests which have used up all the available requests
> > > in the rq. With request queue division we can achieve this easily by
> > > having tasks requiring high priority IO belong to a different cgroup.
> > > dm-ioband and any other 2-level scheduler can do this easily.
> > >
> >
> > Hi Divyesh,
> >
> > I understand that request descriptors can be a bottleneck here. But that
> > should be an issue even today with CFQ where a low priority process
> > consume lots of request descriptors and prevent higher priority process
> > from submitting the request.
> 
> Yes that is true and that is one of the main reasons why I would lean
> towards 2-level scheduler coz you get request queue division as well.
> 
>  I think you already said it and I just
> > reiterated it.
> >
> > I think in that case we need to do something about request descriptor
> > allocation instead of relying on 2nd level of IO scheduler.
> > At this point I am not sure what to do. May be we can take feedback from the
> > respective queue (like cfqq) of submitting application and if it is already
> > backlogged beyond a certain limit, then we can put that application to sleep
> > and stop it from consuming excessive amount of request descriptors
> > (despite the fact that we have free request descriptors).
> 
> This should be done per-cgroup rather than per-process.
> 

Yep, per cgroup limit will make more sense. get_request() already calls
elv_may_queue() to get a feedback from IO scheduler. May be here IO
scheduler can make a decision how many request descriptors are already
allocated to this cgroup. And if the queue is congested, then IO scheduler
can deny the fresh request allocation.

Thanks
Vivek
