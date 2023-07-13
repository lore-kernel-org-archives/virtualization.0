Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD284C001B0
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41E6842090;
	Thu, 13 Jul 2023 14:11:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41E6842090
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C/99V76/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cAle0y-wF9Xi; Thu, 13 Jul 2023 14:11:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 895D542076;
	Thu, 13 Jul 2023 14:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 895D542076
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B5A2C0071;
	Thu, 13 Jul 2023 14:11:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67861C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3539B60A77
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3539B60A77
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C/99V76/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sESKyU82SHXI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:11:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DECD60030
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DECD60030
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689257488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zisuLHJ8gu0UXeSj22EBom1yssk9ZFr5dEm2UPrsAY=;
 b=C/99V76/e8g0Obsoe2KZn//ruPc1miM6KYfYtfINnx4XyGSj9JGmCr/sbbhKZUhKEVDapD
 cgqp7C/Nhk1uMyhrvJpq88U2F2OZBMGWXxihAuYw5sHwppqsDBEVa2vVE/JaUNLzRaUzDD
 uZcNg70kaJ96SEdjPgweX5bIRkixUyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-FqwqVdPpN-SMhbWRSKFfPw-1; Thu, 13 Jul 2023 10:11:20 -0400
X-MC-Unique: FqwqVdPpN-SMhbWRSKFfPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5118C08B2;
 Thu, 13 Jul 2023 14:07:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46D90F66CB;
 Thu, 13 Jul 2023 14:07:34 +0000 (UTC)
Date: Thu, 13 Jul 2023 10:07:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vadim Rozenfeld <vrozenfe@redhat.com>
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230713140733.GB310002@fedora>
References: <20230709202859.138387-1-michael.christie@oracle.com>
 <20230711183438.GA154686@fedora>
 <6b53b833-3c71-2bd9-8fd8-757ecda75c53@oracle.com>
 <20230712142656.GB215287@fedora>
 <41d2d3aa-b537-686a-f2b4-1e0a861cebc8@oracle.com>
 <CAKiOO4taKxW+QEveJA-3ovM04gkx0dBN0M_gEAAR9nb_bA-2uA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKiOO4taKxW+QEveJA-3ovM04gkx0dBN0M_gEAAR9nb_bA-2uA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: linux-scsi@vger.kernel.org, mdean@redhat.com, mst@redhat.com,
 yvugenfi@redhat.com, virtualization@lists.linux-foundation.org,
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
Content-Type: multipart/mixed; boundary="===============0469477644018934601=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0469477644018934601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ni02hCJuqGspY2Rv"
Content-Disposition: inline


--Ni02hCJuqGspY2Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:55:45PM +1000, Vadim Rozenfeld wrote:
> Currently we use 4-byte alignmed (FILE_LONG_ALIGNMENT)  in both Windows
> virtio blk and scsi miniport drivers.
> It shouldn't be a problem to change it to 512 by setting AlignmentMask
> field of PORT_CONFIGURATION_INFORMATION structure
> (
> https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/storport/ns-storport-_port_configuration_information
> )
> to FILE_512_BYTE_ALIGNMENT.
> I don't see any problem with changing the alignment parameter in our
> drivers. But it will take us some time to test it properly.

Hi Vadim,
After looking at this again, I confused memory address/size alignment
with request offset/length alignment. The virtio-scsi device does not
have memory alignment constraints, so FILE_LONG_ALIGNMENT is okay and
there's no need to change it.

Thanks,
Stefan

--Ni02hCJuqGspY2Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSwBSUACgkQnKSrs4Gr
c8hDzwf7BD0MqLoDVXPybn61ZH+UR+DjEouwITuk1QJ9k0Soe1PQIVj0EpSfmDa0
PuirvUDI1ASlVs0TnVF3XdUTH0aaVj3XhaKvxyS5dvqnMSa4oKHMQQGu22g4kBmE
ozXT4W4gt5JwNfBUVnSRYILtxSJ6rkCHakEMELueOEiiuYW60PANE+4XlpFBibS0
riMIS6FFvt/9ms8QcCihfPPv8vVmPfwrrO3BSud8gc7q8vl+HOt1BGxC214Bk6Sm
jutOClSQ4BSsdurFkCh/ECDIx1MYsnT5n4Ll/4Bligs6atWzMfu3Vp++4OovBkxr
4rQ//0BbKfl3ENtK+ev5RStnVzb8XA==
=mbCv
-----END PGP SIGNATURE-----

--Ni02hCJuqGspY2Rv--


--===============0469477644018934601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0469477644018934601==--

