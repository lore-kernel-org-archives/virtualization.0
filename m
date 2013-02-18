From: Andy King <acking@vmware.com>
Subject: [PATCH 0/4] Minor vSockets fixes
Date: Mon, 18 Feb 2013 08:04:09 -0800
Message-ID: <1361203453-1347-1-git-send-email-acking__11199.394070036$1361203743$gmane$org@vmware.com>
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
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, Andy King <acking@vmware.com>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Minor vSockets fixes, two of which were reported on LKML.

Andy King (2):
  VSOCK: Remove hypervisor-only socket option
  VSOCK: Don't reject PF_VSOCK protocol

Dmitry Torokhov (2):
  VSOCK: get rid of EXPORT_SYMTAB
  VSOCK: get rid of vsock_version.h

 include/uapi/linux/vm_sockets.h |    8 --------
 net/vmw_vsock/af_vsock.c        |    7 ++-----
 net/vmw_vsock/vmci_transport.c  |    2 --
 net/vmw_vsock/vsock_version.h   |   22 ----------------------
 4 files changed, 2 insertions(+), 37 deletions(-)
 delete mode 100644 net/vmw_vsock/vsock_version.h

-- 
1.7.4.1
