Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55ECC433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 699784194D;
	Thu,  5 May 2022 08:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pH1ALXvrphKO; Thu,  5 May 2022 08:26:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E79941906;
	Thu,  5 May 2022 08:26:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEC4C0032;
	Thu,  5 May 2022 08:26:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 125CD41948
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70ruMng1lcGK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:26:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02FFD41906
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651739197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D4khpquWbWDinwLydzdoBq7iTp7d5c7LdROC1DapmkY=;
 b=F7ANKeZhYTFCn9vuCPs77UnGMV15X8TkF2PTCP9iY+y6FwAMHdVbeT5mNfeJ6Io3QWZDhK
 YAA12uqWFCio7HlVHdfdAIy3FpZEnQQUC72x4x1EDLuxsdNCpE+DI+jFDu6UMx7NyZUqCE
 84jYpU1gKwcBc9SSP3X6z4Q1tHtljiA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-xG_tydY9OjWX53tBTHprQw-1; Thu, 05 May 2022 04:26:36 -0400
X-MC-Unique: xG_tydY9OjWX53tBTHprQw-1
Received: by mail-lj1-f199.google.com with SMTP id
 v11-20020a2e9f4b000000b0024f195a39a0so1155644ljk.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D4khpquWbWDinwLydzdoBq7iTp7d5c7LdROC1DapmkY=;
 b=wWGaKdoyvuitmzFDJ3R81npvwZD7Au/4pB/il+ZTz5gyElxUvO45Qb3Udi8Lvd142B
 MOseW1jYuPI799xaKkAS0Fyux6rvU9sGmcmyNCrxEA8xWCbSkLh59uajDB/T4L0bIuDu
 R8ODhgAQx87DuK6LXo28ac5N0HE+osMV9JVvVzgJIT19HxCCFLJKf892l2CXCJQy50d9
 pgUCl/3KK/5uWgF1q1WUv+AR7yNqMy+hOZIaciaa9X4uuMBV4fpMNgET6q2hfVcgt5e4
 UJfg413JQgPNNpLtFfslpQKAEtbOALEsVCPUpgHEe22aAOvi7XXaDLuq7KXLqXaRFhRm
 CrCg==
X-Gm-Message-State: AOAM530FJr0CPYzQfGzvWYcD8g7hip3IT2N3ZKa6u3FM6pEqHEqRD6Vy
 TxHRAP4L/OiA7yfsGsRrJ7j3RuejBjVjyrTtJHT//issFztu4E5VFJYWPEPPq84rcD7t/46vQAI
 FyTdMrU53pvs0O6D+NyRx0vzVYk100gANoTVuw38ujMZV11FIKCj9NzCZaQ==
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr3555622ljq.315.1651739195210; 
 Thu, 05 May 2022 01:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7HKKTnzyyxPinHgFaLyss8uhrt+DE2y5rFIlDdSpVp6DDy/oL0ZdnSp0p5EW5xDRCrqgMH0ZIGECCwSKK7Qc=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr3555612ljq.315.1651739195003; Thu, 05 May
 2022 01:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
In-Reply-To: <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 May 2022 16:26:24 +0800
Message-ID: <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> The simulator behaves like a ramdisk, so we don't have to do
> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> >> could be useful to test driver behavior.
> >>
> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> >> that we support the flush command.
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> index 42d401d43911..a6dd1233797c 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> @@ -25,6 +25,7 @@
> >>  #define DRV_LICENSE  "GPL v2"
> >>
> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> >>                 pushed += bytes;
> >>                 break;
> >>
> >> +       case VIRTIO_BLK_T_FLUSH:
> >> +               if (sector != 0) {
> >> +                       dev_err(&vdpasim->vdpa.dev,
> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> >> +                               sector);
> >
> >If this is something that could be triggered by userspace/guest, then
> >we should avoid this.
>
> It can only be triggered by an erratic driver.

Right, so guest can try to DOS the host via this.

>
> I was using the simulator to test a virtio-blk driver that I'm writing
> in userspace and I forgot to set `sector` to zero, so I thought it would
> be useful.
>
> Do you mean to remove the error message?

Some like dev_warn_once() might be better here.

Thanks

>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
