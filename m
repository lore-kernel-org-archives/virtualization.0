Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FFC43214
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 16:10:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AF66112E
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 16:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95AF66112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68FF382E9C;
	Tue,  3 Aug 2021 16:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U08SUTOiLLBk; Tue,  3 Aug 2021 16:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00D5283300;
	Tue,  3 Aug 2021 16:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5541C001A;
	Tue,  3 Aug 2021 16:10:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62047C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 436806078E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="LwdXqV6T";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="CjGblo5J"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCf0urvg_uyX
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9321C60658
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:10:40 +0000 (UTC)
Date: Tue, 3 Aug 2021 18:10:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1628007036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhCR89X1oG7iNKpxBHqwK160maOrSQVKgeomxdN0wRc=;
 b=LwdXqV6TEL+jelWYIVu/L1AwkukJUhfDeR6fxf6HaCffMyf5pGalG64DdzD6SrFbnK74/x
 PVNjb7a8JiALCQD3CJBVmxfKVnGPRCXtU70BUFy11admR5LtOLT9dQeI/ENtXdJ/CkhTdc
 pZNvsYTpT+QPzjRhgzvNT0CjgoFJhxwmycapteSubpDkPSBjZ+FP8bxnvUSWW30Gz0Y7dW
 1ffy1Rr5tDaLDwQ1cWTtCeME4yw92tE3YUaDago5Lw9pEtw1H1L8au8do+a32W2/sN3gs0
 btcFKclunpFVufnMA6+fMpSDPoeRfMtyi+RFwzALyjj/jtaWzgKiRMXG8gO4tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1628007036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhCR89X1oG7iNKpxBHqwK160maOrSQVKgeomxdN0wRc=;
 b=CjGblo5JavDHAEsakSWenCqJ60bnDYFeC+TGn7n/YdarB5rRq+iJbcWjrVSzA5F0n0kDM4
 Vc1wmHGVCRR8DGCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/38] Replace deprecated CPU-hotplug
Message-ID: <20210803161033.vp3o34meyw3ek43z@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <83dc5dfd-1ed0-f428-826f-fb819911fc89@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83dc5dfd-1ed0-f428-826f-fb819911fc89@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ben Segall <bsegall@google.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-acpi@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
 Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Pekka Paalanen <ppaalanen@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 tglx@linutronix.de, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karol Herbst <karolherbst@gmail.com>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>,
 linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Julian Wiedmann <jwi@linux.ibm.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Len Brown <lenb@kernel.org>,
 Mike Travis <mike.travis@hpe.com>, coresight@lists.linaro.org,
 kvm-ppc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Amit Kucheria <amitk@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 platform-driver-x86@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 Mark Gross <mgross@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jiri Kosina <jikos@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-hwmon@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Jiri Olsa <jolsa@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-raid@vger.kernel.org,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-edac@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org,
 Leo Yan <leo.yan@linaro.org>, Borislav Petkov <bp@alien8.de>,
 linuxppc-dev@lists.ozlabs.org, Karsten Graul <kgraul@linux.ibm.com>
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

On 2021-08-03 17:30:40 [+0200], Hans de Goede wrote:
> Hi Sebastien,
Hi Hans,

> On 8/3/21 4:15 PM, Sebastian Andrzej Siewior wrote:
> > This is a tree wide replacement of the deprecated CPU hotplug functions
> > which are only wrappers around the actual functions.
> > 
> > Each patch is independent and can be picked up by the relevant maintainer.
> 
> Ok; and I take it that then also is the plan for merging these ?
> 
> FWIW I'm fine with the drivers/platform/x86 patch going upstream
> through some other tree if its easier to keep the set together ...

There is no need to keep that set together since each patch is
independent. Please merge it through your tree.

> Regards,
> 
> Hans

Sebastian
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
