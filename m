From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 4/4] vsock: cancel packets when failing to connect
Date: Fri, 9 Dec 2016 10:17:56 +0000
Message-ID: <20161209101756.GC18260__10938.4178104394$1481278689$gmane$org@stefanha-x1.localdomain>
References: <1481217156-7160-1-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-2-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-3-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-4-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-5-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4557128732578728479=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481217156-7160-5-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Tao <bergwolf@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, David Miller <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4557128732578728479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 01:12:36AM +0800, Peng Tao wrote:
> Otherwise we'll leave the packets queued until releasing vsock device.
> E.g., if guest is slow to start up, resulting ETIMEDOUT on connect, guest
> will get the connect requests from failed host sockets.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Please do not include Reviewed-by: if the patch has undergone
substantial changes.

I am happy with this latest version:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSoTUAAoJEJykq7OBq3PIgAwH/jje5hhZHiuPT2OchtkAHPtX
KnKvv+lZrliEmFwqcQNLQ5zt1FVXLc+WpSfsiFl70nJlek3JUcE+Ww+KteGp0QCw
xBSpFqIS1/KnHjs5CsqPBf3U4yk0PcFQSKfprBSRIkPjNFYmRMG3bxaIyOKHQftd
2oStgmMoRQSoNkpv/5YEvypY7XEBg3yOW3abvuN+NLFmuB2UV7WE4lzZHvVXrNzp
EJMG/AEQEzNbDYP8Pbtj/F2giakLElYFmHfh1EQTe+9BWLRWKKSJsEzx6HHNEht+
xVWUVuPIcfRiZrknkZAWfPlVyPTAxn8u/JLNoOsHwc18n7AQsmi8XJ54wiszbD4=
=NiBy
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--

--===============4557128732578728479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4557128732578728479==--
