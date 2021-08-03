Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B2C432BE
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 15:30:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8249D61029
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 15:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8249D61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48CFA40324;
	Tue,  3 Aug 2021 15:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zf2l3JhhT3b; Tue,  3 Aug 2021 15:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C852940320;
	Tue,  3 Aug 2021 15:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C78FC001A;
	Tue,  3 Aug 2021 15:30:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 931D9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DB6D401BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYtmGbNr0jIJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC846400F2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628004647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5H/YzWjPRhpmEEex0YbOyxkXYC0ZJIajn0GIxKBlE=;
 b=UfeS02jikwWDo3EkV+EFMlnxI9iCmiMlRK19+5fuubAqKt6D8o/MsbUM0ihE506TMg3a4d
 qx7LJXzh0x2XhaY9RgXT0vbZ3nsWJ6qX7KbIDVQNq/tv0YdLUNW9WH9Fj9SmDdflwuVILQ
 1pUiyONkeKggrxXzAqUGwqCtIYtZOBU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-D1h9n7b4MF6QdVZaCMp_oQ-1; Tue, 03 Aug 2021 11:30:44 -0400
X-MC-Unique: D1h9n7b4MF6QdVZaCMp_oQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 n24-20020aa7c7980000b02903bb4e1d45aaso10613115eds.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 08:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ef5H/YzWjPRhpmEEex0YbOyxkXYC0ZJIajn0GIxKBlE=;
 b=Kb17yvSAB9tEzrStm6L9uBqmXmjueYae4HZgWM7vX+/B+OMUSw6KKi3gviRCbUZmmN
 6asV52q2GW7owZLhVedGsUDYZRBSw/r6xQnHgT+rjEHsGWlZb5ARC+1IOvu3McKKynB0
 By3MqrhcSWRi9d2dXtzZYS8qPunRxUu8l/fuV5Hz8UZ6QlW3dgT/AO/6LXFwChrQ4CJU
 n9pRvBcSxvbHiY7j+iSby+dONc+zCCeeT+tjpB3biSEcYzLzCx+CAXIoXfNBoqc6HhG/
 r8Vlunljo6z/SmTXA5ARpiWxkS1j+mj1MoR5DEGQ2lqP2pitwmvfav9z2QcRScG43xq9
 g3FA==
X-Gm-Message-State: AOAM533+8Q4FCFLvI77wNHEfn/dxconBcxwRMhY9ygRf3ZDgnFj7ppP6
 apPj9HcAGrkbnoB9b5OksE6Ldr9eyIh+uUeQL01HoI+9D9mQ76LNGJbpdagVwUZZzXpb0SWDW0q
 7j50fFettNNmBotCS8gz+IU5Niy2F2f+g0537UioHww==
X-Received: by 2002:a17:906:1da1:: with SMTP id
 u1mr20660421ejh.307.1628004643333; 
 Tue, 03 Aug 2021 08:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf6rV1ZatT2GQ6a3+XcXIUCr6rut+vBVs6RfI7E2ACDBMkrHwlwXE3OZTZ7a4m4dn8RViNBQ==
X-Received: by 2002:a17:906:1da1:: with SMTP id
 u1mr20660382ejh.307.1628004643075; 
 Tue, 03 Aug 2021 08:30:43 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id b17sm4094598edd.27.2021.08.03.08.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 08:30:42 -0700 (PDT)
Subject: Re: [PATCH 00/38] Replace deprecated CPU-hotplug
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20210803141621.780504-1-bigeasy@linutronix.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <83dc5dfd-1ed0-f428-826f-fb819911fc89@redhat.com>
Date: Tue, 3 Aug 2021 17:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
 linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
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

Hi Sebastien,

On 8/3/21 4:15 PM, Sebastian Andrzej Siewior wrote:
> This is a tree wide replacement of the deprecated CPU hotplug functions
> which are only wrappers around the actual functions.
> 
> Each patch is independent and can be picked up by the relevant maintainer.

Ok; and I take it that then also is the plan for merging these ?

FWIW I'm fine with the drivers/platform/x86 patch going upstream
through some other tree if its easier to keep the set together ...

Regards,

Hans



> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: cgroups@vger.kernel.org
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: coresight@lists.linaro.org
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joe Lawrence <joe.lawrence@redhat.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Julian Wiedmann <jwi@linux.ibm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Karol Herbst <karolherbst@gmail.com>
> Cc: Karsten Graul <kgraul@linux.ibm.com>
> Cc: kvm-ppc@vger.kernel.org
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-raid@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: live-patching@vger.kernel.org
> Cc: Mark Gross <mgross@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: nouveau@lists.freedesktop.org
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: rcu@vger.kernel.org
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> Cc: x86@kernel.org
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> 
> Sebastian
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
