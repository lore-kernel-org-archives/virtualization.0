From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Revert "vring: Force use of DMA API for ARM-based
	systems with legacy devices"
Date: Fri, 3 Feb 2017 09:57:19 +0000
Message-ID: <20170203095718.GB11585@arm.com>
References: <1486093716-17120-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1486093716-17120-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 03, 2017 at 05:49:11AM +0200, Michael S. Tsirkin wrote:
> This reverts commit c7070619f3408d9a0dffbed9149e6f00479cf43b.
> 
> This has been shown to regress on some ARM systems:
> 
> by forcing on DMA API usage for ARM systems, we have inadvertently
> kicked open a hornets' nest in terms of cache-coherency. Namely that
> unless the virtio device is explicitly described as capable of coherent
> DMA by firmware, the DMA APIs on ARM and other DT-based platforms will
> assume it is non-coherent. This turns out to cause a big problem for the
> likes of QEMU and kvmtool, which generate virtio-mmio devices in their
> guest DTs but neglect to add the often-overlooked "dma-coherent"
> property; as a result, we end up with the guest making non-cacheable
> accesses to the vring, the host doing so cacheably, both talking past
> each other and things going horribly wrong.
> 
> We are working on a safer work-around.
> 
> Fixes: c7070619f340 ("vring: Force use of DMA API for ARM-based systems with legacy devices")
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> 
> I'll merge this for 4.10. Let's fix it properly for 4.11.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
