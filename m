Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0819E810AD
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 09:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 592F741529;
	Wed, 27 Sep 2023 09:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 592F741529
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCfUQ78G_HCE; Wed, 27 Sep 2023 09:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDF2D40359;
	Wed, 27 Sep 2023 09:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDF2D40359
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4DAC0071;
	Wed, 27 Sep 2023 09:24:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C158C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 09:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01F2941471
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 09:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01F2941471
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DrNc13jbI3dD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 09:24:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD5A140359
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 09:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD5A140359
Received: from kwepemd200001.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwWKJ6NZGztT57;
 Wed, 27 Sep 2023 17:19:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemd200001.china.huawei.com (7.221.188.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Wed, 27 Sep 2023 17:24:09 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Wed, 27 Sep 2023 17:24:09 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAAAEdD4AAMnHjIA==
Date: Wed, 27 Sep 2023 09:24:09 +0000
Message-ID: <9564c220c8344939880bb805c5b3cac9@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <20230926130521-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926130521-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, September 27, 2023 1:14 AM
> To: Halil Pasic <pasic@linux.ibm.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org; Marc
> Hartmayer <mhartmay@linux.ibm.com>; Jason Wang
> <jasowang@redhat.com>; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; pizhenwei@bytedance.com; Cornelia Huck
> <cohuck@redhat.com>
> Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
> 
> On Tue, Sep 26, 2023 at 06:41:58PM +0200, Halil Pasic wrote:
> > [..]
> > > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
> > >  	vc_akcipher_req->src_buf = NULL;
> > >  	vc_akcipher_req->dst_buf = NULL;
> > >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> > > -
> > > +	local_bh_disable();
> > >
> > > crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine
> > > , req, err);
> > > +	local_bh_enable();
> >
> > Thanks Gonglei!
> >
> > I did this a quick spin, and it does not seem to be sufficient on s390x.
> > Which does not come as a surprise to me, because
> >
> > #define lockdep_assert_in_softirq()
> \
> > do
> {
>      \
> >         WARN_ON_ONCE(__lockdep_enabled                  &&
> \
> >                      (!in_softirq() || in_irq() || in_nmi()));          \
> > } while (0)
> >
> > will still warn because  in_irq() still evaluates to true (your patch
> > addresses the !in_softirq() part).
> >
> > I don't have any results on x86 yet. My current understanding is that
> > the virtio-pci transport code disables interrupts locally somewhere in
> > the call chain (actually in vp_vring_interrupt() via
> > spin_lock_irqsave()) and then x86 would be fine. But I will get that verified.
> >
> > On the other hand virtio_airq_handler() calls vring_interrupt() with
> > interrupts enabled. (While vring_interrupt() is called in a (read)
> > critical section in virtio_airq_handler() we use read_lock() and not
> > read_lock_irqsave() to grab the lock. Whether that is correct in it
> > self (i.e. disregarding the crypto problem) or not I'm not sure right
> > now. Will think some more about it tomorrow.) If the way to go forward
> > is disabling interrupts in virtio-ccw before vring_interrupt() is
> > called, I would be glad to spin a patch for that.
> >
> > Copying Conny, as she may have an opinion on this (if I'm not wrong
> > she authored that code).
> >
> > Regards,
> > Halil
> 
> On a related note, config change callback is also handled incorrectly in this
> driver, it takes a mutex from interrupt context.

Good catch. Will fix it.

Thanks.
-Gonglei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
