From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] [PATCH] mm,oom: Offload OOM notify callback to a kernel
	thread.
Date: Mon, 2 Oct 2017 16:19:00 +0200
Message-ID: <20171002141900.acmcbilwhqethfhq__47730.9542046443$1506953970$gmane$org@dhcp22.suse.cz>
References: <20170929065654-mutt-send-email-mst@kernel.org>
	<201709291344.FID60965.VHtMQFFJFSLOOO@I-love.SAKURA.ne.jp>
	<201710011444.IBD05725.VJSFHOOMOFtLQF@I-love.SAKURA.ne.jp>
	<20171002065801-mutt-send-email-mst@kernel.org>
	<20171002090627.547gkmzvutrsamex@dhcp22.suse.cz>
	<201710022033.GFE82801.HLOVOFFJtSFQMO@I-love.SAKURA.ne.jp>
	<20171002115035.7sph6ul6hsszdwa4@dhcp22.suse.cz>
	<20171002170642-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171002170642-mutt-send-email-mst@kernel.org>
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

On Mon 02-10-17 17:11:55, Michael S. Tsirkin wrote:
> On Mon, Oct 02, 2017 at 01:50:35PM +0200, Michal Hocko wrote:
[...]
> > and some
> > other call path is allocating while holding the lock. But you seem to be
> > right and
> > leak_balloon
> >   tell_host
> >     virtqueue_add_outbuf
> >       virtqueue_add
> > 
> > can do GFP_KERNEL allocation and this is clearly wrong. Nobody should
> > try to allocate while we are in the OOM path. Michael, is there any way
> > to drop this?
> 
> Yes - in practice it won't ever allocate - that path is never taken
> with add_outbuf - it is for add_sgs only.
> 
> IMHO the issue is balloon inflation which needs to allocate
> memory. It does it under a mutex, and oom handler tries to take the
> same mutex.

try_lock for the oom notifier path should heal the problem then, righ?
At least for as a quick fix.
-- 
Michal Hocko
SUSE Labs
