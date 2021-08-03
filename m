Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818ECC4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 14:16:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E38060F58
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 14:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E38060F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0E98402CA;
	Tue,  3 Aug 2021 14:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JzGJcH_7SZvj; Tue,  3 Aug 2021 14:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76D1E402D1;
	Tue,  3 Aug 2021 14:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590A3C0010;
	Tue,  3 Aug 2021 14:16:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 992ACC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 14:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86AFE402D1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 14:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OiPpdku9fY9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 14:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF460402CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 14:16:37 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1628000193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qkfc7lxCqn4p3B20wjfjiLsyLpuZIa2kIlbDitBY8sw=;
 b=fStBYY9cDOofnMkMc6JUcZVYcNWx/eg2N05Pb/o7ef6JJTcTG48t+GioJgBl+eXKMJGEgi
 TVCeDR+EwHJjgdulnpLwVy12sseYnaixefw5o14vk+2PAOm/LUlJHLssIOZ+nJyuRxaM3r
 fCCG5ZeBAdz/Q3kIzOJQstWW7ST+mFehWQwEJk+hKZizcoepZD/zOgz+f7GO7oZ2MtK2DY
 wm7slubFVtLqvtY6o7cEl9ZIw3mvJ35go7HuaiPxyi+ESejsT+e0qaP6D0Fis4EUqsKcRu
 JGNGT0BYA9PAUGHVfsb3cVOtZwFCr59O6V6ObVy+T4OF395mknhLgwpLJFiGUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1628000193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qkfc7lxCqn4p3B20wjfjiLsyLpuZIa2kIlbDitBY8sw=;
 b=pGmFmcj1u+vX59p9gWCClfCslb9a1WxY2Pwa8q+HwkfzdAY6X/r9JgYaxIXaCJOpPNDW2W
 rceMZSe2cSwuwVDA==
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/38] Replace deprecated CPU-hotplug
Date: Tue,  3 Aug 2021 16:15:43 +0200
Message-Id: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ben Segall <bsegall@google.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org,
 Mel Gorman <mgorman@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
 Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Pekka Paalanen <ppaalanen@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 tglx@linutronix.de, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karol Herbst <karolherbst@gmail.com>,
 linux-crypto@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>,
 Zefan Li <lizefan.x@bytedance.com>, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Julian Wiedmann <jwi@linux.ibm.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Len Brown <lenb@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Travis <mike.travis@hpe.com>, coresight@lists.linaro.org,
 kvm-ppc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Robin Holt <robinmholt@gmail.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Amit Kucheria <amitk@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 platform-driver-x86@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
 Joel Fernandes <joel@joelfernandes.org>, Mark Gross <mgross@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jiri Kosina <jikos@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-hwmon@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Stuart Hayes <stuart.w.hayes@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Len Brown <len.brown@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, Jiri Olsa <jolsa@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Mike Leach <mike.leach@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-raid@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-edac@vger.kernel.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org,
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

This is a tree wide replacement of the deprecated CPU hotplug functions
which are only wrappers around the actual functions.

Each patch is independent and can be picked up by the relevant maintainer.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: cgroups@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: coresight@lists.linaro.org
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Julian Wiedmann <jwi@linux.ibm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>
Cc: kvm-ppc@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-raid@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: live-patching@vger.kernel.org
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: netdev@vger.kernel.org
Cc: nouveau@lists.freedesktop.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rcu@vger.kernel.org
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Zhang Rui <rui.zhang@intel.com>

Sebastian

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
