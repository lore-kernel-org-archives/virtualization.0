Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D506EC32771
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 07:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C64581252;
	Wed, 21 Sep 2022 07:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C64581252
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L41odCb2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pusaMOOLTj9r; Wed, 21 Sep 2022 07:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EAB280DCF;
	Wed, 21 Sep 2022 07:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EAB280DCF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68D5BC0032;
	Wed, 21 Sep 2022 07:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3A8AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BF7C4093E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BF7C4093E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L41odCb2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xN9EdupU2vc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52CCA40906
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52CCA40906
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663746296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ubLtsAgcpDm3nvMpf+F5CRd6Xb0P+Wgpu8FfKvJ+Z0=;
 b=L41odCb2o2XgCzZCpWpW+5JRtJLH9Dh7DhO1tlhhAQsziyYtGZMnKKuslKQ7MFzsdfIc9Z
 YIqdRmIGJepEDeQHxr4g0NLANjoKao790ytyz3IK5OxoAm/ggFZ8M+MSMU7aqRKgD3Rtn7
 CSVkgsf/uqUFdljre2+2UGH9JIBU/Ac=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-hEMqQBnxOUSCO_ZyyyLU1A-1; Wed, 21 Sep 2022 03:44:55 -0400
X-MC-Unique: hEMqQBnxOUSCO_ZyyyLU1A-1
Received: by mail-ot1-f71.google.com with SMTP id
 z26-20020a05683020da00b00655d8590ed3so2614444otq.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=9ubLtsAgcpDm3nvMpf+F5CRd6Xb0P+Wgpu8FfKvJ+Z0=;
 b=uXwKxv/7q3IcREw1lAM0JEX0N+HFvEgTD4vQsBpK+wlOAVXrjaVE2PfeNX19pm8xeQ
 ESrQAsdBPOlQmW8IPnmhMR9AtyMkbkwx2GXuqW35MwQlO/6kRi3R4YlvJjybBkB608lm
 bRDo4lfSL38K/okxTkdKJKMTwEbJ+DJjHZDUQVgfGLterg+sr+8VlHRL4DgOh1AAoh1F
 i6qf4NDlIifBlUtnVPsPKKOBdEQqTadr4mbU1KjCpxH+PFNV7qmzSmfJrry+kiOuc5cV
 LG1CdF51wI/e9/CmcpTTSTYBZCQI5WyunxVFHUbpN1iUC5Z0sQGHfkzVrTfxCZJGEd56
 Lpnw==
X-Gm-Message-State: ACrzQf2pM6mlPZHaqQOpv1Iu97uziRuN0qUJoa6vwpiB/mUNnYjrhM8G
 qL9RDgd+H5EcmoHvAFkmYg0z1eUc7prDL7XxI60Yl3/TUuAX/0Nbnc/4wwiQHFSFICRrtRMMRC5
 wijL/FaU+AulkU3F7S8xaMbcf6QPnkxq06aMnWF5ZQmDS4rDIUTa46K0RNQ==
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr4112345oan.35.1663746294187; 
 Wed, 21 Sep 2022 00:44:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wkv3SUBRdXvKVaNbuIgmOgYkeMBTnxhWlJtmZOEou/q4L0gaF2SAW7Z0YIVrq9HwXTbuOFZXv4kvlgStXvGI=
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr4112337oan.35.1663746293933; Wed, 21
 Sep 2022 00:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-2-lingshan.zhu@intel.com>
 <CACGkMEsq+weeO7i8KtNNAPhXGwN=cTwWt3RWfTtML-Xwj3K5Qg@mail.gmail.com>
 <e69b65e7-516f-55bd-cb99-863d7accbd32@intel.com>
 <CACGkMEv0++vmfzzmX47NhsaY5JTvbO2Ro7Taf8C0dxV6OVXTKw@mail.gmail.com>
 <27b04293-2225-c78d-f6e3-ffe8a7472ea1@intel.com>
In-Reply-To: <27b04293-2225-c78d-f6e3-ffe8a7472ea1@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Sep 2022 15:44:42 +0800
Message-ID: <CACGkMEvf0sQyFTowg9DtVS3QbAHidv_cOBCk5hUaaKNxwods8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] vDPA: allow userspace to query features of a vDPA
 device
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Wed, Sep 21, 2022 at 2:00 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 9/21/2022 10:17 AM, Jason Wang wrote:
> > On Tue, Sep 20, 2022 at 5:58 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 9/20/2022 10:02 AM, Jason Wang wrote:
> >>> On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>> This commit adds a new vDPA netlink attribution
> >>>> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> >>>> features of vDPA devices through this new attr.
> >>>>
> >>>> This commit invokes vdpa_config_ops.get_config() than
> >>>> vdpa_get_config_unlocked() to read the device config
> >>>> spcae, so no raeces in vdpa_set_features_unlocked()
> >>>>
> >>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> It's better to share the userspace code as well.
> >> OK, will share it in V2.
> >>>> ---
> >>>>    drivers/vdpa/vdpa.c       | 19 ++++++++++++++-----
> >>>>    include/uapi/linux/vdpa.h |  4 ++++
> >>>>    2 files changed, 18 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>>> index c06c02704461..798a02c7aa94 100644
> >>>> --- a/drivers/vdpa/vdpa.c
> >>>> +++ b/drivers/vdpa/vdpa.c
> >>>> @@ -491,6 +491,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> >>>>                   err = -EMSGSIZE;
> >>>>                   goto msg_err;
> >>>>           }
> >>>> +
> >>>> +       /* report features of a vDPA management device through VDPA_ATTR_DEV_SUPPORTED_FEATURES */
> >>> The code explains itself, there's no need for the comment.
> >> these comments are required in other discussions
> > I think it's more than sufficient to clarify the semantic where it is defined.
> OK, then only comments in the header file
> >
> >>>>           if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
> >>>>                                 mdev->supported_features, VDPA_ATTR_PAD)) {
> >>>>                   err = -EMSGSIZE;
> >>>> @@ -815,10 +817,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> >>>>    static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
> >>>>    {
> >>>>           struct virtio_net_config config = {};
> >>>> -       u64 features;
> >>>> +       u64 features_device, features_driver;
> >>>>           u16 val_u16;
> >>>>
> >>>> -       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> >>>> +       vdev->config->get_config(vdev, 0, &config, sizeof(config));
> >>>>
> >>>>           if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
> >>>>                       config.mac))
> >>>> @@ -832,12 +834,19 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>>>                   return -EMSGSIZE;
> >>>>
> >>>> -       features = vdev->config->get_driver_features(vdev);
> >>>> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> >>>> +       features_driver = vdev->config->get_driver_features(vdev);
> >>>> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >>>> +                             VDPA_ATTR_PAD))
> >>>> +               return -EMSGSIZE;
> >>>> +
> >>>> +       features_device = vdev->config->get_device_features(vdev);
> >>>> +
> >>>> +       /* report features of a vDPA device through VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES */
> >>>> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
> >>>>                                 VDPA_ATTR_PAD))
> >>>>                   return -EMSGSIZE;
> >>>>
> >>>> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> >>>> +       return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
> >>>>    }
> >>>>
> >>>>    static int
> >>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> >>>> index 25c55cab3d7c..97531b52dcbe 100644
> >>>> --- a/include/uapi/linux/vdpa.h
> >>>> +++ b/include/uapi/linux/vdpa.h
> >>>> @@ -46,12 +46,16 @@ enum vdpa_attr {
> >>>>
> >>>>           VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> >>>>           VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> >>>> +       /* features of a vDPA management device */
> >>>>           VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> >>>>
> >>>>           VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> >>>>           VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> >>>>           VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> >>>>
> >>>> +       /* features of a vDPA device, e.g., /dev/vhost-vdpa0 */
> >>>> +       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
> >>> What's the difference between this and VDPA_ATTR_DEV_SUPPORTED_FEATURES?
> >> This is to report a vDPA device features, and
> >> VDPA_ATTR_DEV_SUPPORTED_FEATURES
> >> is used for reporting the management device features, we have a long
> >> discussion
> >> on this before.
> > Yes, but the comment is not clear in many ways:
> >
> > " features of a vDPA management device" sounds like features that is
> > out of the scope of the virtio.
> I think the term "vDPA device" implies that it is a virtio device.
> So how about: "virtio features of a vDPA management device"

Not a native speaker, but how about "virtio features that are
supported by the vDPA management device?"

Thanks

> >
> > And
> >
> > "/dev/vhost-vdpa0" is not a vDPA device but a vhost-vDPA device.
> will remove this example here.
>
> Thanks
> >
> > Thanks
> >
> >>> Thanks
> >>>
> >>>> +
> >>>>           /* new attributes must be added above here */
> >>>>           VDPA_ATTR_MAX,
> >>>>    };
> >>>> --
> >>>> 2.31.1
> >>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
