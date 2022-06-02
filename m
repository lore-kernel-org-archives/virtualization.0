Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57556C433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 03:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA3C0607CA;
	Thu,  2 Jun 2022 03:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqDgDWLPv2Az; Thu,  2 Jun 2022 03:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F9D660774;
	Thu,  2 Jun 2022 03:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 216FEC0039;
	Thu,  2 Jun 2022 03:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C293C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 03:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 648AD82BC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 03:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjdwbku3MmwJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 03:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91FB982BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 03:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654142033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nhZSbN+Ew1mV2HyhEGIhPum4yYB0PCOS8RQvOZHGfg=;
 b=EbueC4Ek4SCHEGKpbe9TcZm+cERk+MjUTz5qx/k68szCuMilSg+eJiApbVfxBpfvW26F57
 uonwI+lctnkHvExVgLTJRTExWqPXcuJT7GXnHvX2bDV/dHvNZuEW4NuAN5ZAD8ue/UD1ue
 SG+KaQeDk50O1G8n3dbJ9uOx2Ji4tMk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-gErIQP8qNAmEASyyEbLdig-1; Wed, 01 Jun 2022 23:53:52 -0400
X-MC-Unique: gErIQP8qNAmEASyyEbLdig-1
Received: by mail-lf1-f72.google.com with SMTP id
 c6-20020a056512104600b00477b25bfdf8so1880002lfb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Jun 2022 20:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3nhZSbN+Ew1mV2HyhEGIhPum4yYB0PCOS8RQvOZHGfg=;
 b=2aexsqXX59lPilj7nJv83Rx1sBV8TSagDl95CNBKTzhK7nFVBWYnTmfXZMQsdl7Eb8
 KOIVLPt2+A2Uhkx4GtsraJrVq4oIdDbIRN+dmAQOvWxKgwSQGHHfTVVufcW2+GjrqHnL
 xLntAuVbiPWBp9l0jmi39Bk7/V34nTz+hTP5O6Bt3BVa2BcAEa2u2OplrD26+a88XtyS
 y6A4ii0u7esw1q/sYyj/c8O7S3cpEP4JyVcoh8TEtGl2DNqPilatzYrYHargz1ZA0BIg
 8tCY1nwWmjd2CAkTsU8KhHft/kazyFYnEPys0JPCLM1zTuve7Mz09skz5g+GwOEmwIdr
 CU9g==
X-Gm-Message-State: AOAM533gLlEfukopcynkK+ow8B8eWli/pMdSYPc5IXjTsPH3Wja/pMv4
 3PncDpjvIEfpZU1YxnSnxHCvG9/ui4vfEPaTWx9rHgZowJ2SXaQr/Hh4rpj0lB/xnWqL/1qjdrh
 HYlCgCQLEA+AmQAu3IfZLkJlXhJF/mfYSGbY7wVjAp0OkyPuLq+/63FW8Zg==
X-Received: by 2002:a2e:910e:0:b0:255:4a7e:b42e with SMTP id
 m14-20020a2e910e000000b002554a7eb42emr13517226ljg.492.1654142030533; 
 Wed, 01 Jun 2022 20:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJM9qe1ZzH7Y7RYWXggUuk3BevCy6i+Cbv2/YzP3wdLzlzwEekNr9HqR9L31QhUD0/KMuoWmCNycyMXglwQmk=
X-Received: by 2002:a2e:910e:0:b0:255:4a7e:b42e with SMTP id
 m14-20020a2e910e000000b002554a7eb42emr13517199ljg.492.1654142030349; Wed, 01
 Jun 2022 20:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
 <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 11:53:39 +0800
Message-ID: <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 10:59 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 1, 2022 10:00 PM
> >
> > On Thu, Jun 2, 2022 at 2:58 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, May 31, 2022 10:42 PM
> > > >
> > > > Well, the ability to query the virtqueue state was proposed as
> > > > another feature (Eugenio, please correct me). This should be
> > > > sufficient for making virtio-net to be live migrated.
> > > >
> > > The device is stopped, it won't answer to this special vq config done here.
> >
> > This depends on the definition of the stop. Any query to the device state
> > should be allowed otherwise it's meaningless for us.
> >
> > > Programming all of these using cfg registers doesn't scale for on-chip
> > memory and for the speed.
> >
> > Well, they are orthogonal and what I want to say is, we should first define
> > the semantics of stop and state of the virtqueue.
> >
> > Such a facility could be accessed by either transport specific method or admin
> > virtqueue, it totally depends on the hardware architecture of the vendor.
> >
> I find it hard to believe that a vendor can implement a CVQ but not AQ and chose to expose tens of hundreds of registers.
> But maybe, it fits some specific hw.

You can have a look at the ifcvf dpdk driver as an example.

But another thing that is unrelated to hardware architecture is the
nesting support. Having admin virtqueue in a nesting environment looks
like an overkill. Presenting a register in L1 and map it to L0's admin
should be good enough.

>
> I like to learn the advantages of such method other than simplicity.
>
> We can clearly that we are shifting away from such PCI registers with SIOV, IMS and other scalable solutions.
> virtio drifting in reverse direction by introducing more registers as transport.
> I expect it to an optional transport like AQ.

Actually, I had a proposal of using admin virtqueue as a transport,
it's designed to be SIOV/IMS capable. And it's not hard to extend it
with the state/stop support etc.

>
> > >
> > > Next would be to program hundreds of statistics of the 64 VQs through a
> > giant PCI config space register in some busy polling scheme.
> >
> > We don't need giant config space, and this method has been implemented
> > by some vDPA vendors.
> >
> There are tens of 64-bit counters per VQs. These needs to programmed on destination side.
> Programming these via registers requires exposing them on the registers.
> In one of the proposals, I see them being queried via CVQ from the device.

I didn't see a proposal like this. And I don't think querying general
virtio state like idx with a device specific CVQ is a good design.

>
> Programming them via cfg registers requires large cfg space or synchronous programming until receiving ACK from it.
> This means one entry at a time...
>
> Programming them via CVQ needs replicate and align cmd values etc on all device types. All duplicate and hard to maintain.
>
>
> > >
> > > I can clearly see how all these are inefficient for faster LM.
> > > We need an efficient AQ to proceed with at minimum.
> >
> > I'm fine with admin virtqueue, but the stop and state are orthogonal to that.
> > And using admin virtqueue for stop/state will be more natural if we use
> > admin virtqueue as a transport.
> Ok.
> We should have defined it bit earlier that all vendors can use. :(

I agree.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
