From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events by
 default
Date: Thu, 16 Jan 2020 17:22:34 +0000
Message-ID: <CACvgo52gwC6U5HjnsQSUUDgE7Gp_EDb-QqCY8VDFjAX7cE0Lxg@mail.gmail.com>
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
 <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
 <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <33fdd33f-ce8d-70d3-544e-fac727d2686b@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, david@lechnology.com, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org, Sam Ravnborg <sam@ravnborg.org>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

On Thu, 16 Jan 2020 at 07:37, Thomas Zimmermann <tzimmermann@suse.de> wrote:

> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> > index 7cf3cf936547..23d2f51fc1d4 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -149,6 +149,11 @@ void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
> >       /* Self refresh should be canceled when a new update is available */
> >       state->active = drm_atomic_crtc_effectively_active(state);
> >       state->self_refresh_active = false;
> > +
> > +     if (drm_dev_has_vblank(crtc->dev))
> > +             state->no_vblank = true;
> > +     else
> > +             state->no_vblank = false;
> >  }
> >  EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);
>
> I think the if/else branches are in the wrong order.
>
> But generally speaking, is it really that easy? The xen driver already
> has to work around simple-kms's auto-enabling of no_vblank (see patch
> 4). Maybe this settings interferes with other drivers as well. At least
> the calls for sending fake vblanks should be removed from all affected
> drivers.
>

I'm not sure if setting no_vblank based on dev->num_crtcs is the correct thing.
From the original commit and associated description for no_vblank:

In some cases CRTCs are active but are not able to generating events, at
least not at every frame at it's expected to.
This is typically the case when the CRTC is feeding a writeback connector...

Reflects the ability of a CRTC to send VBLANK events....


The proposed handling of no_vblank feels a little dirty, although
nothing better comes to mind.
Nevertheless code seems perfectly reasonable, so if it were me I'd merge it.

HTH
Emil
