From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 0/3] drm: drm_encoder_init() =>
 drm_encoder_init_funcs()
Date: Thu, 19 Mar 2020 15:19:54 +0100
Message-ID: <20200319141954.GA25036@ravnborg.org>
References: <20200313201744.19773-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200313201744.19773-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Jose Roberto de Souza <jose.souza-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, Emil Velikov <emil.velikov-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Boris Brezillon <bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Andrzej
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 13, 2020 at 09:17:41PM +0100, Sam Ravnborg wrote:
> Thomas Zimmermann had made a nice patch-set that introduced
> drm_simple_encoder_init() which is already present in drm-misc-next.
> 
> While looking at this it was suddenly obvious to me that
> this was functionalty that really should be included in drm_encoder.c
> The case where the core could handle the callback is pretty
> common and not part of the simple pipe line.
> 
> So after some dialog on dri-devel the conclusion was to go for
> a change like this:
> 
>     drm_encoder_init_funcs() for all users that specified a
>     drm_encoder_funcs to extend the functionality.
> 
>     drm_encoder_init() for all users that did not
>     need to extend the basic functionality with
>     drm_encoder_funcs.
> 
> A similar approach with a _funcs() prefix is used elsewhere in drm/
> 
> This required a rename of the existing users, and
> a follow-up patch that moves drm_simple_encoder_init()
> to drm_encoder.c
> 
> Patches 3 in this set demonstrate the use of drm_encoder_init().
> There are many more drivers that can be converted as Thomas
> has already demonstrated.
> 
> This is all based on work done by Thomas Zimmermann,
> I just wanted to implement my suggestion so
> we could select the best way forward.
> 
> Note: Daniel Vetter has hinted the approach implemented
> here smelled like middle-layer.
> IMO this is not so, it is just a way to handle cleanup
> for the simple cases.

We discussed this patch-set briefly on irc.
With the upcoming drmm_ changes and such this is bad timing..
And in the end this may be pointless code-chrunch.

Patch-set shelfed for now - may re-visit it later.

	Sam
