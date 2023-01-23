Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727B9C25B50
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 22:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 049EB60FDA;
	Mon, 23 Jan 2023 22:11:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 049EB60FDA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ItZgT6QP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36-fCxd1Gp-h; Mon, 23 Jan 2023 22:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6432860FE0;
	Mon, 23 Jan 2023 22:11:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6432860FE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4854EC0032;
	Mon, 23 Jan 2023 22:11:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2261C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 22:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF6DD8201B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 22:11:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF6DD8201B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ItZgT6QP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a85TCZU1HVLE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 22:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD94981F53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD94981F53
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674511896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvUmurC9HOodDs2LaRkp+R+qT18zMiP3C2WK1UkBQdM=;
 b=ItZgT6QPp68KTAVibaTP4znhV+bC7K013rBJRU8Yc/9zoj0lZg5cIdFm13DSBMJXJukJS3
 uAVCm2eQ09oq83ymspjwbDMMM3+YJZf/S/N5FNV8s+79IsrJzYTsZ8sVK9tJpXWCSE/enQ
 aRFFnzRnp534pTunriBH4AtJBDvxAhE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452--3poGQaqMM66JfqihUnbzw-1; Mon, 23 Jan 2023 17:11:33 -0500
X-MC-Unique: -3poGQaqMM66JfqihUnbzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DF1F3C22745;
 Mon, 23 Jan 2023 22:11:32 +0000 (UTC)
Received: from localhost (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2C8F492C3C;
 Mon, 23 Jan 2023 22:11:31 +0000 (UTC)
Date: Mon, 23 Jan 2023 17:11:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost-scsi: unbreak any layout for response
Message-ID: <Y88GEm63Tsg1AAu4@fedora>
References: <20230119073647.76467-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230119073647.76467-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bcodding@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============6591573776160387699=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6591573776160387699==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vqhw79aaCtf0o+Pf"
Content-Disposition: inline


--vqhw79aaCtf0o+Pf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 03:36:47PM +0800, Jason Wang wrote:
> Al Viro said:
>=20
> """
> Since "vhost/scsi: fix reuse of &vq->iov[out] in response"
> we have this:
>                 cmd->tvc_resp_iov =3D vq->iov[vc.out];
>                 cmd->tvc_in_iovs =3D vc.in;
> combined with
>                 iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
>                               cmd->tvc_in_iovs, sizeof(v_rsp));
> in vhost_scsi_complete_cmd_work().  We used to have ->tvc_resp_iov
> _pointing_ to vq->iov[vc.out]; back then iov_iter_init() asked to
> set an iovec-backed iov_iter over the tail of vq->iov[], with
> length being the amount of iovecs in the tail.
>=20
> Now we have a copy of one element of that array.  Fortunately, the members
> following it in the containing structure are two non-NULL kernel pointers,
> so copy_to_iter() will not copy anything beyond the first iovec - kernel
> pointer is not (on the majority of architectures) going to be accepted by
> access_ok() in copyout() and it won't be skipped since the "length" (in
> reality - another non-NULL kernel pointer) won't be zero.
>=20
> So it's not going to give a guest-to-qemu escalation, but it's definitely
> a bug.  Frankly, my preference would be to verify that the very first iov=
ec
> is long enough to hold rsp_size.  Due to the above, any users that try to
> give us vq->iov[vc.out].iov_len < sizeof(struct virtio_scsi_cmd_resp)
> would currently get a failure in vhost_scsi_complete_cmd_work()
> anyway.
> """
>=20
> However, the spec doesn't say anything about the legacy descriptor
> layout for the respone. So this patch tries to not assume the response
> to reside in a single separate descriptor which is what commit
> 79c14141a487 ("vhost/scsi: Convert completion path to use") tries to
> achieve towards to ANY_LAYOUT.
>=20
> This is done by allocating and using dedicate resp iov in the
> command. To be safety, start with UIO_MAXIOV to be consistent with the
> limitation that we advertise to the vhost_get_vq_desc().
>=20
> Testing with the hacked virtio-scsi driver that use 1 descriptor for 1
> byte in the response.
>=20
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Nicholas Bellinger <nab@linux-iscsi.org>
> Fixes: a77ec83a5789 ("vhost/scsi: fix reuse of &vq->iov[out] in response")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - tweak the changelog
> - fix the allocation size for tvc_resp_iov (should be sizeof(struct iovec=
))
> ---
>  drivers/vhost/scsi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vqhw79aaCtf0o+Pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPPBhIACgkQnKSrs4Gr
c8h2CQgAjfogTnTq3fYLEVF3lup+f3//rNwFv+dD9Nj1SS3Hb+2tSXDvQWYcimF0
Rk2sqHjeU50pU/ne5Scqe1SadPjqZb+iigRq/M0aRUuE3fa4os5tBRRLXbLNzu+v
iyxXAskl3d9DwbOE13uocY4ldeRqAutyvVrvezMxwyGA2C19yWtmCjsu4FHrA6Wo
WsM4Xu7WtIiqkxeR5TpkEhQokoMaVU+7w80WR1OsUhT3u40sfSwoN6Ue4kknBBHe
JC3z804whf97+HwQ062bfKNZGLYpx8xjid9HqseL8u/n4DLsZTl6XN75f4878FbK
npQ3QkEwdpabVVUxLsYfNsvXyuTwNg==
=1Jmd
-----END PGP SIGNATURE-----

--vqhw79aaCtf0o+Pf--


--===============6591573776160387699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6591573776160387699==--

