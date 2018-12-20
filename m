From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/bochs: add edid present check
Date: Thu, 20 Dec 2018 09:28:26 +0100
Message-ID: <20181220082826.GE21184__39278.6639895805$1545294392$gmane$org@phenom.ffwll.local>
References: <20181220065001.9594-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181220065001.9594-1-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 20, 2018 at 07:50:01AM +0100, Gerd Hoffmann wrote:
> Check first two header bytes before trying to read the edid blob,
> to avoid the log being spammed in case qemu has no edid support (old
> qemu or edid turned off).
> 
> Fixes: 01f23459cf drm/bochs: add edid support.
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

It's a bit a hack, but makes sense.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index c90a0d492f..e1f8ffce00 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -89,6 +89,14 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
>  	if (!bochs->mmio)
>  		return -1;
>  
> +	/*
> +	 * Check first two EDID blob header bytes to figure whenever
> +	 * edid support is enabled in qemu.
> +	 */
> +	if (readb(bochs->mmio + 0) != 0x00 ||
> +	    readb(bochs->mmio + 1) != 0xff)
> +		return -1;
> +
>  	kfree(bochs->edid);
>  	bochs->edid = drm_do_get_edid(&bochs->connector,
>  				      bochs_get_edid_block, bochs);
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
