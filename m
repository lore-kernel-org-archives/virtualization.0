From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/5] VSOCK: support mergeable rx buffer in vhost-vsock
Date: Thu, 13 Dec 2018 16:34:09 +0000
Message-ID: <20181213163409.GP23318__11148.9121373326$1544718749$gmane$org@stefanha-x1.localdomain>
References: <5C10D41E.9050002@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717978203434390315=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C10D41E.9050002@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============0717978203434390315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jh06fhy6YTawvwPV"
Content-Disposition: inline


--jh06fhy6YTawvwPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 05:25:50PM +0800, jiangyiwen wrote:
> Now vsock only support send/receive small packet, it can't achieve
> high performance. As previous discussed with Jason Wang, I revisit the
> idea of vhost-net about mergeable rx buffer and implement the mergeable
> rx buffer in vhost-vsock, it can allow big packet to be scattered in
> into different buffers and improve performance obviously.

Sorry, I've been a bad maintainer.  I was focussed on other projects and
my email backlog is huge.

I like the idea of trying out optimizations on virtio-vsock, seeing if
code can be shared with virtio-net, and maybe later switching to a
virtio-net transport for vsock (if it turns out enough code can be
shared).

Another optimization that could be interesting:

Userspace processes reading from a socket sleep in
vsock_stream_recvmsg().  I wonder if we can bypass struct
virtio_vsock_pkt and copying the payload into pkt->buf in this case.
(This doesn't improve poll(2)/select(2) though!)

Imagine a userspace process waiting for data on a socket.  When the
virtqueue becomes ready, we can read in struct virtio_vsock_hdr and find
the socket for that connection.  Then we could copy the payload directly
to userspace instead of creating a virtio_vsock_pkt and copying to
pkt->buf first.

--jh06fhy6YTawvwPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEooBAAoJEJykq7OBq3PIaXUIAI48B+t2OflKjd3yyXnpqLGe
eqF4+CqWlABqp8CYGnfv7iWX10CvufUf1CXcrRYG3VTdv0dcIcoxkEGR4OTf6StB
tYdm3Gp26EpSVBxZTtWnyRyMtg2au0aLIIv7zbFLJPHLOhwNAQWxcnF9WZ8tjByd
AVDi9tLvn/Ad9Q1MDdESuZ4kegmXz9nqOE5VsGpqd96sKhvmcpPr3vGQKDX/vGOl
4D+n11aNkM/z2xhYzrrl8thHVW/MvVwSFqiWisnGxKnDvh6P+cZ5G/wzdKHRiHKQ
JDZsOnCTtQND4QngyEvDgWWpTHkVEp6Q7fIcLVzufzpqIZ7YqQ0zwy7P/2TlDAI=
=Cwvm
-----END PGP SIGNATURE-----

--jh06fhy6YTawvwPV--

--===============0717978203434390315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0717978203434390315==--
