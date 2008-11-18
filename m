From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Tue, 18 Nov 2008 09:07:51 -0500
Message-ID: <20081118140751.GA4283__46532.3335993618$1227017842$gmane$org@redhat.com>
References: <20081113155834.GE7542@redhat.com>
	<af41c7c40811131041t1b8491b6la5574ebe75f89000@mail.gmail.com>
	<20081113214642.GG7542@redhat.com>
	<af41c7c40811131457w472e4a86tb5344cc1d3d366fb@mail.gmail.com>
	<20081114160525.GE24624@redhat.com>
	<e98e18940811141444u5947b806v27fac453ed1e8a5@mail.gmail.com>
	<20081117142309.GA15564@redhat.com>
	<4922224A.5030502@cn.fujitsu.com>
	<e98e18940811172101na345b6bh5c73f9e657aac5a7@mail.gmail.com>
	<20081118120508.GD15268@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081118120508.GD15268@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fabio Checconi <fchecconi@gmail.com>
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, jens.axboe@oracle.com, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, Divyesh Shah <dpshah@google.com>, Nauman Rafique <nauman@google.com>, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 18, 2008 at 01:05:08PM +0100, Fabio Checconi wrote:
> Hi,
> 
> > From: Nauman Rafique <nauman@google.com>
> > Date: Mon, Nov 17, 2008 09:01:48PM -0800
> >
> > If we start with bfq patches, this is how plan would look like:
> > 
> > 1 Start with BFQ take 2.
> > 2 Do the following to support proportional division:
> >  a) Expose the per device weight interface to user, instead of calculating
> >  from priority.
> >  b) Add support for disk time budgets, besides sector budget that is currently
> >  available (configurable option). (Fabio: Do you think we can just emulate
> > that using the existing code?). Another approach would be to give time slices
> > just like CFQ (discussing?)
> 
>   it should be possible without altering the code.  The slices can be
> assigned in the time domain using big values for max_budget.  The logic
> is: each process is assigned a budget (in the range [max_budget/2, max_budget],
> choosen from the feedback mechanism, driven in __bfq_bfqq_recalc_budget()),
> and if it does not complete it in timeout_sync milliseconds, it is
> charged a fixed amount of sectors of service.
> 
> Using big values for max_budget (where big means greater than two
> times the number of sectors the hard drive can transfer in timeout_sync
> milliseconds) makes the budgets always to time out, so the disk time
> is scheduled in slices of timeout_sync.
> 
> However this is just a temporary workaround to do some basic testing.
> 
> Modifying the scheduler to support time slices instead of sector
> budgets would indeed simplify the code; I think that the drawback
> would be being too unfair in the service domain.  Of course we
> have to consider how much is important to be fair in the service
> domain, and how much added complexity/new code can we accept for it.
> 
> [ Better service domain fairness is one of the main reasons why
>   we started working on bfq, so, talking for me and Paolo it _is_
>   important :) ]
> 
> I have to think a little bit on how it would be possible to support
> an option for time-only budgets, coexisting with the current behavior,
> but I think it can be done.
> 

IIUC, bfq and cfq are different in following manner.

a. BFQ employs WF2Q+ for fairness and CFQ employes weighted round robin.
b. BFQ uses the budget (sector count) as notion of service and CFQ uses
   time slices.
c. BFQ supports hierarchical fair queuing and CFQ does not.  

We are looking forward for implementation of point C. Fabio seems to
thinking of supporting time slice as a service (B). It seems like
convergence of CFQ and BFQ except the point A (WF2Q+ vs weighted round
robin). 

It looks like WF2Q+ provides tighter service bound and bfq guys mention
that they have been able to ensure throughput while ensuring tighter 
bounds. If that's the case, does that mean BFQ is a replacement for CFQ
down the line?
  
Thanks
Vivek
