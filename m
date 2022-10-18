Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125E8C43217
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 07:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0DD482F19;
	Tue, 18 Oct 2022 07:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0DD482F19
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8NL1I14
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NK1scyd7NpJv; Tue, 18 Oct 2022 07:50:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C29A81445;
	Tue, 18 Oct 2022 07:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C29A81445
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC7EC0032;
	Tue, 18 Oct 2022 07:50:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDB5460FD5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:49:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDB5460FD5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8NL1I14
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ar_a76dhuOsW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCC6F60FBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCC6F60FBF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666079395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vRh41W0p6wgS8aUz+pcIKRc5TuBXWZLASuuxasU5Wtc=;
 b=C8NL1I14MddwDfLcgXN+qKb/aHvLfruL063ghwDgN2W1ZZFmFZAYfBawR3655t5pOofZ8B
 WuXElh+7y8wOfhVPQxgk7BagYU4TGuyGytGov3vJdFwWaV50ND7dqFzlMwVYsJq0KrWxZT
 PZ0MBC9zKYUXZk+1NWJuACvIvdBxkSs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-0w49M87KPkSX9KoaA3y8Mw-1; Tue, 18 Oct 2022 03:49:54 -0400
X-MC-Unique: 0w49M87KPkSX9KoaA3y8Mw-1
Received: by mail-oo1-f72.google.com with SMTP id
 e9-20020a4a9b49000000b00475ea4651fcso5721964ook.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vRh41W0p6wgS8aUz+pcIKRc5TuBXWZLASuuxasU5Wtc=;
 b=HrFq3UhQZb/+ly9Vs9BjddeGvoLnZKZ1dH9QFHFqcm9XanA+COz0KvBG0H+9JIu0eA
 eRUHxL9mqhJPqn3ndxvJDkBMuNZhGnpZbvrTxskx2df7g/j/ad8D8kPzAZIDRJs+1OGN
 VusdKM6EDBNAN57TnwcQZU/YcnCzFbSkGeY+7noi+2s06YmOHNN6Pje8XDV9KbnJL9Ts
 Oh0WLzvZKZJOb2qkzDxmU/sqfDV+bmMVsFi45vbRYxcWfqVLDCebXU0rWVbsCEOT0AaR
 6/77ORCc9KUkmVfW7hI3+EN0R2bWpZEHRjmZE54DRLPobENk/lZLBuyoiZpvq1ckN2vB
 9V3A==
X-Gm-Message-State: ACrzQf0tqBCIOpofHGp7b6Y8+DXN/JNYStqpfvXOqIY+foFr1zwBL01W
 5p38YD5GWxsDAXUo7uBKKgACo7ff6dtjOgTGz/BAzu2OvH2CPpNiPJME9xOQZFm10eadoSCiMAR
 wZXfpmNTvzqVEii+Bsuf7WrrvArZr3FECYr40T4I6hsD5juADm/dqjhfQdg==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17168047oad.35.1666079393800; 
 Tue, 18 Oct 2022 00:49:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CZ/POHfxa7P4D4V3Z0ppOI3n6PrdUk6j+3MR9atBP0ebqNqKjdst4QpmFZ6wxXFSRH17zWlPcT0uQFcKmhko=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17168038oad.35.1666079393570; Tue, 18
 Oct 2022 00:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
 <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
 <CACGkMEsCbpCBtABW4qhpZhQ4Dg=tt4ZTiL=_WpUXehcPT+e4qQ@mail.gmail.com>
 <954aa373-11a9-5cad-0ed7-4b97688720ba@intel.com>
 <CACGkMEt=dOwSHB+gJ1wJjwR51wWZgVG561wcWWZqp-Upt5kYGA@mail.gmail.com>
 <91af1513-f3c7-9d25-ed0c-0639c7395f6a@intel.com>
 <CACGkMEtRd3pmN-rYj1LMsckTkNaqHFH7xkdccBK1Z9xzRo9KZw@mail.gmail.com>
 <aca0930e-4599-d3a6-fb5c-74f7223f07a9@intel.com>
In-Reply-To: <aca0930e-4599-d3a6-fb5c-74f7223f07a9@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 15:49:42 +0800
Message-ID: <CACGkMEt=cidT7ioC7jMa8qQjPb9UKHLStB+jZyUks_SWoYhmDw@mail.gmail.com>
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

On Tue, Oct 18, 2022 at 3:46 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 10/18/2022 3:30 PM, Jason Wang wrote:
> > On Tue, Oct 18, 2022 at 3:28 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 10/18/2022 2:44 PM, Jason Wang wrote:
> >>> On Tue, Oct 18, 2022 at 10:20 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>
> >>>> On 10/17/2022 3:13 PM, Jason Wang wrote:
> >>>>> On Mon, Oct 17, 2022 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >>>>>> On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>>>> This commit implements support for reading vdpa device
> >>>>>>> features in iproute2.
> >>>>>>>
> >>>>>>> Example:
> >>>>>>> $ vdpa dev config show vdpa0
> >>>>>>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
> >>>>>>>      negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
> >>>>>>>      dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >>>>>>>
> >>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>>>> Note that Si Wei proposed to unify the two new attributes:
> >>>>> https://patchew.org/linux/1665422823-18364-1-git-send-email-si-wei.liu@oracle.com/
> >>>> I think we have discussed this before, there should be two netlink
> >>>> attributes to report management device features and vDPA device features,
> >>>> they are different type of devices, this unification introduces
> >>>> unnecessary couplings
> >>> I suggest going through the above patch, both attributes are for the
> >>> vDPA device only.
> >> It seems not vDPA device only, from above patch, we see it re-uses
> >> VDPA_ATTR_DEV_FEATURES for reporting vDPA device features
> > Yes, anything wrong with this? The device features could be
> > provisioned via netlink.
> I think the best netlink practice is to let every attr has its own
> and unique purpose, to prevent potential bugs. I think we have discussed
> this before that re-using
> an attr does not save any resource.

They have exactly the same semantic which is the device features for vDPA.

VDPA_ATTR_DEV_FEATURES is introduced by my features provisioning
series, which is used for the userspace to "set" the device features.
VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES is introduced in one of your
previous patches, which is used for userspace to "get" the device
features.

>
> And iprout2 has already updated the uapi header.

Yes, but iproute2 has the same schedule as kernel release, so it's not
too late to fix.

Thanks

>
> Thanks
> >
> > Thanks
> >
> >> Thanks
> >>> Thanks
> >>>
> >>>> Thanks
> >>>>> Thanks
> >>>>>
> >>>>>>> ---
> >>>>>>>     vdpa/vdpa.c | 15 +++++++++++++--
> >>>>>>>     1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> >>>>>>> index b73e40b4..89844e92 100644
> >>>>>>> --- a/vdpa/vdpa.c
> >>>>>>> +++ b/vdpa/vdpa.c
> >>>>>>> @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
> >>>>>>>            [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> >>>>>>>            [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> >>>>>>>            [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>>>> +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> >>>>>>> +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>>>>     };
> >>>>>>>
> >>>>>>>     static int attr_cb(const struct nlattr *attr, void *data)
> >>>>>>> @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
> >>>>>>>
> >>>>>>>     #define NUM_FEATURE_BITS 64
> >>>>>>>
> >>>>>>> -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>>>> +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
> >>>>>>>                               uint16_t dev_id)
> >>>>>>>     {
> >>>>>>>            const char * const *feature_strs = NULL;
> >>>>>>> @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>>>>            if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> >>>>>>>                    feature_strs = dev_to_feature_str[dev_id];
> >>>>>>>
> >>>>>>> -       if (mgmtdevf)
> >>>>>>> +       if (devf)
> >>>>>>>                    pr_out_array_start(vdpa, "dev_features");
> >>>>>>>            else
> >>>>>>>                    pr_out_array_start(vdpa, "negotiated_features");
> >>>>>>> @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>>>>                    val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> >>>>>>>                    print_features(vdpa, val_u64, false, dev_id);
> >>>>>>>            }
> >>>>>>> +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> >>>>>>> +               uint16_t dev_id = 0;
> >>>>>>> +
> >>>>>>> +               if (tb[VDPA_ATTR_DEV_ID])
> >>>>>>> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> >>>>>>> +
> >>>>>>> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> >>>>>>> +               print_features(vdpa, val_u64, true, dev_id);
> >>>>>>> +       }
> >>>>>>>     }
> >>>>>>>
> >>>>>>>     static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>>>> --
> >>>>>>> 2.31.1
> >>>>>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
