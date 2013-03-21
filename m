From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Thu, 21 Mar 2013 12:35:25 +0200
Message-ID: <20130321103525.GA30847@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130321101300.GA30493@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 12:13:00PM +0200, Michael S. Tsirkin wrote:
> On Thu, Mar 21, 2013 at 06:59:37PM +1030, Rusty Russell wrote:
> > (MST, is this what you were thinking?)
> 
> Almost.
> 
> Three points:
> 
> 1. this is still an offset in BAR so for KVM we are still forced to use
> an IO BAR.  I would like an option for hypervisor to simply say "Do IO
> to this fixed address for this VQ". Then virtio can avoid using IO BARs
> completely.
> 
> 2.  for a real virtio device, offset is only 16 bit, using a 32 bit
> offset in a memory BAR giving each VQ a separate 4K page would allow
> priveledge separation where e.g. RXVQ/TXVQ are passed through to
> hardware but CVQ is handled by the hypervisor.
> 
> 3. last thing - (1) applies to ISR reads as well.
> 
> So I had in mind a structure like:
> 
> 	struct vq_notify {
> 		u32 offset;
> 		u16 data;
> 		u16 flags;
> 	}
> 
> enum vq_notify_flags {
> 	VQ_NOTIFY_BAR0,
> 	VQ_NOTIFY_BAR1,
> 	VQ_NOTIFY_BAR2,
> 	VQ_NOTIFY_BAR3,
> 	VQ_NOTIFY_BAR4,
> 	VQ_NOTIFY_BAR5,
> 	VQ_NOTIFY_FIXED_IOPORT,
> }
> 
> And then to notify a vq we write a given data at given offset
> or into a given port for VQ_NOTIFY_FIXED_IOPORT.
> 
> Only point 1 is really important for me though, I can be
> flexible on the rest of it.

So the minimal change on top of this patch, would be adding a FIXED
option to BIR and reporting data and not just offset for queue_notify
(so it can include device info if we share same address between
devices).

-- 
MST
