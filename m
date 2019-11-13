From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/3] virtiofs: Do not send forget request "struct
	list_head" element
Date: Wed, 13 Nov 2019 14:30:09 +0000
Message-ID: <20191113143009.GA554680__24344.0575477265$1573655446$gmane$org@stefanha-x1.localdomain>
References: <20191030150719.29048-1-vgoyal@redhat.com>
	<20191030150719.29048-3-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9092154227302714950=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191030150719.29048-3-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============9092154227302714950==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 11:07:18AM -0400, Vivek Goyal wrote:
> We are sending whole of virtio_fs_foreget struct to the other end over

s/foreget/forget/

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3ME3EACgkQnKSrs4Gr
c8hq0Af/Y6T9m3AkYVL7WhS7dEeOaSsP/EYzLga/CaHn7C6d180GQxMyYGpCcf0D
UQwdoH+qnfkDEwUOrF2VkJGMkpHERcoKAJhq9o5sUZgHtLx01mCt4T5nQYbCpbar
DtLxySRfhqeya6Zf2kkRtpz28Th4PHK7k2qT/v3bKxIxM6PiSv3gDO0TFbdRAflr
gRlpFE59+jlOv8zFbGpgVqklwqNEYYG3BO0NM+yYgpsxUXm68rFktSceJTCRLZsQ
RJW6hIqEsBh8o4ewE2WIafyqHNKU1TWJLDlwWQrDmv9+jokNzB1LTKOac1AqlwH6
6+Q7/AHk8zVeY6A6O1ApBtgabXPA6w==
=OR0s
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--


--===============9092154227302714950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9092154227302714950==--
