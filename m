From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 17:34:30 +0300
Message-ID: <20160427172630-mutt-send-email-mst@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160427142331.GH17926@8bytes.org>
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 27, 2016 at 04:23:32PM +0200, Joerg Roedel wrote:
> On Wed, Apr 27, 2016 at 04:37:04PM +0300, Michael S. Tsirkin wrote:
> > One correction: it's a feature of the device in the system.
> > There could be a mix of devices bypassing and not
> > bypassing the IOMMU.
> 
> No, it really is not. A device can't chose to bypass the IOMMU. But the
> IOMMU can chose to let the device bypass.

QEMU can choose to bypass IOMMU for one device and not the other.
IOMMU in QEMU isn't involved when it's bypassed.

> So any fix here belongs
> into the platform/iommu code too and not into some driver.

Fine but this is beside the point. Almost all virtio devices
bypass IOMMU and what this patch does is create a way
to detect devices that don't. This code can maybe go into
platform.

> > Sounds good. And a way to detect appropriate devices could
> > be by looking at the feature flag, perhaps?
> 
> Again, no! The way to detect that is to look into the iommu description
> structures provided by the firmware. They provide everything necessary
> to tell the iommu code which devices are not translated.
> 
> 
> 
> 	Joerg

It would be easy if they did but they don't do this on all systems.
In particular the idea for firmware interface was clearly
that a given bus either is connected through IOMMU or bypassing it.
Whether virtio bypasses the iommu is unrelated to the bus it's on.

-- 
MST
