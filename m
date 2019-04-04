From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Thu, 4 Apr 2019 15:14:10 +0100
Message-ID: <20190404141410.GA25152__20940.7154515915$1554387264$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0378591956654519726=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============0378591956654519726==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:34PM +0200, Stefano Garzarella wrote:
> This series tries to increase the throughput of virtio-vsock with slight
> changes:
>  - patch 1/4: reduces the number of credit update messages sent to the
>               transmitter
>  - patch 2/4: allows the host to split packets on multiple buffers,
>               in this way, we can remove the packet size limit to
>               VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
>  - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
>               allowed
>  - patch 4/4: increases RX buffer size to 64 KiB (affects only host->gues=
t)
>=20
> RFC:
>  - maybe patch 4 can be replaced with multiple queues with different
>    buffer sizes or using EWMA to adapt the buffer size to the traffic
>=20
>  - as Jason suggested in a previous thread [1] I'll evaluate to use
>    virtio-net as transport, but I need to understand better how to
>    interface with it, maybe introducing sk_buff in virtio-vsock.
>=20
> Any suggestions?

Great performance results, nice job!

Please include efficiency numbers (bandwidth / CPU utilization) in the
future.  Due to the nature of these optimizations it's unlikely that
efficiency has decreased, so I'm not too worried about it this time.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcphEyAAoJEJykq7OBq3PI3fQH/iwehSG1C1HktNyFHXS6s/zt
4G9rovQaFOnHHIa4i0DnqHRZKZ2SyrAZNy7BI8102ULb7aviSx9fK6dmxojv9tSp
wvxg1Y5E/fF21gfYfIOR6DTXt+loSsCeBmCWVMPa2nfRqJVJJzMQfHx1xVE8chE5
ESiA6QGGt3tj+P8F2YfDl3r3twJh1OcO6WZoKT4GxIpUfzNvlJMk99iXJz3e0E+C
14XHoU1qhct6PWRP6R6cMEbRLmKZV6wxDERubCxPnmf+BR99z7ydDUdEZPRpjeot
n8C4zFoJz3Fw/0q/C3XuhLpfLah+3hvF4CbJP/bjnLaZ7TwYP56RO63pakhEjjE=
=zvVe
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============0378591956654519726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0378591956654519726==--
