From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
	virito devices
Date: Wed, 25 Jul 2018 16:31:08 +0300
Message-ID: <20180725162951-mutt-send-email-mst__3844.79661374844$1532525366$gmane$org@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-5-khandual@linux.vnet.ibm.com>
	<20180720160550-mutt-send-email-mst@kernel.org>
	<3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 23, 2018 at 07:46:09AM +0530, Anshuman Khandual wrote:
> There is a redundant definition of virtio_has_iommu_quirk in the tools
> directory (tools/virtio/linux/virtio_config.h) which does not seem to
> be used any where. I guess that can be removed without problem.

It's there just to make tools/virtio build.
Try
	make -C tools/virtio/
In fact I see there's a missing definition for
dma_rmb/dma_wmb there, I'll post a patch.

-- 
MST
