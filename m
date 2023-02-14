Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F60C05027
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 16:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79F7B4092C;
	Tue, 14 Feb 2023 16:42:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79F7B4092C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aI9uKd9y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7IRLkOkFUed; Tue, 14 Feb 2023 16:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C02AC40922;
	Tue, 14 Feb 2023 16:42:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C02AC40922
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 898B1C0033;
	Tue, 14 Feb 2023 16:42:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D11C2C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 16:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B83D881E4E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 16:42:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B83D881E4E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aI9uKd9y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8YWnusFWOCX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 16:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF26981E3A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF26981E3A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676392925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6eqvoFwqH6MbbrEiiK8eru7l+SZ5tdaOJINEp0Ly7Y=;
 b=aI9uKd9y8CXSFoawFbe+ahiGDqgmwyIEQcqhWs8ryJtEqebY4QQT+Ii0NTz8OoPLQqnz/M
 e6ZO6Wx9kJ49yTSSTGZfzaJsTmjIj07AjOjrk5Q3luahI6N6bVuiBaoMYEX/vm990lv3np
 gS0as2kEd4ZngDivRAb1yqNSC3geY5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-DV_7l-xJNnyn8NmnXAK99w-1; Tue, 14 Feb 2023 11:41:59 -0500
X-MC-Unique: DV_7l-xJNnyn8NmnXAK99w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 689AC87A385;
 Tue, 14 Feb 2023 16:41:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC0A42026D4B;
 Tue, 14 Feb 2023 16:41:57 +0000 (UTC)
Date: Tue, 14 Feb 2023 11:41:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in  virtscsi_rescan_hotunplug
Message-ID: <Y+u51GN1uf3i0A4+@fedora>
References: <20230202064124.22277-1-zyytlz.wz@163.com>
 <20230213070906-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230213070906-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: alex000young@gmail.com, security@kernel.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 hackerzheng666@gmail.com, virtualization@lists.linux-foundation.org,
 pbonzini@redhat.com, Zheng Wang <zyytlz.wz@163.com>, jejb@linux.ibm.com
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
Content-Type: multipart/mixed; boundary="===============2730836025172110479=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2730836025172110479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8UxNTXH0/J1RCIqe"
Content-Disposition: inline


--8UxNTXH0/J1RCIqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 07:09:50AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> > There is no check about the return value of kmalloc in
> > virtscsi_rescan_hotunplug. Add the check to avoid use
> > of null pointer 'inq_result' in case of the failure
> > of kmalloc.
> >=20
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
>=20
> I fixed a typo in subject and tweaked the patch a bit

Thanks for picking this patch up.
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=3Dl=
inux-next&id=3D4a8fc6e3ac68ce4c355d1f4473ef1d8468b23bdc

Stefan

--8UxNTXH0/J1RCIqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPrudQACgkQnKSrs4Gr
c8gR5QgAyX3SyeEgLJ/OpK4aeXYNWXfpZcmtdCK3YtTy7c7C16RA7vFll5zv1CpI
z2+qqNf1KeDsrntla046kqeNVgASEKEorQJm9chEw1emaLFyOvzLBCXNd7wvfso3
ix4l6Ua7dM9nm5Rrf6j6zBs9PcdEGtb/llC5m8RR0GFX8iO+izOk1hVG3DmPDOsQ
rK3ZETdRiLAE51MVYNHT+XKR545IK5R9JMhRUzhKEqdR0cMePk0ZPoNKtU2wAzlf
9tiJGw2oiebN9ZHbnpXrulA74v9VQmhKqH/KGv20WkXRL9/QutViOECSBHJGuACf
MFd+kMz4hzdbv50rWM4ksYjDFz45zw==
=SFCg
-----END PGP SIGNATURE-----

--8UxNTXH0/J1RCIqe--


--===============2730836025172110479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2730836025172110479==--

