From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 0/9] netvsc bug fixes and cleanups
Date: Thu, 21 Jul 2011 10:14:48 -0700
Message-ID: <1311268497-8671-1-git-send-email-haiyangz__33853.5060560845$1311267582$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

Fixed a set of bugs in netvsc module, and cleaned up some coding style issues.

Haiyang Zhang (9):
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

 drivers/staging/hv/netvsc.c       |  124 ++++++++++++++++++++-----------------
 drivers/staging/hv/netvsc_drv.c   |   46 +++++++-------
 drivers/staging/hv/rndis_filter.c |   28 ++++++---
 3 files changed, 111 insertions(+), 87 deletions(-)
