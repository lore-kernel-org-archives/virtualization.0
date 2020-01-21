From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Date: Tue, 21 Jan 2020 15:50:53 +0000
Message-ID: <20200121155053.GD641751@stefanha-x1.localdomain>
References: <20200116172428.311437-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116172428.311437-1-sgarzare@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

What should vsock_dev_do_ioctl() IOCTL_VM_SOCKETS_GET_LOCAL_CID return?
The answer is probably dependent on the caller's network namespace.

Ultimately we may need per-namespace transports.  Imagine assigning a
G2H transport to a specific network namespace.

vsock_stream_connect() needs to be namespace-aware so that other
namespaces cannot use the G2H transport to send a connection
establishment packet.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nHd0ACgkQnKSrs4Gr
c8jZrQf/TRB2zBeMXsyYPUoUt2OUY/g4u8e60E+RzcZ4/AxMVlcoaGKuKtNk4DzL
Z+owz+Skn/cI4fcj0XUJrs8/O9Oqwtng0PXbIUE2sUxgd+xkB9j/zMpnwUwAHejI
M67cUcW7U6bo91TkPyp6hhjurVeMTqhxs2FYiDXuOWYxEAJwK+Rot5714FbNqujY
A7/lzlRk8GtJRI5OtH+IQaaE3y7DXzYZafwt/Vkr+LJHGSDtLoImGiziGgj/F4YB
SHxT1+d5fu9xiugvjiQFsA8l6uZjOQSQUXLbjLk3bRWRtRVV9Oa64pufh8B5yI0J
MEc1knCZqHNXlMS7KlHgjY7zhJcsnw==
=lL1o
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
