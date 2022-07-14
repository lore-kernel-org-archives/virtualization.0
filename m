Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFE9C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 06:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD909404AE;
	Thu, 14 Jul 2022 06:51:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD909404AE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iv+PWzrE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwwEAe8VgbJr; Thu, 14 Jul 2022 06:51:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1ECF0400E7;
	Thu, 14 Jul 2022 06:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1ECF0400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE864C0035;
	Thu, 14 Jul 2022 06:51:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11B2B60B3F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11B2B60B3F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iv+PWzrE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5STHghkAFUVu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A7B360ADE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A7B360ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657781474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbT2JvBc2XqkJKnBxgeNM/Rmvyhm52QxegxVfT/r/zs=;
 b=Iv+PWzrEIeJXPZ8SEAqIO8wcYpLN88pJJw4CiaDxZsYrNvLOKFXasG6rHDW00gOZaZCLAI
 XWxy50KNZHliMVjrS0WN6xMfT75XPa5sB/cxn872wKneWeHcsbsGGq9apxdxyObNzYo5gz
 pZFaHxlpCPRT/PmPtNZOtLHfh1UB2SM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-03ky6IsUPaCAhB3KTfx-nQ-1; Thu, 14 Jul 2022 02:51:13 -0400
X-MC-Unique: 03ky6IsUPaCAhB3KTfx-nQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 t7-20020ac243a7000000b00489e8cb9450so392188lfl.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 23:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HbT2JvBc2XqkJKnBxgeNM/Rmvyhm52QxegxVfT/r/zs=;
 b=ah23AXzCgX2gRNJgQeslp4D2AourT0PQ9Bzwdv9ze/tQn+ocWs3PghfL3ij3akti/Q
 lKhMO4QSPuEnhyv8XpDtNpAe/e221NkxnuLidkXk442E8JGkyI19WuonJaM1Ly/NLe/b
 8wzlTHj1Wroot/Zr12GzhW4L9JFWx0v7ahq0/7ZnTCXRQn4u8/woogLx18hLiMuUJutg
 Ut1zb4bZQLXL8/WbAZzNU96/qEOhcRe8KPySmrNzP+pewl6gcxfUlNkuIgj4/6smR59k
 /dQZDyNKR+eBHNAFtdAWGC64vhi6vIO58W7Wvlm0L5xjDwSz+JXrDv5bdqiZzF3Z+tOD
 KZPg==
X-Gm-Message-State: AJIora89SsVi1eWWlgEytOi1ADsD+gZgWAIE3aApDj7i8uRe3Xc9BDYp
 hPUFlV1E0rDH1NPElkdGzgDvSarh2Uu9JGUBX3If1YD5OPbKuUXnXJiZhHk6VOwP1Mp7SxcfUVm
 NZyRrapZg0Iwk/bHnbrmFXnVT5WYw9zm1215H9b0Gp4ZT/XH7XP1S2pLSSQ==
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id
 x38-20020a2ea9a6000000b0025d601ad3d8mr3681061ljq.141.1657781472165; 
 Wed, 13 Jul 2022 23:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uI/eLMRQBpNcuUML+TJyS/PbgkDhlRg3/cP/cM2G/aS/R9MQtHzAiT4CpQCq4CSLsyduUHxZSeAECkmeRWAsU=
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id
 x38-20020a2ea9a6000000b0025d601ad3d8mr3681050ljq.141.1657781471977; Wed, 13
 Jul 2022 23:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220708030525.5065-1-michael.christie@oracle.com>
 <20220708030525.5065-2-michael.christie@oracle.com>
In-Reply-To: <20220708030525.5065-2-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Jul 2022 14:51:00 +0800
Message-ID: <CACGkMEvrFQeKSc552Pk3fAvPmaGRa+VS05h=gL4DbQ0GL_OxDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-scsi: Fix max number of virtqueues
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: pbonzini <pbonzini@redhat.com>, mst <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jul 8, 2022 at 11:05 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> Qemu takes it's num_queues limit then adds the fixed queues (control and
> event) to the total it will request from the kernel. So when a user
> requests 128 (or qemu does it's num_queues calculation based on vCPUS
> and other system limits), we hit errors due to userspace trying to setup
> 130 queues when vhost-scsi has a hard coded limit of 128.
>
> This has vhost-scsi adjust it's max so we can do a total of 130 virtqueues
> (128 IO and 2 fixed). For the case where the user has 128 vCPUs the guest
> OS can then nicely map each IO virtqueue to a vCPU and not have the odd case
> where 2 vCPUs share a virtqueue.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index ffd9e6c2ffc1..8d6b4eef554d 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -159,7 +159,7 @@ enum {
>  };
>
>  #define VHOST_SCSI_MAX_TARGET  256
> -#define VHOST_SCSI_MAX_VQ      128
> +#define VHOST_SCSI_MAX_VQ      128 + VHOST_SCSI_VQ_IO
>  #define VHOST_SCSI_MAX_EVENT   128
>
>  struct vhost_scsi_virtqueue {
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
