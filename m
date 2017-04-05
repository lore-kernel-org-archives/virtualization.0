From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drm: virtio: fix virtio_gpu_cursor_formats
Date: Wed, 5 Apr 2017 20:11:25 +0300
Message-ID: <20170405171125.GT30290__20867.7604831339$1491412360$gmane$org@intel.com>
References: <20170405080915.823-1-lvivier@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170405080915.823-1-lvivier@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <lvivier@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 05, 2017 at 10:09:15AM +0200, Laurent Vivier wrote:
> When we use virtio-vga with a big-endian guest,
> the mouse pointer disappears.
> =

> To fix that, on big-endian use DRM_FORMAT_BGRA8888
> instead of DRM_FORMAT_ARGB8888.
> =

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index 11288ff..3ed7174 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -39,7 +39,11 @@ static const uint32_t virtio_gpu_formats[] =3D {
>  };
>  =

>  static const uint32_t virtio_gpu_cursor_formats[] =3D {
> +#ifdef __BIG_ENDIAN
> +	DRM_FORMAT_BGRA8888,
> +#else
>  	DRM_FORMAT_ARGB8888,
> +#endif

DRM formats are supposed to be little endian, so this isn't really
correct.

>  };
>  =

>  static void virtio_gpu_plane_destroy(struct drm_plane *plane)
> -- =

> 2.9.3
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Ville Syrj=E4l=E4
Intel OTC
