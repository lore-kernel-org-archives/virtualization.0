Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E556FEE57DF
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 15:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D96A416F8;
	Mon, 11 Sep 2023 15:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D96A416F8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSn02oZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pueZDApBCpDx; Mon, 11 Sep 2023 15:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92BB441527;
	Mon, 11 Sep 2023 15:22:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92BB441527
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 691C1C0071;
	Mon, 11 Sep 2023 15:22:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B47AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 15:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E684E81E60
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 15:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E684E81E60
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSn02oZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmXrkEcB5rDU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 15:22:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A35E81341
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 15:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A35E81341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694445745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6+UTvfQcsvDPdhGXSi2AAvjsiLi7Cpcaa64YOiSPW8=;
 b=ZSn02oZqfCrXtbm5EJ1KsZV+OVYS6tiewgF/BTV11oDKNEmxiBfCOllFMg5TlqsvBF3mJK
 9ZCoL1P+CaFgIv9XJSkQHjFnifsV4x3gOHwjtmC9tPTskPcy+qSPujyh61uLFFztGN0ACO
 qDMuCE0Sg4sKI9PBq7M2ioJhVFlcpIg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-lqKOgAgdOfK27hptzaDxOw-1; Mon, 11 Sep 2023 11:22:20 -0400
X-MC-Unique: lqKOgAgdOfK27hptzaDxOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79C873C1ACE8;
 Mon, 11 Sep 2023 15:22:18 +0000 (UTC)
Received: from [10.22.32.237] (unknown [10.22.32.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB4040C200B;
 Mon, 11 Sep 2023 15:22:16 +0000 (UTC)
Message-ID: <11f2a7a5-5219-a46e-5d16-4bdd400f5d9b@redhat.com>
Date: Mon, 11 Sep 2023 11:22:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for
 command line
Content-Language: en-US
To: guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
 paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
 catalin.marinas@arm.com, conor.dooley@microchip.com,
 xiaoguang.xing@sophgo.com, bjorn@rivosinc.com, alexghiti@rivosinc.com,
 keescook@chromium.org, greentime.hu@sifive.com, ajones@ventanamicro.com,
 jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
 leobras@redhat.com
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-8-guoren@kernel.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20230910082911.3378782-8-guoren@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-csky@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-riscv@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 9/10/23 04:29, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Allow cmdline to force the kernel to use queued_spinlock when
> CONFIG_RISCV_COMBO_SPINLOCKS=y.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  2 ++
>   arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7dfb540c4f6c..61cacb8dfd0e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4693,6 +4693,8 @@
>   			[KNL] Number of legacy pty's. Overwrites compiled-in
>   			default number.
>   
> +	qspinlock	[RISCV] Force to use qspinlock or auto-detect spinlock.
> +
>   	qspinlock.numa_spinlock_threshold_ns=	[NUMA, PV_OPS]
>   			Set the time threshold in nanoseconds for the
>   			number of intra-node lock hand-offs before the

Your patch series is still based on top of numa-aware qspinlock patchset 
which isn't upstream yet. Please rebase it without that as that will 
cause merge conflict during upstream merge.

Cheers,
Longman

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
