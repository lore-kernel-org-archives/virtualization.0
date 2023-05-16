Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73836C77B75
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 07:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E649060BF7;
	Tue, 16 May 2023 07:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E649060BF7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYgvzj4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olYvNAG__09e; Tue, 16 May 2023 07:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1759F60A6D;
	Tue, 16 May 2023 07:49:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1759F60A6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB39C0037;
	Tue, 16 May 2023 07:49:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0CAAC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 07:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B6044018F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 07:49:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B6044018F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYgvzj4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMUlHwFTWmPk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 07:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56A7040136
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56A7040136
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684223354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pf0lkFMV6CireMbpf/WkzaAlfdjWjHE4XsLzhgG8rVY=;
 b=SYgvzj4bgVhHHB4TQP7TurL20lSYByb5pV6QwsxQyxC5DamE/7lehNL+z018rJNoVoHHhn
 5p4aH+cvshnXKtHecDVN7l2jYm7vPZKpMLhMErbcOboe/rOy+ykXELUSqjrT6QBIP5hg63
 IQ1QGNMIy++K1/vgYtNAP++gRvSQXyc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-KiYLtfClPCCCBXUwHnTpOg-1; Tue, 16 May 2023 03:49:12 -0400
X-MC-Unique: KiYLtfClPCCCBXUwHnTpOg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso1302026266b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 00:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684223351; x=1686815351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf0lkFMV6CireMbpf/WkzaAlfdjWjHE4XsLzhgG8rVY=;
 b=iNy5hphFIa9L7U9WLHsEDefj/gtM3ALIj9lyv4F4whV+pvsYhhZfOEmEBTWIob7lMD
 WIC/ue6lNWi/JXvq5jwoN7zIhboKzEphAOh9hSBILAdoBoIuqOnNzd/UDL5dZs5FHjaV
 BJACVybs59xs+tfHhBqdTnjcRj7Bs9E8hdfuor62XJ2V8VY6dxECeT5ewA+8tIAw3Jty
 LYlW417fVKZLvmBfuldA2v6U5bC1/6wrlVSH8bOvF5cKmREm8imw5np+vW+FPre393Ko
 sOyi6l0ZltajPSJh5pX2jxQzZL92yMR39SO3Z5eqdEOWijUldv6di1dClOTa2vI7+AEn
 nL0w==
X-Gm-Message-State: AC+VfDw/Hso5KdeRxOGanbWQDd3t3QIKg6Wgui4qReZI8Vv2o4EnueAr
 ogxgv1CieEFU8uwRYKI5r6jpJsJnr+Lu5rJVHUFtSAR4vIIRcEGqWribaG8ledDgSgL2qtidpfU
 N6iuv9szaYelffP9swHJhdIhR7/SjJYZhKmaDBLtC3A==
X-Received: by 2002:a17:907:94c2:b0:966:3114:c790 with SMTP id
 dn2-20020a17090794c200b009663114c790mr32821062ejc.37.1684223351162; 
 Tue, 16 May 2023 00:49:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vOYEuDowTMRksHPU/uQ8AcSIJRlVDLO21nGpQLtJljxD3+CAPTZZkJ0nqODxp13koPTuHKw==
X-Received: by 2002:a17:907:94c2:b0:966:3114:c790 with SMTP id
 dn2-20020a17090794c200b009663114c790mr32821049ejc.37.1684223350842; 
 Tue, 16 May 2023 00:49:10 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 fe18-20020a1709072a5200b00968242f8c37sm10621274ejc.50.2023.05.16.00.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:49:10 -0700 (PDT)
Date: Tue, 16 May 2023 09:49:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
MIME-Version: 1.0
In-Reply-To: <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io,
 mst@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 15, 2023 at 01:41:12PM -0700, Shannon Nelson wrote:
>On 5/9/23 1:46 AM, Stefano Garzarella wrote:
>>On Mon, Apr 24, 2023 at 03:50:30PM -0700, Shannon Nelson via =

>>Virtualization wrote:
>>>Use the right structs for PACKED or split vqs when setting and
>>>getting the vring base.
>>>
>>>Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>>---
>>>drivers/vhost/vhost.c | 18 +++++++++++++-----
>>>drivers/vhost/vhost.h |=A0 8 ++++++--
>>>2 files changed, 19 insertions(+), 7 deletions(-)
>>>
>>>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>index f11bdbe4c2c5..f64efda48f21 100644
>>>--- a/drivers/vhost/vhost.c
>>>+++ b/drivers/vhost/vhost.c
>>>@@ -1633,17 +1633,25 @@ long vhost_vring_ioctl(struct vhost_dev =

>>>*d, unsigned int ioctl, void __user *arg
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D -E=
FAULT;
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s.num > 0xffff) {
>>>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D -=
EINVAL;
>>>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_has_feature(vq, VIRTI=
O_F_RING_PACKED)) {
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->las=
t_avail_idx =3D s.num & 0xffff;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->las=
t_used_idx =3D (s.num >> 16) & 0xffff;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s.n=
um > 0xffff) {
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 r =3D -EINVAL;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 break;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->las=
t_avail_idx =3D s.num;
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->last_avail_idx =3D s.num;
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Forget the cached index value=
. */
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->avail_idx =3D vq->last_avail=
_idx;
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>=A0=A0=A0=A0=A0 case VHOST_GET_VRING_BASE:
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s.index =3D idx;
>>>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s.num =3D vq->last_avail_idx;
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_has_feature(vq, VIRTI=
O_F_RING_PACKED))
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s.num =
=3D (u32)vq->last_avail_idx | =

>>>((u32)vq->last_used_idx << 16);
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s.num =
=3D vq->last_avail_idx;
>>
>>The changes LGTM, but since we are changing the UAPI, should we
>>update the documentation of VHOST_SET_VRING_BASE and
>>VHOST_GET_VRING_BASE in include/uapi/linux/vhost.h?
>
>Correct me if I'm wrong, but I don't think we're changing anything in =

>the UAPI here, just fixing code to work correctly with what is already =

>happening.

IIUC before this patch VHOST_GET_VRING_BASE and VHOST_SET_VRING_BASE
never worked with packed virtqueue, since we were only handling
last_avail_idx. Now we are supporting packed virtqueue, handling
in vhost_vring_state.num both last_avail_idx and last_used_idx (with
wrap counters).

For example for VHOST_GET_VRING_BASE where is documented that the first
15 bits are last_avail_idx, the 16th the avail_wrap_counter, and the
others are last_used_idx and used_wrap_counter?

Maybe I missed something, but since this is UAPI, IMHO we should
document the parameters of ioctls at least in
include/uapi/linux/vhost.h.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
