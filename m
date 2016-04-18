From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Mon, 18 Apr 2016 17:23:54 +0300
Message-ID: <20160418170534-mutt-send-email-mst@redhat.com>
References: <1460979793-6621-1-git-send-email-mst@redhat.com>
	<1460980717.12793.43.camel@infradead.org>
	<20160418160731-mutt-send-email-mst@redhat.com>
	<1460988232.22654.7.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1460988232.22654.7.camel@infradead.org>
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

On Mon, Apr 18, 2016 at 10:03:52AM -0400, David Woodhouse wrote:
> On Mon, 2016-04-18 at 16:12 +0300, Michael S. Tsirkin wrote:
> > I'm not sure I understand the issue.=A0=A0The public API is not about h=
ow
> > the driver works.=A0=A0It doesn't say "don't use DMA API" anywhere, doe=
s it?
> > It's about telling device whether to obey the IOMMU and
> > about discovering whether a device is in fact under the IOMMU.
> =

> Apologies, I was wrongly reading this as a kernel patch.
> =

> After a brief struggle with "telling device whether to obey the IOMMU",
> which is obviously completely impossible from the guest kernel, I
> realise my mistake :)
> =

> So... on x86 how does this get reflected in the DMAR tables that the
> guest BIOS presents to the guest kernel, so that the guest kernel
> *knows* which devices are behind which IOMMU?

This patch doesn't change DMAR tables, it creates a way for virtio
device to tell guest "I obey what DMAR tables tell you, you can stop
doing hacks".

And as PPC guys seem adamant that platform tools there are no good for
that purpose, there's another bit that says "ignore what platform tells
you, I'm not a real device - I'm part of hypervisor and I bypass the
IOMMU".


> (And are you fixing the case of assigned PCI devices, which aren't
> behind any IOMMU, at the same time as you answer that? :)

No - Aviv B.D. has patches on list to fix that.

-- =

MST
