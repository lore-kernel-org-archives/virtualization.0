From: Dejin Zheng <zhengdejin5@gmail.com>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Date: Wed, 22 Apr 2020 21:52:15 +0800
Message-ID: <20200422135215.GA25950@nuc8i5>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kraxel@redhat.com, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 21, 2020 at 08:24:24PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> >
> > It forgot to call bochs_hw_fini() to release related resources when
> > bochs_pci_probe() fail. eg: io virtual address get by ioremap().
> 
> Good start, although I think the best is to switch this driver to use
> pcim_*() functions and drop tons of legacy code.
>
Andy, thanks for your encouragement, I think we might be able to fix this
issue first, after that, drop tons of legacy code by pcim_*() functions.
Do you think it is ok?

BR,
Dejin

> > Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> > index addb0568c1af..210a60135c8a 100644
> > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
> >         return ret;
> >
> >  err_unload:
> > +       bochs_hw_fini(dev);
> >         bochs_unload(dev);
> >  err_free_dev:
> >         drm_dev_put(dev);
> > --
> > 2.25.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
