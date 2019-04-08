From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Mon, 8 Apr 2019 10:44:16 +0100
Message-ID: <20190408094416.GQ15001__14843.5359982372$1554716671$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1261629279429843716=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1261629279429843716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2019 at 02:43:28PM +0800, Jason Wang wrote:
> Another thing that may help is to implement sendpage(), which will greatly
> improve the performance.

I can't find documentation for ->sendpage().  Is the idea that you get a
struct page for the payload and can do zero-copy tx?  (And can userspace
still write to the page, invalidating checksums in the header?)

Stefan

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxfvAAoJEJykq7OBq3PIpPEIAIPydRh9MmTxWJHiLCIdcVZB
YTFjrwJFHuWU1MSyz9onJyJxcranVbekSDh+RaESeGRrg1xSyNZBqqwNUfzm23XP
jQv1xTzq9qCC6ZB81lHgFclJjT5h1/KFVKzG3Wv2dMffDW+7/Y54wOdvPsYGIQdh
ZaeT3vH1BIoIz9xA7Ajt1H3p4XjqCQyOc8LPXzHi11zpg+UgEV6AIbSNq2hjEOuK
1n4tJ/tRaGVsrhfHcg65GzY3mA/z4X6xfpw+dgZ5ZlWRKqfqNbFr4q8Sxpwla3DF
aGElG+Dsc/4SkbOLzD4WfN+JmM/pvsk1pH6RMb/OHlaD9K6fMDlL9cliH2ovmY8=
=y3qN
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--

--===============1261629279429843716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1261629279429843716==--
