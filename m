From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Mon, 9 Nov 2015 13:27:57 +0100
Message-ID: <5640914D.6070401__48321.2188155905$1447072106$gmane$org@redhat.com>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151109133624-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, sparclinux@vger.kernel.org, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 09/11/2015 13:15, Michael S. Tsirkin wrote:
> Well that's not exactly true. I think we would like to make
> it possible to put virtio devices behind an IOMMU on x86,
> but if this means existing guests break, then many people won't be able
> to use this option: having to find out which kernel version your guest
> is running is a significant burden.
> 
> So on the host side, we need to detect guests that
> don't program the IOMMU and make QEMU ignore it.
> I think we need to figure out a way to do this
> before we commit to the guest change.

What is the usecase for putting virtio devices behind an IOMMU, apart from:

1) "because you can"

2) using VFIO within the guest

?  Case 1 can be ignored, and in case 2 the guest will do the right thing.

> Additionally, IOMMU overhead is very high when running within the VM.
> So for uses such as VFIO, we'd like a way to make something like
> iommu-pt the default.

That's not something that the kernel cares about.  It's just a
configuration issue.

Paolo
