Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC0C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 13:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B623A43488;
	Thu,  2 Nov 2023 13:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B623A43488
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3L9lHIyTjzaV; Thu,  2 Nov 2023 13:25:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D785243452;
	Thu,  2 Nov 2023 13:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D785243452
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B16CDC0072;
	Thu,  2 Nov 2023 13:25:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B61FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2418443452
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2418443452
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DCTLJkX279y7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:25:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C8A643486
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C8A643486
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLl0h6D4FzrTrP;
 Thu,  2 Nov 2023 21:22:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 21:25:31 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.031;
 Thu, 2 Nov 2023 21:25:31 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Thread-Topic: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Thread-Index: AQHZ7VsjRTMxo/hUEkmU1GjtoDjS1rAp3v1A///cYoCAO3GWgIACEayQ//9+LICAAIbrcA==
Date: Thu, 2 Nov 2023 13:25:31 +0000
Message-ID: <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
 <20231101092521-mutt-send-email-mst@kernel.org>
 <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
 <20231102091548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102091548-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
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
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Thursday, November 2, 2023 9:17 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>
> Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from irq
> context
> 
> On Thu, Nov 02, 2023 at 01:04:07PM +0000, Gonglei (Arei) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Wednesday, November 1, 2023 9:26 PM
> > > To: Halil Pasic <pasic@linux.ibm.com>
> > > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> > > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > > virtualization@lists.linux-foundation.org;
> > > linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org; Marc
> > > Hartmayer <mhartmay@linux.ibm.com>
> > > Subject: Re: virtcrypto_dataq_callback calls
> > > crypto_finalize_request() from irq context
> > >
> > > On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> > > > On Sun, 24 Sep 2023 11:56:25 +0000 "Gonglei (Arei)"
> > > > <arei.gonglei@huawei.com> wrote:
> > > >
> > > > > Hi Halil,
> > > > >
> > > > > Commit 4058cf08945 introduced a check for detecting crypto
> > > > > completion function called with enable BH, and indeed the
> > > > > virtio-crypto driver didn't disable BH, which needs a patch to fix it.
> > > > >
> > > > > P.S.:
> > > > > https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@bay
> > > > > libr
> > > > > e.com/T/
> > > > >
> > > > > Regards,
> > > > > -Gonglei
> > > >
> > > > Thanks Gonglei!
> > > >
> > > > Thanks! I would be glad to test that fix on s390x. Are you about
> > > > to send one?
> > > >
> > > > Regards,
> > > > Halil
> > >
> > >
> > > Gonglei did you intend to send a fix?
> >
> > Actually I sent a patch a month ago, pls see another thread.
> >
> >
> > Regards,
> > -Gonglei
> 
> And I think there was an issue with that patch that you wanted to fix?
> config changed callback got fixed but this still didn't.
> 
Now my concern is whether or not the judgement (commit 4058cf08945c1) is reasonable.

Regards,
-Gonglei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
