From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v3 00/16] improve the fb_setcmap helper
Date: Wed, 5 Jul 2017 22:19:58 +0200
Message-ID: <20170705201958.unu7gwx6guetqiep__27319.2430999645$1499286017$gmane$org@phenom.ffwll.local>
References: <1499164632-5582-1-git-send-email-peda@axentia.se>
	<20170705060816.nwufo2m7cmthjopn@phenom.ffwll.local>
	<3810fb8e-76d6-0810-26aa-1aae6bac2f9a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3810fb8e-76d6-0810-26aa-1aae6bac2f9a@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Rosin <peda@axentia.se>
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, Sinclair Yeh <syeh@vmware.com>, Russell King <linux@armlinux.org.uk>, amd-gfx@lists.freedesktop.org, VMware Graphics <linux-graphics-maintainer@vmware.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, linux-kernel@vger.kernel.org, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 05, 2017 at 10:09:21AM +0200, Peter Rosin wrote:
> On 2017-07-05 08:08, Daniel Vetter wrote:
> > On Tue, Jul 04, 2017 at 12:36:56PM +0200, Peter Rosin wrote:
> >> Hi!
> >>
> >> While trying to get CLUT support for the atmel_hlcdc driver, and
> >> specifically for the emulated fbdev interface, I received some
> >> push-back that my feeble in-driver attempts should be solved
> >> by the core. This is my attempt to do it right.
> >>
> >> I have obviously not tested all of this with more than a compile,
> >> but patches 1 through 5 are enough to make the atmel-hlcdc driver
> >> do what I need. The rest is just lots of removals and cleanup made
> >> possible by the improved core.
> >>
> >> Please test, I would not be surprised if I have fouled up some
> >> bit-manipulation somewhere, or if I have misunderstood something
> >> about atomics...
> >>
> >> Changes since v2:
> >> - Added patch 1/16 which factors out pseudo-palette handling.
> >> - Removed the if (cmap->start + cmap->len < cmap->start)
> >>   sanity check on the assumption that the fbdev core handles it.
> >> - Added patch 4/16 which factors out atomic state and commit
> >>   handling from drm_atomic_helper_legacy_gamma_set to
> >>   drm_mode_gamma_set_ioctl.
> >> - Do one atomic commit for all affected crtc.
> >> - Removed a now obsolete note in include/drm/drm_crtc.h (ammended
> >>   the last patch).
> >> - Cc list is getting long, so I have redused the list for the
> >>   individual patches. If you would like to get the full series
> >>   (or nothing at all) for the next round (if that is needed) just
> >>   say so.
> > 
> > Is this still on top of my locking rework? I tried to apply patches 1-3,
> > but there's minor conflicts ...
> > -Daniel
> 
> v3 has the same base as v2. I collected your locking rework sometime
> after june 21, you have perhaps changed things since? I saw an update
> of that dpms patch you Cc me, but figured there were no significant
> changes that I needed to handle since I didn't get the full set
> this time either. A bad assumption it seems...

There's a difference between my own private patches, and the maintainer
repo where stuff gets applied. But that explains why there was a conflict.

I plan to merge my locking changes tomorrow (they're reviewed and ready
now), I'll apply your patches after that. That should take care of the
conflicts.

Thanks, Daniel

> 
> Anyway, the base I have for v3 (and v2) is linux next-20170621 plus
> the following locking rework commits (in reverse order):
> 
> Author: Thierry Reding <treding@nvidia.com>
> Date: Wed Jun 21 20:28:15 2017 +0200
> Subject: drm/hisilicon: Remove custom FB helper deferred setup
> 
> Author: Thierry Reding <treding@nvidia.com>
> Date: Wed Jun 21 20:28:14 2017 +0200
> Subject: drm/exynos: Remove custom FB helper deferred setup
> 
> Author: Thierry Reding <treding@nvidia.com>
> Date: Wed Jun 21 20:28:13 2017 +0200
> Subject: drm/fb-helper: Support deferred setup
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:12 2017 +0200
> Subject: drm/fb-helper: Split dpms handling into legacy and atomic paths
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:11 2017 +0200
> Subject: drm/fb-helper: Stop using mode_config.mutex for internals
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:10 2017 +0200
> Subject: drm/fb-helper: Push locking into restore_fbdev_mode_atomic|legacy
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:09 2017 +0200
> Subject: drm/fb-helper: Push locking into pan_display_atomic|legacy
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:08 2017 +0200
> Subject: drm/fb-helper: Drop locking from the vsync wait ioctl code
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:07 2017 +0200
> Subject: drm/fb-helper: Push locking in fb_is_bound
> 
> Author: Thierry Reding <treding@nvidia.com>
> Date: Wed Jun 21 20:28:06 2017 +0200
> Subject: drm/fb-helper: Add top-level lock
> 
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Wed Jun 21 20:28:05 2017 +0200
> Subject: drm/i915: Drop FBDEV #ifdev in mst code
> 
> Author: Thierry Reding <treding@nvidia.com>
> Date: Wed Jun 21 20:28:04 2017 +0200
> Subject: drm/fb-helper: Push down modeset lock into FB helpers
> 
> Cheers,
> peda
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
