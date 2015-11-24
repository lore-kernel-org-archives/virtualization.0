From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Tue, 24 Nov 2015 11:51:14 +0100
Message-ID: <56544122.3010300@redhat.com>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448350074.6696.3.camel@hasee>
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
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 24/11/2015 08:27, Ming Lin wrote:
> handle_notify (qemu/hw/block/dataplane/virtio-blk.c:126)
> aio_dispatch (qemu/aio-posix.c:329)
> aio_poll (qemu/aio-posix.c:474)
> iothread_run (qemu/iothread.c:45)
> start_thread (pthread_create.c:312)
> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)
> 
> I think I'll have a "nvme_dev_notify" similar as "handle_notify"
> 
> static void nvme_dev_notify(EventNotifier *e)
> {
>     ....
> }
> 
> But then how can I know this notify is for cq or sq?

virtio-blk has a single queue, so it has a single EventNotifier.  Your
code using multiple EventNotifiers is fine, you can use
aio_set_event_notifier multiple times on the same iothread.

Paolo
