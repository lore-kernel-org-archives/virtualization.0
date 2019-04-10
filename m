From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/bochs: use simple display pipe
Date: Wed, 10 Apr 2019 23:22:40 +0200
Message-ID: <20190410212240.GA31691__39848.2643462316$1554931400$gmane$org@ravnborg.org>
References: <20190410074828.10296-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190410074828.10296-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd.

>  
>  #include <drm/drm_gem.h>
>  
> @@ -69,9 +70,8 @@ struct bochs_device {
>  	struct edid *edid;
>  
>  	/* drm */
> -	struct drm_device  *dev;
> -	struct drm_crtc crtc;
> -	struct drm_encoder encoder;
> +	struct drm_device *dev;
> +	struct drm_simple_display_pipe pipe;
>  	struct drm_connector connector;

Have you considered to embed drm_device in the bochs_device struct?
This is the new way to do it.

This should likely be a follow-up patch...

Rest of the patch looked good.
Did not do a proper review but you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
