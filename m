From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/24] block, scsi: final compat_ioctl cleanup
Date: Wed, 11 Dec 2019 21:42:34 +0100
Message-ID: <20191211204306.1207817-1-arnd__36216.1022074119$1576097157$gmane$org@arndb.de>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: justin@coraid.com, mst@redhat.com, catalin.marinas@arm.com, Kai.Makisara@kolumbus.fi, linux-ide@vger.kernel.org, artur.paszkiewicz@intel.com, will@kernel.org, tim@cyberelk.net, anton.ivanov@cambridgegreys.com, hare@suse.com, sstabellini@kernel.org, linux-scsi@vger.kernel.org, corbet@lwn.net, y2038@lists.linaro.org, richard@nod.at, linux-doc@vger.kernel.org, dgilbert@interlog.com, xen-devel@lists.xenproject.org, jinpu.wang@cloud.ionos.com, intel-linux-scu@intel.com, Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, jdike@addtoit.com, john.garry@huawei.com, linux-um@lists.infradead.org, efremov@linux.com, linux-block@vger.kernel.org, brking@us.ibm.com, bp@alien8.de, stefanha@redhat.com, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, jgross@suse.com, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.j
List-Id: virtualization@lists.linuxfoundation.org

Hi Jens, James and Martin,

This series concludes the work I did for linux-5.5 on the compat_ioctl()
cleanup, killing off fs/compat_ioctl.c and block/compat_ioctl.c by moving
everything into drivers.

Overall this would be a reduction both in complexity and line count, but
as I'm also adding documentation the overall number of lines increases
in the end.

My plan was originally to keep the SCSI and block parts separate.
This did not work easily because of interdependencies: I cannot
do the final SCSI cleanup in a good way without first addressing the
CDROM ioctls, so this is one series that I hope could be merged through
either the block or the scsi git trees, or possibly both if you can
pull in the same branch.

The series comes in these steps:

1. clean up the sg v3 interface as suggested by Linus. I have
   talked about this with Doug Gilbert as well, and he would
   rebase his sg v4 patches on top of "compat: scsi: sg: fix v3
   compat read/write interface"

2. Four patches for missing block compat_ioctl handlers, to be
   backported into stable kernels. Separate patches because they
   are needed in different stable versions.

3. Actually moving handlers out of block/compat_ioctl.c and
   block/scsi_ioctl.c into drivers, mixed in with cleanup
   patches

4. Document how to do this right. I keep getting asked about this,
   and it helps to point to some documentation file.

The series is avaialable for testing at [1].

       Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=compat-ioctl-endgame

Arnd Bergmann (24):
  compat: ARM64: always include asm-generic/compat.h
  compat: scsi: sg: fix v3 compat read/write interface
  compat_ioctl: block: handle BLKREPORTZONE/BLKRESETZONE
  compat_ioctl: block: handle BLKGETZONESZ/BLKGETNRZONES
  compat_ioctl: block: handle add zone open, close and finish ioctl
  compat_ioctl: block: handle Persistent Reservations
  compaT_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
  compat_ioctl: move CDROM_SEND_PACKET handling into scsi
  compat_ioctl: move CDROMREADADIO to cdrom.c
  compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
  compat_ioctl: block: handle cdrom compat ioctl in non-cdrom drivers
  compat_ioctl: add scsi_compat_ioctl
  compat_ioctl: bsg: add handler
  compat_ioctl: ide: floppy: add handler
  compat_ioctl: scsi: move ioctl handling into drivers
  compat_ioctl: move sys_compat_ioctl() to ioctl.c
  compat_ioctl: simplify the implementation
  compat_ioctl: move cdrom commands into cdrom.c
  compat_ioctl: scsi: handle HDIO commands from drivers
  compat_ioctl: move HDIO ioctl handling into drivers/ide
  compat_ioctl: block: move blkdev_compat_ioctl() into ioctl.c
  compat_ioctl: block: simplify compat_blkpg_ioctl()
  compat_ioctl: simplify up block/ioctl.c
  Documentation: document ioctl interfaces better

 Documentation/core-api/index.rst       |   1 +
 Documentation/core-api/ioctl.rst       | 250 +++++++++++++++
 arch/arm64/include/asm/compat.h        |   5 +-
 arch/um/drivers/ubd_kern.c             |   1 +
 block/Makefile                         |   1 -
 block/bsg.c                            |   1 +
 block/compat_ioctl.c                   | 411 -------------------------
 block/ioctl.c                          | 319 +++++++++++++++----
 block/scsi_ioctl.c                     | 214 ++++++++-----
 drivers/ata/libata-scsi.c              |   9 +
 drivers/block/aoe/aoeblk.c             |   1 +
 drivers/block/floppy.c                 |   3 +
 drivers/block/paride/pcd.c             |   3 +
 drivers/block/paride/pd.c              |   1 +
 drivers/block/paride/pf.c              |   1 +
 drivers/block/pktcdvd.c                |  26 +-
 drivers/block/sunvdc.c                 |   1 +
 drivers/block/virtio_blk.c             |   3 +
 drivers/block/xen-blkfront.c           |   1 +
 drivers/cdrom/cdrom.c                  |  35 ++-
 drivers/cdrom/gdrom.c                  |   3 +
 drivers/ide/ide-cd.c                   |  40 +++
 drivers/ide/ide-disk.c                 |   3 +
 drivers/ide/ide-floppy.c               |   4 +
 drivers/ide/ide-floppy.h               |   2 +
 drivers/ide/ide-floppy_ioctl.c         |  35 +++
 drivers/ide/ide-gd.c                   |  14 +
 drivers/ide/ide-ioctls.c               |  47 ++-
 drivers/ide/ide-tape.c                 |  14 +
 drivers/scsi/aic94xx/aic94xx_init.c    |   3 +
 drivers/scsi/ch.c                      |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   3 +
 drivers/scsi/ipr.c                     |   3 +
 drivers/scsi/isci/init.c               |   3 +
 drivers/scsi/mvsas/mv_init.c           |   3 +
 drivers/scsi/pm8001/pm8001_init.c      |   3 +
 drivers/scsi/scsi_ioctl.c              |  54 +++-
 drivers/scsi/sd.c                      |  50 ++-
 drivers/scsi/sg.c                      | 169 +++++-----
 drivers/scsi/sr.c                      |  53 +++-
 drivers/scsi/st.c                      |  51 +--
 fs/Makefile                            |   2 +-
 fs/compat_ioctl.c                      | 261 ----------------
 fs/internal.h                          |   6 -
 fs/ioctl.c                             | 131 +++++---
 include/linux/blkdev.h                 |   7 +
 include/linux/falloc.h                 |   2 -
 include/linux/fs.h                     |   4 -
 include/linux/ide.h                    |   2 +
 include/linux/libata.h                 |   6 +
 include/scsi/scsi_ioctl.h              |   1 +
 include/scsi/sg.h                      |  30 ++
 54 files changed, 1249 insertions(+), 1062 deletions(-)
 create mode 100644 Documentation/core-api/ioctl.rst
 delete mode 100644 block/compat_ioctl.c
 delete mode 100644 fs/compat_ioctl.c

-- 
2.20.0

Cc: corbet@lwn.net
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: jdike@addtoit.com
Cc: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com
Cc: fujita.tomonori@lab.ntt.co.jp
Cc: justin@coraid.com
Cc: efremov@linux.com
Cc: tim@cyberelk.net
Cc: mst@redhat.com
Cc: jasowang@redhat.com
Cc: pbonzini@redhat.com
Cc: stefanha@redhat.com
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: sstabellini@kernel.org
Cc: konrad.wilk@oracle.com
Cc: roger.pau@citrix.com
Cc: bp@alien8.de
Cc: davem@davemloft.net
Cc: john.garry@huawei.com
Cc: brking@us.ibm.com
Cc: intel-linux-scu@intel.com
Cc: artur.paszkiewicz@intel.com
Cc: jinpu.wang@cloud.ionos.com
Cc: dgilbert@interlog.com
Cc: Kai.Makisara@kolumbus.fi
Cc: arnd@arndb.de
Cc: damien.lemoal@hgst.com
Cc: hare@suse.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: xen-devel@lists.xenproject.org
Cc: linux-fsdevel@vger.kernel.org
