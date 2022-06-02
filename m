Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAEFCCA473
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 02:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4DA840154;
	Thu,  2 Jun 2022 02:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M35USoQb-xG6; Thu,  2 Jun 2022 02:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4DC87400D0;
	Thu,  2 Jun 2022 02:00:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B87DC0039;
	Thu,  2 Jun 2022 02:00:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5FEBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F15740154
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnDd371rf5A6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 811E8400D0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654135239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YBAqPDemohDoYgk1aoIRFIJVsyNoi84c0I5WJRZqFf4=;
 b=NXaS8eyjnLBPEoVMVgukUkDgGYVjNg0wrNQBx87jVa8MddOZB8qB0Mhzw6MsUve8V0YZ61
 57XnzueQtGs+ZxXu2sBnTa+UiqdPElnXzO4U+2lMoqIVhULEsazWWso+7XqrurSzIW9PCD
 xUA2gn3CvTUeDzO3Zqo+9TvzlHNtzmY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-BJvBvATEMACFt37-BbyEEg-1; Wed, 01 Jun 2022 22:00:37 -0400
X-MC-Unique: BJvBvATEMACFt37-BbyEEg-1
Received: by mail-lf1-f71.google.com with SMTP id
 b2-20020a0565120b8200b00477a4532448so1758835lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Jun 2022 19:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YBAqPDemohDoYgk1aoIRFIJVsyNoi84c0I5WJRZqFf4=;
 b=k1LtF/9/QjfMXj8XMUlVJXpvZokycioBFKVK+aVRLn2mbf3SVQrY2Wtdz0dlbhI7yP
 5RBM98r2UEE4FUzbL/bMAGhU/hOxhJVpjYoNe5JwuEDOSnmLNQ05aLmos6vFOWWAcc37
 Cw3/ZkQnFqUulBLwNvKd0FW3Iy7rC34tB/riW0LmxCAOIrsWX/aoFN8vNJET2/gxF356
 MZe/U4zgOWM/tSdC0cEZ0jCy5ryfcXPE1hRiDZxB5dl2PlTzxzFVckaeKNxc9CB4cLPB
 djhV9+25LPEog0zWDxZRFEtC4eE9IqWtrkZ8QucyV+TzEUc8FcXFiS0fFV/td6YHsPp+
 8fVw==
X-Gm-Message-State: AOAM530wQkTL+yiYXq1Ehj+HgEOYDJ04awR3CsWWW2f+Zy9+GM1CnW7a
 BUPW0CGs3AMVdSgtOqnA3m79hgwaOaoHdkfVld6MJD9Lsi6YjG9icRq1z/KXnXlYg3M1Lb5SJbV
 515Se99ruhUXIjFlFsGxldhx8Zu41nBifnL/piyehb3m0J/GGFFLkzkfmlw==
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr1731821lfb.376.1654135236349; 
 Wed, 01 Jun 2022 19:00:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUrUCq3RcCVi51UnrwoiRoYGBE/u1c2zqyot4xytMyyLYLnsA4frnYnk43vssnr4u4dIBnj0FY2DMvEmzTEsY=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr1731798lfb.376.1654135236157; Wed, 01
 Jun 2022 19:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 10:00:24 +0800
Message-ID: <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Jun 2, 2022 at 2:58 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, May 31, 2022 10:42 PM
> >
> > Well, the ability to query the virtqueue state was proposed as another
> > feature (Eugenio, please correct me). This should be sufficient for making
> > virtio-net to be live migrated.
> >
> The device is stopped, it won't answer to this special vq config done here.

This depends on the definition of the stop. Any query to the device
state should be allowed otherwise it's meaningless for us.

> Programming all of these using cfg registers doesn't scale for on-chip memory and for the speed.

Well, they are orthogonal and what I want to say is, we should first
define the semantics of stop and state of the virtqueue.

Such a facility could be accessed by either transport specific method
or admin virtqueue, it totally depends on the hardware architecture of
the vendor.

>
> Next would be to program hundreds of statistics of the 64 VQs through a giant PCI config space register in some busy polling scheme.

We don't need giant config space, and this method has been implemented
by some vDPA vendors.

>
> I can clearly see how all these are inefficient for faster LM.
> We need an efficient AQ to proceed with at minimum.

I'm fine with admin virtqueue, but the stop and state are orthogonal
to that. And using admin virtqueue for stop/state will be more natural
if we use admin virtqueue as a transport.

Thanks

>
> > https://lists.oasis-open.org/archives/virtio-comment/202103/msg00008.html
> >
> > > Once the device is stopped, its state cannot be queried further as device
> > won't respond.
> > > It has limited use case.
> > > What we need is to stop non admin queue related portion of the device.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
