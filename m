Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFAC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 13:35:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93CD61A07
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 13:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93CD61A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52AC3404FA;
	Wed, 24 Mar 2021 13:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1yGHm-eBUAx; Wed, 24 Mar 2021 13:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 036154011D;
	Wed, 24 Mar 2021 13:35:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7272C000E;
	Wed, 24 Mar 2021 13:35:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF02C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D0A984912
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wpBHYv7EbGud
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E77584904
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616592904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJaHNaoPlTW3XDMRdqL5rHIbb29WVJ++1idPZKK0ncU=;
 b=cFvBdfFSt47tEt7zc3Nu/wLoAGWnRdUd0Nv4S0le7O2YxLi20ixexBgcEYNe2iX7nlhwT1
 +7DnNyBAKeQcCzmy6mAi9qIBSocmRATqXWuQs7LMaKNZtr8ohHHF/ROuL27m4EB2ISxONp
 HSmpg3jlL+1isCot1zZvdkVNXXqKYcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-3UI4w1R8MjqWgoC3EEiR7A-1; Wed, 24 Mar 2021 09:35:00 -0400
X-MC-Unique: 3UI4w1R8MjqWgoC3EEiR7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A7610A1779;
 Wed, 24 Mar 2021 13:34:31 +0000 (UTC)
Received: from localhost (ovpn-115-111.ams2.redhat.com [10.36.115.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E3A36A967;
 Wed, 24 Mar 2021 13:34:27 +0000 (UTC)
Date: Wed, 24 Mar 2021 13:34:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4] virtio-vsock: use C style defines for constants
Message-ID: <YFs/4hcX8nd7h2Jv@stefanha-x1.localdomain>
References: <20210323154840.2504509-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323154840.2504509-1-arseny.krasnov@kaspersky.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 cohuck@redhat.com, Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>, oxffffaa@gmail.com,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: multipart/mixed; boundary="===============9069791453542225137=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9069791453542225137==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w+I47P0NEHZk1Xab"
Content-Disposition: inline

--w+I47P0NEHZk1Xab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 06:48:36PM +0300, Arseny Krasnov wrote:
> This:
> 1) Replaces enums with C style "defines", because
>    use of enums is not documented, while "defines"
>    are widely used in spec.
> 2) Adds defines for some constants.
>=20
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 54 +++++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)

Awesome, thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w+I47P0NEHZk1Xab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBbP+IACgkQnKSrs4Gr
c8gvYQf8DUv+wnAOw47q93n+H4VFp4xIiDdexFEonxmbOlyGKoakCjknDP9MpZOU
4d27vUEBg5UkvWFRkQIlXRsfi1QICqGqtB8HoSNA12OGryJlRDpmM0zB0BALViHt
CJqBt5E4oELPRHpOJ8xaxa87DQFZCfHxaYpREUq0vzCQ5JMSb+uN1sOc9Uvl2o4w
1KvR1q9pNwi9MUiT0A2JI5YpAWZ773RSCHIfDDdA3T7yYTkppieklLH46uTcG5A6
MruxIRXXPjKmSp2+6nA1h2/1b/BSiwFpmlYOLc9jDyWLXHcExQ4Td8Th/ey+oSA8
IdJT3FrNjZykF7hAfsGyDU5YlLWr3Q==
=6lg0
-----END PGP SIGNATURE-----

--w+I47P0NEHZk1Xab--


--===============9069791453542225137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9069791453542225137==--

