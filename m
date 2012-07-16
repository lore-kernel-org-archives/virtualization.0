From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Mon, 16 Jul 2012 12:58:21 +0100
Message-ID: <CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ__32822.6363556043$1342439917$gmane$org@mail.gmail.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342107302-28116-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 12, 2012 at 4:35 PM, Asias He <asias@redhat.com> wrote:
> This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
> device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
> gives about 5% to 15% performance improvement.

Why is it 5-15% faster?  vhost-blk and the userspace virtio-blk you
benchmarked should be doing basically the same thing:

1. An eventfd file descriptor is signalled when the vring has new
requests available from the guest.
2. A thread wakes up and processes the virtqueue.
3. Linux AIO is used to issue host I/O.
4. An interrupt is injected into the guest.

Does the vhost-blk implementation do anything fundamentally different
from userspace?  Where is the overhead that userspace virtio-blk has?

I'm asking because it would be beneficial to fix the overhead
(especially it that could speed up all userspace applications) instead
of adding a special-purpose kernel module to work around the overhead.

Stefan
