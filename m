From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Tue, 01 Dec 2015 21:13:11 -0800
Message-ID: <1449033191.3041.11.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448925639.27669.7.camel@ssi>
	<565DC48B.6030903@redhat.com> <1448987171.3041.2.camel@hasee>
	<998355860.30506151.1448989146641.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <998355860.30506151.1448989146641.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2015-12-01 at 11:59 -0500, Paolo Bonzini wrote:
> > What do you think about virtio-nvme+vhost-nvme?
> 
> What would be the advantage over virtio-blk?  Multiqueue is not supported
> by QEMU but it's already supported by Linux (commit 6a27b656fc).

I expect performance would be better.

Seems google cloud VM uses both nvme and virtio-scsi. Not sure if
virtio-blk is also used.
https://cloud.google.com/compute/docs/disks/local-ssd#runscript

> 
> To me, the advantage of nvme is that it provides more than decent performance on
> unmodified Windows guests, and thanks to your vendor extension can be used
> on Linux as well with speeds comparable to virtio-blk.  So it's potentially
> a very good choice for a cloud provider that wants to support Windows guests
> (together with e.g. a fast SAS emulated controller to replace virtio-scsi,
> and emulated igb or ixgbe to replace virtio-net).

vhost-nvme patches are learned from rts-megasas, which could possibly be
a fast SAS emulated controller.
https://github.com/Datera/rts-megasas

> 
> Which features are supported by NVMe and not virtio-blk?

Rob (CCed),

Would you share whether google uses any NVMe specific feature?

Thanks.
