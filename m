From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] [PATCH] mm,oom: Offload OOM notify callback to a kernel
	thread.
Date: Mon, 2 Oct 2017 13:50:35 +0200
Message-ID: <20171002115035.7sph6ul6hsszdwa4__12749.5966539302$1506945045$gmane$org@dhcp22.suse.cz>
References: <20170929065654-mutt-send-email-mst@kernel.org>
	<201709291344.FID60965.VHtMQFFJFSLOOO@I-love.SAKURA.ne.jp>
	<201710011444.IBD05725.VJSFHOOMOFtLQF@I-love.SAKURA.ne.jp>
	<20171002065801-mutt-send-email-mst@kernel.org>
	<20171002090627.547gkmzvutrsamex@dhcp22.suse.cz>
	<201710022033.GFE82801.HLOVOFFJtSFQMO@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201710022033.GFE82801.HLOVOFFJtSFQMO@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, jiangshanlai@gmail.com, josh@joshtriplett.org, jani.nikula@linux.intel.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, rodrigo.vivi@intel.com, paulmck@linux.vnet.ibm.com, intel-gfx@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon 02-10-17 20:33:52, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > [Hmm, I do not see the original patch which this has been a reply to]
> 
> urbl.hostedemail.com and b.barracudacentral.org blocked my IP address,
> and the rest are "Recipient address rejected: Greylisted" or
> "Deferred: 451-4.3.0 Multiple destination domains per transaction is unsupported.",
> and after all dropped at the servers. Sad...
> 
> > 
> > On Mon 02-10-17 06:59:12, Michael S. Tsirkin wrote:
> > > On Sun, Oct 01, 2017 at 02:44:34PM +0900, Tetsuo Handa wrote:
> > > > Tetsuo Handa wrote:
> > > > > Michael S. Tsirkin wrote:
> > > > > > On Mon, Sep 11, 2017 at 07:27:19PM +0900, Tetsuo Handa wrote:
> > > > > > > Hello.
> > > > > > > 
> > > > > > > I noticed that virtio_balloon is using register_oom_notifier() and
> > > > > > > leak_balloon() from virtballoon_oom_notify() might depend on
> > > > > > > __GFP_DIRECT_RECLAIM memory allocation.
> > > > > > > 
> > > > > > > In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
> > > > > > > serialize against fill_balloon(). But in fill_balloon(),
> > > > > > > alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
> > > > > > > called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE] implies
> > > > > > > __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, this allocation attempt might
> > > > > > > depend on somebody else's __GFP_DIRECT_RECLAIM | !__GFP_NORETRY memory
> > > > > > > allocation. Such __GFP_DIRECT_RECLAIM | !__GFP_NORETRY allocation can reach
> > > > > > > __alloc_pages_may_oom() and hold oom_lock mutex and call out_of_memory().
> > > > > > > And leak_balloon() is called by virtballoon_oom_notify() via
> > > > > > > blocking_notifier_call_chain() callback when vb->balloon_lock mutex is already
> > > > > > > held by fill_balloon(). As a result, despite __GFP_NORETRY is specified,
> > > > > > > fill_balloon() can indirectly get stuck waiting for vb->balloon_lock mutex
> > > > > > > at leak_balloon().
> > 
> > This is really nasty! And I would argue that this is an abuse of the oom
> > notifier interface from the virtio code. OOM notifiers are an ugly hack
> > on its own but all its users have to be really careful to not depend on
> > any allocation request because that is a straight deadlock situation.
> 
> Please describe such warning at
> "int register_oom_notifier(struct notifier_block *nb)" definition.

Yes, we can and should do that. Although I would prefer to simply
document this API as deprecated. Care to send a patch? I am quite busy
with other stuff.

> > I do not think that making oom notifier API more complex is the way to
> > go. Can we simply change the lock to try_lock?
> 
> Using mutex_trylock(&vb->balloon_lock) alone is not sufficient. Inside the
> mutex, __GFP_DIRECT_RECLAIM && !__GFP_NORETRY allocation attempt is used
> which will fail to make progress due to oom_lock already held. Therefore,
> virtballoon_oom_notify() needs to guarantee that all allocation attempts use
> GFP_NOWAIT when called from virtballoon_oom_notify().

Ohh, I missed your point and thought the dependency is indirect and some
other call path is allocating while holding the lock. But you seem to be
right and
leak_balloon
  tell_host
    virtqueue_add_outbuf
      virtqueue_add

can do GFP_KERNEL allocation and this is clearly wrong. Nobody should
try to allocate while we are in the OOM path. Michael, is there any way
to drop this?
-- 
Michal Hocko
SUSE Labs
