From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: lost qxl_bo_kunmap_atomic_page
 in qxl_image_init_helper()
Date: Tue, 28 Apr 2020 12:08:31 +0200
Message-ID: <20200428100831.a4525pdp335ffkgi@sirius.home.kraxel.org>
References: <d0d96600-b147-0c44-f551-97a66083518d@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spice-devel-bounces@lists.freedesktop.org>
In-Reply-To: <d0d96600-b147-0c44-f551-97a66083518d@virtuozzo.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/spice-devel>
List-Post: <mailto:spice-devel@lists.freedesktop.org>
List-Help: <mailto:spice-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: spice-devel-bounces@lists.freedesktop.org
Sender: "Spice-devel" <spice-devel-bounces@lists.freedesktop.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2020 at 10:55:27AM +0300, Vasily Averin wrote:
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/gpu/drm/qxl/qxl_image.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
> index 43688ecdd8a0..7270da62fc29 100644
> --- a/drivers/gpu/drm/qxl/qxl_image.c
> +++ b/drivers/gpu/drm/qxl/qxl_image.c
> @@ -212,6 +212,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
>  		break;
>  	default:
>  		DRM_ERROR("unsupported image bit depth\n");
> +		qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
>  		return -EINVAL; /* TODO: cleanup */

I guess you can ditch the TODO comment now, it's done ;)

take care,
  Gerd
