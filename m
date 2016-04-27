From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 18:09:31 +0300
Message-ID: <20160427180610-mutt-send-email-mst__11137.9938469783$1461769793$gmane$org@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<CALCETrVkSSJbjoK8i7pLsSYR0o=Wy1UP-mrmn2uxYUd81g18dg@mail.gmail.com>
	<20160427173603-mutt-send-email-mst@redhat.com>
	<CALCETrUnXSLApj--ypOHnLWLqVSHLpSa922F2C2OCrvA1B585A@mail.gmail.com>
	<20160427175031-mutt-send-email-mst@redhat.com>
	<20160427145851.GJ17926@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160427145851.GJ17926@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm list <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 27, 2016 at 04:58:51PM +0200, Joerg Roedel wrote:
> On Wed, Apr 27, 2016 at 05:54:57PM +0300, Michael S. Tsirkin wrote:
> > Point is, QEMU is not the only virtio implementation out there.
> > So we can't know no virtio implementations have an IOMMU as long as
> > linux supports this IOMMU.
> > virtio always used physical addresses since it was born and if it
> > changes that it must do this in a way that does not break existing
> > users.
> 
> FWIW, virtio in qemu can continue to just use physical addresses. But
> qemu needs to advertise that fact correctly to the OS in the DMAR table.
> This way old kernels (where virtio does not use DMA-API) will also
> continue to work on the fixed qemu.
> 
> 
> 
> 	Joerg

It's not clear it can do this since DMAR tables seem to assume
a given slot is either bypassing IOMMU or going through it.
QEMU allows reusing same slot for virtio and non-virtio devices.

Besides, this patch is not about it, it's a flag for QEMU to
tell guest that it can trust DMAR tables.

-- 
MST
