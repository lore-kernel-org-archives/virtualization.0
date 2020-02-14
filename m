From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Date: Fri, 14 Feb 2020 16:57:11 +0000
Message-ID: <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200214160413.1475396-4-jean-philippe@linaro.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Cc: mst@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com
List-Id: virtualization@lists.linuxfoundation.org

On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> With the built-in topology description in place, x86 platforms can now
> use the virtio-iommu.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 068d4e0e3541..adcbda44d473 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -508,8 +508,9 @@ config HYPERV_IOMMU
>   config VIRTIO_IOMMU
>   	bool "Virtio IOMMU driver"
>   	depends on VIRTIO=y
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>   	select IOMMU_API
> +	select IOMMU_DMA

Can that have an "if X86" for clarity? AIUI it's not necessary for 
virtio-iommu itself (and really shouldn't be), but is merely to satisfy 
the x86 arch code's expectation that IOMMU drivers bring their own DMA 
ops, right?

Robin.

>   	select INTERVAL_TREE
>   	help
>   	  Para-virtualised IOMMU driver with virtio.
> 
