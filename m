Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2085BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 20:21:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A976101A
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 20:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1A976101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EE8C61B98;
	Fri, 10 Sep 2021 20:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTdoCXjEYAKR; Fri, 10 Sep 2021 20:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EF39E61B93;
	Fri, 10 Sep 2021 20:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB105C000F;
	Fri, 10 Sep 2021 20:21:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E8EC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 20:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1A0541581
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 20:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bq5RApoorM3g
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 20:20:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64EB841580
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 20:20:58 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id y128so4610379oie.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 13:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4IPxaQoHLBsI4TsWZBSz429Jh2IPs4Tsu9wpBitBgng=;
 b=T3nsosBj2PSAuFamg7YVG4be9TaX9592+WoxknDZXIQMm5eUsCG8eGoVUL4+anBT1C
 tRoee2Pxs6kkyGWlXNncisiglNFYwRyWqDAFoPVHH8PBTLReFxh8a9xUtwycqB0A7OFE
 lq9nnshU2H++3Up8gQTA/Fv9sjU5OZLCZ5Fyb+c2s6RLehpWm6GKj7jwC63R9FWaeSv8
 cKr4R9Xq5+WaSyEqPKhRzia6lY9Oskk83R3ShFGntVt6qxwdrUbXyTxTuT5UgGwiioyS
 gHLWYjInlAPJb19rgKzF1MFJRbfmS8BIXIHLkj8EM4tG3A+cGp4vVeGjAelbaPYUSEFR
 MYVQ==
X-Gm-Message-State: AOAM530AGKn8jVBKa66+jIlOHbUUx+MPN+uVF9gcsLK53wU4LhCQK4z5
 7i5RZAUEX/cl8OYYNcsNnw==
X-Google-Smtp-Source: ABdhPJz5SQZueBteIwX5jHufIZZ/JozLZUCT7O2iJGriI7vlauYxJk6NPj/twUv+QLH5Q4gVPTAZyQ==
X-Received: by 2002:a05:6808:aa8:: with SMTP id
 r8mr5746125oij.171.1631305258063; 
 Fri, 10 Sep 2021 13:20:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id s24sm1483439otp.37.2021.09.10.13.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Sep 2021 13:20:57 -0700 (PDT)
Received: (nullmailer pid 3226408 invoked by uid 1000);
 Fri, 10 Sep 2021 20:20:55 -0000
Date: Fri, 10 Sep 2021 15:20:55 -0500
From: Rob Herring <robh@kernel.org>
To: Keith Packard <keithpac@amazon.com>
Subject: Re: [PATCH v4 4/7] Make sure task_struct is available for
 raw_smp_processor_id
Message-ID: <YTu+JyNyQH7v+1Yx@robh.at.kernel.org>
References: <id:20210907220038.91021-1-keithpac@amazon.com>
 <20210908190605.419064-1-keithpac@amazon.com>
 <20210908190605.419064-5-keithpac@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210908190605.419064-5-keithpac@amazon.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Song Liu <songliubraving@fb.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Ben Segall <bsegall@google.com>,
 linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>,
 Russell King <linux@armlinux.org.uk>, Christoph Lameter <cl@linux.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, YiFei Zhu <yifeifz2@illinois.edu>,
 Abbott Liu <liuwenliang@huawei.com>, Manivannan Sadhasivam <mani@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Nick Desaulniers <ndesaulniers@gooogle.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Miguel Ojeda <ojeda@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>,
 "Wolfram Sang \(Renesas\)" <wsa+renesas@sang-engineering.com>,
 Steven Rostedt <rostedt@goodmis.org>, KP Singh <kpsingh@kernel.org>,
 Tejun Heo <tj@kernel.org>, Yonghong Song <yhs@fb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Nicolas Pitre <nico@fluxnic.net>, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Valentin Schneider <valentin.schneider@arm.com>, Marc Zyngier <maz@kernel.org>,
 Joe Perches <joe@perches.com>, bpf@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Martin KaFai Lau <kafai@fb.com>, Mike Rapoport <rppt@kernel.org>
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

On Wed, Sep 08, 2021 at 12:06:02PM -0700, Keith Packard wrote:
> To allow architectures to use the 'cpu' field in task_struct for cpu
> identification, the task_struct must be visible whereever the
> raw_smp_processor_id macro is used. It would be simplest to include
> linux/sched.h from the relevant asm/smp.h file, but that file is
> included from linux/sched.h, and the recursive include ends up with
> several declarations in the wrong order.
> 
> To avoid this, the PowerPC architecture code has this ugly hack:
> 
> 	#define raw_smp_processor_id() \
> 		(*(unsigned int *)((void *)current + _TASK_CPU))
> 
> As an alternative, placing includes of linux/sched.h in a few files
> that are used along with asm/smp.h means we can use the task_struct
> field directly.
> 
> Signed-off-by: Keith Packard <keithpac@amazon.com>
> ---
>  arch/arm/mm/proc-v7-bugs.c     | 1 +
>  drivers/vhost/vhost.c          | 1 +
>  drivers/vhost/vhost.h          | 1 +
>  include/asm-generic/irq_regs.h | 1 +
>  include/linux/of_address.h     | 1 +

Where does the DT code use raw_smp_processor_id()? The header itself 
certainly doesn't and the headers should only include what the headers 
use directly.

In general this seems pretty terrible pulling in all of sched.h (and 
then everything else it includes) for just raw_smp_processor_id().

>  include/linux/random.h         | 1 +
>  include/linux/topology.h       | 1 +
>  init/calibrate.c               | 1 +
>  kernel/bpf/bpf_lru_list.h      | 1 +
>  kernel/bpf/percpu_freelist.h   | 1 +
>  kernel/sched/cpuacct.c         | 2 +-
>  lib/irq_regs.c                 | 1 +
>  12 files changed, 12 insertions(+), 1 deletion(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
