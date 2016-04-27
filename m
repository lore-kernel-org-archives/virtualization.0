From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 18:05:51 +0300
Message-ID: <20160427180007-mutt-send-email-mst__25112.9733435393$1461769573$gmane$org@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160427145632.GI17926@8bytes.org>
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

On Wed, Apr 27, 2016 at 04:56:32PM +0200, Joerg Roedel wrote:
> On Wed, Apr 27, 2016 at 05:34:30PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Apr 27, 2016 at 04:23:32PM +0200, Joerg Roedel wrote:
> 
> > QEMU can choose to bypass IOMMU for one device and not the other.
> > IOMMU in QEMU isn't involved when it's bypassed.
> 
> And it is QEMU's task to tell the OS, right? And the correct way to do
> this is via the firmware ACPI tables.

Going forward, this might be reasonable. Of course it didn't in the past
and no one cared because virtio devices used physical addresses. We have
to keep these setups working.

> > Fine but this is beside the point. Almost all virtio devices
> > bypass IOMMU and what this patch does is create a way
> > to detect devices that don't. This code can maybe go into
> > platform.
> 
> Again, the way to detect this is in platform code must not be device
> specific. This is what the DMAR and IVRS tables on x86 are for.
> 
> When there is no way to do this in the firmware (or there is no firmware
> at all), we have to do a quirk in the platform code for it.
> 
> 
> 
> 	Joerg

I really don't get it.

There's exactly one device that works now and needs the work-around and
so that we need to support, and that is virtio. It happens to have
exactly the same issue on all platforms.

Why would we want to work hard to build platform-specific
solutions to a problem that can be solved in 5 lines of
generic code?

-- 
MST
