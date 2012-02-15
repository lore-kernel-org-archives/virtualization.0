From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH v2 0/2] Part 2: handle addr_assign_type for random addresses
Date: Wed, 15 Feb 2012 15:53:13 +0100
Message-ID: <1329317595-2031-1-git-send-email-danny.kukawka__23828.6397805952$1329317670$gmane$org@bisect.de>
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
To: "David S. Miller" <davem@davemloft.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Nicolas Ferre <nicolas.ferre@atmel.com>, Eilon Greenstein <eilong@broadcom.com>, James Morris <jmorris@namei.org>, Daniele Venzano <venza@brownhat.org>, Dennis Aberilla <denzzzhome@yahoo.com>, Stephen Hemminger <shemminger@vyatta.com>, David Decotigny <decot@google.com>, Wan ZongShun <mcuos.com@gmail.com>, Thomas Meyer <thomas@m3y3r.de>, dev@openvswitch.org, Samuel Ortiz <sameo@linux.intel.com>, Eric Dumazet <eric.dumazet@gmail.com>, bridge@lists.linux-foundation.org, Danny Kukawka <dkukawka@suse.de>, James Chapman <jchapman@katalix.com>, Simtec Linux Team <linux@simtec.co.uk>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Jon Mason <jdmason@kudzu.us>, virtualization@lists.linux-foundation.org, Alexey Dobriyan <adobriyan@gmail.com>, Paul <paul.gortmaker@windriver.com>, Rick Jones <rick.jones2@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

The second part of my patch series to fix the handling of 
addr_assign_type for random MAC addresses. This contains the
trival changes from random_ether_addr() to new
eth_hw_addr_random() and code to reset the state to 
NET_ADDR_PERM as soon as the MAC get changed via 
.ndo_set_mac_address where eth_mac_addr wasn't used.

Danny Kukawka (2):
  net: replace random_ether_addr() with eth_hw_addr_random()
  net: use eth_hw_addr_random() and reset addr_assign_type

 drivers/net/dummy.c                               |    3 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |    1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  |    2 +-
 drivers/net/ethernet/cadence/macb.c               |    2 +-
 drivers/net/ethernet/calxeda/xgmac.c              |    3 ++-
 drivers/net/ethernet/cirrus/ep93xx_eth.c          |    2 +-
 drivers/net/ethernet/davicom/dm9000.c             |    2 +-
 drivers/net/ethernet/dnet.c                       |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c          |    2 +-
 drivers/net/ethernet/faraday/ftmac100.c           |    2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c         |    3 ++-
 drivers/net/ethernet/micrel/ks8842.c              |    3 ++-
 drivers/net/ethernet/micrel/ks8851.c              |    3 ++-
 drivers/net/ethernet/micrel/ks8851_mll.c          |    1 +
 drivers/net/ethernet/microchip/enc28j60.c         |    3 ++-
 drivers/net/ethernet/mipsnet.c                    |    2 +-
 drivers/net/ethernet/natsemi/macsonic.c           |    2 +-
 drivers/net/ethernet/nvidia/forcedeth.c           |    3 ++-
 drivers/net/ethernet/rdc/r6040.c                  |    2 +-
 drivers/net/ethernet/sis/sis900.c                 |    2 +-
 drivers/net/ethernet/smsc/smsc911x.c              |    3 ++-
 drivers/net/ethernet/smsc/smsc9420.c              |    5 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 +-
 drivers/net/ethernet/tile/tilepro.c               |    3 ++-
 drivers/net/ethernet/toshiba/tc35815.c            |    2 +-
 drivers/net/ethernet/via/via-rhine.c              |    2 +-
 drivers/net/ifb.c                                 |    2 +-
 drivers/net/macvlan.c                             |    3 ++-
 drivers/net/team/team.c                           |    3 ++-
 drivers/net/tun.c                                 |    2 +-
 drivers/net/usb/smsc75xx.c                        |    2 +-
 drivers/net/usb/smsc95xx.c                        |    2 +-
 drivers/net/veth.c                                |    4 ++--
 drivers/net/virtio_net.c                          |    2 +-
 drivers/net/wan/hdlc_fr.c                         |    2 +-
 drivers/net/wan/hdlc_raw_eth.c                    |    2 +-
 net/bridge/br_device.c                            |    3 ++-
 net/ipv4/ip_gre.c                                 |    2 +-
 net/l2tp/l2tp_eth.c                               |    2 +-
 net/openvswitch/vport-internal_dev.c              |    3 ++-
 40 files changed, 55 insertions(+), 41 deletions(-)

-- 
1.7.8.3
