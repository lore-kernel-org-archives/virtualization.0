Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B2C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:05:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFC0241A7
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dByNIVjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFC0241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CE12858BA;
	Tue, 17 Nov 2020 16:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAYbKZilpstt; Tue, 17 Nov 2020 16:05:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD3BB84EA7;
	Tue, 17 Nov 2020 16:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE35C0891;
	Tue, 17 Nov 2020 16:05:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5233BC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 306072047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aadCRJ4MZOx9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:05:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 750D220021
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605629143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ed1LhVKjQj2PeSGWg14twvLm6/KTivQ3jK64P+HzZhQ=;
 b=dByNIVjEv778UVCtiv1W9ysjazwRKEHAHy+yS7YZVjW6N3QEVkEeRdUK7EKk5LLQ/Jsn1h
 D103RtdeCDJQI6nHTk2xhAyX2HgSZPvh3a3ETqr5NgFrq7MSrcl1volz1Uue/2y+02GQGn
 m01R3xRw8OjOaHNVFoP7BT4gQnxorTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-BpNF29LAMia3uJ9rQX57TA-1; Tue, 17 Nov 2020 11:05:39 -0500
X-MC-Unique: BpNF29LAMia3uJ9rQX57TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A8D11BD341;
 Tue, 17 Nov 2020 16:05:37 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CDD1001E73;
 Tue, 17 Nov 2020 16:05:33 +0000 (UTC)
Date: Tue, 17 Nov 2020 16:05:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 07/10] vhost, vhost-scsi: flush IO vqs then send TMF rsp
Message-ID: <20201117160532.GP131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-9-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-9-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Type: multipart/mixed; boundary="===============3297437789976178949=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3297437789976178949==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Content-Disposition: inline

--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:07PM -0600, Mike Christie wrote:
> With one worker we will always send the scsi cmd responses then send the
> TMF rsp, because LIO will always complete the scsi cmds first which
> calls vhost_scsi_release_cmd to add them to the work queue.
>=20
> When the next patch adds multiple worker support, the worker threads
> could still be sending their responses when the tmf's work is run.
> So this patch has vhost-scsi flush the IO vqs on other worker threads
> before we send the tmf response.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c  | 16 ++++++++++++++--
>  drivers/vhost/vhost.c |  6 ++++++
>  drivers/vhost/vhost.h |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z9MwACgkQnKSrs4Gr
c8gaqgf/ezD3eMZkmyNkKq/TS6tnuCAH04YabhXKm+dLdSH9xZvaLGPKG/CnwF6o
/gS0CjOu5YrvXmP+VlZ+uwaOIqOHgxP79NAm57j5mPXi6VLcz3tK7ctF8jrGDqYH
wzSkCP2Wjr0Dvc3t2d5gAyggrabBtyPzuT9oUjolzEo6DXKQQXN3Ok3sVDDinQ2d
/jF39oufcFmWT3+EeUEBXr2MHtC7ccx3ZFCCASkNznT5s+CuwLrLeqVIS+2wC9FK
x4XdBOvZ0qy/rggn3UAmDQe2cfuaU28vwZhddyVjeBjSyimYbnoSQT1XheHB/45v
MyMI5NxDJBU3WStraKoA/MQRSYcB8A==
=IxzD
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--


--===============3297437789976178949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3297437789976178949==--

