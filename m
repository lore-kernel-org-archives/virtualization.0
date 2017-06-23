From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap helper in
	terms of crtc .gamma_set
Date: Fri, 23 Jun 2017 10:40:38 +0200
Message-ID: <20170623084037.7jzeecvn5cgm7tmz__27070.5847106457$1498207250$gmane$org@phenom.ffwll.local>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
	<1497986735-14418-2-git-send-email-peda@axentia.se>
	<20170621073804.akyg4rxvoavjjt2v@phenom.ffwll.local>
	<fc8ca240-61ad-b5b6-174c-490858401237@axentia.se>
	<20170622063645.k5ciwdeqfafgnxtv@phenom.ffwll.local>
	<854a89af-d146-8414-73e7-2460c8f33598@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <854a89af-d146-8414-73e7-2460c8f33598@axentia.se>
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
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Yannick Fertre <yannick.fertre@st.com>, Ben Skeggs <bskeggs@redhat.com>, amd-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 10:48:10AM +0200, Peter Rosin wrote:
> On 2017-06-22 08:36, Daniel Vetter wrote:
> > On Wed, Jun 21, 2017 at 11:40:52AM +0200, Peter Rosin wrote:
> >> On 2017-06-21 09:38, Daniel Vetter wrote:
> >>> On Tue, Jun 20, 2017 at 09:25:25PM +0200, Peter Rosin wrote:
> >>>> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
> >>>> totally obsolete.
> >>>>
> >>>> I think the gamma_store can end up invalid on error. But the way I read
> >>>> it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
> >>>> this pesky legacy fbdev stuff be any better?
> >>>>
> >>>> drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. However,
> >>>> it saves it to the gamma_store which should already be up to date with what
> >>>> .gamma_get would return and is thus a nop. So, zap it.
> >>>
> >>> Removing drm_fb_helper_save_lut_atomic should be a separate patch I
> >>> think.
> >>
> >> Then 3 patches would be needed, first some hybrid thing that does it the
> >> old way, but also stores the lut in .gamma_store, then the split-out that
> >> removes drm_fb_helper_save_lut_atomic, then whatever is needed to get
> >> to the desired code. I can certainly do that, but do you want me to?
> > 
> > Explain that in the commit message and it's fine.
> 
> I did the split in v2, I assume that's ok too. Better in case anyone ever
> needs to run a bisect on this...
> 
> >>> It's a pre-existing bug, but should we also try to restore the fbdev lut
> >>> in drm_fb_helper_restore_fbdev_mode_unlocked()? Would be yet another bug,
> >>> but might be relevant for your use-case. Just try to run both an fbdev
> >>> application and some kms-native thing, and then SIGKILL the native kms
> >>> app.
> >>>
> >>> But since pre-existing not really required, and probably too much effort.
> >>
> >> Good thing too, because I don't really know my way around this code...
> > 
> > Btw I cc'ed you on one of my patches in the fbdev locking series, we might
> > need to do the same legacy vs. atomic split for the new lut code as I did
> > for dpms. The rule with atomic is that you can't do multiple commits under
> > drm_modeset_lock_all, you either have to do one overall atomic commit
> > (preferred) or drop&reacquire locks again. This matters for LUT since
> > you're updating the LUT on all CRTCs, which when using the gamma_set
> > atomic helper would be multiple commits :-/
> 
> Ahh, ok, I see the problem.
> 
> > Using the dpms patch as template it shouldn't be too hard to address that
> > for your patch here too.
> 
> Hmm, in that patch you handle the legacy case in a separate function, and
> doing that for the lut case looks difficult when the atomic commit happens
> inside the helper (typically drm_atomic_helper_legacy_gamma_set which
> could perhaps be handled, but a real drag to handle for drivers that have
> a custom crtc .gamma_set).

Yeah, that's essentially why you need 2 functions. Legacy one calls the
legacy interfaces, the atomic one calls the new fancy atomic property
stuff directly (i.e. it open-codes the property setting dance from the
helper, but with one atomic commit across all crtc).

The reason that the legacy callback functions are helpers and not just
default behavior is that I expected some drivers to need special hacks to
keep their existing legacy kms userspace working. Atomic helpers unified
behaviour a lot that beforehand was slightly inconsistent. I somewhat
expect that long-term we'll unexport all the compat helpers and just make
them the default for all atomic drivers.

> So, I'm aiming for the drop&reacquire approach...

Hm, I prefer the open-coding, that's at least what we do everywhere else.
Has the benefit that it's more atomic (one commit for everything).

> However, I don't have all of that series, and I suspect that is why I do
> not have any fb_helper->lock.

Oh sorry, entire series is on dri-devel. I can do a git branch too if you
need one, atm it's in my general pile:

https://cgit.freedesktop.org/~danvet/drm/log/

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
