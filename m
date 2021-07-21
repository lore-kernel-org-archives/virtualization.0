Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A02DC6377B
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 20:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE1360FEA
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 20:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1360FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CAF840521;
	Wed, 21 Jul 2021 20:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQSJXk49Esgs; Wed, 21 Jul 2021 20:53:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33E1A403B8;
	Wed, 21 Jul 2021 20:53:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC2CC0010;
	Wed, 21 Jul 2021 20:53:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82462C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A659403B2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6pDKHZU4Rcs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:53:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 973F14012B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:53:35 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-243-8fs3cIPQN2uXPNUECXN4gA-1; Wed, 21 Jul 2021 21:53:31 +0100
X-MC-Unique: 8fs3cIPQN2uXPNUECXN4gA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 21 Jul 2021 21:53:30 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 21 Jul 2021 21:53:30 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yunsheng Lin' <linyunsheng@huawei.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 3/4] tools headers UAPI: add cpu_relax() implementation
 for x86 and arm64
Thread-Topic: [PATCH v2 3/4] tools headers UAPI: add cpu_relax()
 implementation for x86 and arm64
Thread-Index: AQHXfQ/RMbMxcgsnGkW4/hrjrWfzM6tN6faQ
Date: Wed, 21 Jul 2021 20:53:29 +0000
Message-ID: <5db490c6f264431e91bcdbb62fcf3be5@AcuMS.aculab.com>
References: <1626747709-34013-1-git-send-email-linyunsheng@huawei.com>
 <1626747709-34013-4-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1626747709-34013-4-git-send-email-linyunsheng@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Cc: "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "deanbo422@gmail.com" <deanbo422@gmail.com>,
 "nickhu@andestech.com" <nickhu@andestech.com>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "joe@perches.com" <joe@perches.com>,
 "ndesaulniers@gooogle.com" <ndesaulniers@gooogle.com>,
 "green.hu@gmail.com" <green.hu@gmail.com>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
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

From: Yunsheng Lin
> Sent: 20 July 2021 03:22
> 
> As x86 and arm64 is the two available systems that I can build
> and test the cpu_relax() implementation, so only add cpu_relax()
> implementation for x86 and arm64, other arches can be added easily
> when needed.
> 
...
> +#if defined(__i386__) || defined(__x86_64__)
> +/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
> +static __always_inline void rep_nop(void)
> +{
> +	asm volatile("rep; nop" ::: "memory");
> +}

Beware, Intel increased the stall for 'rep nop' in some recent
cpu to IIRC about 200 cycles.

They even document that this might have a detrimental effect.
It is basically far too long for the sort of thing it makes
sense to busy-wait for.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
