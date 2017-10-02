From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] [PATCH] mm,oom: Offload OOM notify callback to a kernel
	thread.
Date: Mon, 2 Oct 2017 11:06:27 +0200
Message-ID: <20171002090627.547gkmzvutrsamex__44054.2913544506$1506935220$gmane$org@dhcp22.suse.cz>
References: <201709111927.IDD00574.tFVJHLOSOOMQFF@I-love.SAKURA.ne.jp>
	<20170929065654-mutt-send-email-mst@kernel.org>
	<201709291344.FID60965.VHtMQFFJFSLOOO@I-love.SAKURA.ne.jp>
	<201710011444.IBD05725.VJSFHOOMOFtLQF@I-love.SAKURA.ne.jp>
	<20171002065801-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171002065801-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, joonas.lahtinen@linux.intel.com, jiangshanlai@gmail.com, josh@joshtriplett.org, jani.nikula@linux.intel.com, virtualization@lists.linux-foundation.org, airlied@linux.ie, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, rodrigo.vivi@intel.com, paulmck@linux.vnet.ibm.com, intel-gfx@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

[Hmm, I do not see the original patch which this has been a reply to]

On Mon 02-10-17 06:59:12, Michael S. Tsirkin wrote:
> On Sun, Oct 01, 2017 at 02:44:34PM +0900, Tetsuo Handa wrote:
> > Tetsuo Handa wrote:
> > > Michael S. Tsirkin wrote:
> > > > On Mon, Sep 11, 2017 at 07:27:19PM +0900, Tetsuo Handa wrote:
> > > > > Hello.
> > > > > 
> > > > > I noticed that virtio_balloon is using register_oom_notifier() and
> > > > > leak_balloon() from virtballoon_oom_notify() might depend on
> > > > > __GFP_DIRECT_RECLAIM memory allocation.
> > > > > 
> > > > > In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
> > > > > serialize against fill_balloon(). But in fill_balloon(),
> > > > > alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
> > > > > called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE] implies
> > > > > __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, this allocation attempt might
> > > > > depend on somebody else's __GFP_DIRECT_RECLAIM | !__GFP_NORETRY memory
> > > > > allocation. Such __GFP_DIRECT_RECLAIM | !__GFP_NORETRY allocation can reach
> > > > > __alloc_pages_may_oom() and hold oom_lock mutex and call out_of_memory().
> > > > > And leak_balloon() is called by virtballoon_oom_notify() via
> > > > > blocking_notifier_call_chain() callback when vb->balloon_lock mutex is already
> > > > > held by fill_balloon(). As a result, despite __GFP_NORETRY is specified,
> > > > > fill_balloon() can indirectly get stuck waiting for vb->balloon_lock mutex
> > > > > at leak_balloon().

This is really nasty! And I would argue that this is an abuse of the oom
notifier interface from the virtio code. OOM notifiers are an ugly hack
on its own but all its users have to be really careful to not depend on
any allocation request because that is a straight deadlock situation.

I do not think that making oom notifier API more complex is the way to
go. Can we simply change the lock to try_lock? If the lock is held we
would simply fall back to the normal OOM handling. As a follow up it
would be great if virtio could use some other form of aging e.g.
shrinker.
-- 
Michal Hocko
SUSE Labs
