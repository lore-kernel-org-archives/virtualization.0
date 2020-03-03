From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 09/51] drm/cirrus: Use drmm_add_final_kfree
Date: Tue, 3 Mar 2020 09:27:26 +0100
Message-ID: <20200303082726.GL2363188@phenom.ffwll.local>
References: <20200302222631.3861340-1-daniel.vetter@ffwll.ch>
 <20200302222631.3861340-10-daniel.vetter@ffwll.ch>
 <20200303074934.vlqxiye7lydnoykd@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200303074934.vlqxiye7lydnoykd@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2020 at 08:49:34AM +0100, Gerd Hoffmann wrote:
> > @@ -575,9 +574,12 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
> >  
> >  	dev = &cirrus->dev;
> >  	ret = drm_dev_init(dev, &cirrus_driver, &pdev->dev);
> > -	if (ret)
> > -		goto err_free_cirrus;
> > +	if (ret) {
> > +		kfree(cirrus);
> > +		goto err_pci_release;
> > +	}
> >  	dev->dev_private = cirrus;
> > +	drmm_add_final_kfree(dev, cirrus);
> 
> That doesn't look like an error path improvement.
> With patch #30 applied it'll looks alot better though.
> So maybe squash the patches?

Breaks the patch set evolution, there's a _lot_ of dependencies in here to
make sure we never break anything interim. But yeah that's why I created
this entire series, since with just the first part it's really not any
better. I also have a pile more ideas on top, so hopefully once this lands
I can get around to them and make everything even better :-)

Cheers, Daniel

> 
> In any case:
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> cheers,
>   Gerd
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
