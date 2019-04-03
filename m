From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Wed, 3 Apr 2019 10:53:41 +0200
Message-ID: <20190403085341.2cxdgxqrjlwecx3n__32905.657465902$1554281637$gmane$org@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > +struct cirrus_device {
> > +       struct drm_device              *dev;
> 
> Why not embed drm_device? It's the latest rage :-)

Sure, can do that.

> > +void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
> > +                       struct drm_plane_state *old_state)
> > +{
> > +       struct drm_plane_state *state = pipe->plane.state;
> > +       struct drm_crtc *crtc = &pipe->crtc;
> > +       struct drm_rect rect;
> > +
> > +       if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> > +               cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
> > +
> > +       if (crtc->state->event) {
> > +               spin_lock_irq(&crtc->dev->event_lock);
> > +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +               spin_unlock_irq(&crtc->dev->event_lock);
> > +               crtc->state->event = NULL;
> > +       }
> > +}

> > +static int cirrus_fb_dirty(struct drm_framebuffer *fb,
> > +                          struct drm_file *file_priv,
> > +                          unsigned int flags, unsigned int color,
> > +                          struct drm_clip_rect *clips,
> > +                          unsigned int num_clips)
> > +{
> > +       struct cirrus_device *cirrus = fb->dev->dev_private;
> > +
> > +       if (cirrus->pipe.plane.state->fb != fb)
> > +               return 0;
> > +
> > +       if (num_clips)
> > +               cirrus_fb_blit_clips(fb, clips, num_clips);
> > +       else
> > +               cirrus_fb_blit_fullscreen(fb);
> > +       return 0;
> > +}
> 
> Why not use the dirty helpers and implement dirty rect support in your
> main plane update function?

Dirty rect support is already there, see above.

So I can just remove cirrus_fb_dirty() and hook up
drm_atomic_helper_dirtyfb() instead.  Easy ;)

cheers,
  Gerd
