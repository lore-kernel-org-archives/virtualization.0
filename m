From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Tue, 19 Apr 2016 11:01:38 -0700
Message-ID: <CALCETrXsbYj5c3j2em2-jrhBWp-VqRJd900s5WDdVUMCN2aiNg__33806.0125745416$1461088934$gmane$org@mail.gmail.com>
References: <1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
	<CALCETrXGC9X6fndftzUKKQ76TXSARHotW8Kz3KcO6opQ-oLaqA@mail.gmail.com>
	<20160419130732-mutt-send-email-mst@redhat.com>
	<CALCETrX72XV25B-0GdaMyJNkJRvvC8MbT4G=L5oGR=D5stpG6w@mail.gmail.com>
	<20160419190520-mutt-send-email-mst@redhat.com>
	<CALCETrWEo12k49kFmPA3NByXrLb8OYQEmDYoYgngQcxMZ=1Mzw@mail.gmail.com>
	<20160419191914-mutt-send-email-mst@redhat.com>
	<1461083204.20056.8.camel@infradead.org>
	<20160419204907-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160419204907-mutt-send-email-mst@redhat.com>
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
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 19, 2016 at 10:49 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Apr 19, 2016 at 12:26:44PM -0400, David Woodhouse wrote:
>> On Tue, 2016-04-19 at 19:20 +0300, Michael S. Tsirkin wrote:
>> >
>> > > I thought that PLATFORM served that purpose.  Woudn't the host
>> > > advertise PLATFORM support and, if the guest doesn't ack it, the host
>> > > device would skip translation?  Or is that problematic for vfio?
>> >
>> > Exactly that's problematic for security.
>> > You can't allow guest driver to decide whether device skips security.
>>
>> Right. Because fundamentally, this *isn't* a property of the endpoint
>> device, and doesn't live in virtio itself.
>>
>> It's a property of the platform IOMMU, and lives there.
>
> It's a property of the hypervisor virtio implementation, and lives there.

It is now, but QEMU could, in principle, change the way it thinks
about it so that virtio devices would use the QEMU DMA API but ask
QEMU to pass everything through 1:1.  This would be entirely invisible
to guests but would make it be a property of the IOMMU implementation.
At that point, maybe QEMU could find a (platform dependent) way to
tell the guest what's going on.

FWIW, as far as I can tell, PPC and SPARC really could, in principle,
set up 1:1 mappings in the guest so that the virtio devices would work
regardless of whether QEMU is ignoring the IOMMU or not -- I think the
only obstacle is that the PPC and SPARC 1:1 mappings are currectly set
up with an offset.  I don't know too much about those platforms, but
presumably the layout could be changed so that 1:1 really was 1:1.

--Andy
