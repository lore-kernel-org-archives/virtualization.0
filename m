From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 00/10] RFC: move logical block size checking to the block core
Date: Tue, 21 Jul 2020 13:52:29 +0300
Message-ID: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-block-owner@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

This patch series aims to move the logical block size checking to the=0D
block code.=0D
=0D
This was inspired by missing check for valid logical block size in=0D
virtio-blk which causes the kernel to crash in a weird way later on=0D
when it is invalid.=0D
=0D
I added blk_is_valid_logical_block_size which returns true iff the=0D
block size is one of supported sizes.=0D
=0D
I added this check to virtio-blk, and also converted  few block drivers=0D
that I am familiar with to use this interface instead of their=0D
own implementation.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (10):=0D
  block: introduce blk_is_valid_logical_block_size=0D
  block: virtio-blk: check logical block size=0D
  block: loop: use blk_is_valid_logical_block_size=0D
  block: nbd: use blk_is_valid_logical_block_size=0D
  block: null: use blk_is_valid_logical_block_size=0D
  block: ms_block: use blk_is_valid_logical_block_size=0D
  block: mspro_blk: use blk_is_valid_logical_block_size=0D
  block: nvme: use blk_is_valid_logical_block_size=0D
  block: scsi: sd: use blk_is_valid_logical_block_size=0D
  block: scsi: sr: use blk_is_valid_logical_block_size=0D
=0D
 block/blk-settings.c                | 18 +++++++++++++++++=0D
 drivers/block/loop.c                | 23 +++++----------------=0D
 drivers/block/nbd.c                 | 12 ++---------=0D
 drivers/block/null_blk_main.c       |  6 +++---=0D
 drivers/block/virtio_blk.c          | 15 ++++++++++++--=0D
 drivers/memstick/core/ms_block.c    |  2 +-=0D
 drivers/memstick/core/mspro_block.c |  6 ++++++=0D
 drivers/nvme/host/core.c            | 17 ++++++++--------=0D
 drivers/scsi/sd.c                   |  5 +----=0D
 drivers/scsi/sr.c                   | 31 ++++++++++++-----------------=0D
 include/linux/blkdev.h              |  1 +=0D
 11 files changed, 71 insertions(+), 65 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D
