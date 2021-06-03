Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B4C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 13:57:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920B9613AA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 13:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B9613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FDCF83EE1;
	Thu,  3 Jun 2021 13:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uXYVlfufqFU3; Thu,  3 Jun 2021 13:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78DE883D55;
	Thu,  3 Jun 2021 13:57:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C050C000E;
	Thu,  3 Jun 2021 13:57:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49708C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22A87605A0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9HpnOEjs2Sr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:57:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AF426059A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622728665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmLTHJrSQDbMU7UTLA4d0t4PiOLJgLmVKJZe+PUyZok=;
 b=HcbTYTGkMY9rMIgdPNa/SDKKcmHFkjdhurOLukU+tz8k4wAUX8LseqgCaVqdiJKVeG4ePE
 itE2s6Qs75+uRUQJNAsq8EOWhHpk5tIwm8xp1P4lWxKSOF4BQ86jCGWsABCteSoaZ/kgbQ
 W254SL5Cv8BC8GOAdg1lgvRoTdVLZaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-NqkgsowEMUKltENCWcyOoQ-1; Thu, 03 Jun 2021 09:57:36 -0400
X-MC-Unique: NqkgsowEMUKltENCWcyOoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D00E0803624;
 Thu,  3 Jun 2021 13:57:35 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C790A60657;
 Thu,  3 Jun 2021 13:57:31 +0000 (UTC)
Date: Thu, 3 Jun 2021 14:57:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 6/9] vhost-scsi: make SCSI cmd completion per vq
Message-ID: <YLjfyqC1VD7kNFpH@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-7-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-7-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Content-Type: multipart/mixed; boundary="===============5529404189550278543=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5529404189550278543==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mvXsWp4PhT0LQr2M"
Content-Disposition: inline


--mvXsWp4PhT0LQr2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:57PM -0500, Mike Christie wrote:
> This patch separates the scsi cmd completion code paths so we can complete
> cmds based on their vq instead of having all cmds complete on the same
> worker/CPU. This will be useful with the next patch that allows us to
> create mulitple worker threads and bind them to different vqs, so we can
> have completions running on different threads/CPUs.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 48 +++++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mvXsWp4PhT0LQr2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC438oACgkQnKSrs4Gr
c8hBHwgAqiLjVqav8oRJZbb+h+FZfPrI5JEeMouqXSxGC/R3GNDnJXHoIosgbjUd
isXzBnt1GHlhRBspQXx1i+z2TZ09csnLPdF25g1qwULMQmZ7pCAjdOIAzMaTauxn
6GBGOB1P+YD4/QQAgdFWyUqI0t0VxfrHxHY5AgAoZ5b4DEt105OrUDMFlwXLbsXm
rMZV8biElfES8egfDNuHg9Ityn/DtQZVB16FQZnB0bYU6elHpXXn+mcaqfKQWWoX
+VDFyFB0I8jmZRfgXf/VBgX9uZUy4ByW+sTE8M+/L0e6eymw75c7ZXSvgImcQazl
rrCvDqyPsNL/jVotE0y8R1cvPFjJ/A==
=6gup
-----END PGP SIGNATURE-----

--mvXsWp4PhT0LQr2M--


--===============5529404189550278543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5529404189550278543==--

