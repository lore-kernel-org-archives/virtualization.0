From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 03/14] vsock: remove include/linux/vm_sockets.h
	file
Date: Wed, 30 Oct 2019 14:57:02 +0000
Message-ID: <MWHPR05MB3376B0A779F775D0603EE752DA600__1541.58883249096$1572447614$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-4-sgarzare@redhat.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-4-sgarzare@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Stefano Garzarella' <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> Sent: Wednesday, October 23, 2019 11:56 AM
> Subject: [PATCH net-next 03/14] vsock: remove include/linux/vm_sockets.h
> file
> 
> This header file now only includes the "uapi/linux/vm_sockets.h".
> We can include directly it when needed.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vm_sockets.h            | 13 -------------
>  include/net/af_vsock.h                |  2 +-
>  include/net/vsock_addr.h              |  2 +-
>  net/vmw_vsock/vmci_transport_notify.h |  1 -
>  4 files changed, 2 insertions(+), 16 deletions(-)  delete mode 100644
> include/linux/vm_sockets.h
> 
> diff --git a/include/linux/vm_sockets.h b/include/linux/vm_sockets.h
> deleted file mode 100644 index 7dd899ccb920..000000000000
> --- a/include/linux/vm_sockets.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * VMware vSockets Driver
> - *
> - * Copyright (C) 2007-2013 VMware, Inc. All rights reserved.
> - */
> -
> -#ifndef _VM_SOCKETS_H
> -#define _VM_SOCKETS_H
> -
> -#include <uapi/linux/vm_sockets.h>
> -
> -#endif /* _VM_SOCKETS_H */
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h index
> 80ea0f93d3f7..c660402b10f2 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -10,7 +10,7 @@
> 
>  #include <linux/kernel.h>
>  #include <linux/workqueue.h>
> -#include <linux/vm_sockets.h>
> +#include <uapi/linux/vm_sockets.h>
> 
>  #include "vsock_addr.h"
> 
> diff --git a/include/net/vsock_addr.h b/include/net/vsock_addr.h index
> 57d2db5c4bdf..cf8cc140d68d 100644
> --- a/include/net/vsock_addr.h
> +++ b/include/net/vsock_addr.h
> @@ -8,7 +8,7 @@
>  #ifndef _VSOCK_ADDR_H_
>  #define _VSOCK_ADDR_H_
> 
> -#include <linux/vm_sockets.h>
> +#include <uapi/linux/vm_sockets.h>
> 
>  void vsock_addr_init(struct sockaddr_vm *addr, u32 cid, u32 port);  int
> vsock_addr_validate(const struct sockaddr_vm *addr); diff --git
> a/net/vmw_vsock/vmci_transport_notify.h
> b/net/vmw_vsock/vmci_transport_notify.h
> index 7843f08d4290..a1aa5a998c0e 100644
> --- a/net/vmw_vsock/vmci_transport_notify.h
> +++ b/net/vmw_vsock/vmci_transport_notify.h
> @@ -11,7 +11,6 @@
>  #include <linux/types.h>
>  #include <linux/vmw_vmci_defs.h>
>  #include <linux/vmw_vmci_api.h>
> -#include <linux/vm_sockets.h>
> 
>  #include "vmci_transport.h"
> 
> --
> 2.21.0

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
