From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] doc: zh_CN: facilitate translation for filesystems
Date: Sun, 15 Mar 2020 10:12:15 +0000
Message-ID: <20200315101215.GA325031@stefanha-x1.localdomain>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200315092810.87008-1-wenhu.wang@vivo.com>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Biggers <ebiggers@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, kernel@vivo.com
List-Id: virtualization@lists.linuxfoundation.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 02:27:58AM -0700, Wang Wenhu wrote:
> This patch series set up the basic facility for the translation work
> of the docs residing on filesystems into Chinese, indexing the filesystem=
s
> directory and adding one indexed translation into it. The virtiofs.rst
> added is not only a translation itself but also an simple example that
> future developers would take.
>=20
> The detailed diff info also shows the basic essential markups of
> the toctree and reStructuredText, at least for the most simple occasions.
> More translations of filesystems are on their way, and futher,
> of more subsystems.
>=20
> ---
> Wang Wenhu (2):
>   doc: zh_CN: index files in filesystems subdirectory
>   doc: zh_CN: add translation for virtiofs
>=20
>  Documentation/filesystems/index.rst           |  2 +
>  Documentation/filesystems/virtiofs.rst        |  2 +
>  .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++
>  .../zh_CN/filesystems/virtiofs.rst            | 62 +++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |  1 +
>  5 files changed, 96 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rs=
t
>  create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs=
.rst
>=20
> --=20
> 2.17.1
>=20

I am not a Chinese speaker but thank you for translation the
documentation!

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5t/38ACgkQnKSrs4Gr
c8i7pggAxFGK9yalFhtI40r+K7LMZVxPGH3zc20Ho6hCuGGbk0pnrVxuDOyAsgTo
w809N9Ypju11BY4lh8vzpA8wmi+mrjCI1I+/Md87gv+vIuur17n6v895rHas9rkh
VN6uRiHTxQR/zaDSaUM3yrR/KDCqHqe26T77B8//ope+JTqpWRNrhNccDtz5x/Kt
BVWkyKGmHwKK2LZm3OkHHYXhZx519RS6gBrxbzSySnBbwPbBWcY75et0o8c3FSJP
qh/pJ8keEtMEKVj/EGTZ2B9MN5d4nSi1yhxVizGHWkeDJ/yg6/l2kMKQ7MzAxPIP
iM5LDusm9auID4W1sU3363No0ZF+4Q==
=Sx9O
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
