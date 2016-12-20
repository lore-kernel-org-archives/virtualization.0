From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC PATCH] vring: Force use of DMA API for ARM-based systems
Date: Tue, 20 Dec 2016 16:50:22 +0000
Message-ID: <ed400fb2-6f92-a343-8b7b-0cb4254802c3__39600.2958449118$1483728374$gmane$org@arm.com>
References: <1482246864-16399-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1482246864-16399-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 20/12/16 15:14, Will Deacon wrote:
> Booting Linux on an ARM fastmodel containing an SMMU emulation results
> in an unexpected I/O page fault from the legacy virtio-blk PCI device:
> 
> [    1.211721] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> [    1.211800] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> [    1.211880] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> [    1.211959] arm-smmu-v3 2b400000.smmu:	0x00000008fa081002
> [    1.212075] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> [    1.212155] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> [    1.212234] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> [    1.212314] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> [    1.212394] arm-smmu-v3 2b400000.smmu:	0x00000008fa081000
> [    1.212471] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> 
> <system hangs failing to read partition table>
> 
> This is because the virtio-blk is behind an SMMU, so we have consequently
> swizzled its DMA ops and configured the SMMU to translate accesses. This
> then requires the vring code to use the DMA API to establish translations,
> otherwise all transactions will result in fatal faults and termination.
> 
> Given that ARM-based systems only see an SMMU if one is really present
> (the topology is all described by firmware tables such as device-tree or
> IORT), then we can safely use the DMA API for all virtio devices.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ed9c9eeedfe5..06b91e29d1b7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -159,6 +159,10 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (xen_domain())
>  		return true;
>  
> +	/* On ARM-based machines, the DMA ops will do the right thing */
> +	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
> +		return true;
> +
>  	return false;
>  }
>  
> 

This patch makes my model usable again, so FWIW:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
