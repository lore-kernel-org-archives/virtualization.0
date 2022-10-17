Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AE8C433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0D5B409F8;
	Mon, 17 Oct 2022 07:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0D5B409F8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZouhmGXg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BziuJmMjusAm; Mon, 17 Oct 2022 07:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC1C0404B7;
	Mon, 17 Oct 2022 07:13:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC1C0404B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0D70C0033;
	Mon, 17 Oct 2022 07:13:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9285FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13E18801E2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13E18801E2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZouhmGXg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3DOlFOuNPb8c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AA508146D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AA508146D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665990806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fTVp4OVTG6rY4QVgkRM3QvqSda6IStVSl2Tqf98Buk=;
 b=ZouhmGXgHHzzms+PiL4h5Ng87g0+hZSn8AX2X+AZG6A/EVaT00DNRbiTl4m8iasPGCjevJ
 UF+TWTS99mDl+BuoafVI4giNJs1ahhkk6DT17/FkyGUedV68YfkunQhV7hBhHialfX+1WQ
 93RZdPO1xVFFDN5fmgi36zGbYhnDrKQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-MHEvqjQTNy2gbrrygMpXDA-1; Mon, 17 Oct 2022 03:13:24 -0400
X-MC-Unique: MHEvqjQTNy2gbrrygMpXDA-1
Received: by mail-oi1-f200.google.com with SMTP id
 m11-20020aca1e0b000000b00350c1f42f26so3604728oic.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fTVp4OVTG6rY4QVgkRM3QvqSda6IStVSl2Tqf98Buk=;
 b=iBdHbelYmSFqD1Q4XtsGcvYHmlhC8aMHiXmmAOAJhf1b7ZVhfca8KvLzgxUWsIBGYV
 In+6SqCkNB9vcQxojSXifYTp5qj+PqeEQ+NB1c3UPy1y/Cwee6doYpmam6TDXw6MDmxI
 YZeoxF8euTcyPosaubEoYZ4O+5il+N9SlBmINHOVzRj+RMgGhh0Y3zpmu0wMa6yj4yYL
 I57uLjiD6/vGXqMBF4J0ji1NM8yKUTIgsXuP+otGa9BWHol7CoDhx11h0PrMpaxbI5CS
 L9VXffsf2oxOW8lChXn0Fo3Zty23ciHrf/UoEFvL5G0MBtUyZ+KcQ2QtXUp8fnV1l+4Z
 GcMw==
X-Gm-Message-State: ACrzQf3n2MT7UE8BG9dNvav0JLr+fmsgz0uWeu0wR9YlcJUw0rLTCgJt
 OYEpz083PbhXeCR4jrSWL2od3VNh3XYHRsGmJ4ckXpQ9QQwcsCV+uwRDOpZwfcnF87bg6e1plTX
 FUA7uQLeKaH7Pbl8DymjG5OF5pCrTmegTgJuqXiympzUR2t61fnHgnzl78Q==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4361015otn.201.1665990804264; 
 Mon, 17 Oct 2022 00:13:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5w2TQ1qg7Z4fJ33aSGv0yWzwdHUgvvlH9/BUV8fqcqyPkS9/6Fx7DcsIVVM1WRSdFFla4yTMVHdOQ6RYDWT9Y=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4361008otn.201.1665990804072; Mon, 17
 Oct 2022 00:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
In-Reply-To: <20221014094152.5570-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:13:12 +0800
Message-ID: <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
Subject: Re: [PATCH] iproute2/vdpa: Add support for reading device features
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, dsahern@kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 hang.yuan@intel.com
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

On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit implements support for reading vdpa device
> features in iproute2.
>
> Example:
> $ vdpa dev config show vdpa0
> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
>   negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
>   dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Note that Si Wei proposed to unify the two new attributes:


> ---
>  vdpa/vdpa.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index b73e40b4..89844e92 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
>         [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
>         [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
>  };
>
>  static int attr_cb(const struct nlattr *attr, void *data)
> @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
>
>  #define NUM_FEATURE_BITS 64
>
> -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
>                            uint16_t dev_id)
>  {
>         const char * const *feature_strs = NULL;
> @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
>         if (dev_id < ARRAY_SIZE(dev_to_feature_str))
>                 feature_strs = dev_to_feature_str[dev_id];
>
> -       if (mgmtdevf)
> +       if (devf)
>                 pr_out_array_start(vdpa, "dev_features");
>         else
>                 pr_out_array_start(vdpa, "negotiated_features");
> @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
>                 val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
>                 print_features(vdpa, val_u64, false, dev_id);
>         }
> +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> +               uint16_t dev_id = 0;
> +
> +               if (tb[VDPA_ATTR_DEV_ID])
> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> +
> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> +               print_features(vdpa, val_u64, true, dev_id);
> +       }
>  }
>
>  static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
