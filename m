Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22999C4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AED6B6066D;
	Mon, 17 Oct 2022 07:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AED6B6066D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtchUHvU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VOKsJEzG6WCQ; Mon, 17 Oct 2022 07:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F32B605BA;
	Mon, 17 Oct 2022 07:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F32B605BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09330C0033;
	Mon, 17 Oct 2022 07:13:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E30A3416DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E30A3416DD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtchUHvU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AiQslkKb0MjE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 923A6416DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 923A6416DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665990826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9elsTyKwP2RgI1TXQIsN6pFsi2ab4o+Pn6NCbA8rb7A=;
 b=gtchUHvUy3w5beFP/oQDioxPQ3qXB3DiMzOq7KyPsZS8+kSfJ8vs70hDT7as+96OImPh8G
 +UrMO0tNKjF4pELsJK8/qjiThNLpit9phReMRa96UKolbQEs6H9+CZITJGf/7h6Wse53N2
 CeahR2uY+sBBNJqOmagWOnp3yOmu/Gw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-qWyRkp8OMAiD1HPCDV7HLA-1; Mon, 17 Oct 2022 03:13:45 -0400
X-MC-Unique: qWyRkp8OMAiD1HPCDV7HLA-1
Received: by mail-oo1-f70.google.com with SMTP id
 x26-20020a4aea1a000000b00480a4135181so4063809ood.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9elsTyKwP2RgI1TXQIsN6pFsi2ab4o+Pn6NCbA8rb7A=;
 b=Ujt44VdXbYbLtWWwLmpQU4Otqg0OJSmv1RtB/pVUuB+HfWaVhFZNXaXtAx6hPoSFtX
 IKKmTEfcv4x3U30c4ZyzojwJEFKGoa0cCVNatasEUn9R+t/cRCOQdKyAZSajXlkapn+E
 k9B+72lVTVy3+GzQ0Wa3vyOCLldZP6jB5t1rzmtT8ItLtRgmz5AJdEzlHZex9fJs1Tbo
 K09DXRG8qeMCHwVeNhjV4xRHi+Iq4NgsH2jDvcqCmXct8ARK86amr1jlAwidQsS3l54A
 QpbIaM9w9XjJbm7Xqr5MaFGeRE5YpJBXF5e+DM8RnFiZqbRgMCxNAe1UHP/j+p+kx2ev
 VrMA==
X-Gm-Message-State: ACrzQf3fzGPesKeca8DDTQftWXPrktTnCvmZKg7BwEsxpR3xFZ3OCLW4
 ndPOmGQw8gYuhlUXJiu0E6+qCxega4HJ8E2vz1rPFLT0TlqwjbgChTc1t+cQWtrQEVr16YJYdq5
 w0Hpiy26I0Gv1UFemMX6kA1EsP4ygJYdY/LTrZWWti6Z6XXFkatRXUPRh3g==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr12274491oiw.35.1665990824605; 
 Mon, 17 Oct 2022 00:13:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM60hrzvtei5NX1fBq/Q7EKckUGENj2+K9sAAsE2eiHNSIL6NO8XivmV3Yu0VxbFkzqlO4sJmTjNfyTsppEQKaM=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr12274482oiw.35.1665990824429; Mon, 17
 Oct 2022 00:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
 <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
In-Reply-To: <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:13:33 +0800
Message-ID: <CACGkMEsCbpCBtABW4qhpZhQ4Dg=tt4ZTiL=_WpUXehcPT+e4qQ@mail.gmail.com>
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

On Mon, Oct 17, 2022 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >
> > This commit implements support for reading vdpa device
> > features in iproute2.
> >
> > Example:
> > $ vdpa dev config show vdpa0
> > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
> >   negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
> >   dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>
> Note that Si Wei proposed to unify the two new attributes:

https://patchew.org/linux/1665422823-18364-1-git-send-email-si-wei.liu@oracle.com/

Thanks

>
>
> > ---
> >  vdpa/vdpa.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> > index b73e40b4..89844e92 100644
> > --- a/vdpa/vdpa.c
> > +++ b/vdpa/vdpa.c
> > @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
> >         [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> >         [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> >         [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> > +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> > +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >  };
> >
> >  static int attr_cb(const struct nlattr *attr, void *data)
> > @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
> >
> >  #define NUM_FEATURE_BITS 64
> >
> > -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> > +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
> >                            uint16_t dev_id)
> >  {
> >         const char * const *feature_strs = NULL;
> > @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >         if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> >                 feature_strs = dev_to_feature_str[dev_id];
> >
> > -       if (mgmtdevf)
> > +       if (devf)
> >                 pr_out_array_start(vdpa, "dev_features");
> >         else
> >                 pr_out_array_start(vdpa, "negotiated_features");
> > @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
> >                 val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> >                 print_features(vdpa, val_u64, false, dev_id);
> >         }
> > +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> > +               uint16_t dev_id = 0;
> > +
> > +               if (tb[VDPA_ATTR_DEV_ID])
> > +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> > +
> > +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> > +               print_features(vdpa, val_u64, true, dev_id);
> > +       }
> >  }
> >
> >  static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> > --
> > 2.31.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
