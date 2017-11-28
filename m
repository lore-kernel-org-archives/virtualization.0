From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] VSOCK: Don't set sk_state to TCP_CLOSE before testing it
Date: Tue, 28 Nov 2017 10:35:42 +0000
Message-ID: <20171128103542.GC17146@stefanha-x1.localdomain>
References: <1511789372-12672-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6242003544860366337=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511789372-12672-1-git-send-email-jhansen@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jorgen Hansen <jhansen@vmware.com>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, gregkh@linuxfoundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org


--===============6242003544860366337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 05:29:32AM -0800, Jorgen Hansen wrote:
> A recent commit (3b4477d2dcf2) converted the sk_state to use
> TCP constants. In that change, vmci_transport_handle_detach
> was changed such that sk->sk_state was set to TCP_CLOSE before
> we test whether it is TCP_SYN_SENT. This change moves the
> sk_state change back to the original locations in that function.
>=20
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  net/vmw_vsock/vmci_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry, silly bug on my part!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHTv+AAoJEJykq7OBq3PIEAwH/iKcvvOLxGvjT6mIJK+mqfiJ
8+Ve54Wn2Ca3ogzBnf8lJvyv2pKpo08LK2BkGimS0A9WdY5IzB2Er3wFAbX+877p
+vXS48lL4Qy+eJpOVFYwE8wDdrcmmpG432IOoZfwMQp84ovNyjm01kwGpDFgoj4v
5/3qdNWsBkB3q9PO/HSoYgu3l1wWVuPDLyLoZSbyLmS162n8uDHSk9MMlbI3WpYj
Xu9HG4fTYk0/UGRowvS3CajARDYApBPM45HahYQ6b2mO4sdpAJs09GI361HVr/ll
4nw42YT0hDKfIPwtuYDVOp6oVnbYNzkTOxb+paZe/YoqoTdJodrNIMxsgruu7hc=
=lqK1
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

--===============6242003544860366337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6242003544860366337==--
