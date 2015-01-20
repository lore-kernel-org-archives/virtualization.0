From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 09/20] s390x/css: Add a callback for when
	subchannel gets disabled
Date: Tue, 20 Jan 2015 10:50:28 +0000
Message-ID: <20150120105028.GG17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-10-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7545453757822026841=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-10-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7545453757822026841==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:11PM +0100, Cornelia Huck wrote:
> From: Thomas Huth <thuth@linux.vnet.ibm.com>
>=20
> We need a possibility to run code when a subchannel gets disabled.
> This patch adds the necessary infrastructure.
>=20
> Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/css.c |   12 ++++++++++++
>  hw/s390x/css.h |    1 +
>  2 files changed, 13 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjL0AAoJEJykq7OBq3PItO8IAIXCKjMWJyTLA52CbU2jF7OR
pShBSY5354sdyOoCf8CF26TdBzoaDBGmsVyLvO0o4VkJxXsgn6u+l58ewmgFCBkx
9jFNGRMvXiXYSVYj2UedVCxGmS5ew6uE/6JuURbubBRGwHRa3L0mJgYq5YmDrE5C
2h8DvGHJ6Gs2Coun/xQiVCqskh5Dbni8GC21dp65pIF87tEKOAqZiF7w55eEiLHi
CAl9GmaRjirGBsCKGi8tC81ilcDeq6qNOyeQykdOX1dsWpekqtmek0NCbSZzs5oG
p6v8IPlt7QTVtWOcmZ9IuvHXsup5yDeGllSoSZc/7aUHHOv1vQH+PB3Jaf5As48=
=rOFF
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

--===============7545453757822026841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7545453757822026841==--
