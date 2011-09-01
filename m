From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 00/10] netvsc bug fixes and cleanups
Date: Thu,  1 Sep 2011 12:19:38 -0700
Message-ID: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Fixed a set of bugs in netvsc module, and cleaned up some coding style issues.

Haiyang Zhang (10):
  staging: hv: remove unnecessary includes in netvsc
  staging: hv: add newline to log messages in netvsc
  staging: hv: convert dev_<loglevel> to netdev_<loglevel> in netvsc
  staging: hv: fix a kernel warning in netvsc_linkstatus_callback()
  staging: hv: re-order the code in netvsc_probe()
  staging: hv: fix counting of #outstanding-sends in failed sends
  staging: hv: fix counting of available buffer slots when send fails
  staging: hv: fix the return status of netvsc_start_xmit()
  staging: hv: fix the page buffer when rndis data go across page
    boundary
  staging: hv: fix some typos in netvsc.c

 drivers/staging/hv/netvsc.c       |  124 ++++++++++++++++++++-----------------
 drivers/staging/hv/netvsc_drv.c   |   44 +++++++------
 drivers/staging/hv/rndis_filter.c |   28 ++++++---
 3 files changed, 110 insertions(+), 86 deletions(-)
