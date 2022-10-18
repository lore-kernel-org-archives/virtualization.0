Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B603C4332F
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 06:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF148301D;
	Tue, 18 Oct 2022 06:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECF148301D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bM0beFAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23U4kgFUe-FD; Tue, 18 Oct 2022 06:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4886082F20;
	Tue, 18 Oct 2022 06:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4886082F20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19E06C0033;
	Tue, 18 Oct 2022 06:44:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14080C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D51924186B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D51924186B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bM0beFAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZSXzq9pb6tC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 767DB41817
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 767DB41817
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666075487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I20aA+WWYWIOWbVmcckEV2OoluAADGlb7gDJdyOmGv4=;
 b=bM0beFAMe6BPsYsSoenhNhYI2ppnjPGbpCXSqv3EPd3a5q8S7U9XRZyl7HlNLKyk21RM41
 QxV3vwrLqa3ZgCvJnRLcOm5RgjFhog/ZBukZJ5RLQXbuCXORyLhpAeC+sLWPnGbsAcCUVY
 e3MDNmxbgHd6gyj0zPfIR1R7AsQaH7s=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-Ft2_JPKKORSzzHSxrSwDxA-1; Tue, 18 Oct 2022 02:44:45 -0400
X-MC-Unique: Ft2_JPKKORSzzHSxrSwDxA-1
Received: by mail-ot1-f69.google.com with SMTP id
 3-20020a9d0b83000000b00660d7acf0dfso5937483oth.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 23:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I20aA+WWYWIOWbVmcckEV2OoluAADGlb7gDJdyOmGv4=;
 b=HClw1egrUv/vjyDJ12vuIMZoEPFLb9tg4sU8p4znJNzW/h5AqDlLMEMJYBjbA8ifIz
 SfjJFKRIUzoYgxvuEywYrMQ8N6qKZZpDZm2HPSVEZNkhKQ+A/GH1PxeMNVFkr+IJqScR
 JAqFCPYY+m/hhv/IlYjw9i2HTBUva6aondaeaqZgHRtENeAlm4H+xtvL3o0QylMJVs4K
 FZu5lKr3v/rjQciuwUhIWhdNlF7S8G4SqigfI6t4RMqXF/4yeOXkbBZD4Uediu7fn/wp
 OLSw4vlxQhGXe9+kDcEV+vbZ7mvQj6P7RGx8N++M8rRRHBupg2GaRpldKXcDJe7uP1Pb
 SVEA==
X-Gm-Message-State: ACrzQf2KtwwMMmR4GNhu5Q3jFmc+7TYwGJxjq9NoaGmszJtpd4IStfbI
 PHIBeV3mf4e+FBhWlIGkYJVoEpahtxz4UlHEqidV+N2fohN+ilbOFYy0r99wMAEJw+Q9ELM+023
 gSmRs/4Uu/K5AKq3fX+/Ad/su5XoJbHAH57ndfNYaHbpHLFmkpON+5JLT1w==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17065978oad.35.1666075485142; 
 Mon, 17 Oct 2022 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Cddk2B14GoitomYNOIONW9L2vfvfkvMP3xytxXmrJjJ9vLK/u7E0HXBnkRfUKjbFx6dQdGWL0XHyM3dmll+Q=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17065968oad.35.1666075484945; Mon, 17
 Oct 2022 23:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
 <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
 <CACGkMEsCbpCBtABW4qhpZhQ4Dg=tt4ZTiL=_WpUXehcPT+e4qQ@mail.gmail.com>
 <954aa373-11a9-5cad-0ed7-4b97688720ba@intel.com>
In-Reply-To: <954aa373-11a9-5cad-0ed7-4b97688720ba@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 14:44:33 +0800
Message-ID: <CACGkMEt=dOwSHB+gJ1wJjwR51wWZgVG561wcWWZqp-Upt5kYGA@mail.gmail.com>
Subject: Re: [PATCH] iproute2/vdpa: Add support for reading device features
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
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

On Tue, Oct 18, 2022 at 10:20 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 10/17/2022 3:13 PM, Jason Wang wrote:
> > On Mon, Oct 17, 2022 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >> On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>> This commit implements support for reading vdpa device
> >>> features in iproute2.
> >>>
> >>> Example:
> >>> $ vdpa dev config show vdpa0
> >>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
> >>>    negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
> >>>    dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >>>
> >>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> Note that Si Wei proposed to unify the two new attributes:
> > https://patchew.org/linux/1665422823-18364-1-git-send-email-si-wei.liu@oracle.com/
> I think we have discussed this before, there should be two netlink
> attributes to report management device features and vDPA device features,
> they are different type of devices, this unification introduces
> unnecessary couplings

I suggest going through the above patch, both attributes are for the
vDPA device only.

Thanks

>
> Thanks
> >
> > Thanks
> >
> >>
> >>> ---
> >>>   vdpa/vdpa.c | 15 +++++++++++++--
> >>>   1 file changed, 13 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> >>> index b73e40b4..89844e92 100644
> >>> --- a/vdpa/vdpa.c
> >>> +++ b/vdpa/vdpa.c
> >>> @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
> >>>          [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> >>>          [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> >>>          [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>> +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> >>> +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>   };
> >>>
> >>>   static int attr_cb(const struct nlattr *attr, void *data)
> >>> @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
> >>>
> >>>   #define NUM_FEATURE_BITS 64
> >>>
> >>> -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>> +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
> >>>                             uint16_t dev_id)
> >>>   {
> >>>          const char * const *feature_strs = NULL;
> >>> @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>          if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> >>>                  feature_strs = dev_to_feature_str[dev_id];
> >>>
> >>> -       if (mgmtdevf)
> >>> +       if (devf)
> >>>                  pr_out_array_start(vdpa, "dev_features");
> >>>          else
> >>>                  pr_out_array_start(vdpa, "negotiated_features");
> >>> @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>                  val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> >>>                  print_features(vdpa, val_u64, false, dev_id);
> >>>          }
> >>> +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> >>> +               uint16_t dev_id = 0;
> >>> +
> >>> +               if (tb[VDPA_ATTR_DEV_ID])
> >>> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> >>> +
> >>> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> >>> +               print_features(vdpa, val_u64, true, dev_id);
> >>> +       }
> >>>   }
> >>>
> >>>   static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> >>> --
> >>> 2.31.1
> >>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
