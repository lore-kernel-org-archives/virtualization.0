From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Date: Thu, 21 Nov 2019 09:34:58 +0000
Message-ID: <20191121093458.GB439743__26419.0866075054$1574328916$gmane$org@stefanha-x1.localdomain>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1147125361251077541=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191119110121.14480-5-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1147125361251077541==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2019 at 12:01:19PM +0100, Stefano Garzarella wrote:

Ideas for long-term changes below.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 760049454a23..c2a3dc3113ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17239,6 +17239,7 @@ F:	net/vmw_vsock/diag.c
>  F:	net/vmw_vsock/af_vsock_tap.c
>  F:	net/vmw_vsock/virtio_transport_common.c
>  F:	net/vmw_vsock/virtio_transport.c
> +F:	net/vmw_vsock/vsock_loopback.c
>  F:	drivers/net/vsockmon.c
>  F:	drivers/vhost/vsock.c
>  F:	tools/testing/vsock/

At this point you are most active in virtio-vsock and I am reviewing
patches on a best-effort basis.  Feel free to add yourself as
maintainer.

> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> new file mode 100644
> index 000000000000..3d1c1a88305f
> --- /dev/null
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * loopback transport for vsock using virtio_transport_common APIs
> + *
> + * Copyright (C) 2013-2019 Red Hat, Inc.
> + * Author: Asias He <asias@redhat.com>
> + *         Stefan Hajnoczi <stefanha@redhat.com>
> + *         Stefano Garzarella <sgarzare@redhat.com>
> + *
> + */
> +#include <linux/spinlock.h>
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/virtio_vsock.h>

Is it time to rename the generic functionality in
virtio_transport_common.c?  This doesn't have anything to do with virtio
:).

> +
> +static struct workqueue_struct *vsock_loopback_workqueue;
> +static struct vsock_loopback *the_vsock_loopback;

the_vsock_loopback could be a static global variable (not a pointer) and
vsock_loopback_workqueue could also be included in the struct.

The RCU pointer is really a way to synchronize vsock_loopback_send_pkt()
and vsock_loopback_cancel_pkt() with module exit.  There is no other
reason for using a pointer.

It's cleaner to implement the synchronization once in af_vsock.c (or
virtio_transport_common.c) instead of making each transport do it.
Maybe try_module_get() and related APIs provide the necessary semantics
so that core vsock code can hold the transport module while it's being
used to send/cancel a packet.

> +MODULE_ALIAS_NETPROTO(PF_VSOCK);

Why does this module define the alias for PF_VSOCK?  Doesn't another
module already define this alias?

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WWkIACgkQnKSrs4Gr
c8jBuAgAg4roCliY5QrKSBc2swUmpdqgthCa2WBtvGuV40W4kMS8BoWa4ACU8uGA
uxOG2+bM919Qiu+LpwTdm4RrQ5Vxk78KUZsHGdTrHxF7tZvg6J9ojjZGc3DkO/zr
ndGHNu05QTeEetAhPg13rpZmYe0WDgR6NTP4cWlpFRxWjBk46laAbA04xLXDN/NF
fgt/nh2LL5k9CWbNFuPKwzm5qudh7OAojBGmk1dfeBnZCLZB4U7AF1zdDB8CJssG
YJ2zcbuKUptctXc8reETVJOxwDXzpvwiQgpIp1blJC+Z3Thdn5vJDxlzefjBLYyL
/DyzsL2ZvpFLxvf62uE+xEAQeXa0Jg==
=lA3N
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

--===============1147125361251077541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1147125361251077541==--
