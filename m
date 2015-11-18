From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 0/2] Google extension to improve qemu-nvme performance
Date: Tue, 17 Nov 2015 21:47:02 -0800
Message-ID: <1447825624-17011-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-nvme@lists.infradead.org, qemu-devel@nongnu.org
Cc: fes@google.com, keith.busch@intel.com, tytso@mit.edu, virtualization@lists.linux-foundation.org, axboe@fb.com, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rob & Mihai,

I wrote vhost-nvme patches on top of Christoph's NVMe target.
vhost-nvme still uses mmio. So the guest OS can run unmodified NVMe
driver. But the tests I have done didn't show competitive performance
compared to virtio-blk/virtio-scsi. The bottleneck is in mmio. Your nvme
vendor extension patches reduces greatly the number of MMIO writes.
So I'd like to push it upstream.

I port these 2 patches to newer kernel and qemu.
I use ram disk as backend to compare performance.

qemu-nvme: 29MB/s
qemu-nvme+google-ext: 100MB/s
virtio-blk: 174MB/s
virtio-scsi: 118MB/s

I'll show you qemu-vhost-nvme+google-ext number later.

root@guest:~# cat test.job 
[global]
bs=4k
ioengine=libaio
iodepth=64
direct=1
runtime=120
time_based
rw=randread
norandommap
group_reporting
gtod_reduce=1
numjobs=2

[job1]
filename=/dev/nvme0n1
#filename=/dev/vdb
#filename=/dev/sda
rw=read

Patches also available at:
kernel:
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext
qemu:
http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=nvme-google-ext 

Thanks,
Ming
