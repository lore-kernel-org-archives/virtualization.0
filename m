From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/2] block: virtio-blk: support multi virt queues per
	virtio-blk device
Date: Mon, 14 Dec 2015 11:31:26 +0100
Message-ID: <566E9A7E.3030203__44084.7067897723$1450089108$gmane$org@redhat.com>
References: <1402680562-8328-1-git-send-email-ming.lei@canonical.com>
	<1402680562-8328-3-git-send-email-ming.lei@canonical.com>
	<CAJSP0QWaS--gPZ=ONFrXby1DQLw4R0RCro7bpHCdmucyjmqT_w@mail.gmail.com>
	<CACVXFVO0SybUKArQbKkj2+hbk6q_gt3SBooNNmw1jErRR8d07A@mail.gmail.com>
	<53A06475.7000308@redhat.com>
	<CACVXFVO6GDu7Cp=s7kn_XBE2EFnuh+XQs4UQKTFaCLi4_9jcgg@mail.gmail.com>
	<53A06E05.9060708@redhat.com>
	<CACVXFVMkV5R5GUjM7Y-U54SA-ENZZ26dbbv4K2_OYPdmmiuUqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVMkV5R5GUjM7Y-U54SA-ENZZ26dbbv4K2_OYPdmmiuUqg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



On 18/06/2014 06:04, Ming Lei wrote:
> For virtio-blk, I don't think it is always better to take more queues, and
> we need to leverage below things in host side:
> 
> - host storage top performance, generally it reaches that with more
> than 1 jobs with libaio(suppose it is N, so basically we can use N
> iothread per device in qemu to try to get top performance)
> 
> - iothreads' loading(if iothreads are at full loading, increasing
> queues doesn't help at all)
> 
> In my test, I only use the current per-dev iothread(x-dataplane)
> in qemu to handle 2 vqs' notification and precess all I/O from
> the 2 vqs, and looks it can improve IOPS by ~30%.
> 
> For virtio-scsi, the current usage doesn't make full use of blk-mq's
> advantage too because only one vq is active at the same time, so I
> guess the multi vqs' benefit won't be very much and I'd like to post
> patches to support that first, then provide test data with
> more queues(8, 16).

Hi Ming Lei,

would you like to repost these patches now that MQ support is in the kernel?

Also, I changed my mind about moving linux-aio to AioContext.  I now
think it's a good idea, because it limits the number of io_getevents
syscalls. O:-)  So I would be happy to review your patches for that as well.

Paolo
