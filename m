Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB0C5519F
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 13:08:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E86221EB
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 13:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D84NmoFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E86221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D7538704B;
	Tue, 17 Nov 2020 13:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NAODj756p+Eh; Tue, 17 Nov 2020 13:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95CF08703E;
	Tue, 17 Nov 2020 13:08:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8106CC0800;
	Tue, 17 Nov 2020 13:08:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D31C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B16E785B58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lPn2oSzUuPnQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:08:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C9E8C85B48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605618484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Lg/Z4Afo5hxT/KugPsnPGAOmJRCi/NRgTpP62lvgaI=;
 b=D84NmoFHqRzhwONu/x0q+06ew/loTm5uSupq/+c4lC8tizFWPn0+ORWgD0PCrRBwp9kmw2
 McBDTDScxOz4xJcVFBwjyLv/xXNVbzYiZUMwdoigjns9IWTTTRe3kwJ3chOaonxjhzm3sY
 saMAAMua70iQdoad1RhkKhlBYVFNi0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-ptnvOMjXPqeBoGKu0-1OoQ-1; Tue, 17 Nov 2020 08:07:28 -0500
X-MC-Unique: ptnvOMjXPqeBoGKu0-1OoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF769100747C;
 Tue, 17 Nov 2020 13:07:26 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63558176BB;
 Tue, 17 Nov 2020 13:07:23 +0000 (UTC)
Date: Tue, 17 Nov 2020 13:07:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 02/10] vhost scsi: remove extra flushes
Message-ID: <20201117130722.GL131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-4-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-4-git-send-email-michael.christie@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============9126600484413924759=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9126600484413924759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QWRRbczYj8mXuejp"
Content-Disposition: inline

--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:02PM -0600, Mike Christie wrote:
> The vhost work flush function was flushing the entire work queue, so
> there is no need for the double vhost_work_dev_flush calls in
> vhost_scsi_flush.
>=20
> And we do not need to call vhost_poll_flush for each poller because
> that call also ends up flushing the same work queue thread the
> vhost_work_dev_flush call flushed.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 8 --------
>  1 file changed, 8 deletions(-)

Ah, this was done as a separate step:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QWRRbczYj8mXuejp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zywoACgkQnKSrs4Gr
c8izTgf/dq+avFDuwW5m2oQ4Rd78KfOtpZtKTgCJtgIAJoOegflxIrOhYKpZTBnd
mY0WyFNOAhDu6FIUUYQeRz5jNtSVKlbqZRFfuAZFUaLbaaKrFQiNcQinILSO58xt
0kcOyUkve3Dt5EzXNTxfaXVMn9rvB38fkLNIbUprHcxXzyNJyGzKxhczSlQBSGWZ
2pf7mWHICtymczfFltMo6f8weScWg01NqQhzrEt4EcYGnIJ7jRyHYZiPfhiXoYjs
8pIeX6RiLImOh+tB+tCsGOwtMqVOft3e5vNoep1QMxoTZRqqPc5p7zuVXR8O/hnu
+3sqOIFOIgMgfa67qXaoRfKuVCH/Uw==
=9o1W
-----END PGP SIGNATURE-----

--QWRRbczYj8mXuejp--


--===============9126600484413924759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9126600484413924759==--

