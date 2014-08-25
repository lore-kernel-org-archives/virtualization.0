From: Chris Friesen <chris.friesen@windriver.com>
Subject: help? looking for limits on in-flight write operations for virtio-blk
Date: Mon, 25 Aug 2014 13:42:53 -0600
Message-ID: <53FB91BD.40403@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm trying to figure out what controls the number if in-flight virtio 
block operations when running linux in qemu on top of a linux host.

The problem is that we're trying to run as many VMs as possible, using 
ceph/rbd for the rootfs.  We've tripped over the fact the the memory 
consumption of qemu can spike noticeably when doing I/O (something as 
simple as "dd" from /dev/zero to a file can cause the memory consumption 
to go up by 200MB--with dozens of VMs this can add up enough to trigger 
the OOM killer.

It looks like the rbd driver in qemu allocates a number of buffers for 
each request, one of which is the full amount of data to read/write. 
Monitoring the "inflight" numbers in the guest I've seen it go as high 
as 184.

I'm trying to figure out if there are any limits on how high the 
inflight numbers can go, but I'm not having much luck.

I was hopeful when I saw qemu calling virtio_add_queue() with a queue 
size, but the queue size was 128 which didn't match the inflight numbers 
I was seeing, and after changing the queue size down to 16 I still saw 
the number of inflight requests go up to 184 and then the guest took a 
kernel panic in virtqueue_add_buf().

Can someone with more knowledge of how virtio block works point me in 
the right direction?

Thanks,
Chris
