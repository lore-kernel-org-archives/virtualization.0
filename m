From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 01/15] drm: Initialize struct drm_crtc_state.no_vblank
 from device settings
Date: Tue, 28 Jan 2020 16:14:42 +0100
Message-ID: <20200128151442.GH43062@phenom.ffwll.local>
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-2-tzimmermann@suse.de>
 <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>
 <183782e6-164c-bae8-90e0-906edb059a1d@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <183782e6-164c-bae8-90e0-906edb059a1d@suse.de>
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
Cc: david@lechnology.com, Sam Ravnborg <sam@ravnborg.org>, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>, Sean Paul <sean@poorly.run>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 27, 2020 at 07:42:27PM +0100, Thomas Zimmermann wrote:
> Hi Emil
> =

> Am 27.01.20 um 19:12 schrieb Emil Velikov:
> > Hi Thomas,
> > =

> > On Thu, 23 Jan 2020 at 09:21, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
> > =

> >> @@ -174,12 +174,22 @@ struct drm_crtc_state {
> >>          * @no_vblank:
> >>          *
> >>          * Reflects the ability of a CRTC to send VBLANK events. This =
state
> >> -        * usually depends on the pipeline configuration, and the main=
 usuage
> >> -        * is CRTCs feeding a writeback connector operating in oneshot=
 mode.
> >> -        * In this case the VBLANK event is only generated when a job =
is queued
> >> -        * to the writeback connector, and we want the core to fake VB=
LANK
> >> -        * events when this part of the pipeline hasn't changed but ot=
hers had
> >> -        * or when the CRTC and connectors are being disabled.
> >> +        * usually depends on the pipeline configuration. If set to tr=
ue, DRM
> >> +        * atomic helpers will sendout a fake VBLANK event during disp=
lay
> >> +        * updates.
> >> +        *
> >> +        * One usage is for drivers and/or hardware without support fo=
r VBLANK
> >> +        * interrupts. Such drivers typically do not initialize vblank=
ing
> >> +        * (i.e., call drm_vblank_init() wit the number of CRTCs). For=
 CRTCs
> >> +        * without initialized vblanking, the field is initialized to =
true and
> >> +        * a VBLANK event will be send out on each update of the displ=
ay
> >> +        * pipeline.
> >> +        *
> >> +        * Another usage is CRTCs feeding a writeback connector operat=
ing in
> >> +        * oneshot mode. In this case the VBLANK event is only generat=
ed when
> >> +        * a job is queued to the writeback connector, and we want the=
 core
> >> +        * to fake VBLANK events when this part of the pipeline hasn't=
 changed
> >> +        * but others had or when the CRTC and connectors are being di=
sabled.
> >>          *
> > =

> > Perhaps it's just me, yet the following ideas would make the topic
> > significantly easier and clearer.
> > =

> >  - adding explicit "fake" when talking about drm/atomic _helpers_
> > generating/sending a VBLANK event.
> > For example, in 15/15 the commit message says "fake", while inline
> > comment omits it... Leading to the confusion pointed out.
> =

> No problem on being more precise here. I'll update the docs accordingly.
> =

> > =

> > - s/no_vblank/fake_vblank/g or s/no_vblank/no_hw_vblank/g
> > Simple and concise. With slight inclination towards the former wording =
:-)
> =

> I'd prefer to not change the field's name. The current name 'no_vblank'
> indicates state and lets helpers decide what to do with it. The name
> 'fake_vblank' indicates an instruction to the helpers, telling them what
> to do. It does neither seem to fit into drm_crtc_state, nor into the
> overall concept.

Yeah e.g. xen has no hw vblank, but still has special processing of
events, which are kinda triggered by the "hw" (it's an event from the
compositor).

Maybe the confusion is with the helper function that generates the
fake_vblank, since it's not really a fake vblank at all, it's just "send
out this atomic completion event now, I'm not going to do it as part of
the vblank processing since no vblank". So maybe that function should be
called _send_events_i_have_no_hw_vblank, which yeah is not a great name
:-) But maybe you have an idea for that one?
-Daniel

> =

> Best regards
> Thomas
> =

> > =

> > If you and Daniel agree with the rename, then the first sentence of
> > the description should probably be tweaked.
> > =

> > HTH
> > Emil
> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
