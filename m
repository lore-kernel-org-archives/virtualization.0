From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Wed, 3 Apr 2019 11:58:06 +0200
Message-ID: <0c959f3a-15e9-8295-dc11-2f6b9a4229ac__24350.5807056621$1554285504$gmane$org@tronnes.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
	<20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Den 03.04.2019 10.53, skrev Gerd Hoffmann:
>>> +struct cirrus_device {
>>> +       struct drm_device              *dev;
>>
>> Why not embed drm_device? It's the latest rage :-)
> 
> Sure, can do that.
> 
>>> +void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
>>> +                       struct drm_plane_state *old_state)
>>> +{
>>> +       struct drm_plane_state *state = pipe->plane.state;
>>> +       struct drm_crtc *crtc = &pipe->crtc;
>>> +       struct drm_rect rect;
>>> +
>>> +       if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>>> +               cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
>>> +
>>> +       if (crtc->state->event) {
>>> +               spin_lock_irq(&crtc->dev->event_lock);
>>> +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
>>> +               spin_unlock_irq(&crtc->dev->event_lock);
>>> +               crtc->state->event = NULL;
>>> +       }
>>> +}
> 
>>> +static int cirrus_fb_dirty(struct drm_framebuffer *fb,
>>> +                          struct drm_file *file_priv,
>>> +                          unsigned int flags, unsigned int color,
>>> +                          struct drm_clip_rect *clips,
>>> +                          unsigned int num_clips)
>>> +{
>>> +       struct cirrus_device *cirrus = fb->dev->dev_private;
>>> +
>>> +       if (cirrus->pipe.plane.state->fb != fb)
>>> +               return 0;
>>> +
>>> +       if (num_clips)
>>> +               cirrus_fb_blit_clips(fb, clips, num_clips);
>>> +       else
>>> +               cirrus_fb_blit_fullscreen(fb);
>>> +       return 0;
>>> +}
>>
>> Why not use the dirty helpers and implement dirty rect support in your
>> main plane update function?
> 
> Dirty rect support is already there, see above.
> 
> So I can just remove cirrus_fb_dirty() and hook up
> drm_atomic_helper_dirtyfb() instead.  Easy ;)
> 

You can even use drm_gem_fb_create_with_dirty() instead of
drm_gem_fb_create_with_funcs().

Noralf.

> cheers,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
