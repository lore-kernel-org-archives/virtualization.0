From: Fabio Checconi <fchecconi@gmail.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Tue, 18 Nov 2008 15:41:39 +0100
Message-ID: <20081118144139.GE15268__4520.59042077071$1227019244$gmane$org@gandalf.sssup.it>
References: <af41c7c40811131041t1b8491b6la5574ebe75f89000@mail.gmail.com>
	<20081113214642.GG7542@redhat.com>
	<af41c7c40811131457w472e4a86tb5344cc1d3d366fb@mail.gmail.com>
	<20081114160525.GE24624@redhat.com>
	<e98e18940811141444u5947b806v27fac453ed1e8a5@mail.gmail.com>
	<20081117142309.GA15564@redhat.com>
	<4922224A.5030502@cn.fujitsu.com>
	<e98e18940811172101na345b6bh5c73f9e657aac5a7@mail.gmail.com>
	<20081118120508.GD15268@gandalf.sssup.it>
	<20081118140751.GA4283@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081118140751.GA4283@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, jens.axboe@oracle.com, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, Divyesh Shah <dpshah@google.com>, Nauman Rafique <nauman@google.com>, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

> From: Vivek Goyal <vgoyal@redhat.com>
> Date: Tue, Nov 18, 2008 09:07:51AM -0500
>
> On Tue, Nov 18, 2008 at 01:05:08PM +0100, Fabio Checconi wrote:
...
> > I have to think a little bit on how it would be possible to support
> > an option for time-only budgets, coexisting with the current behavior,
> > but I think it can be done.
> > 
> 
> IIUC, bfq and cfq are different in following manner.
> 
> a. BFQ employs WF2Q+ for fairness and CFQ employes weighted round robin.
> b. BFQ uses the budget (sector count) as notion of service and CFQ uses
>    time slices.
> c. BFQ supports hierarchical fair queuing and CFQ does not.  
> 
> We are looking forward for implementation of point C. Fabio seems to
> thinking of supporting time slice as a service (B). It seems like
> convergence of CFQ and BFQ except the point A (WF2Q+ vs weighted round
> robin). 
> 
> It looks like WF2Q+ provides tighter service bound and bfq guys mention
> that they have been able to ensure throughput while ensuring tighter 
> bounds. If that's the case, does that mean BFQ is a replacement for CFQ
> down the line?
>   

BFQ started from CFQ, extending it in the way you correctly describe,
so it is indeed very similar.  There are also some minor changes to
locking, cic handling, hw_tag detection and to the CIC_SEEKY heuristic.

The two schedulers share similar goals, and in my opinion BFQ can be
considered, in the long term, a CFQ replacement; *but* before talking
about replacing CFQ we have to consider that:

  - it *needs* review and testing; we've done our best, but for sure
    it's not enough; review and testing are never enough;
  - the service domain fairness, which was one of our objectives, requires
    some extra complexity; the mechanisms we used and the design choices
    we've made may not fit all the needs, or may not be as generic as the
    simpler CFQ's ones;
  - CFQ has years of history behind and has been tuned for a wider
    variety of environments than the ones we've been able to test.

If time-based fairness is considered more robust and the loss of
service-domain fairness is not a problem, then the two schedulers can
be made even more similar.
