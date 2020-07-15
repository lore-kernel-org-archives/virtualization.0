From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD IOMMU + SME + amdgpu regression
Date: Wed, 15 Jul 2020 11:17:20 +0200
Message-ID: <20200715091720.GV27672@8bytes.org>
References: <1591915710.rakbpzst8h.none.ref@localhost>
 <1591915710.rakbpzst8h.none@localhost>
 <20200622100257.GD31822@suse.de>
 <1592839701.mxvvths2x9.none@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1592839701.mxvvths2x9.none@localhost>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Alex Xu (Hello71)" <alex_y_xu-FFYn/CNdgSA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matt>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 22, 2020 at 11:30:04AM -0400, Alex Xu (Hello71) wrote:
> Yes, it works with SME off with dbed452a078 ("dma-pool: decouple 
> DMA_REMAP from DMA_COHERENT_POOL") applied.

Okay, I can reproduce the problem on my Ryzen System, and the boot log
shows various warnings/bugs from the amdgpu driver. I think this should
be looked at by the AMDGPU folks first, as I didn't really got far
looking into the GPU drivers code.

Regards,

	Joerg
