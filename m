Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76CC433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 17:48:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06E7617C9
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 17:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06E7617C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 634F883C32;
	Tue, 11 May 2021 17:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCUGvTnMKP2x; Tue, 11 May 2021 17:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12BCF83A81;
	Tue, 11 May 2021 17:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0012C000D;
	Tue, 11 May 2021 17:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7DAC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 17:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A240260674
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 17:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkzO5wQTTsiu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 17:48:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C6E96064C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 17:48:06 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id b25so30977544eju.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tXU/u/oI0c/X+zEdSbjxSjUwDdEq6XptIKJISi7rLG4=;
 b=MW+jnvnJIKnOGEtUwz3fsZFljt3ifuyz+WcJOv9QbqR3U2V0/NEvqymsIPF5umUnPa
 n33vPvd5/pV04hDrPogIfeHSHw3/5t/Tw18SowZjV5KRFhEqo53ycPeWzNXZJK0vrygI
 2vdof3xPopC/8A3cK/cyPI92FtKVLjcJgCgI92yRKI3fSL1MbWf7DXTC5nmlSh7k7bKT
 xKx/RDXI2UpE63LVp7qr+/fbudVqiymDhuwPb2LQOgahSE9OAOqxqh/qSlAecMo9Niyv
 flgWhOIljYicY1kR15yAy7mDnLQkVAaueQyvWsVLdf5nBNIQKWydzX3qygCukvXMZKnR
 i3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tXU/u/oI0c/X+zEdSbjxSjUwDdEq6XptIKJISi7rLG4=;
 b=j2kpmhoB1gJrqoG2R6ylw0sX+33R7nMzfziNWPzuRBdB+BZLhLtp8L/c7bV5DG7jEp
 j34ne2oOD4rWvGxZ1t2XUupwUQF/62/PNmTnWUdbUO0TnTbd4OMOjkbV8dtEL8mG2RR+
 GCihCoDhZ8aEfPF85ukPXMfXJIGSbEKP3O4KLD5ehyGRkVn7wIpYsO8nf+TA7Tr8rXaK
 78P2ZLVSXCyF4brzPRt+fl4VJOxpFS6g47swHpyidUeyRVAExg/uDvtKkoayyGyKNlYk
 rDpghGP+4kh4dm1sWUy1u8E/9qjtIJTrmB7M4hYmI5Q7CtRZ64qg1JEsUcHFTc25fE0M
 DS5w==
X-Gm-Message-State: AOAM532izB1/BoidtqAO1Pv+m1fcNxIQf1PVaja7/v4m5pVhm/OyzShs
 VlOj7yGaAkNuwFC1wt96K8/1r1jtDWI=
X-Google-Smtp-Source: ABdhPJyM1s8XQ9N0atdYr9rep96El+/l6nDWVKGdCXtK/iGP0r/0gs+2i3+VLKt+W5qRYA++fuz3Gw==
X-Received: by 2002:a17:907:2662:: with SMTP id
 ci2mr33286546ejc.459.1620755284327; 
 Tue, 11 May 2021 10:48:04 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id ch30sm15154064edb.92.2021.05.11.10.48.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:48:03 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z17so1921995wrq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:48:03 -0700 (PDT)
X-Received: by 2002:a5d:6285:: with SMTP id k5mr4589508wru.50.1620755283209;
 Tue, 11 May 2021 10:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
In-Reply-To: <20210511044253.469034-3-yuri.benditovich@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 11 May 2021 13:47:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
Message-ID: <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Yan Vugenfirer <yan@daynix.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
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

On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Large UDP packet provided by the guest with GSO type set to
> VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> packets according to the gso_size field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/linux/virtio_net.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f3e554..4ecf9a1ca912 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                         ip_proto = IPPROTO_UDP;
>                         thlen = sizeof(struct udphdr);
>                         break;
> +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> +                       gso_type = SKB_GSO_UDP_L4;
> +                       ip_proto = IPPROTO_UDP;
> +                       thlen = sizeof(struct udphdr);
> +                       break;

If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
having to infer protocol again, as for UDP fragmentation offload (the
retry case below this code).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
