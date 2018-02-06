From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Tue, 6 Feb 2018 17:00:13 +0200
Message-ID: <20180206170013.7e2b08bb__12801.4305294075$1517929127$gmane$org@eldfell>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
	<20180126135803.29781-2-tomeu.vizoso@collabora.com>
	<20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
	<49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
	<20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
	<f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
	<20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7255212266594128920=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

--===============7255212266594128920==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YRXYvEnENKe9OWQMruDI4Eh"; protocol="application/pgp-signature"

--Sig_/YRXYvEnENKe9OWQMruDI4Eh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2018 17:03:22 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Feb 05, 2018 at 03:46:17PM +0100, Tomeu Vizoso wrote:
> > On 02/05/2018 01:20 PM, Gerd Hoffmann wrote: =20
> > >    Hi,
> > >  =20
>=20
> Hmm.  I allways assumed the wayland client allocates the buffers, not
> the server.  Is that wrong?

Hi Gerd,

a fly-by comment here:

The standard operation mode on Wayland indeed is that the client
allocates any pixel buffers. It is not the whole story though.

Server allocated buffers passed to a client also exist:
- core protocol uses this to pass keymaps to clients
- people are not forbidden from writing Wayland extensions that do this
  for whatever reason

The latter server-allocated case could probably be overlooked, but the
keymap case not really. Furthermore, copy&paste and drag&drop protocol
pass pipe file descriptors via Wayland to establish client-to-client
pipes.


Thanks,
pq

--Sig_/YRXYvEnENKe9OWQMruDI4Eh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlp5wv4ACgkQI1/ltBGq
qqc8Cg//aFIZhRaCKo+sjSb+GvUO/L9rb23445t/y+iV6X1JbMw3GlmL7IBPqcB2
3jveY+iKuIIOlof7l5qtJpl3SNIWCoiz2aQbhICif++TyYQUJQkWbPYthxsdNBrS
b4oXg22xhXriFy8G7QaLfMEfBM2Tq8j+kNscgZRlPaYrMrkcF24Q2sNGk4SUIT3P
DFMV2oKFlYphNYrSlZ7n5cq8g+jvd19KG6NshtHAT5T8ECn5Z1hM31sCQZi53+6n
jhtEu6EN9cuQxaIzMLdWw4+/ZUKlFKopoXqLr1PL5K6vVlxRZlm4d6WmJSD8C975
l04vhwR2TqXrp9xjLb5Uh9ZbVAk/vBdiWaXtTFJ+8MTM+dbZhBze2jqvjm9D6CCd
/Vnd3v44JpnhPRW4A4yQ3OF/3tyfgfhvb/nmRJrzNKywn7bLiBhBXdLgW7oKqd+4
zl00Zcx0HLAiKcM2wywdzaJNJ2q5SPQb9cwz1YLnxlTrTGM8F1KGZXqQQ32J2jiQ
6Lur+aD6AsxNO3R9I7gHr47QWDHxnujxzPVFxXsEYPXCAbxrNe3G05YD321aL+jB
g0NNRNm+Tg4Zi+SaOvojqEC0p5UAWhdBSQolyJJJ5EcSewXbUdvprJjXEjLdYRRv
n186vTIF9TatR+uL0ucMbdjakymmsV/KU+Icl4iIiXfm+srNulE=
=X1pM
-----END PGP SIGNATURE-----

--Sig_/YRXYvEnENKe9OWQMruDI4Eh--

--===============7255212266594128920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7255212266594128920==--
