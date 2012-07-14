From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/15] drivers: hv: kvp
Date: Sat, 14 Jul 2012 13:32:10 -0700
Message-ID: <1342297930-12607-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This patchset expands the KVP (Key Value Pair) functionality to
implement the mechanism to GET/SET IP addresses in the guest. This
functionality is used in Windows Server 2012 to implement VM
replication functionality. The way IP configuration information
is managed is distro specific. Based on the feedback I have gotten
from Olaf, Greg, Steve, Ben and Mairus, I have chosen to seperate
distro specific code from this patch-set. Most of the GET operation
can be implemented in a way that is completely distro independent and
I have implemented that as such and is included in this patch-set.
Some of the attributes that can only be fetched in a distro
dependent way as well the mechanism for configuring an interface
(the SET operation) that is cledarly distro specific is to be
implemented via external scripts that will be invoked via the KVP
code. We define here the interface to these scripts.

K. Y. Srinivasan (15):
  Drivers: hv: Format GUIDS as per MSFT standards
  Drivers: hv: Add KVP definitions for IP address injection
  Drivers: hv: kvp: Cleanup error handling in KVP
  Drivers: hv: kvp: Support the new IP injection messages
  Tools: hv: Prepare to expand  kvp_get_ip_address() functionality
  Tools: hv: Further refactor kvp_get_ip_address()
  Tools: hv: Gather address family information
  Tools: hv: Gather subnet information
  Tools: hv: Represent the ipv6 mask using CIDR notation
  Tools: hv: Gather ipv[4,6] gateway information
  Tools: hv: Gather DNS information
  Tools: hv: Gather DHCP information
  Tools: hv: Implement the KVP verb - KVP_OP_SET_IP_INFO
  Tools: hv: Rename the function kvp_get_ip_address()
  Tools: hv: Implement the KVP verb - KVP_OP_GET_IP_INFO

 drivers/hv/hv_kvp.c      |  172 +++++++++--
 drivers/hv/hv_util.c     |    4 +-
 drivers/hv/vmbus_drv.c   |    4 +-
 include/linux/hyperv.h   |   45 +++-
 tools/hv/hv_kvp_daemon.c |  804 +++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 914 insertions(+), 115 deletions(-)

-- 
1.7.4.1
