From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Tue, 19 Apr 2016 09:00:27 -0700
Message-ID: <CALCETrVBo-XBD53eStOCwJd53F7_VTnrMJ9rY7_cXwnt2Z6AOw__30041.4782403552$1461081664$gmane$org@mail.gmail.com>
References: <1460979793-6621-1-git-send-email-mst@redhat.com>
	<1460980717.12793.43.camel@infradead.org>
	<20160418160731-mutt-send-email-mst@redhat.com>
	<1460988232.22654.7.camel@infradead.org>
	<20160418170534-mutt-send-email-mst@redhat.com>
	<1460992923.3765.8.camel@infradead.org>
	<20160418182320-mutt-send-email-mst@redhat.com>
	<1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
	<20160419103815-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160419103815-mutt-send-email-mst@redhat.com>
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
Cc: Wei Liu <wei.liu2@citrix.com>, kvm list <kvm@vger.kernel.org>, qemu-block@nongnu.org, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Apr 19, 2016 2:13 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>
> I guess you are right in that we should split this part out.
> What I wanted is really the combination
> PASSTHROUGH && !PLATFORM so that we can say "ok we don't
> need to guess, this device actually bypasses the IOMMU".

What happens when you use a device like this on Xen or with a similar
software translation layer?

I think that a "please bypass IOMMU" feature would be better in the
PCI, IOMMU, or platform code.  For Xen, virtio would still want to use
the DMA API, just without translating at the DMAR or hardware level.
Doing it in virtio is awkward, because virtio is involved at the
device level and the driver level, but the translation might be
entirely in between.

I think a nicer long-term approach would be to have a way to ask the
guest to set up a full 1:1 mapping for performance, but to still
handle the case where the guest refuses to do so or where there's more
than one translation layer involved.

But I agree that this part shouldn't delay the other part of your series.

--Andy
