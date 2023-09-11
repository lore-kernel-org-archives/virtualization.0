Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E84C71153
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 02:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE55C40916;
	Mon, 11 Sep 2023 02:35:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE55C40916
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIBNWNnA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fiSRrsn24i9n; Mon, 11 Sep 2023 02:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2128D40936;
	Mon, 11 Sep 2023 02:35:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2128D40936
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D145DC0071;
	Mon, 11 Sep 2023 02:35:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F275C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 02:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62B7060BA7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 02:35:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62B7060BA7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIBNWNnA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AI-3R35qu2DU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 02:35:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7578A60B9D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 02:35:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7578A60B9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694399728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JiEAacOPpZr8Csa8+TL/orlrtaJ6UeA2+KsyYOTzfY=;
 b=QIBNWNnA1n7jZoHWDBjgr3TvyqYbK4HZX15ezec6M4AsgjfmziNaxjF4M4za1LrN0pnS8W
 Sedb/SAd/u0jn41O8NXveRGfqqX4uOUrmTBWRhzG0iEfDbgVsuFYls5O+huKM0ODZ/4eNw
 +26WPMf5lBHKyqC8bYPyWcqejgijHN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-azuA0cncMTqSkMKdZMqhhg-1; Sun, 10 Sep 2023 22:35:22 -0400
X-MC-Unique: azuA0cncMTqSkMKdZMqhhg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90084101FAA8;
 Mon, 11 Sep 2023 02:35:21 +0000 (UTC)
Received: from [10.22.8.52] (unknown [10.22.8.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5531549310E;
 Mon, 11 Sep 2023 02:35:19 +0000 (UTC)
Message-ID: <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
Date: Sun, 10 Sep 2023 22:35:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
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
 <20230910082911.3378782-5-guoren@kernel.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20230910082911.3378782-5-guoren@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


On 9/10/23 04:28, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The target of xchg_tail is to write the tail to the lock value, so
> adding prefetchw could help the next cmpxchg step, which may
> decrease the cmpxchg retry loops of xchg_tail. Some processors may
> utilize this feature to give a forward guarantee, e.g., RISC-V
> XuanTie processors would block the snoop channel & irq for several
> cycles when prefetch.w instruction (from Zicbop extension) retired,
> which guarantees the next cmpxchg succeeds.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   kernel/locking/qspinlock.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index d3f99060b60f..96b54e2ade86 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>    */
>   static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>   {
> -	u32 old, new, val = atomic_read(&lock->val);
> +	u32 old, new, val;
> +
> +	prefetchw(&lock->val);
> +	val = atomic_read(&lock->val);
>   
>   	for (;;) {
>   		new = (val & _Q_LOCKED_PENDING_MASK) | tail;

That looks a bit weird. You pre-fetch and then immediately read it. How 
much performance gain you get by this change alone?

Maybe you can define an arch specific primitive that default back to 
atomic_read() if not defined.

Cheers,
Longman

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
