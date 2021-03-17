Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22EC433E6
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 09:37:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643E964F41
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 09:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643E964F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 175EE83F56;
	Wed, 17 Mar 2021 09:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5QKKS7HWQpM9; Wed, 17 Mar 2021 09:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A860883F7C;
	Wed, 17 Mar 2021 09:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7877FC000A;
	Wed, 17 Mar 2021 09:37:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76182C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 576B96F4F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ALIzEZ5DddV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F7D0600D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615973821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SPq25jtfYHNoMdRcDr249FaN2pikM90IE2m6m6T2KCQ=;
 b=a6/o0JdRK1o2VzOdQLwMjfPmS/V0H45ReB0LSfJMAzeooL8exiczbnX08CbF5E6EKYtjCY
 IqWKApV7bAS/vgWNaL60Whf5GDtQkheIhmU8YT1rEswyFUujw/ALAjmCAja2nf3eSHpxbd
 A8BGb4OOiLTkKF3rKIDw2dl9Bgt5Rsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-JmLCvksuO3-LxUz5PFZ9UA-1; Wed, 17 Mar 2021 05:36:59 -0400
X-MC-Unique: JmLCvksuO3-LxUz5PFZ9UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76F6B802B45;
 Wed, 17 Mar 2021 09:36:57 +0000 (UTC)
Received: from localhost (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26B095C8BE;
 Wed, 17 Mar 2021 09:36:47 +0000 (UTC)
Date: Wed, 17 Mar 2021 09:36:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v2] virtiofs: fix memory leak in virtio_fs_probe()
Message-ID: <YFHNr/Sqgo6QnoGV@stefanha-x1.localdomain>
References: <20210317084443.22657-1-lhenriques@suse.de>
MIME-Version: 1.0
In-Reply-To: <20210317084443.22657-1-lhenriques@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4548432011210225798=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4548432011210225798==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ut6GBzXLkDIRjWkj"
Content-Disposition: inline


--Ut6GBzXLkDIRjWkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 08:44:43AM +0000, Luis Henriques wrote:
> When accidentally passing twice the same tag to qemu, kmemleak ended up
> reporting a memory leak in virtiofs.  Also, looking at the log I saw the
> following error (that's when I realised the duplicated tag):
>=20
>   virtiofs: probe of virtio5 failed with error -17
>=20
> Here's the kmemleak log for reference:
>=20
> unreferenced object 0xffff888103d47800 (size 1024):
>   comm "systemd-udevd", pid 118, jiffies 4294893780 (age 18.340s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 80 90 02 a0 ff ff ff ff  ................
>   backtrace:
>     [<000000000ebb87c1>] virtio_fs_probe+0x171/0x7ae [virtiofs]
>     [<00000000f8aca419>] virtio_dev_probe+0x15f/0x210
>     [<000000004d6baf3c>] really_probe+0xea/0x430
>     [<00000000a6ceeac8>] device_driver_attach+0xa8/0xb0
>     [<00000000196f47a7>] __driver_attach+0x98/0x140
>     [<000000000b20601d>] bus_for_each_dev+0x7b/0xc0
>     [<00000000399c7b7f>] bus_add_driver+0x11b/0x1f0
>     [<0000000032b09ba7>] driver_register+0x8f/0xe0
>     [<00000000cdd55998>] 0xffffffffa002c013
>     [<000000000ea196a2>] do_one_initcall+0x64/0x2e0
>     [<0000000008f727ce>] do_init_module+0x5c/0x260
>     [<000000003cdedab6>] __do_sys_finit_module+0xb5/0x120
>     [<00000000ad2f48c6>] do_syscall_64+0x33/0x40
>     [<00000000809526b5>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v1:
> - Use kfree() to free fs->vqs instead of calling virtio_fs_put()
>=20
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ut6GBzXLkDIRjWkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBRza8ACgkQnKSrs4Gr
c8jnxQgArLrpuXxh9hc3EbwX0Cb5eLWUCOMDFF3Nd6fM4WjDFDc/ZBYzk2W8iZIj
S8uH8ZpSF1RTgM327Zo+XqkFFfuSgdjqCrmW9z6iR7gSpnqOuSD2HReZcu3XxRln
gfW+XA3v0IB97Xpm6mDgdJFnZaowJVPiGafLQsc6VZiv3UtkHI4FXwYJzM7pWknS
HX/lMfSAi1TRkkJEY4zAkZKPVV3Jmgx5MOsMLbjjIa8griE4FnHQ7q5FlU3xDXla
ooBxfh2hqUb/p9SAlNh6zxg8VCgQTRMo6a5kZupcH9PhVorr8Ki2tYvZUpmKwEwm
y/8FuXXLTWEGnuX27koOOzoGvcl1Ag==
=3lq4
-----END PGP SIGNATURE-----

--Ut6GBzXLkDIRjWkj--


--===============4548432011210225798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4548432011210225798==--

