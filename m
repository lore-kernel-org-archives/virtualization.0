Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DCFC64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 15:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63E7B6103C;
	Mon, 27 Feb 2023 15:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63E7B6103C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TGbeGmh9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PQQZRiTAR86O; Mon, 27 Feb 2023 15:53:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D21976100C;
	Mon, 27 Feb 2023 15:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D21976100C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7C1BC0032;
	Mon, 27 Feb 2023 15:53:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 790ADC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 465096100C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 465096100C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDZSWIQJj0qx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EF4560736
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EF4560736
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677513231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FSg5+r6je78Oo6DOHt1spvGdIu0PScSllKZjUp4heJA=;
 b=TGbeGmh9Vho44WmXHMi5kA/+ywd4fhC2lpdoiu1KviipEMH4GtI5KoNF2DugUNe19eeCTL
 /96sQa08q9Rd956Z1XIql8HsBfRh0rVlaBbIPJQv6fdR81tDkKfGdS8ZjKIVDOf0+4uHra
 Fo8i0zTZFRleXwglV3G2PmpyPZXOatM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-inavr7DaPlSPxeWPDMSTeg-1; Mon, 27 Feb 2023 10:53:49 -0500
X-MC-Unique: inavr7DaPlSPxeWPDMSTeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F14185A7A4;
 Mon, 27 Feb 2023 15:53:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 348811121314;
 Mon, 27 Feb 2023 15:53:47 +0000 (UTC)
Date: Mon, 27 Feb 2023 10:53:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: vgoyal@redhat.com
Subject: Re: [RESEND v2 PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <Y/zSCarxyabSC1Zf@fedora>
References: <20230224143751.36863-1-david@ixit.cz>
MIME-Version: 1.0
In-Reply-To: <20230224143751.36863-1-david@ixit.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: David Heidelberg <david@ixit.cz>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, wsa+renesas@sang-engineering.com,
 helen.koike@collabora.com, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0454353283792758785=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0454353283792758785==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RSf3QCTu5WhPlQBP"
Content-Disposition: inline


--RSf3QCTu5WhPlQBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 03:37:51PM +0100, David Heidelberg wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Make it possible to boot directly from a virtiofs file system with tag
> 'myfs' using the following kernel parameters:
>=20
>   rootfstype=3Dvirtiofs root=3Dmyfs rw
>=20
> Booting directly from virtiofs makes it possible to use a directory on
> the host as the root file system.  This is convenient for testing and
> situations where manipulating disk image files is cumbersome.
>=20
> Reviewed-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2: added Reviewed-by and CCed everyone interested.
>=20
> We have used this option in Mesa3D CI for testing crosvm for
> more than one years and it's proven to work reliably.
>=20
> We are working on effort to removing custom patches to be able to do=20
> automated apply and test of patches from any tree.                       =
      =20
>=20
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-ru=
nner.sh#L85
>  init/do_mounts.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Vivek, do you remember where we ended up with boot from virtiofs? I
thought a different solution was merged some time ago.

There is documentation from the virtiofs community here:
https://virtio-fs.gitlab.io/howto-boot.html

Stefan

>=20
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 811e94daf0a8..11c11abe23d7 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -578,6 +578,16 @@ void __init mount_root(void)
>  			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
>  		return;
>  	}
> +#endif
> +#ifdef CONFIG_VIRTIO_FS
> +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> +		if (!do_mount_root(root_device_name, "virtiofs",
> +				   root_mountflags, root_mount_data))
> +			return;
> +
> +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> +		      root_device_name);
> +	}
>  #endif
>  	if (ROOT_DEV =3D=3D 0 && root_device_name && root_fs_names) {
>  		if (mount_nodev_root() =3D=3D 0)
> --=20
> 2.39.1
>=20

--RSf3QCTu5WhPlQBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP80gkACgkQnKSrs4Gr
c8gQDAf/S5FKAUxYW0RXBL8p7kqYdskcOGTgDOV7axCS6K87pK4tYT7M3RqheN3+
edcQhwOIM1ycR+xuYS5AA60sUtNKlsF4RIZu8+ug1sJPoXZE2WDtQbMk4sCpctgt
oWQTTVA35jvOv8SnfVL6AYcYTtymB6bpXaX/cYdUn5ERaOleKRvt4E8Rpjv9hCjS
2pg+KhGCoTWLicimXqEmHZI4FwChxJgvmw8EmNmyNm9wzuh9xibsLbm0tB6wyIdt
f7FWURT1T+yIr8TIChaWUg7pb+HldwDxpcFSsLeZGgaPB22os24ZTalYNrd8KQrm
320U02Kiol90+QZLWEVXkJQ1z2HlmA==
=igqY
-----END PGP SIGNATURE-----

--RSf3QCTu5WhPlQBP--


--===============0454353283792758785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0454353283792758785==--

