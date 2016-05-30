From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Mon, 30 May 2016 16:47:55 +0200
Message-ID: <20160530144755.GK27098__25228.9768345237$1464619694$gmane$org@phenom.ffwll.local>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427718227.3372.33.camel@nilsson.home.kraxel.org>
	<20150330144927.GN23521@phenom.ffwll.local>
	<CAKMK7uFUNT193f5djZD6T8cgRxxnZL73yrqbupPHOd2P-+Y=pQ@mail.gmail.com>
	<1464335302.10663.10.camel@redhat.com>
	<20160527090313.GX27098@phenom.ffwll.local>
	<1464616236.5179.41.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1464616236.5179.41.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 30, 2016 at 03:50:36PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > - add a small core function to registerr HOT_X/HOT_Y for a (cursor) plane,
> >   e.g. drm_plane_register_hotspot(). That should allocate the properties
> >   (if they don't exist yet) and then attach those props to the cursor. We
> >   don't want those props everywhere, but only on drivers that support/need
> >   them, aka virtual hw.
> 
> Hmm, why is this special to virtual hw?
> 
> >  	if (crtc->cursor) {
> > -		ret = drm_mode_cursor_universal(crtc, req, file_priv);
> > +		if (drm_core_check_feature(DRIVER_ATOMIC))
> > +			ret = drm_mode_cursor_atomic(crtc, req, file_priv);
> > +		else
> > +			ret = drm_mode_cursor_universal(crtc, req, file_priv);
> >  		goto out;
> 
> >   drm_mode_cursor_atomic would simply be a fusing of
> >   drm_mode_cursor_universal + drm_atomic_helper_update_plane (dump all the
> >   intermediate variables and store directly in the plane state), with the
> >   addition of also storing hot_x/y into the plane state.
> 
> Hmm, that'll either make drm_mode_cursor_atomic a big cut+pasted
> function, or need quite some refactoring to move common code into
> functions callable from both drm_mode_cursor_atomic
> +drm_mode_cursor_universal ...
> 
> Why attach the hotspot to the plane?  Wouldn't it make more sense to
> make it a framebuffer property?

We don't have properties on the framebuffer. I guess you /could/ just add
it internally to struct drm_framebuffer, and not bother exposing to
userspace. I guess that would be a lot simpler, but it also means that
atomic userspace can't use hotspots before we add properties to fbs. And
doing that is a bit tricky since drm_framebuffer objects are meant to be
invariant - this assumption is deeply in-grained into the code all over
the place, everything just compares pointers when semantically it means to
compare the entire fb (including backing storage pointer/offsets and
everything).

So would be a bit more work to wire up for atomic userspace, but indeed a
lot less work to implement. I'm totally happy if you go with that tradeoff
;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
