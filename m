Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CEC43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC2184CC7;
	Tue,  7 Jun 2022 06:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nEAKYPTNZgY; Tue,  7 Jun 2022 06:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9946280897;
	Tue,  7 Jun 2022 06:15:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F062C0039;
	Tue,  7 Jun 2022 06:15:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646CEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 456D160C0C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmF8OIobp8NP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE21D606DC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654582511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwobWdiv7zoiQQTttGF2XO0A4bzubaGTbiuN7Fw0a3s=;
 b=YAUUBIaDVyjz7lFgHzhwvelrIYeaAM8phyfOzrl40wlxxvO87UPwscUvt4b7ILcc5yatva
 07OdWjBqLt6wxWeP4yg3E3xUQix63t2fta//JUvm3UlxgJhgKZ2BHlmfKpr9MYbmQdr2IX
 kgAXy8UtmvNHMwLOI8E3IpUrF4Qswcs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-JvLTXnKxNWWjqqzdf6QLJw-1; Tue, 07 Jun 2022 02:15:10 -0400
X-MC-Unique: JvLTXnKxNWWjqqzdf6QLJw-1
Received: by mail-lf1-f69.google.com with SMTP id
 q17-20020a0565123a9100b0047889d19f70so8273379lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Jun 2022 23:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IwobWdiv7zoiQQTttGF2XO0A4bzubaGTbiuN7Fw0a3s=;
 b=bAkPqcBodi2jMWRBrvNSf+Lb0jQDTi9S2RhejLFBKLEFRmv5OTK7+kptfCPsNo6V+M
 NUawGwfQ9Y0lJtzRl7DVl4F17Ea8NGVPnB8blFCbTyzxq/j/fDx4cgzIRieC+tidCcBV
 u0khIlEcsvAigFxQY53VijbUhddxRvC5FPdtGNdmxpf5RVn4Ta31PUKlH3t76GTwKPlY
 RU5OKTRy0kNpe/JSiuONBitJZ5ORMD6eEfzfxo3/Ob7GJ/Sf/tUBapIzt7Je76XJJuzt
 RsbvzItj0LCamZQOI6/U5BnQrIZLKJ1P6jBvDhIAVT1RFMRCFhijX7dtrSC44YzkQDS6
 B5Xw==
X-Gm-Message-State: AOAM532+tdhprtoKV/rb84M/mYKv4OfX0C0NNUCTOzhWPkF2r7Dsnfq+
 4heMtUmNNAesGTrIRuJIFK/FKAd4UpH9wwU9BEHOb5HOyIBdaBhk8K7mTaReRE1JFu4hOIJozWn
 L7MjtPF+epVw63FKYpT5KkCpFSmLAoIfLwUel4jwcsQ3UtzpwNTN46jjynQ==
X-Received: by 2002:ac2:4e0f:0:b0:479:54a6:f9bb with SMTP id
 e15-20020ac24e0f000000b0047954a6f9bbmr3745344lfr.257.1654582508792; 
 Mon, 06 Jun 2022 23:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwbCHzOStBHS1kLdIsx0TiIAu+B9gjJ7P5zEhkh8poeSMqphGgkX5Eleo+aghrpoYD9Dn3nIpc/a1Ofv3vqOc=
X-Received: by 2002:ac2:4e0f:0:b0:479:54a6:f9bb with SMTP id
 e15-20020ac24e0f000000b0047954a6f9bbmr3745336lfr.257.1654582508590; Mon, 06
 Jun 2022 23:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-6-lingshan.zhu@intel.com>
 <CACGkMEtCKT5ib_+gUdryDXfxntTr_JF7fZpeePZ+=BFjY_TG+w@mail.gmail.com>
 <f86049b5-1eb1-97e7-654c-d3cde0e62aa7@intel.com>
In-Reply-To: <f86049b5-1eb1-97e7-654c-d3cde0e62aa7@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Jun 2022 14:14:57 +0800
Message-ID: <CACGkMEuXjUMUTNAQUHr=_n1BiQkz0FD5+t52636uTuM36h-0Kw@mail.gmail.com>
Subject: Re: [PATCH 5/6] vDPA: answer num of queue pairs = 1 to userspace when
 VIRTIO_NET_F_MQ == 0
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Mon, Jun 6, 2022 at 4:22 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 6/2/2022 3:38 PM, Jason Wang wrote:
> > On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >> If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair,
> >> so when userspace querying queue pair numbers, it should return mq=1
> >> than zero
> > Spec said:
> >
> > "max_virtqueue_pairs only exists if VIRTIO_NET_F_MQ is set"
> >
> > So we are probably fine.
> I thinks it is asking how many queue
> pairs(VDPA_ATTR_DEV_NET_CFG_MAX_VQP), so answering 0 may not be correct.
>
> Thanks,
> Zhu Lingshan

Please add the result of the userspace vdpa tool before and after this
patch in the changlog in next version.

Thanks

> >
> > Thanks
> >
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 030d96bdeed2..50a11ece603e 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -818,9 +818,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> >>          u16 val_u16;
> >>
> >>          if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> >> -               return 0;
> >> +               val_u16 = 1;
> >> +       else
> >> +               val_u16 = le16_to_cpu((__force __le16)config->max_virtqueue_pairs);
> >>
> >> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> >>          return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
> >>   }
> >>
> >> --
> >> 2.31.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
