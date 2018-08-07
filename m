From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 23:18:14 -0700
Message-ID: <20180807061814.GC32709__7769.56701088256$1533622580$gmane$org@infradead.org>
References: <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803220443-mutt-send-email-mst@kernel.org>
	<051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
	<20180805031046-mutt-send-email-mst@kernel.org>
	<fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
	<20180806164106-mutt-send-email-mst@kernel.org>
	<ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
	<20180806233024-mutt-send-email-mst@kernel.org>
	<0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
	<20180807002857-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180807002857-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 07, 2018 at 12:46:34AM +0300, Michael S. Tsirkin wrote:
> Well we have the RFC for that - the switch to using DMA ops unconditionally isn't
> problematic itself IMHO, for now that RFC is blocked
> by its perfromance overhead for now but Christoph says
> he's trying to remove that for direct mappings,
> so we should hopefully be able to get there in X weeks.

The direct calls to dma_direct_ops aren't going to help you with legacy
virtio, given that virtio is specified to deal with physical addresses,
while dma-direct is not in many cases.

It would however help with the case where qemu always sets the platform
dma flag, as we'd avoid the indirect calls for that.
