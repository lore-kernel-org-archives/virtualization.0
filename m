Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF7C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:29:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EB6613E6
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EB6613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC7F3606EA;
	Thu,  3 Jun 2021 10:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ovp__U6FefW; Thu,  3 Jun 2021 10:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 924F8605AE;
	Thu,  3 Jun 2021 10:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 604ECC000D;
	Thu,  3 Jun 2021 10:28:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B053C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8130E606A8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnNZ76p1a-fk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33544605AE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622716134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPQToC1ik9oHfu1AmKA/86ffSnUnlZHx++iOqDu8E5Y=;
 b=WrpWDpbb7Ccn+8Zor/3Vo7TK4zhN17rr3B259/cOh8LLG3dZcFrEsFW0Msyfw/aIB72Kb4
 JwcdVUSFHvMHPfquiHfrKm3+vlbeTijaTahVpAkwCihGG63o7CoszFvPT/Zb8QHj5g+CRs
 EcXVrQfMLmp3g6Lo+4HzXrNBrAUF7Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-OHMTbGSeMdydLSw4QWlSaw-1; Thu, 03 Jun 2021 06:28:52 -0400
X-MC-Unique: OHMTbGSeMdydLSw4QWlSaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C940C800D62;
 Thu,  3 Jun 2021 10:28:51 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08E625C8AA;
 Thu,  3 Jun 2021 10:28:41 +0000 (UTC)
Date: Thu, 3 Jun 2021 11:28:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 2/9] vhost: move vhost worker creation to kick setup
Message-ID: <YLiu2SSYO6OFvMej@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-3-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-3-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Content-Type: multipart/mixed; boundary="===============9043586525760541456=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============9043586525760541456==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/Dbkikjln5Hb9KX"
Content-Disposition: inline


--n/Dbkikjln5Hb9KX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:53PM -0500, Mike Christie wrote:
> The next patch will add new ioctls that allows userspace to create workers
> and bind them to devs and vqs after VHOST_SET_OWNER. To support older
> tools, newer tools that want to go wild with worker threads, and newer
> tools that want the old/default behavior this patch moves the default
> worker setup to the kick setup.
>=20
> After the first vq's kick/poll setup is done we could start to get works
> queued, so this is the point when we must have a worker setup. If we are
> using older tools or the newer tools just want the default single vhost
> thread per dev behavior then it will automatically be done here. If the
> tools are using the newer ioctls that have already created the workers
> then we also detect that here and do nothing.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n/Dbkikjln5Hb9KX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC4rtkACgkQnKSrs4Gr
c8iu4wf/Sk12UdeSXdEDKaWJ2ulcEl3xPNuQ07SuOYcgryJ97dPwlAcruGzMGcWt
RXT085PKTuq3wXxBWV5TJgAduO15mBdTb3r3Ns0IH+kYmCtauaH0xi12LtiNsmKf
sTf+3isPIWzjCjnLn+QzydOlJmnRbfGOlH6CDeMsg87HrpsuOJUEmgm5fuP6thSs
ZKLB3D6cdhcOXlqH4Bqmj75VZNot7BYrfNczyah+zIcdS5oFvArraAMsbOm2ahTz
HyrSRS8bmALHHLsZPry9PtltXQKdYeuSbwaRkpd4oWhTIP1EsbMRIuy/Trc59Y6r
htvrEZK30F4/D12V5p9i03VZZ0QQPg==
=D334
-----END PGP SIGNATURE-----

--n/Dbkikjln5Hb9KX--


--===============9043586525760541456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9043586525760541456==--

