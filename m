From: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Subject: [PATCH 00/11] Replace printk_rateilimit() with printk_ratelimited()
Date: Thu, 16 Jun 2011 14:06:04 +0200
Message-ID: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>, Steve Wise <swise@chelsio.com>, Roland Dreier <roland@kernel.org>, Sean Hefty <sean.hefty@intel.com>, Hal Rosenstock <hal.rosenst>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

since the printk_ratelimit() function shouldn't be used anymore, I replaced it
in a few files with printk_ratelimited().

If you wish some more patches I can send more in.

Greets,
Manu

Manuel Zerpies (11):
  drivers/ide: use printk_ratelimited() instead of printk_ratelimit()
  drivers/tty: use printk_ratelimited() instead of printk_ratelimit()
  net/can: use printk_ratelimited() instead of printk_ratelimit()
  net/rds: use prink_ratelimited() instead of printk_ratelimit()
  RDMA/hw/cxgb4: use printk_ratelimited() instead of printk_ratelimit()
  drivers/net: use printk_ratelimited() instead of printk_ratelimit()
  drivers/usb/atm: use printk_ratelimited() instead of
    printk_ratelimit()
  [SCSI] tcm_fc: use printk_ratelimited() instead of printk_ratelimit()
  xen/xenbus: use printk_ratelimited() instead of printk_ratelimit()
  wusb: use printk_ratelimited() instead of printk_ratelimit()
  usb/class: use printk_ratelimited() instead of printk_ratelimit()

 drivers/ide/ide-atapi.c                |    4 ++--
 drivers/infiniband/hw/cxgb4/resource.c |    9 +++++----
 drivers/net/sc92031.c                  |   16 ++++++----------
 drivers/target/tcm_fc/tfc_io.c         |    4 ++--
 drivers/tty/moxa.c                     |    5 +++--
 drivers/tty/mxser.c                    |    4 ++--
 drivers/tty/tty_io.c                   |    4 ++--
 drivers/usb/atm/usbatm.c               |    4 ++--
 drivers/usb/class/usblp.c              |    7 +++----
 drivers/usb/wusbcore/wa-xfer.c         |    7 +++----
 drivers/xen/xenbus/xenbus_xs.c         |    4 ++--
 net/can/af_can.c                       |    5 +++--
 net/rds/bind.c                         |    4 ++--
 net/rds/ib_cm.c                        |    6 +++---
 net/rds/ib_send.c                      |    4 ++--
 net/rds/iw_cm.c                        |    9 ++++-----
 net/rds/iw_rdma.c                      |    9 +++++----
 net/rds/iw_send.c                      |    4 ++--
 net/rds/send.c                         |    7 +++----
 19 files changed, 56 insertions(+), 60 deletions(-)

-- 
1.7.4.1
