Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCDC433ED
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0EF613C3
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0EF613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F31084618;
	Wed, 14 Apr 2021 08:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JgSZt5QmAJbA; Wed, 14 Apr 2021 08:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 083E7845CD;
	Wed, 14 Apr 2021 08:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1C9FC000B;
	Wed, 14 Apr 2021 08:40:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 446BBC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 08:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D1A60D6D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 08:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffXMdJvfmkQR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 08:40:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D49D60BA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 08:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618389655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDVMJkpRK1Zblh+QKUchn0+EWb/JoRAGYZO+L/mZbdU=;
 b=BlL69nv3bKUEizesfXE4Ss2Oe2KcFO1d5TYvUcmtwBGFZRLTjeGhAseiEECk6APN9KYQDr
 Obmdb0tZl/WradG/suSzg6b/GLlBU8kzijOpHZXzc0KDw5rh9VqgP+NiYX/nxo0olAIRHT
 55w1uuj2j3BBSWHofRtTtX8vEP3hQhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-pyeGloAtMc223IRxWQU0_A-1; Wed, 14 Apr 2021 04:40:52 -0400
X-MC-Unique: pyeGloAtMc223IRxWQU0_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683D28030CA;
 Wed, 14 Apr 2021 08:40:51 +0000 (UTC)
Received: from localhost (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D46AA6A039;
 Wed, 14 Apr 2021 08:40:50 +0000 (UTC)
Date: Wed, 14 Apr 2021 09:40:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] virtiofs: remove useless function
Message-ID: <YHaqkV0rUc7iu66f@stefanha-x1.localdomain>
References: <1618305743-42003-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1618305743-42003-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com, miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============0481779090130193717=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0481779090130193717==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iAAPjvzcPxYyW4TN"
Content-Disposition: inline


--iAAPjvzcPxYyW4TN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 05:22:23PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
>=20
> fs/fuse/virtio_fs.c:130:35: warning: unused function 'vq_to_fpq'
> [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/fuse/virtio_fs.c | 5 -----
>  1 file changed, 5 deletions(-)

The function was never used...

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iAAPjvzcPxYyW4TN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB2qpEACgkQnKSrs4Gr
c8iE9Af/a/YtHLu0Ely+QkjFL93NVsZwlPbkJERhv9mpU3qzK2gU9aHG0fD4bdPQ
fpvXmjcncPiB4OX8se/gdVg2YrVaBC9w/t/DPho4JZvnMeZsTLMvpk2oncKyZObb
s+Tp4GoTg++uWS8e7b4bu7R79mm8q9xGpyc9t9grC7VbHbMN8OMJwmcMJz/hHndg
fRoojMr9xsZQ9wThmAgmMrQy4W3XwIX8JDv1hAl3wiUWJSIr+izEmNMjLsN2QV61
vV1PpKhL07W1sTTLxMm5krVi0DNV8HInQTsTCF6gBYGocDoWl/BvAXKm4SpmnlS2
9g7Fk6BwxZYIiNJawHq3u4F6xLlttg==
=AMFq
-----END PGP SIGNATURE-----

--iAAPjvzcPxYyW4TN--


--===============0481779090130193717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0481779090130193717==--

