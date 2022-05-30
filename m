Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 06:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4626360EAB;
	Mon, 30 May 2022 06:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOfuZM4Flcvc; Mon, 30 May 2022 06:50:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A7EF60A46;
	Mon, 30 May 2022 06:50:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE83C0039;
	Mon, 30 May 2022 06:50:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8188FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 06:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 693D040201
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 06:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DySxgPKXAxQG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 06:50:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 280A5400A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 06:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653893407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA2EU1n3m5GYJZ5id1x49ev2OO8TYlhuVqKxXwmud78=;
 b=IgGkK0ecqimBOujE7ZJC/lRCZIFpcD2oVG7v1c67AE6/u0Lmx0gsq+S7wveBqq8S0kNgNt
 3YgR+k4E4BLq7AvAuKKL4SqiPhAzSRpV/c44u7CertaFlBUG66SWe1FExby363DOknSTLP
 qHXeHIDIwQWWJ/UT3UWsqvk3wRxj/oA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-88tGh5GcNpGG_d1jAB2LKg-1; Mon, 30 May 2022 02:50:06 -0400
X-MC-Unique: 88tGh5GcNpGG_d1jAB2LKg-1
Received: by mail-wr1-f70.google.com with SMTP id
 t8-20020adff048000000b002102a5877d5so382579wro.21
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 May 2022 23:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=OA2EU1n3m5GYJZ5id1x49ev2OO8TYlhuVqKxXwmud78=;
 b=QS8DR7a/0knmSPH1d68342NbPBzUdq779rOd3Hd3lMRN8i+kBSt4XA3itY5dmZ5CHW
 Sr7GLHYjlfit+TCD3Dse4RSAEPW1mQX7vbu4FGdS8R5AzPRk+eUfKfSfXEYUN0ZW1kpA
 P10uB/ZX3qx9bC0zq5n2025JXeJ8jeui2JNZVF7xtgfoULquCbM2kJDBJGUuJvACsIyJ
 hGhlpgdPYjd3Gx6uJWL0pZ+CiGv+zCkhmvQsIjuKoT25e3pS4VVsQt/AphhbzKCOKn14
 Cz1IQd67vA11ShJpkOWMZ5U5CmK+FWkxXfpWgSUPP2D50ctJ2Ldp4Fg+d6dwY+vT5ii6
 2SSw==
X-Gm-Message-State: AOAM532OdP9Jr/YXbY1JmCW3790SucO4DESrXh5kFMo0exICetOZbe+z
 VgGmOj6XrCkiMoQ+HA/M1sdDcYoWG9CfGS14VZi6m22nBKs/OHV2k/Eb7TdMzCmSlS4V9SwGlze
 0UW2ma9WjepJbd17cjuuxAlKxCWdxNZ+ZIJUBrFB6ZQ==
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id
 h10-20020adf9cca000000b002102f7693femr4575105wre.12.1653893403106; 
 Sun, 29 May 2022 23:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ4OTL2ca2wmWyNO4crgHpqC/B3lDmwhG91OltBGji82xyGj9aMMNAtDCPwYTN03OTbIPtxw==
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id
 h10-20020adf9cca000000b002102f7693femr4575084wre.12.1653893402877; 
 Sun, 29 May 2022 23:50:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736?
 (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de.
 [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a5d64a5000000b0020c5253d8casm9032773wrp.22.2022.05.29.23.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 May 2022 23:50:02 -0700 (PDT)
Message-ID: <2d742b58-efd2-9a74-0af6-68948a06bfe8@redhat.com>
Date: Mon, 30 May 2022 08:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
 naoya.horiguchi@nec.com, mst@redhat.com
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-3-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/3] mm/memory-failure.c: support reset PTE during unpoison
In-Reply-To: <20220520070648.1794132-3-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 pbonzini@redhat.com
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

On 20.05.22 09:06, zhenwei pi wrote:
> Origianlly, unpoison_memory() is only used by hwpoison-inject, and
> unpoisons a page which is poisoned by hwpoison-inject too. The kernel PTE
> entry has no change during software poison/unpoison.
> 
> On a virtualization platform, it's possible to fix hardware corrupted page
> by hypervisor, typically the hypervisor remaps the error HVA(host virtual
> address). So add a new parameter 'const char *reason' to show the reason
> called by.
> 
> Once the corrupted page gets fixed, the guest kernel needs put page to
> buddy. Reuse the page and hit the following issue(Intel Platinum 8260):
>  BUG: unable to handle page fault for address: ffff888061646000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 2c01067 P4D 2c01067 PUD 61aaa063 PMD 10089b063 PTE 800fffff9e9b9062
>  Oops: 0002 [#1] PREEMPT SMP NOPTI
>  CPU: 2 PID: 31106 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0-rc6.bm.1-amd64 #6
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:clear_page_erms+0x7/0x10
> 
> The kernel PTE entry of the fixed page is still uncorrected, kernel hits
> page fault during prep_new_page. So add 'bool reset_kpte' to get a change
> to fix the PTE entry if the page is fixed by hypervisor.

Why don't we want to do that for the hwpoison case?

> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/linux/mm.h   |  2 +-
>  mm/hwpoison-inject.c |  2 +-
>  mm/memory-failure.c  | 26 +++++++++++++++++++-------
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 665873c2788c..7ba210e86401 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3191,7 +3191,7 @@ enum mf_flags {
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> -extern int unpoison_memory(unsigned long pfn);
> +extern int unpoison_memory(unsigned long pfn, bool reset_kpte, const char *reason);
>  extern int sysctl_memory_failure_early_kill;
>  extern int sysctl_memory_failure_recovery;
>  extern void shake_page(struct page *p);
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 5c0cddd81505..0dd17ba98ade 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -57,7 +57,7 @@ static int hwpoison_unpoison(void *data, u64 val)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	return unpoison_memory(val);
> +	return unpoison_memory(val, false, "hwpoison-inject");

s/hwpoison-inject/hwpoison/

or maybe

s/hwpoison-inject/debugfs/

>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 95c218bb0a37..a46de3be1dd7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2132,21 +2132,26 @@ core_initcall(memory_failure_init);
>  /**
>   * unpoison_memory - Unpoison a previously poisoned page
>   * @pfn: Page number of the to be unpoisoned page
> + * @reset_kpte: Reset the PTE entry for kmap
> + * @reason: The callers tells why unpoisoning the page
>   *
> - * Software-unpoison a page that has been poisoned by
> - * memory_failure() earlier.
> + * Unpoison a page that has been poisoned by memory_failure() earlier.
>   *
> - * This is only done on the software-level, so it only works
> - * for linux injected failures, not real hardware failures
> + * For linux injected failures, there is no need to reset PTE entry.
> + * It's possible to fix hardware memory failure on a virtualization platform,
> + * once hypervisor fixes the failure, guest needs put page back to buddy and
> + * reset the PTE entry in kernel.

Why can't we do this unconditionally? Just check if the PTE is poisoned,
and if so, reset it.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
