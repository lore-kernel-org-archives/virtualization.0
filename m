Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A0EC6FA82
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 02:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9282960F47;
	Wed, 21 Sep 2022 02:15:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9282960F47
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JRpvlJVe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8-I5x37Y15V; Wed, 21 Sep 2022 02:15:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E78060BF3;
	Wed, 21 Sep 2022 02:15:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E78060BF3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6EF4C0033;
	Wed, 21 Sep 2022 02:14:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE3CDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9510860D56
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9510860D56
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M22S3GZswnh9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20B4560BF3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20B4560BF3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 02:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663726494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9P+rGLJHapFEFbIQqvk7PpMo3XqXvFcVFCgGvvB/1Q=;
 b=JRpvlJVenw9Ip4zOduGgKU8ssEy5jPKiArDiOaiyzNsUiyGes7z4YBQNmTV8Bei2yLH3yD
 +5s+6aYb97P1P+Vm/2bMmSK8K0OTnmZd/ebzjK0QM/YLNtyFgK6JJSEkAxjrXWRSjTTve8
 O9HYVSlu6T/19RXQy05ZTDkvyBfeZ08=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-6J--gYCQMUenk_RWNt0i2Q-1; Tue, 20 Sep 2022 22:14:53 -0400
X-MC-Unique: 6J--gYCQMUenk_RWNt0i2Q-1
Received: by mail-ot1-f70.google.com with SMTP id
 bk9-20020a056830368900b006593c120badso2310701otb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=j9P+rGLJHapFEFbIQqvk7PpMo3XqXvFcVFCgGvvB/1Q=;
 b=uHDh609LvVrQieUwy4+ilZLljfLLyYI4LjyIbO6fwI/jUPwIS5QJaaT6Pk75xjTXTB
 nP/FoWp3MyEKsaLbu8/TW0USUpgAHqg7h9vbeIo+DhZ8nwhWx9vxUFqQx39FAQ7BgEjW
 0O+D16ecZ6NBjQG3JINBBjHzcVBv8s2jyevRSV0MoYQ8cLxFudVZmOHNLykMayit0bOK
 j6HCt4G1PiXAvoJjnyfeEKw6WEBeB/vHsuxMEvBAIc9LosiiQFHJdoJ2xf9vrCtUJzOz
 mpgen+WhTttqXCcIajDT0PVAJi33Gawgf5sNG5vbBOdqeD7j9CQv9VJR3Q6YfgtA72q6
 V7tg==
X-Gm-Message-State: ACrzQf252pGelE2llq6gAAMa6b1ZFkF6vzCWXmeHYPWVKmSm+reYMgrs
 8bZD1L+4c0O3MxHYnuWI4IeXOHO5jApIk3/qLLIlR7jlPnOU/iTIMijUnmoWrQcXnJL99M2iNeR
 MFPgiUVeRDdeGiiKr5194AI041aMmxYMQy2usRjeJwkBPvQvdPQdmA79mPA==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr2863381oib.35.1663726493136; 
 Tue, 20 Sep 2022 19:14:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4OeG5pl5c1sj5sNO3PI4GwxWvbIOCE9z6qMMFenIcaCHhKx9wT6EV+LsxBQsF9TM10MuzNear2uxgAJeKNqAA=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr2863373oib.35.1663726492903; Tue, 20
 Sep 2022 19:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-3-lingshan.zhu@intel.com>
 <CACGkMEsYARr3toEBTxVcwFi86JxK0D-w4OpNtvVdhCEbAnc8ZA@mail.gmail.com>
 <6fd1f8b3-23b1-84cc-2376-ee04f1fa8438@intel.com>
In-Reply-To: <6fd1f8b3-23b1-84cc-2376-ee04f1fa8438@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Sep 2022 10:14:41 +0800
Message-ID: <CACGkMEuusM3EMmWW6+q8V1fZscfjM2R9n7jGefUnSY59UnZDYQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] vDPA: only report driver features if FEATURES_OK is
 set
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

On Tue, Sep 20, 2022 at 1:46 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 9/20/2022 10:16 AM, Jason Wang wrote:
> > On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >> vdpa_dev_net_config_fill() should only report driver features
> >> to userspace after features negotiation is done.
> >>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 798a02c7aa94..29d7e8858e6f 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -819,6 +819,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>          struct virtio_net_config config = {};
> >>          u64 features_device, features_driver;
> >>          u16 val_u16;
> >> +       u8 status;
> >>
> >>          vdev->config->get_config(vdev, 0, &config, sizeof(config));
> >>
> >> @@ -834,10 +835,14 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>                  return -EMSGSIZE;
> >>
> >> -       features_driver = vdev->config->get_driver_features(vdev);
> >> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >> -                             VDPA_ATTR_PAD))
> >> -               return -EMSGSIZE;
> >> +       /* only read driver features after the feature negotiation is done */
> >> +       status = vdev->config->get_status(vdev);
> >> +       if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
> > Any reason this is not checked in its caller as what it used to do before?
> will check the existence of vdev->config->get_status before calling it in V2

Just to clarify, I meant to check FEAUTRES_OK in the caller -
vdpa_dev_config_fill() otherwise each type needs to repeat this in
their specific codes.

Thanks

>
> Thanks,
> Zhu Lingshan
> >
> > Thanks
> >
> >> +               features_driver = vdev->config->get_driver_features(vdev);
> >> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >> +                                     VDPA_ATTR_PAD))
> >> +                       return -EMSGSIZE;
> >> +       }
> >>
> >>          features_device = vdev->config->get_device_features(vdev);
> >>
> >> --
> >> 2.31.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
