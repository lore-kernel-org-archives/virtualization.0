From: Andy King <acking@vmware.com>
Subject: [PATCH 0/1] VM Sockets for Linux upstreaming
Date: Wed,  6 Feb 2013 16:23:55 -0800
Message-ID: <1360196636-9357-1-git-send-email-acking__38349.810432601$1360196891$gmane$org@vmware.com>
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
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Andy King <acking@vmware.com>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

In an effort to improve the out-of-the-box experience with Linux kernels for
VMware users, VMware is working on readying the VM Sockets (VSOCK, formerly
VMCI Sockets) (vsock) kernel module for inclusion in the Linux kernel. The
purpose of this post is to acquire feedback on the vsock kernel module.

Unlike previous submissions, where the new socket family was entirely reliant
on VMware's VMCI PCI device (and thus VMware's hypervisor), VM Sockets is now
completely[1] separated out into two parts, each in its own module:

o Core socket code, which is transport-neutral and invokes transport
  callbacks to communicate with the hypervisor.  This is vsock.ko.
o A VMCI transport, which communicates over VMCI with the VMware hypervisor.
  This is vmw_vsock_vmci_transport.ko, and it registers with the core module
  as a transport.

This should provide a path to introducing additional transports, for example
virtio, with the ultimate goal being to make this new socket family
hypervisor-neutral.

[1] If Gerd tries it and determines this to be false (still), I'll ship him
    a keg of beer.

Andy King (1):
  VSOCK: Introduce VM Sockets

 include/linux/socket.h                       |    4 +-
 include/uapi/linux/vm_sockets.h              |  171 ++
 net/Kconfig                                  |    1 +
 net/Makefile                                 |    1 +
 net/vmw_vsock/Kconfig                        |   28 +
 net/vmw_vsock/Makefile                       |    7 +
 net/vmw_vsock/af_vsock.c                     | 2015 ++++++++++++++++++++++++
 net/vmw_vsock/af_vsock.h                     |  175 +++
 net/vmw_vsock/vmci_transport.c               | 2157 ++++++++++++++++++++++++++
 net/vmw_vsock/vmci_transport.h               |  139 ++
 net/vmw_vsock/vmci_transport_notify.c        |  680 ++++++++
 net/vmw_vsock/vmci_transport_notify.h        |   83 +
 net/vmw_vsock/vmci_transport_notify_qstate.c |  438 ++++++
 net/vmw_vsock/vsock_addr.c                   |   86 +
 net/vmw_vsock/vsock_addr.h                   |   32 +
 net/vmw_vsock/vsock_version.h                |   22 +
 16 files changed, 6038 insertions(+), 1 deletions(-)
 create mode 100644 include/uapi/linux/vm_sockets.h
 create mode 100644 net/vmw_vsock/Kconfig
 create mode 100644 net/vmw_vsock/Makefile
 create mode 100644 net/vmw_vsock/af_vsock.c
 create mode 100644 net/vmw_vsock/af_vsock.h
 create mode 100644 net/vmw_vsock/vmci_transport.c
 create mode 100644 net/vmw_vsock/vmci_transport.h
 create mode 100644 net/vmw_vsock/vmci_transport_notify.c
 create mode 100644 net/vmw_vsock/vmci_transport_notify.h
 create mode 100644 net/vmw_vsock/vmci_transport_notify_qstate.c
 create mode 100644 net/vmw_vsock/vsock_addr.c
 create mode 100644 net/vmw_vsock/vsock_addr.h
 create mode 100644 net/vmw_vsock/vsock_version.h

-- 
1.7.4.1
