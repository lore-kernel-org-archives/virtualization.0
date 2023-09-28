Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E7E810DF
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 02:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A917061593;
	Thu, 28 Sep 2023 02:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A917061593
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P8V08McaZ1rc; Thu, 28 Sep 2023 02:03:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 063616156B;
	Thu, 28 Sep 2023 02:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 063616156B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D26BBC0039;
	Thu, 28 Sep 2023 02:03:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7BEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 02:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA3FD424EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 02:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA3FD424EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ix1Y9tvoCbC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 02:03:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0216442414
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 02:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0216442414
Received: from kwepemd500002.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RwxVn50XczNnmP;
 Thu, 28 Sep 2023 09:59:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd500002.china.huawei.com (7.221.188.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 28 Sep 2023 10:03:19 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 28 Sep 2023 10:03:19 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAAAEdD4AAMnHjIP//vvqAgADI4ID//3VFcA==
Date: Thu, 28 Sep 2023 02:03:18 +0000
Message-ID: <53d400c057564aa28930bbf3d76ddeff@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <20230926130521-mutt-send-email-mst@kernel.org>
 <9564c220c8344939880bb805c5b3cac9@huawei.com>
 <20230927152531.061600f0.pasic@linux.ibm.com>
 <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
In-Reply-To: <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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
From: "Gonglei \(Arei\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Thursday, September 28, 2023 9:24 AM
> To: Michael S. Tsirkin <mst@redhat.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org; Marc
> Hartmayer <mhartmay@linux.ibm.com>; Jason Wang
> <jasowang@redhat.com>; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; Cornelia Huck <cohuck@redhat.com>
> Subject: Re: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
> 
> Hi Michael & Lei,
> 
> I volunteer to fix this by workqueue.
> 
Thanks, patches are always welcome.

> I also notice that device drivers use workqueue to handle config-changed again
> and again, what about re-implement __virtio_config_changed() by kicking
> workqueue instead?
> 
Personally, I prefer to implement it in the device driver case by case. some devices 
want to work in the upper half of the interrupt context, such as virtio-mem.

> By the way, balloon dirvers uses
> spin_lock_irqsave/spin_unlock_irqrestore in config-changed callback, do it
> handle correctly?
> 
It's ok. The critical resource protected is global system_freezable_wq.

Regards,
-Gonglei

> On 9/27/23 21:25, Halil Pasic wrote:
> > On Wed, 27 Sep 2023 09:24:09 +0000
> > "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> >
> >>> On a related note, config change callback is also handled
> >>> incorrectly in this driver, it takes a mutex from interrupt context.
> >>
> >> Good catch. Will fix it.
> >
> > Thanks Gonglei! Sorry I first misunderstood this as a problem within
> > the virtio-ccw driver, but it is actually about virtio-crypto. Thanks
> > for fixing this!
> >
> > Regards,
> > Halil
> 
> --
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
