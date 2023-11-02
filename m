Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977E7C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 13:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E38141F43;
	Thu,  2 Nov 2023 13:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E38141F43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4QLCVSSYsQ0; Thu,  2 Nov 2023 13:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E2AF41E8C;
	Thu,  2 Nov 2023 13:17:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E2AF41E8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD55C0072;
	Thu,  2 Nov 2023 13:17:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31365C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CD9F8506F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CD9F8506F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxeANW7pFxEW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:17:54 +0000 (UTC)
X-Greylist: delayed 996 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 02 Nov 2023 13:17:53 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80D0084F70
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80D0084F70
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:17:53 +0000 (UTC)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SLkX16wDrzVm1M;
 Thu,  2 Nov 2023 21:01:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 21:01:09 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 2 Nov 2023 21:01:09 +0800
To: Halil Pasic <pasic@linux.ibm.com>
Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Topic: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Thread-Index: AdnvwZyqMOU4LXJLQHSIVFGYJFXR5QAk7LIAADLTkZAHGvVqsA==
Date: Thu, 2 Nov 2023 13:01:09 +0000
Message-ID: <adb0c5f790dc408887f9d98548373919@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com> 
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
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

Ping Herbert.  

Thanks.

> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Wednesday, September 27, 2023 5:18 PM
> To: 'Halil Pasic' <pasic@linux.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org;
> Marc Hartmayer <mhartmay@linux.ibm.com>; Michael S. Tsirkin
> <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> pizhenwei@bytedance.com; Cornelia Huck <cohuck@redhat.com>
> Subject: RE: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
> 
> 
> 
> > -----Original Message-----
> > From: Halil Pasic [mailto:pasic@linux.ibm.com]
> > Sent: Wednesday, September 27, 2023 12:42 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>;
> > linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; pizhenwei@bytedance.com; Halil Pasic
> > <pasic@linux.ibm.com>; Cornelia Huck <cohuck@redhat.com>
> > Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh
> > disabled
> >
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
> > > ,
> > > req, err);
> > > +	local_bh_enable();
> >
> > Thanks Gonglei!
> >
> > I did this a quick spin, and it does not seem to be sufficient on s390x.
> > Which does not come as a surprise to me, because
> >
> > #define lockdep_assert_in_softirq()
> > \
> > do
> > {
> >      \
> >         WARN_ON_ONCE(__lockdep_enabled                  &&
> > \
> >                      (!in_softirq() || in_irq() || in_nmi()));          \
> > } while (0)
> >
> > will still warn because  in_irq() still evaluates to true (your patch
> > addresses the !in_softirq() part).
> >
> You are right.
> 
> So I think the core of this question is: Can we call crypto_finalize_request() in
> the upper half of the interrupt?
> If so, maybe we should introduce a new function, such as
> lockdep_assert_in_interrupt().
> 
> #define lockdep_assert_in_interrupt()                               \
> do {                                                           \
>        WARN_ON_ONCE(__lockdep_enabled && !in_interrupt());        \
> } while (0)
> 
> If not, why?
> 
> Herbert, do you have any suggestions? Thanks.
> 
> 
> Regards,
> -Gonglei
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
