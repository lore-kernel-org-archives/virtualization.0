From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [snabb-devel] Re: memory barriers in virtq.lua?
Date: Tue, 7 Apr 2015 17:30:59 +0200
Message-ID: <20150407172849-mutt-send-email-mst__44328.556667506$1428420684$gmane$org@redhat.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
	<CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2015 at 04:22:42PM +0200, Luke Gorrie wrote:
> Hi Michael,
> 
> I'm writing to follow up the previous discussion about memory barriers in
> virtio-net device implementations, and Cc'ing the DPDK list because I believe
> this is relevant to them too.
> 
> First, thanks again for getting in touch and reviewing our code.
> 
> I have now found a missed case where we *do* require a hardware memory barrier
> on x86 in our vhost/virtio-net device. That is when checking the interrupt
> suppression flag after updating used->idx. This is needed because x86 can
> reorder the write to used->idx after the read from avail->flags, and that
> causes the guest to see a stale value of used->idx after it toggles interrupt
> suppression.
> 
> If I may spell out my mental model, for the sake of being corrected and/or as
> an example of how third party developers are reading and interpreting the
> Virtio-net spec:
> 
> Relating this to Virtio 1.0, the most relevant section is 3.2.1 (Supplying
> Buffers to the Device) which calls for two "suitable memory barriers". The spec
> talks about these from the driver perspective, but they are both relevant to
> the device side too.
> 
> The first barrier (write to descriptor table before write to used->idx) is
> implicit on x86 because writes by the same core are not reordered. This means
> that no explicit hardware barrier is needed. (A compiler barrier may be needed,
> however.)
> 
> The second memory barrier (write to used->idx before reading avail->flags) is
> not implicit on x86 because stores are reordered after loads. So an explicit
> hardware memory barrier is needed.
> 
> I hope that is a correct assessment of the situation. (Forgive my
> x86centricity, I am sure that seems very foreign to kernel hackers.)
> 
> If this assessment is correct then the DPDK developers might also want to
> review librte_vhost/vhost_rxtx.c and consider adding a hardware memory barrier
> between writing used->idx and reading avail->flags.
> 
> Cheers,
> -Luke

I agree, this looks like a bug in dpdk.

> P.S. I notice that the Linux virtio-net driver does not seem to tolerate
> spurious interrupts, even though the Virtio 1.0 spec requires this ("must"). On
> 3.13.11-ckt15 I see them trigger an "irq nobody cared" kernel log message and
> then the irq is disabled. If that sounds suspicious I can supply more
> information.
> 
>

More information might be useful, yes.

Just guessing from the available info:

I think you refer to this:
        The driver MUST handle spurious interrupts from the device.

The intent is to be able to handle some spurious interrupts once in a
while.  AFAIK linux triggers the message if it gets a huge number of
spurious interrupts for an extended period of time.
For example, this will trigger if the device does not clear interrupt
line after interrupt register read.
