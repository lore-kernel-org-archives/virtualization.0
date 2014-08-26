From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: help? looking for limits on in-flight write operations for
	virtio-blk
Date: Tue, 26 Aug 2014 11:34:56 +0100
Message-ID: <CAJSP0QU1e5eZoSm3nbBC4=ePHG21ABVh6+Kjo+SAFnvviLCPAg@mail.gmail.com>
References: <53FB91BD.40403@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FB91BD.40403@windriver.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Friesen <chris.friesen@windriver.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Jeff Cody <jcody@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 25, 2014 at 8:42 PM, Chris Friesen
<chris.friesen@windriver.com> wrote:
> I'm trying to figure out what controls the number if in-flight virtio block
> operations when running linux in qemu on top of a linux host.
>
> The problem is that we're trying to run as many VMs as possible, using
> ceph/rbd for the rootfs.  We've tripped over the fact the the memory
> consumption of qemu can spike noticeably when doing I/O (something as simple
> as "dd" from /dev/zero to a file can cause the memory consumption to go up
> by 200MB--with dozens of VMs this can add up enough to trigger the OOM
> killer.
>
> It looks like the rbd driver in qemu allocates a number of buffers for each
> request, one of which is the full amount of data to read/write. Monitoring
> the "inflight" numbers in the guest I've seen it go as high as 184.
>
> I'm trying to figure out if there are any limits on how high the inflight
> numbers can go, but I'm not having much luck.
>
> I was hopeful when I saw qemu calling virtio_add_queue() with a queue size,
> but the queue size was 128 which didn't match the inflight numbers I was
> seeing, and after changing the queue size down to 16 I still saw the number
> of inflight requests go up to 184 and then the guest took a kernel panic in
> virtqueue_add_buf().
>
> Can someone with more knowledge of how virtio block works point me in the
> right direction?

You can use QEMU's I/O throttling as a workaround:
qemu -drive ...,iops=64

libvirt has XML syntax for specifying iops limits.  Please see
<iotune> at http://libvirt.org/formatdomain.html.

I have CCed Josh Durgin and Jeff Cody for ideas on reducing
block/rbd.c memory consumption.  Is it possible to pass a
scatter-gather list so I/O can be performed directly on guest memory?
This would also improve performance slightly.

Stefan
