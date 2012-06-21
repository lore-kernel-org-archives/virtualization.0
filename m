From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/13] drivers: hv: kvp
Date: Thu, 21 Jun 2012 14:30:00 -0700
Message-ID: <1340314200-27078-1-git-send-email-kys@microsoft.com>
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
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, apw@canonical.com
List-Id: virtualization@lists.linuxfoundation.org

This patchset expands the KVP (Key Value Pair) functionality to
implement the mechanism to get/set IP addresses in the guest. This
functionality is used in Windows Server 2012 to implement VM
replication functionality. The way IP configuration information
is managed is distro specific. The current implementation supports
RedHat way of doing things. We will expand support to other distros
incrementally. 



K. Y. Srinivasan (13):
  Drivers: hv: Add KVP definitions for IP address injection
  Drivers: hv: kvp: Cleanup error handling in KVP
  Drivers: hv: kvp: Support the new IP injection messages
  Tools: hv: Prepare to expand  kvp_get_ip_address() functionality
  Tools: hv: Further refactor kvp_get_ip_address()
  Tools: hv: Gather address family information
  Tools: hv: Gather subnet information
  Tools: hv: Represent the ipv6 mask using CIDR notation
  Tools: hv: Gather DNS information
  Tools: hv: Gather ipv[4,6] gateway information
  Tools: hv: Gather dhcp information
  Tools: hv: Implement the KVP verb - KVP_OP_GET_IP_INFO
  Tools: hv: Implement the KVP verb - KVP_OP_SET_IP_INFO

 drivers/hv/hv_kvp.c      |  103 ++++++--
 include/linux/hyperv.h   |   39 +++-
 tools/hv/hv_kvp_daemon.c |  650 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 686 insertions(+), 106 deletions(-)

-- 
1.7.4.1
