From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Wed, 2 Dec 2015 11:07:36 +0100
Message-ID: <565EC2E8.9010508@redhat.com>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448925639.27669.7.camel@ssi>
	<565DC48B.6030903@redhat.com> <1448987171.3041.2.camel@hasee>
	<998355860.30506151.1448989146641.JavaMail.zimbra@redhat.com>
	<1449033191.3041.11.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449033191.3041.11.camel@hasee>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: qemu-devel@nongnu.org, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 02/12/2015 06:13, Ming Lin wrote:
> On Tue, 2015-12-01 at 11:59 -0500, Paolo Bonzini wrote:
>>> What do you think about virtio-nvme+vhost-nvme?
>>
>> What would be the advantage over virtio-blk?  Multiqueue is not supported
>> by QEMU but it's already supported by Linux (commit 6a27b656fc).
> 
> I expect performance would be better.

Why?  nvme and virtio-blk are almost the same, even more so with the
doorbell extension.  virtio is designed to only hit paths that are not
slowed down by virtualization.  It's really hard to do better, except
perhaps with VFIO (and then you don't need your vendor extension).

>> To me, the advantage of nvme is that it provides more than decent performance on
>> unmodified Windows guests, and thanks to your vendor extension can be used
>> on Linux as well with speeds comparable to virtio-blk.  So it's potentially
>> a very good choice for a cloud provider that wants to support Windows guests
>> (together with e.g. a fast SAS emulated controller to replace virtio-scsi,
>> and emulated igb or ixgbe to replace virtio-net).
> 
> vhost-nvme patches are learned from rts-megasas, which could possibly be
> a fast SAS emulated controller.
> https://github.com/Datera/rts-megasas

Why the hate for userspace? :)

I don't see a reason why vhost-nvme would be faster than a userspace
implementation.  vhost-blk was never committed upstream for similar
reasons: it lost all the userspace features (snapshots, storage
migration, etc.)---which are nice to have and do not cost performance if
you do not use them---without any compelling performance gain.

Without the doorbell extension you'd have to go back to userspace on
every write and ioctl to vhost (see MEGASAS_IOC_FRAME in rts-megasas).
With the doorbell extension you're doing exactly the same work, and then
kernel thread vs. userspace thread shouldn't matter much given similar
optimization effort.  A userspace NVMe, however, will gain all
optimization that is done to QEMU's block layer for free.  We have done
a lot and have more planned.

>> Which features are supported by NVMe and not virtio-blk?

Having read the driver, the main improvements of NVMe compared to
virtio-blk are support for discard and FUA.  Discard is easy to add to
virtio-blk.  In the past the idea was "just use virtio-scsi", but it may
be worth adding it now that SSDs are more common.

Thus, FUA is pretty much the only reason for a kernel-based
implementation, because it is not exported in userspace.  However, does
it actually make a difference on real-world workloads?  Local SSDs on
Google Cloud are not even persistent, so you never need to flush to them.

Paolo
