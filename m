From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Mon, 9 May 2016 13:09:24 +0200
Message-ID: <57306FE4.4050006__45665.9412979663$1462792220$gmane$org@redhat.com>
References: <20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
	<20160427180007-mutt-send-email-mst@redhat.com>
	<1461770135.118304.152.camel@infradead.org>
	<20160427211635-mutt-send-email-mst@redhat.com>
	<1461784617.118304.181.camel@infradead.org>
	<20160428172039-mutt-send-email-mst@redhat.com>
	<1461856314.33870.98.camel@infradead.org>
	<20160428182341-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160428182341-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Joerg Roedel <joro@8bytes.org>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Anthony PERARD <anthony.perard@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org



On 28/04/2016 17:37, Michael S. Tsirkin wrote:
> > All the internally-emulated devices *can* be either translated or
> > untranslated. That's just a matter of software. Surely, you currently
> > *can't* have translated assigned devices (until someone implements the
> > whole VT-d page table shadowing or whatever), so you'll be barred from
> > assigning a device to a slot which *previously* had an untranslated
> > device. But so what? Put it in a different slot instead.
> 
> Unfortunately people got used to be able to put any device
> in any slot, and built external tools around that ability.
> It's rather painful to break this assumption.

Once you move to PCIe, a lot of things become more complicated.  This is
just one of them; instead of needing half a dozen PCI bridges, you'll
need half a dozen plus one.

Paolo
