Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF785C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 08:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7782741890;
	Tue, 18 Oct 2022 08:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7782741890
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddfttPs2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djSNRbU5npJF; Tue, 18 Oct 2022 08:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8051241755;
	Tue, 18 Oct 2022 08:01:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8051241755
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45F44C0077;
	Tue, 18 Oct 2022 08:01:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38261C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0600960FDB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0600960FDB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddfttPs2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-b_nCfqg-01
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9195606AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9195606AA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666080057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KBEgunrtLEbVQ10230Rw9kyYRN//dNNJ18k3DgM1dc=;
 b=ddfttPs26flbeVQOdfeLsHoWWum/frOUBYf5yLl7kh6b/0PtSQXJ/zLGU50dfrWVMYSuA3
 7muU4FaPDCb7XcWmF7jWFQEyxMiQdQtKYW61N8D3WIVE3ATJA4YWkFnQ5WEXBK1MH9Rlw1
 xEIsDyM3dmZnYgg2mTlVeHhgtCe2kF8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-sY2PLF2YNamEKxr0R0eW_Q-1; Tue, 18 Oct 2022 04:00:56 -0400
X-MC-Unique: sY2PLF2YNamEKxr0R0eW_Q-1
Received: by mail-oo1-f70.google.com with SMTP id
 u5-20020a4a6145000000b0047f8391678cso5777687ooe.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 01:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7KBEgunrtLEbVQ10230Rw9kyYRN//dNNJ18k3DgM1dc=;
 b=wEa1jNRhxFY07YFz+BkQGWF4mEHKHoL4QLvJLxUMmQnXmV8RD+SNi8TjZLgzi7tMNc
 PsFfTMkzvf9gQlKJiTPTKmlcOd3nW/2/HkiXw7QScYCSNQzEqBDEx6SwVWBuOHEhoU3s
 fUEMMSQAyCysgF5PrKIEMWmqB2LPtg175NAFPy80OozKMZR7Su96DKXjh9195wevCEpP
 8LT8TZQJEGKw4ismR5/9FNJWZHQdiRUXnUXaYe8NXEcRnRWcVpILeLF5jhcKYwx31sMv
 IzVu186HGM8e+gMhRI8RtvDP2Uswe/3eVv0XVyht6cZQ3RpdHCGyfrimTjBTEtj4pP9x
 kC2A==
X-Gm-Message-State: ACrzQf0WzqWN0GCTbIPaVQSQnOGIjQcsg1Mt500ipTxctrQQNbhLwdDE
 2eaorqlCF/oTUoF7cYTgFHO+4yDkkNdY6NvBJH0QDoyXaifv/P4ptFreS4pkoR+NQUVBvrMQooY
 aSGZkudH2jFS3vY+zgAL7iIJD8GOI3uVn2sKvSYNr7w/+uGl85DZLTalvhw==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17184607oad.35.1666080056178; 
 Tue, 18 Oct 2022 01:00:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4M3CLFDuB/InV8uhUoA4IWtjjDlWVRtnXc6cqAzkg6ximaQRtxVe6un1pOoKjTlwmOA/MbraqVO/cpozPaauc=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17184601oad.35.1666080055927; Tue, 18
 Oct 2022 01:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221014094152.5570-1-lingshan.zhu@intel.com>
 <CACGkMEu_pKJukgKuPbTksfemRrfFCb9qbu0iVDKx0O8HL-8q1w@mail.gmail.com>
 <CACGkMEsCbpCBtABW4qhpZhQ4Dg=tt4ZTiL=_WpUXehcPT+e4qQ@mail.gmail.com>
 <954aa373-11a9-5cad-0ed7-4b97688720ba@intel.com>
 <CACGkMEt=dOwSHB+gJ1wJjwR51wWZgVG561wcWWZqp-Upt5kYGA@mail.gmail.com>
 <91af1513-f3c7-9d25-ed0c-0639c7395f6a@intel.com>
 <CACGkMEtRd3pmN-rYj1LMsckTkNaqHFH7xkdccBK1Z9xzRo9KZw@mail.gmail.com>
 <aca0930e-4599-d3a6-fb5c-74f7223f07a9@intel.com>
 <CACGkMEt=cidT7ioC7jMa8qQjPb9UKHLStB+jZyUks_SWoYhmDw@mail.gmail.com>
 <1bc99068-d0bf-21a6-f3c7-31f74e094b92@intel.com>
In-Reply-To: <1bc99068-d0bf-21a6-f3c7-31f74e094b92@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 16:00:44 +0800
Message-ID: <CACGkMEvcR+PBbnaMpy0CKteNy-HD=42cySEXceSA2iefC2YDLg@mail.gmail.com>
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

On Tue, Oct 18, 2022 at 3:55 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 10/18/2022 3:49 PM, Jason Wang wrote:
> > On Tue, Oct 18, 2022 at 3:46 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 10/18/2022 3:30 PM, Jason Wang wrote:
> >>> On Tue, Oct 18, 2022 at 3:28 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>
> >>>> On 10/18/2022 2:44 PM, Jason Wang wrote:
> >>>>> On Tue, Oct 18, 2022 at 10:20 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>>> On 10/17/2022 3:13 PM, Jason Wang wrote:
> >>>>>>> On Mon, Oct 17, 2022 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >>>>>>>> On Fri, Oct 14, 2022 at 5:50 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>>>>>>> This commit implements support for reading vdpa device
> >>>>>>>>> features in iproute2.
> >>>>>>>>>
> >>>>>>>>> Example:
> >>>>>>>>> $ vdpa dev config show vdpa0
> >>>>>>>>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
> >>>>>>>>>       negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
> >>>>>>>>>       dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>>>>>> Note that Si Wei proposed to unify the two new attributes:
> >>>>>>> https://patchew.org/linux/1665422823-18364-1-git-send-email-si-wei.liu@oracle.com/
> >>>>>> I think we have discussed this before, there should be two netlink
> >>>>>> attributes to report management device features and vDPA device features,
> >>>>>> they are different type of devices, this unification introduces
> >>>>>> unnecessary couplings
> >>>>> I suggest going through the above patch, both attributes are for the
> >>>>> vDPA device only.
> >>>> It seems not vDPA device only, from above patch, we see it re-uses
> >>>> VDPA_ATTR_DEV_FEATURES for reporting vDPA device features
> >>> Yes, anything wrong with this? The device features could be
> >>> provisioned via netlink.
> >> I think the best netlink practice is to let every attr has its own
> >> and unique purpose, to prevent potential bugs. I think we have discussed
> >> this before that re-using
> >> an attr does not save any resource.
> > They have exactly the same semantic which is the device features for vDPA.
> >
> > VDPA_ATTR_DEV_FEATURES is introduced by my features provisioning
> > series, which is used for the userspace to "set" the device features.
> > VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES is introduced in one of your
> > previous patches, which is used for userspace to "get" the device
> > features.
> so basically we are just combining and renaming the attr,
> if so, fine with me, get and set may never conflict and in
> totally different netlink contexts.

Yes, I think so.

Thanks

>
> Thanks
> >
> >> And iprout2 has already updated the uapi header.
> > Yes, but iproute2 has the same schedule as kernel release, so it's not
> > too late to fix.
> >
> > Thanks
> >
> >> Thanks
> >>> Thanks
> >>>
> >>>> Thanks
> >>>>> Thanks
> >>>>>
> >>>>>> Thanks
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>      vdpa/vdpa.c | 15 +++++++++++++--
> >>>>>>>>>      1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> >>>>>>>>> index b73e40b4..89844e92 100644
> >>>>>>>>> --- a/vdpa/vdpa.c
> >>>>>>>>> +++ b/vdpa/vdpa.c
> >>>>>>>>> @@ -87,6 +87,8 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
> >>>>>>>>>             [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> >>>>>>>>>             [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> >>>>>>>>>             [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>>>>>> +       [VDPA_ATTR_DEV_FEATURES] = MNL_TYPE_U64,
> >>>>>>>>> +       [VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
> >>>>>>>>>      };
> >>>>>>>>>
> >>>>>>>>>      static int attr_cb(const struct nlattr *attr, void *data)
> >>>>>>>>> @@ -482,7 +484,7 @@ static const char * const *dev_to_feature_str[] = {
> >>>>>>>>>
> >>>>>>>>>      #define NUM_FEATURE_BITS 64
> >>>>>>>>>
> >>>>>>>>> -static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>>>>>> +static void print_features(struct vdpa *vdpa, uint64_t features, bool devf,
> >>>>>>>>>                                uint16_t dev_id)
> >>>>>>>>>      {
> >>>>>>>>>             const char * const *feature_strs = NULL;
> >>>>>>>>> @@ -492,7 +494,7 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> >>>>>>>>>             if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> >>>>>>>>>                     feature_strs = dev_to_feature_str[dev_id];
> >>>>>>>>>
> >>>>>>>>> -       if (mgmtdevf)
> >>>>>>>>> +       if (devf)
> >>>>>>>>>                     pr_out_array_start(vdpa, "dev_features");
> >>>>>>>>>             else
> >>>>>>>>>                     pr_out_array_start(vdpa, "negotiated_features");
> >>>>>>>>> @@ -771,6 +773,15 @@ static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>>>>>>                     val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> >>>>>>>>>                     print_features(vdpa, val_u64, false, dev_id);
> >>>>>>>>>             }
> >>>>>>>>> +       if (tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]) {
> >>>>>>>>> +               uint16_t dev_id = 0;
> >>>>>>>>> +
> >>>>>>>>> +               if (tb[VDPA_ATTR_DEV_ID])
> >>>>>>>>> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> >>>>>>>>> +
> >>>>>>>>> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES]);
> >>>>>>>>> +               print_features(vdpa, val_u64, true, dev_id);
> >>>>>>>>> +       }
> >>>>>>>>>      }
> >>>>>>>>>
> >>>>>>>>>      static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> >>>>>>>>> --
> >>>>>>>>> 2.31.1
> >>>>>>>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
