Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9224C433EF
	for <virtualization@archiver.kernel.org>; Sun, 17 Apr 2022 13:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6830541D22;
	Sun, 17 Apr 2022 13:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQwbk7HK8IN4; Sun, 17 Apr 2022 13:27:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD08541D0F;
	Sun, 17 Apr 2022 13:27:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9651CC0033;
	Sun, 17 Apr 2022 13:27:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DCC9C002C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 13:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04E1E60E42
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 13:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jVjuu12Npdyf
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 13:27:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DDC661001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 13:27:07 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-nF3cRDBxPKCZQGK-HhuPow-1; Sun, 17 Apr 2022 14:27:03 +0100
X-MC-Unique: nF3cRDBxPKCZQGK-HhuPow-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sun, 17 Apr 2022 14:27:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sun, 17 Apr 2022 14:27:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Peter Zijlstra' <peterz@infradead.org>, Christophe de Dinechin
 <dinechin@redhat.com>
Subject: RE: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Thread-Topic: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Thread-Index: AQHYUBibLip3vnTtMkGRChiOLjIGKKz0GpLA
Date: Sun, 17 Apr 2022 13:27:00 +0000
Message-ID: <13a0f55340174900b36caa90920d942a@AcuMS.aculab.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
In-Reply-To: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
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
Cc: Juri
 Lelli <juri.lelli@redhat.com>, "trivial@kernel.org" <trivial@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

From: Peter Zijlstra
> Sent: 14 April 2022 16:21
...
> <snip tons of noise>
> 
..
> > -#define sched_class_highest (__end_sched_classes - 1)
> > +/*
> > + * sched_class_highests is really __end_sched_classes - 1, but written in a way
> > + * that makes it clear that it is within __begin_sched_classes[] and not outside
> > + * of __end_sched_classes[].
> > + */
> > +#define sched_class_highest (__begin_sched_classes + \
> > +			     (__end_sched_classes - __begin_sched_classes - 1))
> >  #define sched_class_lowest  (__begin_sched_classes - 1)
> >
> > +/* The + 1 below places the pointers within the range of their array */
> >  #define for_class_range(class, _from, _to) \
> > -	for (class = (_from); class != (_to); class--)
> > +	for (class = (_from); class + 1 != (_to) + 1; class--)

That is still technically broken because you are still calculating
the address of array[-1] - even though it is probably optimised out.

> Urgh, so now we get less readable code, just because GCC is being
> stupid?
> 
> What's wrong with negative array indexes? memory is memory, stuff works.

Consider segmented x86 where malloc() always returns {segment:0..segment:size).
Pointer arithmetic will only change the offset.
So &array[-1] is likely to be greater than &array[0].
So it has never been valid C to create pointers to before a data item.

OTOH I've NFI why gcc and clang have started generating warnings for
portability issues that really don't affect mainstream systems.

I'm just waiting for them to warn about memset(p, 0 sizeof *p) when
the structure contains pointers - because the NULL pointer doesn't
have to be the all-zero bit pattern.
The only reason (int)&(struct foo *)0->member is non-portable is because
NULL might not be 0.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
