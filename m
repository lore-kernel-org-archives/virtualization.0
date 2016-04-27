From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 21:17:57 +0300
Message-ID: <20160427211635-mutt-send-email-mst__44524.6518393562$1461781101$gmane$org@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
	<20160427180007-mutt-send-email-mst@redhat.com>
	<1461770135.118304.152.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1461770135.118304.152.camel@infradead.org>
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
Cc: Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Joerg Roedel <joro@8bytes.org>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, Anthony PERARD <anthony.perard@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 27, 2016 at 04:15:35PM +0100, David Woodhouse wrote:
> On Wed, 2016-04-27 at 18:05 +0300, Michael S. Tsirkin wrote:
> > 
> > I really don't get it.
> > 
> > There's exactly one device that works now and needs the work-around and
> > so that we need to support, and that is virtio. It happens to have
> > exactly the same issue on all platforms.
> 
> False. We have other devices which are currently *not* translated by
> the emulated IOMMU and which aren't going to be in the short term
> either.
> 
> We also have other devices (emulated hardware NICs) to which precisely
> the same "we don't need protection" arguments apply, and which we
> *could* expose to the guest without an IOMMU translation if we really
> wanted to. It makes as much sense as exposing virtio without an IOMMU,
> going forward.

The reasons for virtio are mostly dealing legacy.
We don't need protection is a separate issue
that I'd rather drop for now.

> > Why would we want to work hard to build platform-specific
> > solutions to a problem that can be solved in 5 lines of
> > generic code?
> 
> Because it's a dirty hack in the *wrong* place.

No one came up with a better one so far :(

> -- 
> dwmw2
