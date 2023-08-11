Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B338C001B0
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 19:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F29AF41EC6;
	Fri, 11 Aug 2023 19:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F29AF41EC6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zq3NimUc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AI13K7zgsT0j; Fri, 11 Aug 2023 19:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0BF6741ECA;
	Fri, 11 Aug 2023 19:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BF6741ECA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB038C0072;
	Fri, 11 Aug 2023 19:34:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 684B4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 19:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 426C1838B2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 19:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 426C1838B2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zq3NimUc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpTTds5dOzEL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 19:34:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 635958386E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 19:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 635958386E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691782475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4ViBLckjSjhNPhrCupJ24JN3joY3lkNEYQ4wLCKCu0=;
 b=Zq3NimUceEEtDBKz+FAD6OfFy7Jm3vGJebq3uJY8Q3E5k5oNW1MK4D6P0+YJEzuW6LaHBl
 7kNi1BYMDR5lQf/9Xi8iLp0IhP3GdjIL0/jYZAT7T/+kMMES/OM0IZt2rVGtEugt0BWgHA
 OAoQQzPEyonh+DNCvYcpY8ElN2HqRuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-Rl9t6dKwP9qAeaYIUQeYSA-1; Fri, 11 Aug 2023 15:34:28 -0400
X-MC-Unique: Rl9t6dKwP9qAeaYIUQeYSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FF685C6F4;
 Fri, 11 Aug 2023 19:34:23 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ACD11121314;
 Fri, 11 Aug 2023 19:34:20 +0000 (UTC)
Message-ID: <ec070d3b-80fb-b625-cde1-80ead49c6227@redhat.com>
Date: Fri, 11 Aug 2023 15:34:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V10 04/19] riscv: qspinlock: Add basic queued_spinlock
 support
Content-Language: en-US
To: guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
 paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
 catalin.marinas@arm.com, conor.dooley@microchip.com,
 xiaoguang.xing@sophgo.com, bjorn@rivosinc.com, alexghiti@rivosinc.com,
 keescook@chromium.org, greentime.hu@sifive.com, ajones@ventanamicro.com,
 jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-5-guoren@kernel.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20230802164701.192791-5-guoren@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


On 8/2/23 12:46, guoren@kernel.org wrote:
> 	\
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..c644a92d4548
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#define _Q_PENDING_LOOPS	(1 << 9)
> +#endif
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS

You can merge the two "#ifdef CONFIG_QUEUED_SPINLOCKS" into single one 
to avoid the duplication.

Cheers,
Longman

> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +#else
> +#include <asm-generic/spinlock.h>
> +#endif
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
