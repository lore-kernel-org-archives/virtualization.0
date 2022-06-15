Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F6C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 01:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B1238308D;
	Wed, 15 Jun 2022 01:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8hBJwvj8uMS; Wed, 15 Jun 2022 01:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5D2182FF9;
	Wed, 15 Jun 2022 01:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB05C0032;
	Wed, 15 Jun 2022 01:29:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF3BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B807F60F9E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ou4KzNQB7amv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DADF860F58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655256543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPcslwf6/5AipVOiJxjFuNmMuJiLjP5Ai/xX9fViRS4=;
 b=QQbe3riAOnysT+McwsCYR7Jyb8wsIGxw0xHpuuwGxDvnfL07OpA2GcdlJt73su7ULDMVJs
 pBGne0MMx/OjS1c+f9I8qBWpOzkmDSoyY4iVsGJgeKM4J3jhnt3ItQn8z/JXzc98UVcRiL
 MsVXOP/B3BBLDgk1C1fBhYlxajhAZhI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-nDJ0L2qwOqaPK_KjdGZ16Q-1; Tue, 14 Jun 2022 21:29:02 -0400
X-MC-Unique: nDJ0L2qwOqaPK_KjdGZ16Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 j3-20020a05651231c300b0047dbea7b031so5273108lfe.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gPcslwf6/5AipVOiJxjFuNmMuJiLjP5Ai/xX9fViRS4=;
 b=Ns7WWF6JqvMJIjkeOzcmFa8s06woDR2T/jJxFO8tBpHeCoxYuP2rvcnKxZ8/2JxNQe
 H6nyKmoXDi0HF5tHzzj2zvIy7p7s/Hoza/hujWlILep0B/2xeDQT6IL0nG28i4onYhVl
 ELRi88CPPCJj9z99IpYqJfuOVcPsxHb7i0rIytH75D0tGIdrDNVDjFQet96jVbd06v2k
 9z38iGNAriSlLyP1mJ4sjfHHsHZlDZg5jM/zNH4TFPx7v7Qlh/ZFfOp4OVT05jRtR1bh
 Ze+pX5hkVFVTSpE/5gYaeU80vX6sQIrTpvmoY8tyU31DwAX5kNVLrZjktEM6wtemqYUJ
 KwSg==
X-Gm-Message-State: AJIora/4ATD5vUf/AGChYyHqabB2bfxvSI91YIHIf6o8l29EA0Y2medY
 5c5dhpn+inm1yQL9411hRvfH2SqsMoaI3SxwRDgQP+uEkGEUyfDYGzhmSrtcyp8SWl9mIPaI+ql
 vwWAJRodxAeuaZEj1kPmjcjI8lfBV7WWEq3Rlyg2g9j4f8JdBhDMn5b5SAQ==
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr4549831lfj.411.1655256541025; 
 Tue, 14 Jun 2022 18:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy6G17S6B/NL5asgkhJ3N6qCPtMcJgm4jIUP9oxu6MOto7+cw1fHjnYuylfVl22jAQ1SwvKuEFSnQqUE0b/Qw=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr4549812lfj.411.1655256540740; Tue, 14
 Jun 2022 18:29:00 -0700 (PDT)
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
 <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
 <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Jun 2022 09:28:49 +0800
Message-ID: <CACGkMEtRTyymit=Zmwwcq0jNan-_C9p70vcLP0g7XmwQiOjUbw@mail.gmail.com>
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
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
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

On Wed, Jun 15, 2022 at 8:10 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 1, 2022 11:54 PM
> >
> > On Thu, Jun 2, 2022 at 10:59 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, June 1, 2022 10:00 PM
> > > >
> > > > On Thu, Jun 2, 2022 at 2:58 AM Parav Pandit <parav@nvidia.com> wrote:
> > > > >
> > > > >
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Tuesday, May 31, 2022 10:42 PM
> > > > > >
> > > > > > Well, the ability to query the virtqueue state was proposed as
> > > > > > another feature (Eugenio, please correct me). This should be
> > > > > > sufficient for making virtio-net to be live migrated.
> > > > > >
> > > > > The device is stopped, it won't answer to this special vq config done
> > here.
> > > >
> > > > This depends on the definition of the stop. Any query to the device
> > > > state should be allowed otherwise it's meaningless for us.
> > > >
> > > > > Programming all of these using cfg registers doesn't scale for
> > > > > on-chip
> > > > memory and for the speed.
> > > >
> > > > Well, they are orthogonal and what I want to say is, we should first
> > > > define the semantics of stop and state of the virtqueue.
> > > >
> > > > Such a facility could be accessed by either transport specific
> > > > method or admin virtqueue, it totally depends on the hardware
> > architecture of the vendor.
> > > >
> > > I find it hard to believe that a vendor can implement a CVQ but not AQ and
> > chose to expose tens of hundreds of registers.
> > > But maybe, it fits some specific hw.
> >
> > You can have a look at the ifcvf dpdk driver as an example.
> >
> Ifcvf is an example of using registers.
> It is not an answer why AQ is hard for it. :)

Well, it's an example of how vDPA is implemented. I think we agree
that for vDPA, vendors have the flexibility to implement their
perferrable datapath.

> virtio spec has definition of queue now and implementing yet another queue shouldn't be a problem.
>
> So far no one seem to have problem with the additional queue.
> So I take it as AQ is ok.
>
> > But another thing that is unrelated to hardware architecture is the nesting
> > support. Having admin virtqueue in a nesting environment looks like an
> > overkill. Presenting a register in L1 and map it to L0's admin should be good
> > enough.
> So may be a optimized interface can be added that fits nested env.
> At this point in time real users that we heard are interested in non-nested use cases. Let's enable them first.

That's fine. For nests, it's actually really easy, just adding an
interface within the existing transport should be sufficient.

>
>
> >
> > >
> > > I like to learn the advantages of such method other than simplicity.
> > >
> > > We can clearly that we are shifting away from such PCI registers with SIOV,
> > IMS and other scalable solutions.
> > > virtio drifting in reverse direction by introducing more registers as
> > transport.
> > > I expect it to an optional transport like AQ.
> >
> > Actually, I had a proposal of using admin virtqueue as a transport, it's
> > designed to be SIOV/IMS capable. And it's not hard to extend it with the
> > state/stop support etc.
> >
> > >
> > > > >
> > > > > Next would be to program hundreds of statistics of the 64 VQs
> > > > > through a
> > > > giant PCI config space register in some busy polling scheme.
> > > >
> > > > We don't need giant config space, and this method has been
> > > > implemented by some vDPA vendors.
> > > >
> > > There are tens of 64-bit counters per VQs. These needs to programmed on
> > destination side.
> > > Programming these via registers requires exposing them on the registers.
> > > In one of the proposals, I see them being queried via CVQ from the device.
> >
> > I didn't see a proposal like this. And I don't think querying general virtio state
> > like idx with a device specific CVQ is a good design.
> >
> My example was not for the idx. But for VQ statistics that is queried via CVQ.
>
> > >
> > > Programming them via cfg registers requires large cfg space or synchronous
> > programming until receiving ACK from it.
> > > This means one entry at a time...
> > >
> > > Programming them via CVQ needs replicate and align cmd values etc on all
> > device types. All duplicate and hard to maintain.
> > >
> > >
> > > > >
> > > > > I can clearly see how all these are inefficient for faster LM.
> > > > > We need an efficient AQ to proceed with at minimum.
> > > >
> > > > I'm fine with admin virtqueue, but the stop and state are orthogonal to
> > that.
> > > > And using admin virtqueue for stop/state will be more natural if we
> > > > use admin virtqueue as a transport.
> > > Ok.
> > > We should have defined it bit earlier that all vendors can use. :(
> >
> > I agree.
>
> I remember few months back, you acked in the weekly meeting that TC has approved the AQ direction.
> And we are still in this circle of debating the AQ.

I think not. Just to make sure we are on the same page, the proposal
here is for vDPA, and hope it can provide forward compatibility to
virtio. So in the context of vDPA, admin virtqueue is not a must.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
