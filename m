From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH 2/2] drm/virtio: send vblank event on plane atomic update
Date: Tue, 22 Mar 2016 13:17:24 +0000
Message-ID: <CAPj87rO5M3u-X6O6kOqcaXXM_gndAqE22Hr_oJ8Xj20idXaJtQ__2031.69483361325$1458767101$gmane$org@mail.gmail.com>
References: <1458588187-26002-1-git-send-email-gustavo@padovan.org>
	<1458588187-26002-2-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458588187-26002-2-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gustavo Padovan <gustavo@padovan.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 21 March 2016 at 19:23, Gustavo Padovan <gustavo@padovan.org> wrote:
> @@ -96,6 +98,11 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
>                                       plane->state->crtc_y,
>                                       plane->state->crtc_w,
>                                       plane->state->crtc_h);
> +
> +       spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +       if (crtc->state->event)
> +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +       spin_unlock_irqrestore(&crtc->dev->event_lock, flags);

This seems like the wrong place to do it, in that it will generate one
flip event per plane, rather than one per CRTC. So this should
probably be done in the overall atomic_commit hook I think.

Also, without some kind of delay, this means that we'll generate
flip-complete events immediately, which will cause compositors like
Weston to render infinitely fast. It's probably worth looking at what
happened when this came up with Bochs - I'm not sure if we fake a 16ms
delay, or refuse to do async modesets, or what.

Cheers,
Daniel
