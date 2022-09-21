Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AEEC54EE9
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 02:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DA5082A6C;
	Wed, 21 Sep 2022 02:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DA5082A6C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3lkTQnx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUqtJKhz073S; Wed, 21 Sep 2022 02:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D1D6828F8;
	Wed, 21 Sep 2022 02:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D1D6828F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55198C0033;
	Wed, 21 Sep 2022 02:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85148C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49D2D8290B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49D2D8290B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7ytYQud_z3c
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77D2B828F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77D2B828F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663726687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gtl07m+44fhXx6lazyZdmQ7bZDMn8Q/qijchxc3xv0=;
 b=D3lkTQnx88oNiLgpr3IGCdMiIPCFT0Rsjqw/tvA/sOYL4wPBlNAGoR/RVClc+t7R0T9Yil
 5oXNBWjm3uJrhM1DyOAeTD9m5/ix5QVQ64ciG9vmaWsq9P2b+vL0YY0eotaRqkVS9BmKf9
 z4fbVmYujJwbl5WrFpzRZADuDr90VaE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-TE6Tw7SIPTSymJWIC2k7Fw-1; Tue, 20 Sep 2022 22:18:06 -0400
X-MC-Unique: TE6Tw7SIPTSymJWIC2k7Fw-1
Received: by mail-oo1-f72.google.com with SMTP id
 a21-20020a4ad1d5000000b004757a8a97ddso2090325oos.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=/gtl07m+44fhXx6lazyZdmQ7bZDMn8Q/qijchxc3xv0=;
 b=S3q3H9b5Ay8it9OC/ArAbDJkvb9DvZyyksDFru/4rBXdsop6WPUzErJ3fSMBpN5f97
 XRxFTpX8xEBhEy1SoBL/XzoZUIvfjUJavLtzfcD3Bdcb9tQjWzAqAStMTSjOmdfffLmE
 s6d+bzi1TDA6ARPsbli5SiJU4LLfHBLbotQBxkRhJP4FT30pMGPPtjybIotua8mcsfqo
 9QU4MlmzziwdB6UPIhr2UFpgEaRwYijmZ852TQ+26R4uY9Xy6hP50ye9MaikFGBbpTXB
 RJByEnW3tSKDmiL0mycTQDLnx7zoCHOoD5ya0S0ob4XWwxkAEfea42EkRCOlOulJVDKH
 8z4A==
X-Gm-Message-State: ACrzQf3rDER60bwn4Jw9C/Sp7RkqOwXRI9VkePPKiX2rnGhqxZVFKpXd
 1uOxiW6zBLtqcqNExjlqWkHyNm4AOnE9OQudfxV0IhSEmbGtB0ZsW3wLRzcWLIqyn0T9CGOWDhd
 uLY2YHsewesoyLa2WubUyphiBRm3Zj/203R+tXccq53WLxzuKxYYDTLIL0A==
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr2890627oiv.280.1663726685177; 
 Tue, 20 Sep 2022 19:18:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Sp+DzA3Bx7zu6GlOqn0yJePMZvUgNVa704D/MJlnLCmpKE8iIbo4+I9gBgpCklksgG4cc3YQtPXFcDSMfQBA=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr2890617oiv.280.1663726684913; Tue, 20
 Sep 2022 19:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-2-lingshan.zhu@intel.com>
 <CACGkMEsq+weeO7i8KtNNAPhXGwN=cTwWt3RWfTtML-Xwj3K5Qg@mail.gmail.com>
 <e69b65e7-516f-55bd-cb99-863d7accbd32@intel.com>
In-Reply-To: <e69b65e7-516f-55bd-cb99-863d7accbd32@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Sep 2022 10:17:53 +0800
Message-ID: <CACGkMEv0++vmfzzmX47NhsaY5JTvbO2Ro7Taf8C0dxV6OVXTKw@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 5:58 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 9/20/2022 10:02 AM, Jason Wang wrote:
> > On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >> This commit adds a new vDPA netlink attribution
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> >> features of vDPA devices through this new attr.
> >>
> >> This commit invokes vdpa_config_ops.get_config() than
> >> vdpa_get_config_unlocked() to read the device config
> >> spcae, so no raeces in vdpa_set_features_unlocked()
> >>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > It's better to share the userspace code as well.
> OK, will share it in V2.
> >
> >> ---
> >>   drivers/vdpa/vdpa.c       | 19 ++++++++++++++-----
> >>   include/uapi/linux/vdpa.h |  4 ++++
> >>   2 files changed, 18 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index c06c02704461..798a02c7aa94 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -491,6 +491,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> >>                  err = -EMSGSIZE;
> >>                  goto msg_err;
> >>          }
> >> +
> >> +       /* report features of a vDPA management device through VDPA_ATTR_DEV_SUPPORTED_FEATURES */
> > The code explains itself, there's no need for the comment.
> these comments are required in other discussions

I think it's more than sufficient to clarify the semantic where it is defined.

> >
> >>          if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
> >>                                mdev->supported_features, VDPA_ATTR_PAD)) {
> >>                  err = -EMSGSIZE;
> >> @@ -815,10 +817,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> >>   static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
> >>   {
> >>          struct virtio_net_config config = {};
> >> -       u64 features;
> >> +       u64 features_device, features_driver;
> >>          u16 val_u16;
> >>
> >> -       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> >> +       vdev->config->get_config(vdev, 0, &config, sizeof(config));
> >>
> >>          if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
> >>                      config.mac))
> >> @@ -832,12 +834,19 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>                  return -EMSGSIZE;
> >>
> >> -       features = vdev->config->get_driver_features(vdev);
> >> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> >> +       features_driver = vdev->config->get_driver_features(vdev);
> >> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >> +                             VDPA_ATTR_PAD))
> >> +               return -EMSGSIZE;
> >> +
> >> +       features_device = vdev->config->get_device_features(vdev);
> >> +
> >> +       /* report features of a vDPA device through VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES */
> >> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
> >>                                VDPA_ATTR_PAD))
> >>                  return -EMSGSIZE;
> >>
> >> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> >> +       return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
> >>   }
> >>
> >>   static int
> >> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> >> index 25c55cab3d7c..97531b52dcbe 100644
> >> --- a/include/uapi/linux/vdpa.h
> >> +++ b/include/uapi/linux/vdpa.h
> >> @@ -46,12 +46,16 @@ enum vdpa_attr {
> >>
> >>          VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> >>          VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> >> +       /* features of a vDPA management device */
> >>          VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> >>
> >>          VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> >>          VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> >>          VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> >>
> >> +       /* features of a vDPA device, e.g., /dev/vhost-vdpa0 */
> >> +       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
> > What's the difference between this and VDPA_ATTR_DEV_SUPPORTED_FEATURES?
> This is to report a vDPA device features, and
> VDPA_ATTR_DEV_SUPPORTED_FEATURES
> is used for reporting the management device features, we have a long
> discussion
> on this before.

Yes, but the comment is not clear in many ways:

" features of a vDPA management device" sounds like features that is
out of the scope of the virtio.

And

"/dev/vhost-vdpa0" is not a vDPA device but a vhost-vDPA device.

Thanks

> >
> > Thanks
> >
> >> +
> >>          /* new attributes must be added above here */
> >>          VDPA_ATTR_MAX,
> >>   };
> >> --
> >> 2.31.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
