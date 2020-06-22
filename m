From: "Alex Xu (Hello71)" <alex_y_xu-FFYn/CNdgSA@public.gmane.org>
Subject: Re: AMD IOMMU + SME + amdgpu regression
Date: Mon, 22 Jun 2020 11:30:04 -0400
Message-ID: <1592839701.mxvvths2x9.none@localhost>
References: <1591915710.rakbpzst8h.none.ref@localhost>
        <1591915710.rakbpzst8h.none@localhost> <20200622100257.GD31822@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200622100257.GD31822-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matt>
List-Id: virtualization@lists.linuxfoundation.org

Excerpts from Joerg Roedel's message of June 22, 2020 6:02 am:
> Hi Alex,
>=20
> On Thu, Jun 11, 2020 at 07:05:21PM -0400, Alex Xu (Hello71) wrote:
>> I am using an ASRock B450 Pro4 with Ryzen 1600 and ASUS RX 480. I don't=20
>> understand this code at all, but let me know what I can do to=20
>> troubleshoot.
>=20
> Does it boot without SME enabled?
>=20
>=20
> Regards,
>=20
> 	Joerg
>=20

Yes, it works with SME off with dbed452a078 ("dma-pool: decouple=20
DMA_REMAP from DMA_COHERENT_POOL") applied.
