From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 16:29:42 +0800
Message-ID: <50052276.2080906__5794.34810574657$1342513678$gmane$org@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/16/2012 07:58 PM, Stefan Hajnoczi wrote:
> On Thu, Jul 12, 2012 at 4:35 PM, Asias He <asias@redhat.com> wrote:
>> This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
>> device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
>> gives about 5% to 15% performance improvement.
>
> Why is it 5-15% faster?  vhost-blk and the userspace virtio-blk you
> benchmarked should be doing basically the same thing:
>
> 1. An eventfd file descriptor is signalled when the vring has new
> requests available from the guest.
> 2. A thread wakes up and processes the virtqueue.
> 3. Linux AIO is used to issue host I/O.
> 4. An interrupt is injected into the guest.

Yes. This is how both of them work. Though, there are some differences 
in details. e.g.

In vhost-blk, we use the vhost's work infrastructure to handle the 
requests. In kvm tool, we use a dedicated thread.
In vhost-blk, we use irqfd to inject interrupts. In kvm tool, we use 
ioctl to inject interrupts.


> Does the vhost-blk implementation do anything fundamentally different
> from userspace?  Where is the overhead that userspace virtio-blk has?


Currently, no. But we could play with bio directly in vhost-blk as 
Christoph suggested which could make the IO path from guest to host's 
real storage even shorter in vhost-blk.

I've been trying my best to reduce the overhead of virtio-blk at kvm 
tool side. I do not see any significant overhead out there. Compared to 
vhost-blk, the overhead we have in userspace virito-blk is syscalls. In 
each IO request, we have

    epoll_wait() & read(): wait for the eventfd which guest notifies us
    io_submit(): submit the aio
    read(): read the aio complete eventfd
    io_getevents(): reap the aio complete result
    ioctl(): trigger the interrupt

So, vhost-blk at least saves ~6 syscalls for us in each request.

> I'm asking because it would be beneficial to fix the overhead
> (especially it that could speed up all userspace applications) instead
> of adding a special-purpose kernel module to work around the overhead.

I guess you mean qemu here. Yes, in theory, qemu's block layer can be 
improved to achieve similar performance as vhost-blk or kvm tool's 
userspace virito-blk has. But I think it makes no sense to prevent one 
solution becase there is another in theory solution called: we can do 
similar in qemu.

What do you mean by specail-purpose here, we need general-purpose kernel
module? Is vhost-net a special purpose kernel module?  Is xen-blkback a 
special-purpose kernel module? And I think vhost-blk is beneficial to 
qemu too, as well as any other kvm host side implementation.

-- 
Asias
