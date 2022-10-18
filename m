Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DB2C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 07:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F0F040A5F;
	Tue, 18 Oct 2022 07:31:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F0F040A5F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYBMefUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PV7Dn5YlBDFv; Tue, 18 Oct 2022 07:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDA90402C3;
	Tue, 18 Oct 2022 07:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDA90402C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD86C0032;
	Tue, 18 Oct 2022 07:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 888D2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C9F240A5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C9F240A5F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o6OYWpsR_F6n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:31:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3556402C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3556402C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666078271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0hYgzZQfmuju2kGtMBSk9OubWiE0Vwud4ecELa6A/0=;
 b=SYBMefUEVeYe80qKeF9N0VuLtUf/IgzrhcLbEc4BtXTDgEAS6IKFCRlC0K0PcYQM5gqafU
 4LZ3C3u8GqnjFLxdKxYJgQXQALLqCd686uFyU0q/jhYE6bazEYnTStC+XuMpfxx4qvWCIh
 NWCYJCdF0D68IJmZ6IQ2bqIZ5/sxDQQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-MreHDE5rP2qFp8h-KCYVyA-1; Tue, 18 Oct 2022 03:31:10 -0400
X-MC-Unique: MreHDE5rP2qFp8h-KCYVyA-1
Received: by mail-oi1-f198.google.com with SMTP id
 n82-20020aca5955000000b003550eb96719so4749618oib.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L0hYgzZQfmuju2kGtMBSk9OubWiE0Vwud4ecELa6A/0=;
 b=Urdzxf89p3Ql8d7c43BaeEHuD7Dw8/S9HYMdfgDdAQBlxa6ClO4Pqk7gvufk9mIb/F
 OhFBSGYtn61Pp0xgeFMEFvfdf/9o4EbtKfNlVqEbxVkGXwoKvEl/B3Ia/xjRXRHDu+HE
 6zU7fgjWvROIAsOXDGfr0s9gUPkkTqNiZG8he3vQsYh1iax4jflPhw3nxdz3hvHintYd
 N1LTzvX/x8mp/nY7c4dohBVohuEGPTtIxlGXt12DiFPnvWzVJvcX/7wotYngEVzTN8yH
 RrS0/cAHb8W2GdhWvFUIVw1ySNyqP5tW0068ofBsVRNGqInwPZWwZROPT3iBasGdp/WS
 hAWQ==
X-Gm-Message-State: ACrzQf3XOfwE1I0da03yRDziKhwAH11a+p5ockwpyZMd/aNjm+x3tEpy
 RRR7EfQSQrPweW0vUq8cYw0T3giB5WbSvpLqzsjiaERDsayCsxOmf+rg711kfUnrISopMPBog8B
 hpkkzGVSHjsQzRu0bMOma1cov+Qq17Bbh4CM5OfVJ6rs0MO/Gy6OyiVdyZA==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr14818691oiw.35.1666078269474; 
 Tue, 18 Oct 2022 00:31:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ciFPqKz1ku83wKlQ/Yd58xyeEBG3ION3kprFyss3YBuU/Y1DG4Ght/DGQ4gXpl+1qOG+1AMssh6eTnXWd6vs=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr14818681oiw.35.1666078269273; Tue, 18
 Oct 2022 00:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
 <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
 <CACGkMEsCbpCBtABW4qhpZhQ4Dg=tt4ZTiL=_WpUXehcPT+e4qQ@mail.gmail.com>
 <954aa373-11a9-5cad-0ed7-4b97688720ba@intel.com>
 <CACGkMEt=dOwSHB+gJ1wJjwR51wWZgVG561wcWWZqp-Upt5kYGA@mail.gmail.com>
 <91af1513-f3c7-9d25-ed0c-0639c7395f6a@intel.com>
In-Reply-To: <91af1513-f3c7-9d25-ed0c-0639c7395f6a@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 15:30:57 +0800
Message-ID: <CACGkMEtRd3pmN-rYj1LMsckTkNaqHFH7xkdccBK1Z9xzRo9KZw@mail.gmail.com>
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

On Tue, Oct 18, 2022 at 3:28 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 10/18/2022 2:44 PM, Jason Wang wrote:
> > On Tue, Oct 18, 2022 at 10:20 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 10/17/2022 3:13 PM, Jason Wang wrote:
> >>> On Mon, Oct 17, 2022 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >>>> On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>> This commit implements support for reading vdpa device
> >>>>> features in iproute2.
> >>>>>
> >>>>> Example:
> >>>>> $ vdpa dev config show vdpa0
> >>>>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
> >>>>>     negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
> >>>>>     dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >>>>>
> >>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>> Note that Si Wei proposed to unify the two new attributes:
> >>> https://patchew.org/linux/1665422823-18364-1-git-send-email-si-wei.liu@oracle.com/
> >> I think we have discussed this before, there should be two netlink
> >> attributes to report management device features and vDPA device features,
> >> they are different type of devices, this unification introduces
> >> unnecessary couplings
> > I suggest going through the above patch, both attributes are for the
> > vDPA device only.
> It seems not vDPA device only, from above patch, we see it re-uses
> VDPA_ATTR_DEV_FEATURES for reporting vDPA device features

Yes, anything wrong with this? The device features could be
provisioned via netlink.

Thanks

>
> Thanks
> >
> > Thanks
> >
> >> Thanks
> >>> Thanks
> >>>
> >>>>> ---
> >>>>>    vdpa/vdpa.c | 15 +++++++++++++--
> >>>>>    1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> >>>>> index b73e40b4..89844e92 100644
> >>>>> --- a/vdpa/vdpa.c
> >>>>> +++ b/vdpa/vdpa.c
> >>>>> @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
> >>>>>           [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> >>>>>           [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> >>>>>           [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>> +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> >>>>> +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>>    };
> >>>>>
> >>>>>    static int attr_cb(const struct nlattr *attr, void *data)
> >>>>> @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
> >>>>>
> >>>>>    #define NUM_FEATURE_BITS 64
> >>>>>
> >>>>> -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>> +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
> >>>>>                              uint16_t dev_id)
> >>>>>    {
> >>>>>           const char * const *feature_strs = NULL;
> >>>>> @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>>           if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> >>>>>                   feature_strs = dev_to_feature_str[dev_id];
> >>>>>
> >>>>> -       if (mgmtdevf)
> >>>>> +       if (devf)
> >>>>>                   pr_out_array_start(vdpa, "dev_features");
> >>>>>           else
> >>>>>                   pr_out_array_start(vdpa, "negotiated_features");
> >>>>> @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>>                   val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> >>>>>                   print_features(vdpa, val_u64, false, dev_id);
> >>>>>           }
> >>>>> +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> >>>>> +               uint16_t dev_id = 0;
> >>>>> +
> >>>>> +               if (tb[VDPA_ATTR_DEV_ID])
> >>>>> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> >>>>> +
> >>>>> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> >>>>> +               print_features(vdpa, val_u64, true, dev_id);
> >>>>> +       }
> >>>>>    }
> >>>>>
> >>>>>    static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>> --
> >>>>> 2.31.1
> >>>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
