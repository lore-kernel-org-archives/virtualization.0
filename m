Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C981C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 09:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DACF160A99;
	Tue,  5 Apr 2022 09:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ob4CfPJjR4fh; Tue,  5 Apr 2022 09:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A030607EC;
	Tue,  5 Apr 2022 09:09:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3988EC002C;
	Tue,  5 Apr 2022 09:09:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A169C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 09:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55D09607F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 09:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONLbZAXMAEN3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 09:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A729607EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649149753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAS2zJr4RGhhYKW10JCPapfDFJYlad7vSeh9SuK0g88=;
 b=Mds0CZPgYCozHD5I9Ad25TGNWSaEOzA0a68xep5a8mj7XzWAB2xF7VpCTkU6qTuINbw1oR
 RSei2EIB1e2jucMzj5O6MuEqrMaIA9c4+A/6ZR+CapIttmAjK1gvEVwFePX5uuiFXWxvRg
 6OshEzsALoaBcUgF9jlA8i3r6dCJPsY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-M2v2-9cAOZyN3mBC6TGFTQ-1; Tue, 05 Apr 2022 05:09:02 -0400
X-MC-Unique: M2v2-9cAOZyN3mBC6TGFTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C04733801ECE;
 Tue,  5 Apr 2022 09:09:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F993145F949;
 Tue,  5 Apr 2022 09:09:01 +0000 (UTC)
Date: Tue, 5 Apr 2022 10:09:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkwHLFrWKJXn02gL@stefanha-x1.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220405053122.77626-3-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: mgurtovoy@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============5348577719927805969=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5348577719927805969==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TccE7CylT9ec6Nxl"
Content-Disposition: inline


--TccE7CylT9ec6Nxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2022 at 02:31:22PM +0900, Suwan Kim wrote:
> This patch supports mq_ops->queue_rqs() hook. It has an advantage of
> batch submission to virtio-blk driver. It also helps polling I/O because
> polling uses batched completion of block layer. Batch submission in
> queue_rqs() can boost polling performance.
>=20
> In queue_rqs(), it iterates plug->mq_list, collects requests that
> belong to same HW queue until it encounters a request from other
> HW queue or sees the end of the list.
> Then, virtio-blk adds requests into virtqueue and kicks virtqueue
> to submit requests.
>=20
> If there is an error, it inserts error request to requeue_list and
> passes it to ordinary block layer path.
>=20
> For verification, I did fio test.
> (io_uring, randread, direct=3D1, bs=3D4K, iodepth=3D64 numjobs=3DN)
> I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
> It shows about 2% improvement.
>=20
>                                  |   numjobs=3D2   |   numjobs=3D4
>       -----------------------------------------------------------
>         fio without queue_rqs()  |   291K IOPS   |   238K IOPS
>       -----------------------------------------------------------
>         fio with queue_rqs()     |   295K IOPS   |   243K IOPS
>=20
> For polling I/O performance, I also did fio test as below.
> (io_uring, hipri, randread, direct=3D1, bs=3D512, iodepth=3D64 numjobs=3D=
4)
> I set 4 vcpu and 2 poll queues for VM.
> It shows about 2% improvement in polling I/O.
>=20
>                                       |   IOPS   |  avg latency
>       -----------------------------------------------------------
>         fio poll without queue_rqs()  |   424K   |   613.05 usec
>       -----------------------------------------------------------
>         fio poll with queue_rqs()     |   435K   |   601.01 usec
>=20
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 110 +++++++++++++++++++++++++++++++++----
>  1 file changed, 99 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TccE7CylT9ec6Nxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJMBywACgkQnKSrs4Gr
c8grSQgAman3xRuQCT/MEKpDKENDYNmeSdt/bb5ZMZTpYYsVCFmEyf9yMli6wbeb
BzRIo1ibq12uEwYvTpr4xAt7QbXeAfpazh74FSdFyOsEiaxhAWaE8lrHvD+PYHt8
bExnX+rFjS8kLvtsizGI0urDn6JjRrbYjbAmgcKV8byHXFZGo/M1/B02hJ1unzcP
A0QRlvhbAfloAXLgmcj79BkuXox+XsYzzImGfWykTdTRRLq9VNBqrym3qkUlvsDJ
A2V48hKhP1U+5mOMpKJwnpJCSCP4z7+G61mpbVcF7FxKG5RJjei29JXl3dmVYXRE
nRjVI1eXcSKScD5FKh12WuBF0npczw==
=oety
-----END PGP SIGNATURE-----

--TccE7CylT9ec6Nxl--


--===============5348577719927805969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5348577719927805969==--

