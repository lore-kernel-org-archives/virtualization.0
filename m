From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2,1/2] doc: zh_CN: index files in filesystems
 subdirectory
Date: Mon, 16 Mar 2020 07:57:35 +0100
Message-ID: <20200316075735.67793bfc@coco.lan>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
        <20200315155258.91725-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200315155258.91725-1-wenhu.wang@vivo.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, Eric Biggers <ebiggers@google.com>, Jaskaran Singh <jaskaransingh7654321@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, kernel@vivo.com
List-Id: virtualization@lists.linuxfoundation.org

Em Sun, 15 Mar 2020 08:52:38 -0700
Wang Wenhu <wenhu.wang@vivo.com> escreveu:

> Add filesystems subdirectory into the table of Contents for zh_CN,
> all translations residing on it would be indexed conveniently.
>=20
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changelog:
>  - v2 added SPDX header
> ---
>  Documentation/filesystems/index.rst           |  2 ++
>  .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |  1 +
>  3 files changed, 32 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
>=20
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyst=
ems/index.rst
> index 386eaad008b2..ab47d5b1f092 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -1,3 +1,5 @@
> +.. _filesystems_index:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  Filesystems in the Linux kernel
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Doc=
umentation/translations/zh_CN/filesystems/index.rst
> new file mode 100644
> index 000000000000..0a2cabfeaf7b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. raw:: latex
> +
> +	\renewcommand\thesection*
> +	\renewcommand\thesubsection*

Out of curiosity: why do you add those?

My experience with raw latex is that adding things like that tend to
break with different Sphinx versions. So, if this is really needed, I
suggest you to test with at least Sphinx 1.7.9 and with the latest
version, to be sure that it won't cause troubles.

Except for that, patch looks ok to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Regards,
Mauro

> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
> +:Translator: Wang Wenhu <wenhu.wang@vivo.com>
> +
> +.. _cn_filesystems_index:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux Kernel=E4=B8=AD=E7=9A=84=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E8=BF=99=E4=BB=BD=E6=AD=A3=E5=9C=A8=E5=BC=80=E5=8F=91=E7=9A=84=E6=89=8B=
=E5=86=8C=E6=88=96=E8=AE=B8=E5=9C=A8=E6=9C=AA=E6=9D=A5=E6=9F=90=E4=B8=AA=E8=
=BE=89=E7=85=8C=E7=9A=84=E6=97=A5=E5=AD=90=E9=87=8C=E4=BB=A5=E6=98=93=E6=87=
=82=E7=9A=84=E5=BD=A2=E5=BC=8F=E5=B0=86Linux=E8=99=9A=E6=8B=9F\
> +=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=EF=BC=88VFS=EF=BC=89=E5=B1=82=E4=BB=
=A5=E5=8F=8A=E5=9F=BA=E4=BA=8E=E5=85=B6=E4=B8=8A=E7=9A=84=E5=90=84=E7=A7=8D=
=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=A6=82=E4=BD=95=E5=B7=A5=E4=BD=9C=E5=
=91=88=E7=8E=B0=E7=BB=99=E5=A4=A7=E5=AE=B6=E3=80=82=E5=BD=93=E5=89=8D\
> +=E5=8F=AF=E4=BB=A5=E7=9C=8B=E5=88=B0=E4=B8=8B=E9=9D=A2=E7=9A=84=E5=86=85=
=E5=AE=B9=E3=80=82
> +
> +=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=AE=9E=E7=8E=B0=E6=96=87=E6=A1=A3=
=E3=80=82
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
> index d3165535ec9e..76850a5dd982 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -14,6 +14,7 @@
>     :maxdepth: 2
> =20
>     process/index
> +   filesystems/index
> =20
>  =E7=9B=AE=E5=BD=95=E5=92=8C=E8=A1=A8=E6=A0=BC
>  ----------



Thanks,
Mauro
