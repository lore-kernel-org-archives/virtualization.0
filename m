From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Date: Tue, 21 Apr 2020 20:24:24 +0300
Message-ID: <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200421164543.16605-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dejin Zheng <zhengdejin5@gmail.com>
Cc: kraxel@redhat.com, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> It forgot to call bochs_hw_fini() to release related resources when
> bochs_pci_probe() fail. eg: io virtual address get by ioremap().

Good start, although I think the best is to switch this driver to use
pcim_*() functions and drop tons of legacy code.

> Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index addb0568c1af..210a60135c8a 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>         return ret;
>
>  err_unload:
> +       bochs_hw_fini(dev);
>         bochs_unload(dev);
>  err_free_dev:
>         drm_dev_put(dev);
> --
> 2.25.0
>


-- 
With Best Regards,
Andy Shevchenko
