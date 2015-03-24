From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Tue, 24 Mar 2015 22:50:28 +0000
Message-ID: <CAPj87rN4pXHukDRD-e=ZrO1hcts04cSz1Hr9TNAgicGVWE5_-Q__39815.9577897333$1427300616$gmane$org@mail.gmail.com>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
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
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 24 March 2015 at 16:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> +static int virtio_gpu_crtc_page_flip(struct drm_crtc *crtc,
> +                                    struct drm_framebuffer *fb,
> +                                    struct drm_pending_vblank_event *event,
> +                                    uint32_t flags)
> +{
> +       return -EINVAL;
> +}

I'm not going to lie, I was really hoping the 5th (?) GPU option for
Qemu would support pageflipping. Daniel's comment about conversion to
atomic is relevant, but: do you have a mechanism which allows you to
post updates (e.g. 'start displaying this buffer now please') that
allows you to get events back when they have actually been displayed?

Cheers,
Daniel
