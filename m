From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v4 01/15] drm: Initialize struct drm_crtc_state.no_vblank
 from device settings
Date: Mon, 27 Jan 2020 18:12:54 +0000
Message-ID: <CACvgo53YvKjPNNshZoTjJehHyOX6e05kJ5gAXtjwxs+oLLv7vw@mail.gmail.com>
References: <20200123092123.28368-1-tzimmermann@suse.de>
 <20200123092123.28368-2-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200123092123.28368-2-tzimmermann@suse.de>
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
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, Dave Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org, Emil Velikov <emil.velikov@collabora.com>, Sean Paul <sean@poorly.run>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Thomas,

On Thu, 23 Jan 2020 at 09:21, Thomas Zimmermann <tzimmermann@suse.de> wrote:

> @@ -174,12 +174,22 @@ struct drm_crtc_state {
>          * @no_vblank:
>          *
>          * Reflects the ability of a CRTC to send VBLANK events. This state
> -        * usually depends on the pipeline configuration, and the main usuage
> -        * is CRTCs feeding a writeback connector operating in oneshot mode.
> -        * In this case the VBLANK event is only generated when a job is queued
> -        * to the writeback connector, and we want the core to fake VBLANK
> -        * events when this part of the pipeline hasn't changed but others had
> -        * or when the CRTC and connectors are being disabled.
> +        * usually depends on the pipeline configuration. If set to true, DRM
> +        * atomic helpers will sendout a fake VBLANK event during display
> +        * updates.
> +        *
> +        * One usage is for drivers and/or hardware without support for VBLANK
> +        * interrupts. Such drivers typically do not initialize vblanking
> +        * (i.e., call drm_vblank_init() wit the number of CRTCs). For CRTCs
> +        * without initialized vblanking, the field is initialized to true and
> +        * a VBLANK event will be send out on each update of the display
> +        * pipeline.
> +        *
> +        * Another usage is CRTCs feeding a writeback connector operating in
> +        * oneshot mode. In this case the VBLANK event is only generated when
> +        * a job is queued to the writeback connector, and we want the core
> +        * to fake VBLANK events when this part of the pipeline hasn't changed
> +        * but others had or when the CRTC and connectors are being disabled.
>          *

Perhaps it's just me, yet the following ideas would make the topic
significantly easier and clearer.

 - adding explicit "fake" when talking about drm/atomic _helpers_
generating/sending a VBLANK event.
For example, in 15/15 the commit message says "fake", while inline
comment omits it... Leading to the confusion pointed out.

- s/no_vblank/fake_vblank/g or s/no_vblank/no_hw_vblank/g
Simple and concise. With slight inclination towards the former wording :-)

If you and Daniel agree with the rename, then the first sentence of
the description should probably be tweaked.

HTH
Emil
