From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH 08/13] drm/virtio: Stop updating plane->crtc
Date: Thu, 5 Apr 2018 18:46:03 +0200
Message-ID: <20180405164603.GI3881__31515.3717333034$1522946649$gmane$org@phenom.ffwll.local>
References: <20180405151400.11326-1-ville.syrjala@linux.intel.com>
	<20180405151400.11326-8-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180405151400.11326-8-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 05, 2018 at 06:13:55PM +0300, Ville Syrjala wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> =

> We want to get rid of plane->crtc on atomic drivers. Stop setting it.
> =

> v2: s/fb/crtc/ in the commit message (Gerd)
> =

> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 2 --
>  1 file changed, 2 deletions(-)
> =

> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/v=
irtio/virtgpu_display.c
> index 8cc8c34d67f5..42e842ceb53c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -302,8 +302,6 @@ static int vgdev_output_init(struct virtio_gpu_device=
 *vgdev, int index)
>  	drm_crtc_init_with_planes(dev, crtc, primary, cursor,
>  				  &virtio_gpu_crtc_funcs, NULL);
>  	drm_crtc_helper_add(crtc, &virtio_gpu_crtc_helper_funcs);
> -	primary->crtc =3D crtc;
> -	cursor->crtc =3D crtc;
>  =

>  	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
>  			   DRM_MODE_CONNECTOR_VIRTUAL);
> -- =

> 2.16.1
> =

> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
