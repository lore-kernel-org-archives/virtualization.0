From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in dma_addressing_limited
Date: Mon, 22 Jul 2019 18:56:49 +0200
Message-ID: <77ba1061-08b6-421e-a6dd-d5db9851325b__2802.18596324033$1563814640$gmane$org@redhat.com>
References: <20190722165149.3763-1-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190722165149.3763-1-eric.auger@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph,

On 7/22/19 6:51 PM, Eric Auger wrote:
> We currently have cases where the dma_addressing_limited() gets
> called with dma_mask unset. This causes a NULL pointer dereference.
> 
> Use dma_get_mask() accessor to prevent the crash.
> 
> Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

As a follow-up of my last email, here is a patch featuring
dma_get_mask(). But you don't have the WARN_ON_ONCE anymore, pointing
out suspect users.

Feel free to pick up your preferred approach

Thanks

Eric
> 
> ---
> 
> v1 -> v2:
> - was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
>   against NULL dma_mask
> - Use dma_get_mask
> ---
>  include/linux/dma-mapping.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e11b115dd0e4..f7d1eea32c78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>   */
>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
> +			    dma_get_required_mask(dev);
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> 
