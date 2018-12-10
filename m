From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/7] drm/qxl: Don't set the dpms hook
Date: Mon, 10 Dec 2018 14:08:53 +0100
Message-ID: <20181210130853.zpmstn4uqvdapxyp__7209.57550588555$1544447218$gmane$org@sirius.home.kraxel.org>
References: <20181210100359.22507-1-daniel.vetter@ffwll.ch>
	<20181210100359.22507-6-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181210100359.22507-6-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, spice-devel@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 10, 2018 at 11:03:57AM +0100, Daniel Vetter wrote:
> Doesn't do anything with atomic.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index ce0b9c40fc21..72a1784dae54 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1010,7 +1010,6 @@ static void qxl_conn_destroy(struct drm_connector *connector)
>  }
>  
>  static const struct drm_connector_funcs qxl_connector_funcs = {
> -	.dpms = drm_helper_connector_dpms,
>  	.detect = qxl_conn_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = qxl_conn_destroy,

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
