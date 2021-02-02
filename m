Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902BC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:59:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F35364F58
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35364F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BF76C20418;
	Tue,  2 Feb 2021 14:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7FttKcg3jPgv; Tue,  2 Feb 2021 14:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C2E182001C;
	Tue,  2 Feb 2021 14:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA82C0FA7;
	Tue,  2 Feb 2021 14:59:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13CA4C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02599860BF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7cyBoUnRQUP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 932BD860BE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612277984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lA/rmyOorAoy/w+AhxxsEsI+Afad/+5GXMgJ3Bkqofw=;
 b=hAysMetj+MA528+8mUzw9a4dl7eGMOzQOReB3kGeIVkIZgb26bhu27JIolvxbR+siVn/2E
 BHUiT45bsTFOX0AyRIflyd4cNiODhhj48f5zO7kRODbXbcze48FluGe1M5K4fBUXiUbg4q
 0r7VGMwL1aXspR9demlXF/4Ii9eHRx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-AHW_jZeEPuiICXhvtzL4ew-1; Tue, 02 Feb 2021 09:59:42 -0500
X-MC-Unique: AHW_jZeEPuiICXhvtzL4ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A82800D55;
 Tue,  2 Feb 2021 14:59:39 +0000 (UTC)
Received: from localhost (ovpn-115-185.ams2.redhat.com [10.36.115.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7644F6EF41;
 Tue,  2 Feb 2021 14:59:35 +0000 (UTC)
Date: Tue, 2 Feb 2021 09:34:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Message-ID: <20210202093412.GA243557@stefanha-x1.localdomain>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-9-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============6704989413895059325=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6704989413895059325==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 28, 2021 at 03:41:25PM +0100, Stefano Garzarella wrote:
> +static void vdpasim_blk_work(struct work_struct *work)
> +{
> +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> +	u8 status = VIRTIO_BLK_S_OK;
> +	int i;
> +
> +	spin_lock(&vdpasim->lock);
> +
> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto out;
> +
> +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
> +
> +		if (!vq->ready)
> +			continue;
> +
> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->out_iov,
> +					    &vq->in_iov, &vq->head,
> +					    GFP_ATOMIC) > 0) {
> +			int write;
> +
> +			vq->in_iov.i = vq->in_iov.used - 1;
> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
> +						      &status, 1);
> +			if (write <= 0)
> +				break;

This code looks fragile:

1. Relying on unsigned underflow and the while loop in
   vringh_iov_push_iotlb() to handle the case where in_iov.used == 0 is
   risky and could break.

2. Does this assume that the last in_iov element has size 1? For
   example, the guest driver may send a single "in" iovec with size 513
   when reading 512 bytes (with an extra byte for the request status).

Please validate inputs fully, even in test/development code, because
it's likely to be copied by others when writing production code (or
deployed in production by unsuspecting users) :).

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAZHJQACgkQnKSrs4Gr
c8iMOQf9Ei+h8ZIngw9GkwH+ynl8uKorG3xB/0jyLQbEMG1hN8mcKrP21stVX6pi
gioFVSxs+cZ1ZNS3HaBPzjbzA9nUVPuppl2lSmYkzbRJo85gr4mGMql8Z5ZS0zhf
A+bq8NmikaxZuEDybVc7jhNSpOd+mPSBoQv7fn6q31E8cGMnmzaZuOmRfPvATbXO
JMXQojrahx/RxvAjj27CKng+eMgLQm8dfmFvJ71cB3Qdgq4y65qCFRY41FTyA9fa
RGJo1b8gYSYXLoaYcUVumCz03afY3d7JYVtD+sdkn8lCerx+igLlHc4ZUrTgxioI
h1lxVCzYIYQAthUlKGGaPLSQ/cHRBQ==
=Sk9g
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


--===============6704989413895059325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6704989413895059325==--

