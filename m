Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D9C5519F
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:15:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89D9221F8
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grVTF+i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89D9221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 517FC8426E;
	Tue, 17 Nov 2020 16:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ab2h2AEgVlxb; Tue, 17 Nov 2020 16:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0D0D81AE0;
	Tue, 17 Nov 2020 16:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B42C0891;
	Tue, 17 Nov 2020 16:15:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 860FBC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 74AA885751
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbUX8hD2MIBU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E6A0484C33
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605629725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wsI8dT8PpexMe9TuKFjAgUNaAmV6auVjRCkQ8lpeHW4=;
 b=grVTF+i3Hl7saynH5bBino2EKWUXLDhFHkJLzqAdICbUjFzHdJyVXPWkmGdc5hQIe9FWz/
 msmQj2VVNGkDc8It/kIa8tnZ5dWHngDKnF8Bc6UL0Nk4hA0xOV/RSeo9tYmM4SjdrRMUVj
 VH2RcSmfgGnnFfOJpKCnhNxFTWc+Xks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-mCQTzDWuOOqXoqcnilpHFw-1; Tue, 17 Nov 2020 11:14:44 -0500
X-MC-Unique: mCQTzDWuOOqXoqcnilpHFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 576FA8042A0;
 Tue, 17 Nov 2020 16:14:43 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82F3B62A4F;
 Tue, 17 Nov 2020 16:14:39 +0000 (UTC)
Date: Tue, 17 Nov 2020 16:14:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 09/10] vhost: add VHOST_SET_VRING_ENABLE support
Message-ID: <20201117161438.GR131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-11-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-11-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, mst@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============0444861142883685192=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0444861142883685192==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X35wERi4JU/f1kly"
Content-Disposition: inline

--X35wERi4JU/f1kly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:09PM -0600, Mike Christie wrote:
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2f98b81..e953031 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1736,6 +1736,28 @@ static long vhost_vring_set_num_addr(struct vhost_=
dev *d,
> =20
>  =09return r;
>  }
> +
> +static long vhost_vring_set_enable(struct vhost_dev *d,
> +=09=09=09=09   struct vhost_virtqueue *vq,
> +=09=09=09=09   void __user *argp)
> +{
> +=09struct vhost_vring_state s;
> +=09int ret =3D 0;
> +
> +=09if (vq->private_data)
> +=09=09return -EBUSY;
> +
> +=09if (copy_from_user(&s, argp, sizeof s))
> +=09=09return -EFAULT;
> +
> +=09if (s.num !=3D 1 && s.num !=3D 0)
> +=09=09return -EINVAL;
> +
> +=09if (d->ops && d->ops->enable_vring)
> +=09=09ret =3D d->ops->enable_vring(vq, s.num);
> +=09return ret;
> +}

Silently ignoring this ioctl on drivers that don't implement
d->ops->enable_vring() could be a problem. Userspace expects to be able
to enable/disable vqs, we can't just return 0 because the vq won't be
enabled/disabled as requested.

> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index a293f48..1279c09 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -158,6 +158,7 @@ struct vhost_msg_node {
> =20
>  struct vhost_dev_ops {
>  =09int (*msg_handler)(struct vhost_dev *dev, struct vhost_iotlb_msg *msg=
);
> +=09int (*enable_vring)(struct vhost_virtqueue *vq, bool enable);

Please add doc comments explaining what this callback needs to do and
the environment in which it is executed (locks that are held, etc).

--X35wERi4JU/f1kly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z9u4ACgkQnKSrs4Gr
c8ic5gf+O5o6weTp4soPZPFPYRPFV5BCzOnFZJnbdZ9ZiVoApnqC2iOnZTeJjwov
Tut0vqNrK6AaS/CHM6zo5pPSiwcITUlDy94VuB4fwtxprI3+b5FSbVBT5jZsdqpX
Axm3VoQu7RaqcWhPS0Sj6QRGy3bL6aruaoDM5zIlBO2p78bQsxqhgZxPKnoaG63s
deG/jgvNvGZgJ+EYd+CxvdaNvQP9ktK8MTWryuMdzYo/lOo1sGLyfdsimQPQNYs1
PrG1/vyYUDRBYwoUFuKRuopp/2GLMHDXeZXf4ZvqyPT4CYFH6CFJ7TK5ae4a15R7
HqqpOBChKzwUplk9si9SdpffMI+CJQ==
=Jr92
-----END PGP SIGNATURE-----

--X35wERi4JU/f1kly--


--===============0444861142883685192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0444861142883685192==--

