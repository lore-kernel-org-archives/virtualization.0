From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Remove virtio device during shutdown
Date: Fri, 13 Mar 2015 15:17:23 +0100
Message-ID: <20150313151657-mutt-send-email-mst@redhat.com>
References: <1426061357-4440-1-git-send-email-famz@redhat.com>
	<20150311095814-mutt-send-email-mst@redhat.com>
	<20150311101135.GA13653@ad.nay.redhat.com>
	<20150312172138-mutt-send-email-mst@redhat.com>
	<20150312233552.GB32054@ad.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150312233552.GB32054@ad.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 13, 2015 at 07:35:52AM +0800, Fam Zheng wrote:
> On Thu, 03/12 17:22, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2015 at 06:11:35PM +0800, Fam Zheng wrote:
> > > On Wed, 03/11 10:06, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 11, 2015 at 04:09:17PM +0800, Fam Zheng wrote:
> > > > > Currently shutdown is nop for virtio devices, but the core code could
> > > > > remove things behind us such as MSI-X handler etc. For example in the
> > > > > case of virtio-scsi-pci, the device may still try to send interupts,
> > > > > which will be on IRQ lines seeing MSI-X disabled. Those interrupts will
> > > > > be unhandled, and may cause flood.
> > > 
> > > Here is the problem I want to solve - file system driver hang:
> > > 
> > > If a fs code happen to hit __wait_on_buffer right after pci pci_device_shutdown
> > > disabled msix, it will never make progress because the requests it waits for
> > > will never be completed. So the system hangs.
> > 
> > Paolo says that pci reset of virtio scsi device guarantees
> > that all outstanding requests complete.
> > 
> > If true and implemented correctly, I don't see what else
> > needs to be done.
> > 
> > You will need to debug this some more.
> 
> First of all I was wrong about the fs driver above, scratch that, I'm sorry for
> the misleading.
> 
> Regarding the hang in shutdown, Ulrich Obergfell has already pointed out that
> the vcpu is "busy/stuck in interrupt processing":
> 
> https://bugzilla.redhat.com/attachment.cgi?id=998391 (RHBZ 1199155)
> 
> Summary: The reason it is stuck is that an IRQ from virtio-scsi-pci is not
> handled. Why is there that IRQ? Because pci core code disabled msix. Why is it
> not handled?  Because it's done behind virtio-scsi, who still is waiting for
> msix.
> 
> "Hence, the interrupt will not be acknowledged and the guest becomes flooded
> with IRQ 11 interrupt."
> 
> Fortunately it's not a livelock for upstream, because of:
> 
>     commit 184564efae4d775225c8fe3b762a56956fb1f827
>     Author: Zhang Haoyu <zhanghy@sangfor.com>
>     Date:   Thu Sep 11 16:47:04 2014 +0800
> 
>     kvm: ioapic: conditionally delay irq delivery duringeoi broadcast
> 
> But we still should do the shutdown right.
> 
> I also propose to not shutdown msix from pci core shutdown if the device
> doesn't have shutdown function:
> 
> http://www.spinics.net/lists/kernel/msg1944041.html

Makes sense.
Can you bounce this one to me please?
I'll ack.

> With that patch is applied, the "nop" .shutdown in virtio-pci shouldn't hurt
> much.
> 
> Regarding handing the requests, now I don't know if we really care about them
> at shutdown. As you said, waiting for requests may cause more hang.
> 
> Ideas?
> 
> Fam
