Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C6C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA69E613F3
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA69E613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A641E83F4E;
	Thu,  3 Jun 2021 14:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nmCFhLuE9wo; Thu,  3 Jun 2021 14:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E8E083E17;
	Thu,  3 Jun 2021 14:32:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B612C000D;
	Thu,  3 Jun 2021 14:32:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 744FEC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6252F60800
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWnGVGz3nukT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:32:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74C1060811
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622730734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQeNSgxab343s13T8dhM9QnuIAZEWvIgxgspgrSno7w=;
 b=bnjX3f/Cw+wrQRv9+b1rPPVu2HCoEa/5uDAgUk7mh5jDmhJy6HWaP/DlacaTxg7ZSP8hv8
 xVPzErDITjkinOOFgflxktmY9gQj+mdtsMAK06DV4AV+kSt8kFihY0S1tv4Nlb5sLZP7XQ
 Qqlak2vwQoVo+6wZN6Wie8ID2e2lmE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-KI1l-vCpOGuhs-KogWGDQQ-1; Thu, 03 Jun 2021 10:31:58 -0400
X-MC-Unique: KI1l-vCpOGuhs-KogWGDQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE761107ACE6;
 Thu,  3 Jun 2021 14:31:56 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA705D9F2;
 Thu,  3 Jun 2021 14:31:53 +0000 (UTC)
Date: Thu, 3 Jun 2021 15:31:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 8/9] vhost: add vhost_dev pointer to vhost_work
Message-ID: <YLjn2Ht5WoPG4wup@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-9-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-9-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============1585647491416594895=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1585647491416594895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RZiem2OgOyGjJMdR"
Content-Disposition: inline


--RZiem2OgOyGjJMdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:59PM -0500, Mike Christie wrote:
> The next patch allows a vhost_worker to handle different devices. To
> prepare for that, this patch adds a pointer to the device on the work so
> we can get to the different mms in the vhost_worker thread.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c  |  7 ++++---
>  drivers/vhost/vhost.c | 24 ++++++++++++++----------
>  drivers/vhost/vhost.h |  4 +++-
>  drivers/vhost/vsock.c |  3 ++-
>  4 files changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RZiem2OgOyGjJMdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC459gACgkQnKSrs4Gr
c8gs3wf/XTDhzvGmFLjY39Te8DUMhO7QSZodoNYrGfc+qcC0icDBORmrE2HRAaST
fIjxQuantnSWIs7Lf6mO7h0J2aAc16AxzvtgUSP4idqwWNtVXibwk7wLLXEyPaHr
9XjMohaiUyWz5E7B8D24isDsirA2zYDQIEP/D6eiJrA00HVAwsex+zSI3zrr2tre
afpRecjqR3mhVEHaCpYcwmlcE03usH4L8iBhDxobZg5YWjRUvacuSdyqr2vkoGrH
dJgB8IpuzlNjLAFIFjFcJ/KXhtZ2GNAvn/6CXckki4zSAlvGQ3KMBKXNyEJkJmXO
KGmtBbA/gHy26xeLfaJ1Q4DiSov/zg==
=J4Wq
-----END PGP SIGNATURE-----

--RZiem2OgOyGjJMdR--


--===============1585647491416594895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1585647491416594895==--

