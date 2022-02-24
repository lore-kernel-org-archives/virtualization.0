Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDBCC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 08:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB1D940467;
	Thu, 24 Feb 2022 08:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgSX5YZyLXiI; Thu, 24 Feb 2022 08:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF248400AF;
	Thu, 24 Feb 2022 08:53:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0FBAC001A;
	Thu, 24 Feb 2022 08:53:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65511C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F32C408CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y8XzwTJ7Ffu8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 625BF40372
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645692824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thrYYz9q4DcC0rOHSVDRqBTRDM3HEZ49oAwiCU0vtIA=;
 b=XHFcKxq3HjKYkfe724sAVLTbwSG+7nf/iJTFBAXnUG5J3SkNRVIzjINqBsmeXP6lvz7EEb
 /U/h/lfubNzelj5p3WyGyLyf2vKvpIsQvxZhpeVJxpCJMJATLEjBYBl+yfgemfAKjcmEfn
 2FNW2jCL/Hvmh1vIOWew5kW5vGdCUqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-2e81YYi9MyyiXnp89lNAuQ-1; Thu, 24 Feb 2022 03:53:41 -0500
X-MC-Unique: 2e81YYi9MyyiXnp89lNAuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41803800496;
 Thu, 24 Feb 2022 08:53:39 +0000 (UTC)
Received: from localhost (unknown [10.39.194.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA567607CB;
 Thu, 24 Feb 2022 08:53:32 +0000 (UTC)
Date: Thu, 24 Feb 2022 08:53:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <YhdHi4wHLjUfD3WN@stefanha-x1.localdomain>
References: <20220222094742.16359-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220222094742.16359-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Anirudh Rayabharam <mail@anirudhrb.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============7283981448823284978=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7283981448823284978==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eMHA10fN330j9lI9"
Content-Disposition: inline


--eMHA10fN330j9lI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2022 at 10:47:42AM +0100, Stefano Garzarella wrote:
> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
> ownership. It expects current->mm to be valid.
>=20
> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
> the user has not done close(), so when we are in do_exit(). In this
> case current->mm is invalid and we're releasing the device, so we
> should clean it anyway.
>=20
> Let's check the owner only when vhost_vsock_stop() is called
> by an ioctl.
>=20
> When invoked from release we can not fail so we don't check return
> code of vhost_vsock_stop(). We need to stop vsock even if it's not
> the owner.
>=20
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail=
=2Ecom
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - initialized `ret` in vhost_vsock_stop [Dan]
> - added comment about vhost_vsock_stop() calling in the code and an expla=
nation
>   in the commit message [MST]
>=20
> v1: https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarza=
re@redhat.com
> ---
>  drivers/vhost/vsock.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eMHA10fN330j9lI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIXR4oACgkQnKSrs4Gr
c8i0LQf/bGGbSYckr30SGrkHytT/rZHQYzSD8L7Mcj6YDjh7rV/lE31ATrVY9JY4
qZ/hJTMlfAx8gqVYEmZrUh9xM09BjRAdSjGy92sdpbVYhWbr1D0HmDS+hQvFQjXs
HHpjWQeHtKjAfw8nz6HfgcH3329t+oVH5V4RQ5pOeLNq0Tm58uYdhmf7IqIrb9TI
LySJlzqTqsRzI8URPo6u9i+PqNhTnbjYTSBP2/WnAZeSrHUDXlOmeJ5cXGweinGe
CiH+66Eay0ga1M/Xym1xsota2L8lfQlO9HF1XkTJiYEeQDYthIJUc7wuZvnftCgh
ZND4ieEesa+iV+Lyaxno7s+gT0fLHw==
=f2iv
-----END PGP SIGNATURE-----

--eMHA10fN330j9lI9--


--===============7283981448823284978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7283981448823284978==--

