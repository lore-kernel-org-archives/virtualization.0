From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 0/2] virtio nvme
Date: Wed,  9 Sep 2015 22:48:30 -0700
Message-ID: <1441864112-12765-1-git-send-email-mlin@kernel.org>
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
To: linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
Cc: Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

These 2 patches added virtio-nvme to kernel and qemu,
basically modified from virtio-blk and nvme code.

As title said, request for your comments.

Play it in Qemu with:
-drive file=disk.img,format=raw,if=none,id=D22 \
-device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4

The goal is to have a full NVMe stack from VM guest(virtio-nvme)
to host(vhost_nvme) to LIO NVMe-over-fabrics target.

Now there are lots of duplicated code with linux/nvme-core.c and qemu/nvme.c.
The ideal result is to have a multi level NVMe stack(similar as SCSI).
So we can re-use the nvme code, for example

                        .-------------------------.
                        | NVMe device register    |
  Upper level           | NVMe protocol process   |
                        |                         |
                        '-------------------------'



              .-----------.    .-----------.    .------------------.
 Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
              |           |    |           |    |initiator         |
              '-----------'    '-----------'    '------------------'

todo:
 - tune performance. Should be as good as virtio-blk/virtio-scsi
 - support discard/flush/integrity
 - need Redhat's help for the VIRTIO_ID_NVME pci id
 - multi level NVMe stack

Code also available at:
http://www.minggr.net/cgit/cgit.cgi/linux/commit/?h=virtio-nvme/v1
http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=virtio-nvme/v1

Thanks,
Ming
