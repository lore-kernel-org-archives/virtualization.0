Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B4BC43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D385C4174E;
	Tue,  7 Jun 2022 06:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3d2tTchrmt3R; Tue,  7 Jun 2022 06:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 352634177E;
	Tue,  7 Jun 2022 06:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C9FC0039;
	Tue,  7 Jun 2022 06:16:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA157C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8FE6410AB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CtzCmASfDvMt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E54E410AA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654582566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfFt9YB7FAG4KKOd5cKTjk9ERTgqrvpSR7iiUCrN8L4=;
 b=e31n8+tDgGpKfw/0G4mYfc4YOTJyeIDparNVt4o2uwJJb9oM5hhSHRuqi6hznbUrkXTzNn
 UKUb/BwXkxQjptNWWP9G+CnL/OdrpnmIXvai6jMBnCvnbtKffXD5wLKhBTcaMOepk+94NK
 7BiOUFUfCf59wGCTqOBqCR6g65k3Tu4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-oCOloJMBPgav_Kcc-vGVYQ-1; Tue, 07 Jun 2022 02:16:03 -0400
X-MC-Unique: oCOloJMBPgav_Kcc-vGVYQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 bu3-20020a056512168300b0047791fb1d68so8315578lfb.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Jun 2022 23:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mfFt9YB7FAG4KKOd5cKTjk9ERTgqrvpSR7iiUCrN8L4=;
 b=jtcFxLci6tGNH3nwfDGEC372uKryarUhzl1UhI25DHvqoOQY2BDcNbxDuMkpoDIP+M
 QqoVskd9eyhgurPJgQz9yD5NTStrbJeOfFUwm5Qhh3s8hOabntJAmQIa+bKdXEI7aKB/
 lpTIFks8VuwmeTg7Ug8dV/flBk8KF8FpIp1qRyyTn5d5eEJkzkuhmLPlt0EXh7pSURII
 CgKraiPZekM2Y4ckk0FisPNpoxclzJ8v1jHnFkwh+DlZRUrAnBnNEZCR040Zn6Pt449S
 XN6Bo7+8DWA3jzxJyEpFJlXQket1MncidcHNH9ecOEzAyoS4mk+8Q4QdO5Hf9L5SVA6K
 H8Dg==
X-Gm-Message-State: AOAM533C6YFoyhea6f9mVeodbMZf5QQXBLOtMd82EVPcEKIHbS/akU9Z
 QHS76mn4Hs3VJbyuM8xGKCQU7hSdKhhsSMwpnsrR+Sxbh/gjWp2Sld550ZoFD7Krf3fCm0J6mQT
 sK+dNcb91liHGkGxPbxVN+JhkahzTx0PxBhR/39qBrUAWwqhdW0VYWeG+iw==
X-Received: by 2002:a05:6512:3e1d:b0:479:3cfa:f2c4 with SMTP id
 i29-20020a0565123e1d00b004793cfaf2c4mr6986709lfv.98.1654582561644; 
 Mon, 06 Jun 2022 23:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZzTuBn3IIguYCiZKP5oHvXhD16W7D6wTFb71MJ8M2FxxZx+S93j4cdDUj1/zy38Fq4cdFG9Ckb6I3T6j/8GY=
X-Received: by 2002:a05:6512:3e1d:b0:479:3cfa:f2c4 with SMTP id
 i29-20020a0565123e1d00b004793cfaf2c4mr6986701lfv.98.1654582561471; Mon, 06
 Jun 2022 23:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-7-lingshan.zhu@intel.com>
 <CACGkMEtS6W8wXdrXbQuniZ-ox1WsCAc1UQHJGD=J4PViviQYpA@mail.gmail.com>
 <054679a9-16ed-6cf6-ba8d-037aedc29357@intel.com>
In-Reply-To: <054679a9-16ed-6cf6-ba8d-037aedc29357@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Jun 2022 14:15:50 +0800
Message-ID: <CACGkMEvGidNuYJ6Lww7CgAAx8Es7UvoDNfwDB_pJY7b0W3U6cQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa_dev_net_config_fill()
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
> On 6/2/2022 3:40 PM, Jason Wang wrote:
> > On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >> This commit fixes spars warnings: cast to restricted __le16
> >> in function vdpa_dev_net_config_fill()
> >>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 50a11ece603e..2719ce9962fc 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -837,11 +837,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>                      config.mac))
> >>                  return -EMSGSIZE;
> >>
> >> -       val_u16 = le16_to_cpu(config.status);
> >> +       val_u16 = le16_to_cpu((__force __le16)config.status);
> > Can we use virtio accessors like virtio16_to_cpu()?
> I will work out a vdpa16_to_cpu()

I meant __virtio16_to_cpu(true, xxx) actually here.

Thanks

>
> Thanks,
> Zhu Lingshan
> >
> > Thanks
> >
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> >>                  return -EMSGSIZE;
> >>
> >> -       val_u16 = le16_to_cpu(config.mtu);
> >> +       val_u16 = le16_to_cpu((__force __le16)config.mtu);
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>                  return -EMSGSIZE;
> >>
> >> --
> >> 2.31.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
