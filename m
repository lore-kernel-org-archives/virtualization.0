Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C64C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 13:54:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CBC613E7
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 13:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CBC613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAD8A400FF;
	Thu,  3 Jun 2021 13:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUb1GWn5a0lx; Thu,  3 Jun 2021 13:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65E13400CA;
	Thu,  3 Jun 2021 13:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 468DCC000E;
	Thu,  3 Jun 2021 13:54:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF377C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89B3C40367
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-v7wFYuBwwr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7918840243
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622728453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kB/QJX5BIlb1z1hPD/TANoHe7uf5sJAff0xCkv6VsY=;
 b=KMZqHAJxVkrThbQ5+BoUuVi0e4iMepkAoy2ZCkTznIBjpyzsfp/au+3QNS4R/LXhCCsUqu
 3SDxd494ZiaFn6Qj8Ag3CqyGm9+7+aU+zEnjJLOf6EwKWIanTXk0oOfJGYZ+8fN7HZRFxg
 88GxLDNXpcgg8LloPIZjzWq34anHWJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-3GFkZtYmMkii5c7HxqWoVQ-1; Thu, 03 Jun 2021 09:54:11 -0400
X-MC-Unique: 3GFkZtYmMkii5c7HxqWoVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57FE8180FD75;
 Thu,  3 Jun 2021 13:54:10 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4E465C232;
 Thu,  3 Jun 2021 13:54:05 +0000 (UTC)
Date: Thu, 3 Jun 2021 14:54:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 5/9] vhost-scsi: flush IO vqs then send TMF rsp
Message-ID: <YLje/Ja40HpxxRlh@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-6-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-6-michael.christie@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============7039657191686140992=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7039657191686140992==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oQptM8rAC7OUhFVQ"
Content-Disposition: inline


--oQptM8rAC7OUhFVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:56PM -0500, Mike Christie wrote:
> With one worker we will always send the scsi cmd responses then send the
> TMF rsp, because LIO will always complete the scsi cmds first which
> calls vhost_scsi_release_cmd to add them to the work queue.
>=20
> When the next patches adds multiple worker support, the worker threads
> could still be sending their responses when the tmf's work is run.
> So this patch has vhost-scsi flush the IO vqs on other worker threads
> before we send the tmf response.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c  | 17 ++++++++++++++---
>  drivers/vhost/vhost.c |  6 ++++++
>  drivers/vhost/vhost.h |  1 +
>  3 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 46f897e41217..e585f2180457 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1168,12 +1168,23 @@ static void vhost_scsi_tmf_resp_work(struct vhost=
_work *work)
>  {
>  	struct vhost_scsi_tmf *tmf =3D container_of(work, struct vhost_scsi_tmf,
>  						  vwork);
> -	int resp_code;
> +	int resp_code, i;
> +
> +	if (tmf->scsi_resp =3D=3D TMR_FUNCTION_COMPLETE) {
> +		/*
> +		 * When processing a TMF lio completes the cmds then the TMF,
> +		 * so with one worker the TMF always completes after cmds. For
> +		 * multiple worker support we must flush the IO vqs to make
> +		 * sure if they have differrent workers then the cmds have

s/differrent/different/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oQptM8rAC7OUhFVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC43vwACgkQnKSrs4Gr
c8hjZwf+KeUTDVtyQ9sFewX8iRHhfPwDLkXjwwOArYnb7aItO7iqWHMMOzOWB0EJ
aEEPQJh4wkPM2JEFaSfG0nKKEiOCAp7eKBWaGEROSJAb2iEWDdqwFv0aRo8q/oNb
JAraumYNlrKuBFm5WFQWLxnqh5AmYGYwbZ91LPsoz1inRXo8C5gqCgQuILBCK+2u
7NuZhNpJHVjnCyOoVA2OskULdIPUHNpnCF0DVg2VpOVuPIcAAXPo8VIRb09ZxlXB
zQ/VZPxMBZ44vF/3oWSvjgWxtBM16YbDQF3LzkVoMdsqnKXX4KP2ooXNfIDU5n0C
vQXaagDOfVUHdhoAz2+n6LQ83zR9bw==
=G+4s
-----END PGP SIGNATURE-----

--oQptM8rAC7OUhFVQ--


--===============7039657191686140992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7039657191686140992==--

