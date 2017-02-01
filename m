From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/14] hyperv: vmbus related patches
Date: Wed,  1 Feb 2017 08:28:47 -0800
Message-ID: <20170201162901.3894-1-sthemmin@microsoft.com>
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
To: kys@microsoft.com, gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a rebase/resend of earlier patches. I skipped the pure
cosmetic patches for now.  Mostly this is consolidation earlier
changes, removing dead code etc.  The important part is the
change for allowing a vmbus channel to get callback directly
in interrupt mode; this is necessary for NAPI support.

Stephen Hemminger (14):
  vmbus: use kernel bitops for traversing interrupt mask
  vmbus: drop no longer used kick_q argument
  vmbus: remove no longer used signal_policy
  vmbus: remove unused kickq argument to sendpacket
  netvsc: remove no longer needed receive staging buffers
  vmbus: remove per channel state
  vmbus: callback is in softirq not workqueue
  vmbus: put related per-cpu variable together
  vmbus: change to per channel tasklet
  vmbus: add direct isr callback mode
  vmbus: remove conditional locking of vmbus_write
  vmbus: expose hv_begin/end_read
  vmbus: constify parameters where possible
  vmbus: replace modulus operation with subtraction

Starting point was top of current char-misc-next branch.

 drivers/hv/channel.c              |  47 +++++--------
 drivers/hv/channel_mgmt.c         |  41 ++++++------
 drivers/hv/connection.c           | 134 +++++---------------------------------
 drivers/hv/hv.c                   | 124 +++++++++++++++--------------------
 drivers/hv/hv_util.c              |   3 +-
 drivers/hv/hyperv_vmbus.h         |  80 ++++++++++++-----------
 drivers/hv/ring_buffer.c          |  66 ++++++-------------
 drivers/hv/vmbus_drv.c            | 115 ++++++++++++++++++++++++++------
 drivers/net/hyperv/hyperv_net.h   |   5 --
 drivers/net/hyperv/netvsc.c       | 104 ++++-------------------------
 drivers/net/hyperv/rndis_filter.c |  11 ----
 drivers/uio/uio_hv_generic.c      |   2 +-
 include/linux/hyperv.h            | 134 +++++++++++++++++---------------------
 13 files changed, 338 insertions(+), 528 deletions(-)

-- 
2.11.0
