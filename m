Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7CCC001DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 922FD41FFE;
	Thu, 13 Jul 2023 14:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 922FD41FFE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcVRbbOQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hRwYKNG66RMB; Thu, 13 Jul 2023 14:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94B8F41F4B;
	Thu, 13 Jul 2023 14:04:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94B8F41F4B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5ACC0071;
	Thu, 13 Jul 2023 14:04:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA29C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C00206139B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C00206139B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcVRbbOQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8QmsbB8UL1oC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C93D61398
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C93D61398
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689257088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kejpQ7yR2S84tXVx9SoQ/put9HkEfzWndejAhecD6PM=;
 b=KcVRbbOQBxoRos4vqWybg5IessSFWFETPsd8g/YsKypoh76E/g3nTgOnkVWy4CHBdCEFwT
 NNW384HeLNzMvTs35VF/yE/Ufqg4pIiS8ac7NHA5nazGzti0VvYqFpX+PJmS5L4g/rHSHW
 y/9yUIgyAfL2SdKB8iaM4EojLXRJOKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-Of-EHkPkNyemV-2SOmd0NA-1; Thu, 13 Jul 2023 10:04:08 -0400
X-MC-Unique: Of-EHkPkNyemV-2SOmd0NA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A59610504BB;
 Thu, 13 Jul 2023 14:03:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAD4B1454142;
 Thu, 13 Jul 2023 14:03:44 +0000 (UTC)
Date: Thu, 13 Jul 2023 10:03:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230713140342.GA310002@fedora>
References: <20230709202859.138387-1-michael.christie@oracle.com>
 <20230711183438.GA154686@fedora>
 <6b53b833-3c71-2bd9-8fd8-757ecda75c53@oracle.com>
 <20230712142656.GB215287@fedora>
 <41d2d3aa-b537-686a-f2b4-1e0a861cebc8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <41d2d3aa-b537-686a-f2b4-1e0a861cebc8@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
Content-Type: multipart/mixed; boundary="===============5103131378590172743=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5103131378590172743==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PBejcH5agZqVo5Jy"
Content-Disposition: inline


--PBejcH5agZqVo5Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 11:05:11AM -0500, Mike Christie wrote:
> On 7/12/23 9:26 AM, Stefan Hajnoczi wrote:
> > On Tue, Jul 11, 2023 at 04:01:22PM -0500, Mike Christie wrote:
> >> On 7/11/23 1:34 PM, Stefan Hajnoczi wrote:
> >>> On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:
> >>>> The following patches were made over Linus's tree and fix an issue
> >>>> where windows guests will send iovecs with offset/lengths that result
> >>>> in IOs that are not aligned to 512. The LIO layer will then send them
> >>>> to Linux's FS/block layer but it requires 512 byte alignment, so
> >>>> depending on the FS/block driver being used we will get IO errors or
> >>>> hung IO.
> >>>>
> >>>> The following patches have vhost-scsi detect when windows sends these
> >>>> IOs and copy them to a bounce buffer. It then does some cleanup in
> >>>> the related code.
> >>>
> >>> Hang on, virtio-scsi is a SCSI HBA and READs/WRITEs submitted must
> >>> follow the usual constraints on SCSI block limits. Would Windows send
> >>> mis-aligned I/O to a non-virtio-scsi SCSI HBA?
> >>
> >> It's like linux where you can config settings like that.
> >>
> >>>> Are you sure this is not a bug in the Windows guest driver where blo=
ck
> >>> limits are being misconfigured?
> >>
> >> From what our windows dev told us the guest drivers like here:
> >>
> >> https://github.com/virtio-win
> >>
> >> don't set the windows AlignmentMask to 512. They tried that and it
> >> resulted in windows crash dump crashing because it doesn't like the
> >> hard alignment requirement.
> >>
> >> We thought other apps would have trouble as well, so we tried to add
> >> bounce buffer support to the windows driver, but I think people thought
> >> it was going to be uglier than this patch and in the normal alignment
> >> case might also affect performance. There was some windows driver/laye=
ring
> >> and buffer/cmd details that I don't fully understand and took their wo=
rd
> >> for because I don't know a lot about windows.
> >>
> >> In the end we still have to add checks to vhost-scsi to protect against
> >> bad drivers, so we thought we might as well just add bounce buffer sup=
port
> >> to vhost-scsi.
> >=20
> > CCing virtio-win developers so they can confirm how the vioscsi driver
> > is supposed to handle request alignment.
> >=20
> > My expectation is that the virtio-scsi device will fail mis-aligned I/O
> > requests.
>=20
> I don't think you can just change the driver's behavior to fail now,
> because apps send mis-aligned IO and its working as long as they have less
> than 256 bio vecs.
>=20
> We see mis-aligned IOs during boot and also from random non window's apps.
> If we just start to fail then it would be a regression when the app no
> longer works or the OS fails to start up.

I was wrong:

The virtio-scsi specification contains no alignment requirements for I/O
buffers. It is fine for the driver to submit iovecs with any memory
alignment.

The QEMU code allocates a bounce buffer if the iovecs submitted by the
driver do not match the minimum alignment requirements on the host (e.g.
O_DIRECT requirements).

It makes sense that vhost_scsi needs to use a bounce buffer in cases
where the underlying storage has stricter memory alignment requirements.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--PBejcH5agZqVo5Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSwBD4ACgkQnKSrs4Gr
c8jZZQgAiXLRmCgucPEGc4bLM1Ch0HqdkBRqe6ST0FN95ffDCONwWSWLTfXfsJOy
mvcn+aLKShsLgW+3Q/Iq7AyEAImiO7OWWTi1ZgltSSC5Gvxn6EPHLgXP0Lwmpwdh
2vcrAXIQ48HbLAg/eE+4K6ORsH3+/cE1pI/5H4p64LH4Feca/KwHfW8d8KE24taZ
A+bFSY8DcHGk8W6J25Fjx2gMYFXFMYZ5n5u3hVbse4syBwgRcJYM7Yq+Thmvvkoh
tivsDiHLCccKrEZGudP/vlaLUdW35SLegSWjQWJuF6jYroAZEl/L7uU7Es02U72o
tQ0MCYSZt8DMr6g4/EPmx02ZoJ/8ug==
=P4dJ
-----END PGP SIGNATURE-----

--PBejcH5agZqVo5Jy--


--===============5103131378590172743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5103131378590172743==--

