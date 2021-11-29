Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ABFC433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47E9141C03;
	Mon, 29 Nov 2021 10:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZhJSXG5sf2v; Mon, 29 Nov 2021 10:20:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E84E34058B;
	Mon, 29 Nov 2021 10:20:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF1F1C001C;
	Mon, 29 Nov 2021 10:20:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CDCAC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B5F441C03
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LbsMP5MAT1Eb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C60344058B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638181203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6SaX+NTgiaFDnrzD5rOQdn6fQZIVXiBx5LgIgNJIdg=;
 b=Vbr5Vf2BhuLvUZVqzUr6aJYtFc8i/CZ528WhkFO5V+U1jpU0lelSxwRmjej6kK+sFwvmld
 /TDWyKCPHsjU1B3u+iXUcadFSoOPSGv5TvcJXZwObXTJolGxoSfhK3lgQv+C+kqF6FS0aW
 AkpR8GJIomzVS3khj1LGIKzeRnjwz7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-Lc5EhORMMfagTkSimab4og-1; Mon, 29 Nov 2021 05:19:59 -0500
X-MC-Unique: Lc5EhORMMfagTkSimab4og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9340E343CB;
 Mon, 29 Nov 2021 10:19:58 +0000 (UTC)
Received: from localhost (unknown [10.39.195.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69EF960C13;
 Mon, 29 Nov 2021 10:19:52 +0000 (UTC)
Date: Mon, 29 Nov 2021 10:19:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
Message-ID: <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
In-Reply-To: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Miklos Szeredi <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6829567493057540815=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6829567493057540815==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z2Ce6dDVMZ60RS5B"
Content-Disposition: inline


--Z2Ce6dDVMZ60RS5B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
> No need to generate virtio_fs.o first and then link to virtiofs.o, just
> rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
> in Makefile, also update MAINTAINERS. Additionally, rename the private
> header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
> and f2fs.h in fs/f2fs.

There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
and fuse_i.h -> fuse.h). A patch series with two patches would be easier
to review and cleaner to backport.

I'm happy with renaming virtio_fs.c to virtiofs.c:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Z2Ce6dDVMZ60RS5B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGkqUcACgkQnKSrs4Gr
c8hcDwf9GKHQ6ydDAUWUl6kfFQdbJcYRM28PABP2g94fv4RMNpFyPVMxz6gMQ0pv
eplzXRrlAfIeHUMmw/6LAG6VMygzxo5dApigaKd94inPQbGvdQziO3axf3vKyshe
nk0GSOvwk0adN9LUvJOP4v/zaia6SrH/mTTNLCHRXyq/mnN5wPEImGHR1l4Sr+NM
spQp+XoBrjQEuikwBL9wEg7ZP+Oyy64tC0kzXzQnq4XY+UdVNIyLZ+BvAxJGJxtR
Fup9FzJNPiVRC7Y0Np12bQBa/wv+KAHH/g/GYOKpkHiCbczTCeDZUe+TcQNaJE0t
f+3+ZCQAbio2j/rvXWtoy+WK33we5A==
=GXwS
-----END PGP SIGNATURE-----

--Z2Ce6dDVMZ60RS5B--


--===============6829567493057540815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6829567493057540815==--

