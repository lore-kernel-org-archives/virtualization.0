Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3E9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 02:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAA2D404A9;
	Thu, 23 Dec 2021 02:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpigaSqz-QCf; Thu, 23 Dec 2021 02:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07AED405D7;
	Thu, 23 Dec 2021 02:28:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF62C002F;
	Thu, 23 Dec 2021 02:28:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EFB5C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 242F160ACA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNn4yWn1gsXw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:28:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D82C60AC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640226482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lD+yKKSTlWhbb8fyyzyMzYFqhMnUdrYIuHofdazALpA=;
 b=UUnI19gd9SB4lyU/R2ukECxGI77hndFakXcXmk9IiL14JTw/pAlLCFmwHGzQKzYD1lYsS5
 qLmlaHRdlPTDuOANMNt6IxgMjab0oj7UP58PDyDgmgGGtOY5U0/KRNxpY1dC37kBcg/pLN
 MkHcizXp41rmEnztoIUEOQFJ3gPvJwk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-TzpUz6M-OCWb5Tee9OfTSw-1; Wed, 22 Dec 2021 21:28:01 -0500
X-MC-Unique: TzpUz6M-OCWb5Tee9OfTSw-1
Received: by mail-lf1-f71.google.com with SMTP id
 m5-20020a05651202e500b00425baf04eacso1668614lfq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 18:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lD+yKKSTlWhbb8fyyzyMzYFqhMnUdrYIuHofdazALpA=;
 b=acu7hfD4NU/t/GjFJVXf0ea0E8+crN150KmDHZv8aYy+fzmnSbiT1FSCVASH9pdbHc
 8lTnXj8IwfyRTWRE65tV2eo1xc2JvIcJ1d7whi4xGLfAYTHSbSOw3FZH0vgIcN9XV12n
 jCP3c941GtsblcTyCFlKFKuPgK9jnk8dOmfKvz0TwewlddB71NxSpJyvgQXIni7JsZBu
 kuiMCvmp4p/J4cRA4sP4m3iOunY33eM4ru+WKUfUB6eyshRZQLoOSe6+XoI+h8OF9FjN
 Y9vebJ7yP0k7uoDWLTHPheerL3A0MqwOj96ZTtUiZjWzUBUeF3e1S/x0W9qCOPIAq6lk
 RpXQ==
X-Gm-Message-State: AOAM533lFSMph1jCgcpx6n0VcqeNe2bBP/2zewm4nYJE/TJ/xh6RsF7e
 oPPMohYWcamOikU1NTGo2iowsgmlB6WKN9O7l5h+hU4EuwIAjdXAooYsle1CJdGVSq3eIAEMmDq
 tBkxLnqx2+kfM0cjfyc7GSp6rJfptwmfOLIYeXGnm/tuUqIp5hEP+qW3G+Q==
X-Received: by 2002:a05:6512:3d21:: with SMTP id
 d33mr379502lfv.481.1640226480264; 
 Wed, 22 Dec 2021 18:28:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVctKVuQr1giKj8QV9qnt9UES8BKDlC31EGW8r1mMx/Jbg/Z9vMZrS6d8kMjHLwGsbpIW8LyLR+7HVk9EvcB0=
X-Received: by 2002:a05:6512:3d21:: with SMTP id
 d33mr379482lfv.481.1640226480039; 
 Wed, 22 Dec 2021 18:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
 <84292943-b4de-8162-1fde-fcfab479b629@oracle.com>
 <20211222075402.GA214545@mtl-vdi-166.wap.labs.mlnx>
 <8e93cfc4-b71e-adc5-8b35-337523e3a431@oracle.com>
In-Reply-To: <8e93cfc4-b71e-adc5-8b35-337523e3a431@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Dec 2021 10:27:49 +0800
Message-ID: <CACGkMEvMAS1PspbRdL-0SHfGkkZLp-1AFQAwCkQPAiZeMzxAHw@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Thu, Dec 23, 2021 at 3:25 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 12/21/2021 11:54 PM, Eli Cohen wrote:
> > On Tue, Dec 21, 2021 at 11:29:36PM -0800, Si-Wei Liu wrote:
> >>
> >> On 12/21/2021 11:10 PM, Eli Cohen wrote:
> >>> On Wed, Dec 22, 2021 at 09:03:37AM +0200, Parav Pandit wrote:
> >>>>> From: Eli Cohen <elic@nvidia.com>
> >>>>> Sent: Wednesday, December 22, 2021 12:17 PM
> >>>>>
> >>>>>>>> --- a/drivers/vdpa/vdpa.c
> >>>>>>>> +++ b/drivers/vdpa/vdpa.c
> >>>>>>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
> >>>>>>> vdpa_mgmt_dev *mdev, struct sk_buff *m
> >>>>>>>>                err = -EMSGSIZE;
> >>>>>>>>                goto msg_err;
> >>>>>>>>        }
> >>>>>>>> +      if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> >>>>>>>> +                      mdev->max_supported_vqs))
> >>>>>>> It still needs a default value when the field is not explicitly
> >>>>>>> filled in by the driver.
> >>>>>>>
> >>>>>> Unlikely. This can be optional field to help user decide device max limit.
> >>>>>> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
> >>>>> space.
> >>>>> This is not about what you expose to userspace. It's about the number of VQs
> >>>>> you want to create for a specific instance of vdpa.
> >>>> This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
> >>>> User will choose to create VQ with VQs <= N depending on its vcpu and other factors.
> >>> You're right.
> >>> So each vendor needs to put there their value.
> >> If I understand Parav correctly, he was suggesting not to expose
> >> VDPA_ATTR_DEV_MGMTDEV_MAX_VQS to userspace if seeing (max_supported_vqs ==
> >> 0) from the driver.
> > I can see the reasoning, but maybe we should leave it as zero which
> > means it was not reported. The user will then need to guess. I believe
> > other vendors will follow with an update so this to a real value.
> Unless you place a check in the vdpa core to enforce it on vdpa
> creation, otherwise it's very likely to get ignored by other vendors.
>
> >
> >> But meanwhile, I do wonder how users tell apart multiqueue supporting parent
> >> from the single queue mgmtdev without getting the aid from this field. I
> >> hope the answer won't be to create a vdpa instance to try.
> >>
> > Do you see a scenario that an admin decides to not instantiate vdpa just
> > because it does not support MQ?
> Yes, there is. If the hardware doesn't support MQ, the provisioning tool
> in the mgmt software will need to fallback to software vhost backend
> with mq=on. At the time the tool is checking out, it doesn't run with
> root privilege.
>
> >
> > And it the management device reports it does support, there's still no
> > guarantee you'll end up with a MQ net device.
> I'm not sure I follow. Do you mean it may be up to the guest feature
> negotiation? But the device itself is still MQ capable, isn't it?

I think we need to clarify the "device" here.

For compatibility reasons, there could be a case that mgmt doesn't
expect a mq capable vdpa device. So in this case, even if the parent
is MQ capable, the vdpa isn't.

Thanks

>
> Thanks,
> -Siwei
>
> >
> >
> >> -Siwei
> >>
> >>>> This is what is exposed to the user to decide the upper bound.
> >>>>>> There has been some talk/patches of rdma virtio device.
> >>>>>> I anticipate such device to support more than 64K queues by nature of rdma.
> >>>>>> It is better to keep max_supported_vqs as u32.
> >>>>> Why not add it when we have it?
> >>>> Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
> >>>> Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
> >>> I can use u32 then.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
