From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: spapr_tce: Disable compile testing to fix build
 on book3s_32 config
Date: Sat, 18 Apr 2020 14:46:44 +0200
Message-ID: <20200418124644.GF6113@8bytes.org>
References: <20200414142630.21153-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200414142630.21153-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 14, 2020 at 04:26:30PM +0200, Krzysztof Kozlowski wrote:
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
