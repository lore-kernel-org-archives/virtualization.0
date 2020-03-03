From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 09/51] drm/cirrus: Use drmm_add_final_kfree
Date: Tue, 3 Mar 2020 08:49:34 +0100
Message-ID: <20200303074934.vlqxiye7lydnoykd@sirius.home.kraxel.org>
References: <20200302222631.3861340-1-daniel.vetter@ffwll.ch>
 <20200302222631.3861340-10-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200302222631.3861340-10-daniel.vetter@ffwll.ch>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

> @@ -575,9 +574,12 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  
>  	dev = &cirrus->dev;
>  	ret = drm_dev_init(dev, &cirrus_driver, &pdev->dev);
> -	if (ret)
> -		goto err_free_cirrus;
> +	if (ret) {
> +		kfree(cirrus);
> +		goto err_pci_release;
> +	}
>  	dev->dev_private = cirrus;
> +	drmm_add_final_kfree(dev, cirrus);

That doesn't look like an error path improvement.
With patch #30 applied it'll looks alot better though.
So maybe squash the patches?

In any case:
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
