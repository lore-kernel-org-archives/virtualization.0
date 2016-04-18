From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Mon, 18 Apr 2016 16:12:01 +0300
Message-ID: <20160418160731-mutt-send-email-mst__41653.921447187$1460985156$gmane$org@redhat.com>
References: <1460979793-6621-1-git-send-email-mst@redhat.com>
	<1460980717.12793.43.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1460980717.12793.43.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 18, 2016 at 07:58:37AM -0400, David Woodhouse wrote:
> On Mon, 2016-04-18 at 14:47 +0300, Michael S. Tsirkin wrote:
> > This adds a flag to enable/disable bypassing the IOMMU by
> > virtio devices.
> 
> I'm still deeply unhappy with having this kind of hack in the virtio
> code at all, as you know. Drivers should just use the DMA API and if
> the *platform* wants to make it a no-op for a specific device, then it
> can.
> 
> Remember, this isn't just virtio either. Don't we have *precisely* the
> same issue with assigned PCI devices on a system with an emulated Intel
> IOMMU? The assigned PCI devices aren't covered by the emulated IOMMU,
> and the platform needs to know to bypass *those* too.
> 
> Now, we've had this conversation, and we accepted the hack in virtio
> for now until the platforms (especially SPARC and Power IIRC) can get
> their act together and make their DMA API implementations not broken.
> 
> But now you're adding this hack to the public API where we have to
> support it for ever. Please, can't we avoid that?

I'm not sure I understand the issue.  The public API is not about how
the driver works.  It doesn't say "don't use DMA API" anywhere, does it?
It's about telling device whether to obey the IOMMU and
about discovering whether a device is in fact under the IOMMU.

Once DMA API allows bypassing IOMMU per device we'll be
able to drop the ugly hack from virtio drivers, simply keying it
off the given flag.


> -- 
> dwmw2
> 
> 
