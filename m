Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9274EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 05:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 815C761294;
	Thu, 13 Jul 2023 05:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 815C761294
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCQ0heY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XT8K65PaFI18; Thu, 13 Jul 2023 05:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B28B961283;
	Thu, 13 Jul 2023 05:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B28B961283
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27166C0072;
	Thu, 13 Jul 2023 05:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11F0BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D882E41F8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D882E41F8A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCQ0heY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kVOVWeGJEdpm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:56:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 197E241F88
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 197E241F88
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689227759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngbNAZZQiprEAyvFcGE0XT586TsZFa74GGFlMXFae48=;
 b=PCQ0heY3iuj1Tw8Y8yexmIVfrCxMYOYfPXmWQzXlYV1rnfhYZ9aVU5Md3uogzHN6Iq9t0q
 zj6fojuCjIVMuYLadzxGJvQ8NaUgwxA28AmAjEiwPuImE9nh5Jf7lX/3uoQbsHPwmj9zhE
 KvpPJNbqpaTjiuzm8i41ZW9XL8UAyK4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-_17T2vdoPFGs89aiUvE5ug-1; Thu, 13 Jul 2023 01:55:58 -0400
X-MC-Unique: _17T2vdoPFGs89aiUvE5ug-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1b434c31877so574852fac.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 22:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689227757; x=1691819757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngbNAZZQiprEAyvFcGE0XT586TsZFa74GGFlMXFae48=;
 b=VpH1jZNYveCaQ7G+dmU/WHLd0mMkwjwQ3k9Ogmokm3pVWQXkCMJOREirnRTxcXdgtD
 pzcaB6ttiRR67TsgpyJ21T4/FoPccFPkeAjWVgfybgA6MLnZ0h63le8aaiK3mjAq7elY
 sch0udCuOSJS1dviIK++lg5r+2VyM++IXx68tl4Vnqm+C7G+R9WEkvqL3p+hWCepMjNs
 e+KSyMuZ9vX5bL6iqSFUaZIhQgHmzFGcNNb6F5AcB55AP2pNUeDO5vVAnzcKLba+IOp4
 wPBOyNpM862s5P4UISYZhDpUPfLndWu3g4uz9+hzwc2n1f8uFPcQJ6oPynueFJ9Gs5rj
 g0Dg==
X-Gm-Message-State: ABy/qLbD2fp5iOmZ0H3DnvVIdU/eu/raHIEoJykRhGA0GODZhX01J/9s
 PMkUn6tt3UxvLAqujZVwo0bWT/oZeaszbRhCTD5f1BrKgOSVhyjK2XAt+1oOGLUq9Jgtt9JWlcT
 C7Ug1Zh9wo3aBKRCw1lvz1TzqUyYYC8spvICNIeODavisJze3ZVfNhdECIQ==
X-Received: by 2002:a05:6870:4727:b0:1b0:89e4:e260 with SMTP id
 b39-20020a056870472700b001b089e4e260mr1006709oaq.19.1689227757280; 
 Wed, 12 Jul 2023 22:55:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8mdfmf7ZY4BdCvWxe4slTDltUCs8eQ+eV5VlnbjuSSTBZD8OfrLJBcW04z/fl4gwZR1Cs0e5tTbv5oWTTLvA=
X-Received: by 2002:a05:6870:4727:b0:1b0:89e4:e260 with SMTP id
 b39-20020a056870472700b001b089e4e260mr1006697oaq.19.1689227757034; Wed, 12
 Jul 2023 22:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230709202859.138387-1-michael.christie@oracle.com>
 <20230711183438.GA154686@fedora>
 <6b53b833-3c71-2bd9-8fd8-757ecda75c53@oracle.com>
 <20230712142656.GB215287@fedora>
 <41d2d3aa-b537-686a-f2b4-1e0a861cebc8@oracle.com>
In-Reply-To: <41d2d3aa-b537-686a-f2b4-1e0a861cebc8@oracle.com>
From: Vadim Rozenfeld <vrozenfe@redhat.com>
Date: Thu, 13 Jul 2023 15:55:45 +1000
Message-ID: <CAKiOO4taKxW+QEveJA-3ovM04gkx0dBN0M_gEAAR9nb_bA-2uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-scsi@vger.kernel.org, mdean@redhat.com, mst@redhat.com,
 yvugenfi@redhat.com, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: multipart/mixed; boundary="===============8319448980366475323=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8319448980366475323==
Content-Type: multipart/alternative; boundary="000000000000673102060057fc8c"

--000000000000673102060057fc8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently we use 4-byte alignmed (FILE_LONG_ALIGNMENT)  in both Windows
virtio blk and scsi miniport drivers.
It shouldn't be a problem to change it to 512 by setting AlignmentMask
field of PORT_CONFIGURATION_INFORMATION structure
(
https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/storport/ns-=
storport-_port_configuration_information
)
to FILE_512_BYTE_ALIGNMENT.
I don't see any problem with changing the alignment parameter in our
drivers. But it will take us some time to test it properly.

Best regards,
Vadim.

On Thu, Jul 13, 2023 at 2:43=E2=80=AFAM Mike Christie <michael.christie@ora=
cle.com>
wrote:

> On 7/12/23 9:26 AM, Stefan Hajnoczi wrote:
> > On Tue, Jul 11, 2023 at 04:01:22PM -0500, Mike Christie wrote:
> >> On 7/11/23 1:34 PM, Stefan Hajnoczi wrote:
> >>> On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:
> >>>> The following patches were made over Linus's tree and fix an issue
> >>>> where windows guests will send iovecs with offset/lengths that resul=
t
> >>>> in IOs that are not aligned to 512. The LIO layer will then send the=
m
> >>>> to Linux's FS/block layer but it requires 512 byte alignment, so
> >>>> depending on the FS/block driver being used we will get IO errors or
> >>>> hung IO.
> >>>>
> >>>> The following patches have vhost-scsi detect when windows sends thes=
e
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
> >> bounce buffer support to the windows driver, but I think people though=
t
> >> it was going to be uglier than this patch and in the normal alignment
> >> case might also affect performance. There was some windows
> driver/layering
> >> and buffer/cmd details that I don't fully understand and took their wo=
rd
> >> for because I don't know a lot about windows.
> >>
> >> In the end we still have to add checks to vhost-scsi to protect agains=
t
> >> bad drivers, so we thought we might as well just add bounce buffer
> support
> >> to vhost-scsi.
> >
> > CCing virtio-win developers so they can confirm how the vioscsi driver
> > is supposed to handle request alignment.
> >
> > My expectation is that the virtio-scsi device will fail mis-aligned I/O
> > requests.
>
> I don't think you can just change the driver's behavior to fail now,
> because apps send mis-aligned IO and its working as long as they have les=
s
> than 256 bio vecs.
>
> We see mis-aligned IOs during boot and also from random non window's apps=
.
> If we just start to fail then it would be a regression when the app no
> longer works or the OS fails to start up.
>
>

--000000000000673102060057fc8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Currently we use 4-byte al=
ignmed (<span style=3D"color:rgb(22,22,22);font-family:&quot;Segoe UI&quot;=
,SegoeUI,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:14=
px">FILE_LONG_ALIGNMENT</span>)<span style=3D"color:rgb(22,22,22);font-fami=
ly:&quot;Segoe UI&quot;,SegoeUI,&quot;Helvetica Neue&quot;,Helvetica,Arial,=
sans-serif;font-size:14px">=C2=A0</span>=C2=A0in both Windows virtio blk an=
d scsi miniport drivers.</div><div dir=3D"ltr">It shouldn&#39;t be a proble=
m to change it to 512 by setting AlignmentMask field of PORT_CONFIGURATION_=
INFORMATION structure</div><div dir=3D"ltr">( <a href=3D"https://learn.micr=
osoft.com/en-us/windows-hardware/drivers/ddi/storport/ns-storport-_port_con=
figuration_information">https://learn.microsoft.com/en-us/windows-hardware/=
drivers/ddi/storport/ns-storport-_port_configuration_information</a> )</div=
><div dir=3D"ltr">to FILE_512_BYTE_ALIGNMENT.=C2=A0</div><div dir=3D"ltr">I=
 don&#39;t see any problem with changing the alignment parameter in our dri=
vers. But it will take us some time to test it properly.</div><div><br></di=
v><div>Best regards,</div><div>Vadim.</div></div></div></div></div></div></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Jul 13, 2023 at 2:43=E2=80=AFAM Mike Christie &lt;<a href=3D"ma=
ilto:michael.christie@oracle.com">michael.christie@oracle.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/12/23 9:2=
6 AM, Stefan Hajnoczi wrote:<br>
&gt; On Tue, Jul 11, 2023 at 04:01:22PM -0500, Mike Christie wrote:<br>
&gt;&gt; On 7/11/23 1:34 PM, Stefan Hajnoczi wrote:<br>
&gt;&gt;&gt; On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:=
<br>
&gt;&gt;&gt;&gt; The following patches were made over Linus&#39;s tree and =
fix an issue<br>
&gt;&gt;&gt;&gt; where windows guests will send iovecs with offset/lengths =
that result<br>
&gt;&gt;&gt;&gt; in IOs that are not aligned to 512. The LIO layer will the=
n send them<br>
&gt;&gt;&gt;&gt; to Linux&#39;s FS/block layer but it requires 512 byte ali=
gnment, so<br>
&gt;&gt;&gt;&gt; depending on the FS/block driver being used we will get IO=
 errors or<br>
&gt;&gt;&gt;&gt; hung IO.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The following patches have vhost-scsi detect when windows =
sends these<br>
&gt;&gt;&gt;&gt; IOs and copy them to a bounce buffer. It then does some cl=
eanup in<br>
&gt;&gt;&gt;&gt; the related code.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hang on, virtio-scsi is a SCSI HBA and READs/WRITEs submitted =
must<br>
&gt;&gt;&gt; follow the usual constraints on SCSI block limits. Would Windo=
ws send<br>
&gt;&gt;&gt; mis-aligned I/O to a non-virtio-scsi SCSI HBA?<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s like linux where you can config settings like that.<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; Are you sure this is not a bug in the Windows guest driver=
 where block<br>
&gt;&gt;&gt; limits are being misconfigured?<br>
&gt;&gt;<br>
&gt;&gt; From what our windows dev told us the guest drivers like here:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/virtio-win" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/virtio-win</a><br>
&gt;&gt;<br>
&gt;&gt; don&#39;t set the windows AlignmentMask to 512. They tried that an=
d it<br>
&gt;&gt; resulted in windows crash dump crashing because it doesn&#39;t lik=
e the<br>
&gt;&gt; hard alignment requirement.<br>
&gt;&gt;<br>
&gt;&gt; We thought other apps would have trouble as well, so we tried to a=
dd<br>
&gt;&gt; bounce buffer support to the windows driver, but I think people th=
ought<br>
&gt;&gt; it was going to be uglier than this patch and in the normal alignm=
ent<br>
&gt;&gt; case might also affect performance. There was some windows driver/=
layering<br>
&gt;&gt; and buffer/cmd details that I don&#39;t fully understand and took =
their word<br>
&gt;&gt; for because I don&#39;t know a lot about windows.<br>
&gt;&gt;<br>
&gt;&gt; In the end we still have to add checks to vhost-scsi to protect ag=
ainst<br>
&gt;&gt; bad drivers, so we thought we might as well just add bounce buffer=
 support<br>
&gt;&gt; to vhost-scsi.<br>
&gt; <br>
&gt; CCing virtio-win developers so they can confirm how the vioscsi driver=
<br>
&gt; is supposed to handle request alignment.<br>
&gt; <br>
&gt; My expectation is that the virtio-scsi device will fail mis-aligned I/=
O<br>
&gt; requests.<br>
<br>
I don&#39;t think you can just change the driver&#39;s behavior to fail now=
,<br>
because apps send mis-aligned IO and its working as long as they have less<=
br>
than 256 bio vecs.<br>
<br>
We see mis-aligned IOs during boot and also from random non window&#39;s ap=
ps.<br>
If we just start to fail then it would be a regression when the app no<br>
longer works or the OS fails to start up.<br>
<br>
</blockquote></div>

--000000000000673102060057fc8c--


--===============8319448980366475323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8319448980366475323==--

