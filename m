From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Date: Mon, 11 Mar 2019 19:48:39 +0100
Message-ID: <20190311184839.GO2665__15446.6400666692$1552330137$gmane$org@phenom.ffwll.local>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
	<20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
	<20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
	<20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
	<20190311132358.GF2665@phenom.ffwll.local>
	<20190311133919.azyhtioxf23duf3g@sirius.home.kraxel.org>
	<20190311174958.xdw4lrvf6ydeplvc@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190311174958.xdw4lrvf6ydeplvc@smtp.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2019 at 02:49:58PM -0300, Rodrigo Siqueira wrote:
> On 03/11, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > > IIRC the drm code checks for the atomic_enable callback presence to
> > > > figure whenever it should take the atomic or legacy code paths.
> > > 
> > > It should check for drm_driver->mode_config.funcs.atomic_commit for that,
> > > see drm_drv_uses_atomic_modeset(). Anything else should be a bug.
> > > 
> > > Or do you mean the fallback to the old crtc helper prepare/commit
> > > callbacks?
> > 
> > Probably the later.  There was some reason why I've left in the empty
> > bochs_crtc_atomic_enable() callback ...
> 
> Just for checking before I start to work in this patch:
> The correct solution should be made atomic_enable and atomic_disable
> optional, right? I should do it, and check if Bochs driver really needs
> bochs_crtc_atomic_enable after my change, right?

Yup. I just tried to remember why we haven't done this yet, but I think
that was a patch to make crtc->helper_funcs optional. And that doesn't
make sense imo, since if your crtc doesn't do anything then you don't
really have an atomic driver :-) And if there's ever a legit use case for
this, then that drive probably shouldn't use the atomic helpers ...

But making crtc_helper_funcs->atomic_enable/disable optional sounds like a
good idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
