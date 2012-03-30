From: Ren Mingxin <renmx@cn.fujitsu.com>
Subject: [PATCH 0/4] block: move sd_format_disk_name() into block core as
	disk_name_format()
Date: Fri, 30 Mar 2012 17:50:12 +0800
Message-ID: <4F7581D4.4040301__42679.3468920097$1333381107$gmane$org@cn.fujitsu.com>
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
To: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>
Cc: VIRTUAL <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>, KVM <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



This patch series renames "sd_format_disk_name()" to
"disk_name_format()" and moves it into block core. So
that who needs formatting disk name can use it, instead
of duplicating these similar help functions.

Ren Mingxin (4):
   block: add function disk_name_format() into block core
   scsi: replace sd_format_disk_name() to disk_name_format()
   block: replace rssd_disk_name_format() to disk_name_format()
   virtio_blk: use disk_name_format() to support mass of disks naming

  block/genhd.c                     |   49 ++++++++++++++++++++++++++++++++++++++
  drivers/block/mtip32xx/mtip32xx.c |   33 -------------------------
  drivers/block/virtio_blk.c        |   13 ----------
  drivers/scsi/sd.c                 |   48 -------------------------------------
  include/linux/genhd.h             |    2 +
  5 files changed, 54 insertions(+), 91 deletions(-)

Any comment will be appreciated.

Thanks,
Ren
