From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v5 09/10] vring: Use the DMA API on Xen
Date: Fri, 29 Jan 2016 10:34:59 +0000
Message-ID: <56AB4053.4070007__31753.3813220964$1454063737$gmane$org@citrix.com>
References: <cover.1454034075.git.luto@kernel.org>
	<64e979cc139c5e6a9bbfae9f1bc5e6693d91bea9.1454034075.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <64e979cc139c5e6a9bbfae9f1bc5e6693d91bea9.1454034075.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, David Vrabel <david.vrabel@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 29/01/16 02:31, Andy Lutomirski wrote:
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c169c6444637..305c05cc249a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -47,6 +47,18 @@
>  
>  static bool vring_use_dma_api(void)
>  {
> +#if defined(CONFIG_X86) && defined(CONFIG_XEN)
> +	/*
> +	 * In theory, it's possible to have a buggy QEMU-supposed
> +	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
> +	 * such a configuration, virtio has never worked and will
> +	 * not work without an even larger kludge.  Instead, enable
> +	 * the DMA API if we're a Xen guest, which at least allows
> +	 * all of the sensible Xen configurations to work correctly.
> +	 */
> +	return static_cpu_has(X86_FEATURE_XENPV);

You want:

    if (xen_domain())
        return true;

Without the #if so we use the DMA API for all types of Xen guest on all
architectures.

David
