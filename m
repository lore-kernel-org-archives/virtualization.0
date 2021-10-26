Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A27C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 15:23:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7AA60E74
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 15:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB7AA60E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97AE54015E;
	Tue, 26 Oct 2021 15:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qE1H8mkZioHG; Tue, 26 Oct 2021 15:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2981840120;
	Tue, 26 Oct 2021 15:23:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE63DC0019;
	Tue, 26 Oct 2021 15:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86459C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 15:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DA1B81751
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 15:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bih2XBDZugcs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 15:23:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8D828174C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635261790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkpuDI1xqrOFfxjCnES39c8hUWyHSyRHa6KbkJwr754=;
 b=EsWxgdlc7ixPs4JnxJMQ4c5xYav2nnqmdz1zT0Jg5p582tKggfGQhydOJJ6dbyXV+pPUo3
 IrxXbk8Q0tqNIo+4/cCdRXlkaFbI1N01ihtxeDckKZljCEAIuaWvGvtK8/ZNAI4Ar0lUEo
 5mAAJYzri+79aGdBlBNXBXpPnVW/qiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-j-Pe4w1SPUGimPpyJ5z36A-1; Tue, 26 Oct 2021 11:23:08 -0400
X-MC-Unique: j-Pe4w1SPUGimPpyJ5z36A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC271006AA2;
 Tue, 26 Oct 2021 15:23:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC0A5F4E0;
 Tue, 26 Oct 2021 15:22:58 +0000 (UTC)
Date: Tue, 26 Oct 2021 16:22:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <YXgdUfV52ZuZo2CB@stefanha-x1.localdomain>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211022051911.108383-13-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Content-Type: multipart/mixed; boundary="===============2783363809650041078=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2783363809650041078==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3TF8DvIYw1i77WAN"
Content-Disposition: inline


--3TF8DvIYw1i77WAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 12:19:11AM -0500, Mike Christie wrote:
> +/* Caller must have device mutex */
> +static int vhost_vq_setup_worker(struct vhost_virtqueue *vq,
> +				 struct vhost_vring_worker *info)

It's clearer if the function name matches the ioctl name
(VHOST_SET_VRING_WORKER).

--3TF8DvIYw1i77WAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF4HVEACgkQnKSrs4Gr
c8iU0wgAj4ZtAHsGeZepIAqBVetF9MhIZn24Y2gIQ+ceP/XUd10zAwCFXhDAi+ZX
lzVQcExOuoEeLy9k6g56Y1UB7DiKa05Tq1ApspPWaPU1o04zpUekYzhi5NMk2Kas
zlhwaWaMhxboupvsX9UdADGWhcPLrH1vq/wMMsITdPscQC4qDSLOxGyPhpaiJj/k
Z3GQtd5QP01WbZ8BgvVGG3adyJ3zDMBP56WGhIWzL5Qw+mo2vN0TZeStbEvKpyQx
cB/wNe+dSUaoAJGesAsdtHOV1L5zGJHIywWujoRxgqe3bE2eityzmrV55T5X2D2m
IIxsl6jecWOVSCqQJC0w3dHGz1L3gg==
=TsdU
-----END PGP SIGNATURE-----

--3TF8DvIYw1i77WAN--


--===============2783363809650041078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2783363809650041078==--

