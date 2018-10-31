From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 3/5] drm/virtio: add in-fences support for explicit
	synchronization
Date: Wed, 31 Oct 2018 09:38:56 +0000
Message-ID: <CACvgo51EXugYmNamgUKzyaYbk_kEyODNbG10AJtkvhbQgYwxWw__30615.3015153997$1540978692$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-4-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-4-robert.foss@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rob,

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:

> @@ -124,6 +127,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
>                 return -EINVAL;
>
> +       if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
> +               in_fence = sync_file_get_fence(in_fence_fd);
> +               if (!in_fence)
> +                       return -EINVAL;
> +
> +               /*
> +                * Wait if the fence is from a foreign context, or if the fence
> +                * array contains any fence from a foreign context.
> +                */
> +               if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context)) {
> +                       ret = dma_fence_wait(in_fence, true);
> +                       if (ret)
> +                               return ret;
Aren't we missing dma_fence_put() before the return here?

With that
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
