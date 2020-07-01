From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 00/34] iommu: Move iommu_group setup to IOMMU core code
Date: Wed, 1 Jul 2020 11:53:07 +0100
Message-ID: <9b0ef27a-f249-a90b-9899-e53b946f83cc@arm.com>
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200701004020.GA6221@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200701004020.GA6221-J5quhbR+WMc@public.gmane.org>
Content-Language: en-GB
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qian Cai <cai-J5quhbR+WMc@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw>
List-Id: virtualization@lists.linuxfoundation.org

On 2020-07-01 01:40, Qian Cai wrote:
> Looks like this patchset introduced an use-after-free on arm-smmu-v3.
> 
> Reproduced using mlx5,
> 
> # echo 1 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> # echo 0 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> 
> The .config,
> https://github.com/cailca/linux-mm/blob/master/arm64.config
> 
> Looking at the free stack,
> 
> iommu_release_device->iommu_group_remove_device
> 
> was introduced in 07/34 ("iommu: Add probe_device() and release_device()
> call-backs").

Right, iommu_group_remove_device can tear down the group and call 
->domain_free before the driver has any knowledge of the last device 
going away via the ->release_device call.

I guess the question is do we simply flip the call order in 
iommu_release_device() so drivers can easily clean up their internal 
per-device state first, or do we now want them to be robust against 
freeing domains with devices still nominally attached?

Robin.
