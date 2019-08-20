From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close
	tests on a VMCI host
Date: Tue, 20 Aug 2019 09:32:03 +0100
Message-ID: <20190820083203.GB9855__7519.49222046591$1566289936$gmane$org@stefanha-x1.localdomain>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-11-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2223663232642248723=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190801152541.245833-11-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============2223663232642248723==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 05:25:40PM +0200, Stefano Garzarella wrote:
> When VMCI transport is used, if the guest closes a connection,
> all data is gone and EOF is returned, so we should skip the read
> of data written by the peer before closing the connection.

All transports should aim for identical semantics.  I think virtio-vsock
should behave the same as VMCI since userspace applications should be
transport-independent.

Let's view this as a vsock bug.  Is it feasible to change the VMCI
behavior so it's more like TCP sockets?  If not, let's change the
virtio-vsock behavior to be compatible with VMCI.

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1bsAIACgkQnKSrs4Gr
c8iy2wf9Hf2RT30SVoJTzJ+hX0eVKck7gc8yFdT08PLyaZW9ND3d2J7oYGhT3/kF
3IneL017fwh3nVZ9rcWcVH2ntn7Mq8+I0mTBH24UP0UMLMz/Ieq/6oRj3ySm/UbA
7/RZHJ2+he0dBgOPggnmNBPDTqAytUBaDouuIWJiXYnVX8g82C1qhcckeuIrxbc5
5hQPmjQnSmRVcclubheU+QAqqQbAySFDYbJp36sRGiAyJR31vQJGQWqk+r0uZvlt
DT1YTMdU7EfmWoVp4nW2dDMnN+WlZA0qFZ2gv/7/ZiZ0etvXTPN8/owaW3HxTQOJ
PPVwBTXGU+LNuAHvJOt9METVQX4+oQ==
=YtHX
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============2223663232642248723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2223663232642248723==--
