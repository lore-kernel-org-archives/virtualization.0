Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E87C32771
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 07:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 299956100A;
	Wed, 21 Sep 2022 07:44:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 299956100A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1w9VV80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xq9HNhVVzwR4; Wed, 21 Sep 2022 07:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B45C61007;
	Wed, 21 Sep 2022 07:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B45C61007
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 182D2C0032;
	Wed, 21 Sep 2022 07:44:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E40DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D505340940
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D505340940
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1w9VV80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7LGTsT08Scp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C98E40906
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C98E40906
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663746243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86vShVgoh12B6XaEHHutbnawfEbjDkAMZ1MtTQw6pEo=;
 b=Y1w9VV80QRdbg9+5omFjMxcuylpzmt0L8D1NnKPkCndaRHj9t++CJ7lty02QMH9KeJnA/Z
 XKIWvMg0ybmTUBhBjIT6+Na7zHuoXkQ/ylANS+8RGL+3qT3BlgmT0EyDEoXv/TOn78R1cn
 Dz32W6HFrzqCtHqn+W62VdpCA7ZYs1A=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-HmWVwzGhO9ygL_NqEigC_Q-1; Wed, 21 Sep 2022 03:44:01 -0400
X-MC-Unique: HmWVwzGhO9ygL_NqEigC_Q-1
Received: by mail-oi1-f199.google.com with SMTP id
 h133-20020aca3a8b000000b00350c126bf48so2731740oia.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=86vShVgoh12B6XaEHHutbnawfEbjDkAMZ1MtTQw6pEo=;
 b=FMNwepQZtR/M0AyS/+eEh72eUTD3yXmoEos8fI3Q4neZY5LrgF78/ijOhN/AihJwRG
 1snEWybct2f0/bwI5c+Wuu56TOQiTSjQHZa9ohAzZ8o8gCRgj+oO75nlX0/bEXhekRuz
 Ci6VoyNWor06hw66FMgoVMyOvGtawhArJp07/rVbXwhNapDnp7aaRFgskKSdf9nzWoDC
 TbwZSYXwdjosiIVxzKCbqBCta4c4ASdj0N6LPpPrDd61Xa2frGokfnU2jPYXVGFORzlw
 jkRXPgYAf6Xsu+iHuVLqekBg/hLikZjnAa1En6GJbb6CgQBOlSXOQ/hXuWw5Iob2Svtg
 j50w==
X-Gm-Message-State: ACrzQf1+2mW1Wp1USghOqqynqeHRN4S7qpdhuQ13hvU9UzfNGeC0px0e
 x6wmK2dxIkbzqu2BwxbfrwuBG/3gbAPz9KzDeHngnNKpEoN+t2UA55/9g4oI+DYhenxeky+zE82
 wlOUxL54nMc+d/Cyy43hnD6fWs6TyBiXW65XLDjG5hPNmpMyoml3R+fqzRQ==
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr3234464oiv.280.1663746241014; 
 Wed, 21 Sep 2022 00:44:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qONZ88pXEclF6rWHrCx6zwa1UB2BpZ/Kart+KFBy/YxtaT63ZnO00Ywv2ymwreiaf+VxnSFQCuGq04KCBrEo=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr3234455oiv.280.1663746240793; Wed, 21
 Sep 2022 00:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-3-lingshan.zhu@intel.com>
 <CACGkMEsYARr3toEBTxVcwFi86JxK0D-w4OpNtvVdhCEbAnc8ZA@mail.gmail.com>
 <6fd1f8b3-23b1-84cc-2376-ee04f1fa8438@intel.com>
 <CACGkMEuusM3EMmWW6+q8V1fZscfjM2R9n7jGefUnSY59UnZDYQ@mail.gmail.com>
 <ed56a694-a024-23be-d4cb-7ab51c959b61@intel.com>
In-Reply-To: <ed56a694-a024-23be-d4cb-7ab51c959b61@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Sep 2022 15:43:49 +0800
Message-ID: <CACGkMEuXA6Uj7OHqUDux=Yz+XFtouKWGOVV4fk5B5XCZW5F22w@mail.gmail.com>
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

On Wed, Sep 21, 2022 at 1:39 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 9/21/2022 10:14 AM, Jason Wang wrote:
> > On Tue, Sep 20, 2022 at 1:46 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 9/20/2022 10:16 AM, Jason Wang wrote:
> >>> On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>> vdpa_dev_net_config_fill() should only report driver features
> >>>> to userspace after features negotiation is done.
> >>>>
> >>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>> ---
> >>>>    drivers/vdpa/vdpa.c | 13 +++++++++----
> >>>>    1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>>> index 798a02c7aa94..29d7e8858e6f 100644
> >>>> --- a/drivers/vdpa/vdpa.c
> >>>> +++ b/drivers/vdpa/vdpa.c
> >>>> @@ -819,6 +819,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>>>           struct virtio_net_config config = {};
> >>>>           u64 features_device, features_driver;
> >>>>           u16 val_u16;
> >>>> +       u8 status;
> >>>>
> >>>>           vdev->config->get_config(vdev, 0, &config, sizeof(config));
> >>>>
> >>>> @@ -834,10 +835,14 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> >>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>>>                   return -EMSGSIZE;
> >>>>
> >>>> -       features_driver = vdev->config->get_driver_features(vdev);
> >>>> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >>>> -                             VDPA_ATTR_PAD))
> >>>> -               return -EMSGSIZE;
> >>>> +       /* only read driver features after the feature negotiation is done */
> >>>> +       status = vdev->config->get_status(vdev);
> >>>> +       if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
> >>> Any reason this is not checked in its caller as what it used to do before?
> >> will check the existence of vdev->config->get_status before calling it in V2
> > Just to clarify, I meant to check FEAUTRES_OK in the caller -
> > vdpa_dev_config_fill() otherwise each type needs to repeat this in
> > their specific codes.
> if we check FEATURES_OK in the caller vdpa_dev_config_fill(), then
> !FEATURES_OK will block reporting all attributions, for example
> the device features and virtio device config space fields in this series
> and device status.
> Currently only driver features needs to check FEATURES_OK.
> Or did I missed anything?

I don't see much difference, we just move the following part to the
caller, it is not the config but the VDPA_ATTR_DEV_NEGOTIATED_FEATURES
is blocked.

Thanks

>
> Thanks
> >
> > Thanks
> >
> >> Thanks,
> >> Zhu Lingshan
> >>> Thanks
> >>>
> >>>> +               features_driver = vdev->config->get_driver_features(vdev);
> >>>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >>>> +                                     VDPA_ATTR_PAD))
> >>>> +                       return -EMSGSIZE;
> >>>> +       }
> >>>>
> >>>>           features_device = vdev->config->get_device_features(vdev);
> >>>>
> >>>> --
> >>>> 2.31.1
> >>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
