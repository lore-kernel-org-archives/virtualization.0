Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E736AC433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 03:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78DDC40236;
	Thu,  5 May 2022 03:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PjPqLmtTtD7; Thu,  5 May 2022 03:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC9C34010E;
	Thu,  5 May 2022 03:14:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0A49C0039;
	Thu,  5 May 2022 03:14:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06500C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 03:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2D1F60AC9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 03:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eR2t9z0bfSgV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 03:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 538FE60AC3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 03:14:45 +0000 (UTC)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KtzLz6CNXzhYx9;
 Thu,  5 May 2022 11:14:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:14:41 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Thu, 5 May 2022 11:14:41 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Thread-Topic: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Thread-Index: AQHYV8hyMXkGqKxZB02P/aEBjf+Trq0PG9WAgACQlMA=
Date: Thu, 5 May 2022 03:14:40 +0000
Message-ID: <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
In-Reply-To: <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
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
> Sent: Thursday, May 5, 2022 10:35 AM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com;
> jasowang@redhat.com
> Cc: herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org;
> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org;
> helei.sig11@bytedance.com; davem@davemloft.net
> Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
> 
> Hi, Lei
> 
> Jason replied in another patch:
> Still hundreds of lines of changes, I'd leave this change to other maintainers to
> decide.
> 
> Quite frankly, the virtio crypto driver changed only a few in the past, and the
> performance of control queue is not good enough. I am in doubt about that this
> driver is not used widely. So I'd like to rework a lot, it would be best to complete
> this work in 5.18 window.
> 
> This gets different point with Jason. I would appreciate it if you could give me
> any hint.
> 

This is already in my todo list.

Regards,
-Gonglei

> On 4/24/22 18:41, zhenwei pi wrote:
> > Hi, Lei
> > I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
> >   and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c, then
> > the xx_core.c supports:
> >    - probe/remove/irq affinity seting for a virtio device
> >    - basic virtio related operations
> >
> > xx_common.c supports:
> >    - common helpers/functions for algos
> >
> > Do you have any suggestion about this?
> >
> > v3 -> v4:
> >   - Don't create new file virtio_common.c, the new functions are added
> >     into virtio_crypto_core.c
> >   - Split the first patch into two parts:
> >       1, change code style,
> >       2, use private buffer instead of shared buffer
> >   - Remove relevant change.
> >   - Other minor changes.
> >
> > v2 -> v3:
> >   - Jason suggested that spliting the first patch into two part:
> >       1, using private buffer
> >       2, remove the busy polling
> >     Rework as Jason's suggestion, this makes the smaller change in
> >     each one and clear.
> >
> > v1 -> v2:
> >   - Use kfree instead of kfree_sensitive for insensitive buffer.
> >   - Several coding style fix.
> >   - Use memory from current node, instead of memory close to device
> >   - Add more message in commit, also explain why removing per-device
> >     request buffer.
> >   - Add necessary comment in code to explain why using kzalloc to
> >     allocate struct virtio_crypto_ctrl_request.
> >
> > v1:
> > The main point of this series is to improve the performance for virtio
> > crypto:
> > - Use wait mechanism instead of busy polling for ctrl queue, this
> >    reduces CPU and lock racing, it's possiable to create/destroy session
> >    parallelly, QPS increases from ~40K/s to ~200K/s.
> > - Enable retry on crypto engine to improve performance for data queue,
> >    this allows the larger depth instead of 1.
> > - Fix dst data length in akcipher service.
> > - Other style fix.
> >
> > lei he (2):
> >    virtio-crypto: adjust dst_len at ops callback
> >    virtio-crypto: enable retry for virtio-crypto-dev
> >
> > zhenwei pi (3):
> >    virtio-crypto: change code style
> >    virtio-crypto: use private buffer for control request
> >    virtio-crypto: wait ctrl queue instead of busy polling
> >
> >   .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
> >   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
> >   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
> >   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
> >   4 files changed, 180 insertions(+), 119 deletions(-)
> >
> 
> --
> zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
