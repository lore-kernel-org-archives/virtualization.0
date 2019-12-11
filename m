From: Gurchetan Singh <gurchetansingh@chromium.org>
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
Date: Tue, 10 Dec 2019 17:06:42 -0800
Message-ID: <CAAfnVB=prUDgkPjZdB9QcA9XHdcBCQSPcf4mBL75LG8QJ4D=0Q__12742.0495309465$1576026435$gmane$org@mail.gmail.com>
References: <20191210085759.14763-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210085759.14763-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 10, 2019 at 12:58 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> virtio-gpu uses cached mappings.  shmem helpers use writecombine though.
> So roll our own mmap function, wrapping drm_gem_shmem_mmap(), to tweak
> vm_page_prot accordingly.
>
> Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 017a9e0fc3bb..158610902054 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -75,6 +75,22 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>         drm_gem_shmem_free_object(obj);
>  }
>
> +static int virtio_gpu_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> +{
> +       pgprot_t prot;
> +       int ret;
> +
> +       ret = drm_gem_shmem_mmap(obj, vma);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* virtio-gpu needs normal caching, so clear writecombine */
> +       prot = vm_get_page_prot(vma->vm_flags);
> +       prot = pgprot_decrypted(prot);
> +       vma->vm_page_prot = prot;
> +       return 0;
> +}
> +
>  static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
>         .free = virtio_gpu_free_object,
>         .open = virtio_gpu_gem_object_open,
> @@ -86,7 +102,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
>         .get_sg_table = drm_gem_shmem_get_sg_table,
>         .vmap = drm_gem_shmem_vmap,

Do we need vmap/vmunap?  It seems optionable and also uses non-cacheable memory?

>         .vunmap = drm_gem_shmem_vunmap,
> -       .mmap = &drm_gem_shmem_mmap,
> +       .mmap = &virtio_gpu_gem_mmap,

Why the &virtio_gpu_gem_mmap?  Shouldn't just virtio_gpu_gem_mmap work?



>  };
>
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
> --
> 2.18.1
>
