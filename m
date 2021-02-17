Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85663C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 13:01:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C50164E42
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 13:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C50164E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CA206F60A
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 13:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4fzHPxDPO1z for <virtualization@archiver.kernel.org>;
	Wed, 17 Feb 2021 13:01:50 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 73A1E6F5CE; Wed, 17 Feb 2021 13:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 708016EEFD;
	Wed, 17 Feb 2021 13:01:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CAE8C0174;
	Wed, 17 Feb 2021 13:01:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6125EC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 13:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E39F860C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 13:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sN_Ol29FBSHy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 13:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 95B5A860AE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613566903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIThSsbUjDdWjx/9SU7T/XKx8itj2Smth98HnG4qOis=;
 b=XNl7XKAogJjTdoB/PfDolGrGfw7OLlFHykyDozcACxbxIvOF30zhr10f0BHMiRQuGvVVqS
 DY45UHiPrsayYvBAJwVak7JK68E9tf3ocM0HUFZstmhvEACQvcfmIOCLYZiQyr4gWWJOW7
 QNOj6YVMMjXXjQG714WbER5tk1o2I3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-eMe8E2DTOMCdqLF5J46xQg-1; Wed, 17 Feb 2021 08:01:38 -0500
X-MC-Unique: eMe8E2DTOMCdqLF5J46xQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10D41005501;
 Wed, 17 Feb 2021 13:01:36 +0000 (UTC)
Received: from localhost (ovpn-115-102.ams2.redhat.com [10.36.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E0F36A8ED;
 Wed, 17 Feb 2021 13:01:09 +0000 (UTC)
Date: Wed, 17 Feb 2021 13:01:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v2 4/7] vhost: Add VhostShadowVirtqueue
Message-ID: <20210217130108.GF269203@stefanha-x1.localdomain>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-5-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Rob Miller <rob.miller@broadcom.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>
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
Content-Type: multipart/mixed; boundary="===============4013405176006275651=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4013405176006275651==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline

--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 04:37:54PM +0100, Eugenio P=E9rez wrote:
> +/*
> + * Creates vhost shadow virtqueue, and instruct vhost device to use the =
shadow
> + * methods and file descriptors.
> + */
> +VhostShadowVirtqueue *vhost_shadow_vq_new(struct vhost_dev *dev, int idx=
)
> +{
> +    g_autofree VhostShadowVirtqueue *svq =3D g_new0(VhostShadowVirtqueue=
, 1);
> +    int r;
> +
> +    r =3D event_notifier_init(&svq->kick_notifier, 0);
> +    if (r !=3D 0) {
> +        error_report("Couldn't create kick event notifier: %s",
> +                     strerror(errno));
> +        goto err_init_kick_notifier;
> +    }
> +
> +    r =3D event_notifier_init(&svq->call_notifier, 0);
> +    if (r !=3D 0) {
> +        error_report("Couldn't create call event notifier: %s",
> +                     strerror(errno));
> +        goto err_init_call_notifier;
> +    }
> +
> +    return svq;

Use-after-free due to g_autofree. I think this should be:

  return g_steal_pointer(&svq)

https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html#g-steal=
-pointer

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAtE5QACgkQnKSrs4Gr
c8iPKwgAsqpgBXufqRLw/6AgkmS4Uw1bCJru2OzwGNmr8nHE73Fy+Nn4+Ck+4V3D
PIPomdEyA+GDcDoI6m820D85cBQJLaJosu7u5bgQirHJM5fPsRQfy2P20SAK1FWF
b6LnpEFF0a9ZHz26LtQZDQ4GYZ2eMwuwFzyky+JWd/LF//A9FOFP3OH+PM9wYNHA
aXFShfY9mFPDFIstEcVyAx2d/uFt+lah5S0zLJANUVAwZWdxNzarDeYspJ3gYUZ5
3C4++2ApTDQY9bF3XJZfEei78HRnz1mHNTVnpxPnRy6KZ/AKgjwRrvRi16WfkHx8
pwlbJIdEXaH6+ss6KE1aEhPDpjcPhQ==
=N1Yp
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--


--===============4013405176006275651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4013405176006275651==--

