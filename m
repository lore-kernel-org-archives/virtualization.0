From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Date: Mon, 11 Mar 2019 07:22:00 +0100
Message-ID: <20190311062200.4mtel3j5fjxtxrcf__36457.8348978952$1552285333$gmane$org@sirius.home.kraxel.org>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 10, 2019 at 06:21:50PM -0300, Rodrigo Siqueira wrote:
> When the subtest basic-plain-flip from IGT project was executed on Bochs
> driver, the following bug appears:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

>  ? drm_atomic_helper_commit_modeset_disables+0x396/0x3e0 [drm_kms_helper]

> +static void  bochs_crtc_atomic_disable(struct drm_crtc *crtc,
> +				       struct drm_crtc_state *old_state)
> +{
> +}
> +
>  static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_crtc_state)
>  {
> @@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
>  static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>  	.mode_set_nofb = bochs_crtc_mode_set_nofb,
>  	.atomic_enable = bochs_crtc_atomic_enable,
> +	.atomic_disable = bochs_crtc_atomic_disable,

Shouldn't we make the callback optional instead of adding empty dummy
functions to drivers?

cheers,
  Gerd
