From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Tue, 19 Apr 2016 09:12:03 -0700
Message-ID: <CALCETrWEo12k49kFmPA3NByXrLb8OYQEmDYoYgngQcxMZ=1Mzw@mail.gmail.com>
References: <1460988232.22654.7.camel@infradead.org>
	<20160418170534-mutt-send-email-mst@redhat.com>
	<1460992923.3765.8.camel@infradead.org>
	<20160418182320-mutt-send-email-mst@redhat.com>
	<1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
	<CALCETrXGC9X6fndftzUKKQ76TXSARHotW8Kz3KcO6opQ-oLaqA@mail.gmail.com>
	<20160419130732-mutt-send-email-mst@redhat.com>
	<CALCETrX72XV25B-0GdaMyJNkJRvvC8MbT4G=L5oGR=D5stpG6w@mail.gmail.com>
	<20160419190520-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160419190520-mutt-send-email-mst@redhat.com>
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

On Tue, Apr 19, 2016 at 9:09 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Apr 19, 2016 at 09:02:14AM -0700, Andy Lutomirski wrote:
>> On Tue, Apr 19, 2016 at 3:27 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Apr 18, 2016 at 12:24:15PM -0700, Andy Lutomirski wrote:
>> >> On Mon, Apr 18, 2016 at 11:29 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>> >> > For x86, you *can* enable virtio-behind-IOMMU if your DMAR tables tell
>> >> > the truth, and even legacy kernels ought to cope with that.
>> >> > FSVO 'ought to' where I suspect some of them will actually crash with a
>> >> > NULL pointer dereference if there's no "catch-all" DMAR unit in the
>> >> > tables, which puts it back into the same camp as ARM and Power.
>> >>
>> >> I think x86 may get a bit of a free pass here.  AFAIK the QEMU IOMMU
>> >> implementation on x86 has always been "experimental", so it just might
>> >> be okay to change it in a way that causes some older kernels to OOPS.
>> >>
>> >> --Andy
>> >
>> > Since it's experimental, it might be OK to change *guest kernels*
>> > such that they oops on old QEMU.
>> > But guest kernels were not experimental - so we need a QEMU mode that
>> > makes them work fine. The more functionality is available in this QEMU
>> > mode, the betterm because it's going to be the default for a while. For
>> > the same reason, it is preferable to also have new kernels not crash in
>> > this mode.
>> >
>>
>> People add QEMU features that need new guest kernels all time time.
>> If you enable virtio-scsi and try to boot a guest that's too old, it
>> won't work.  So I don't see anything fundamentally wrong with saying
>> that the non-experimental QEMU Q35 IOMMU mode won't boot if the guest
>> kernel is too old.  It might be annoying, since old kernels do work on
>> actual Q35 hardware, but it at least seems to be that it might be
>> okay.
>>
>> --Andy
>
> Yes but we need a mode that makes both old and new kernels work, and
> that should be the default for a while.  this is what the
> IOMMU_PASSTHROUGH flag was about: old kernels ignore it and bypass DMA
> API, new kernels go "oh compatibility mode" and bypass the IOMMU
> within DMA API.

I thought that PLATFORM served that purpose.  Woudn't the host
advertise PLATFORM support and, if the guest doesn't ack it, the host
device would skip translation?  Or is that problematic for vfio?

>
> --
> MST



-- 
Andy Lutomirski
AMA Capital Management, LLC
