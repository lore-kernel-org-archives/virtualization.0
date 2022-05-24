Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 18:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D26B40C5E;
	Tue, 24 May 2022 18:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HrXnXV5Y2XZF; Tue, 24 May 2022 18:59:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D15240104;
	Tue, 24 May 2022 18:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5E90C0032;
	Tue, 24 May 2022 18:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 18:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33089415D2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 18:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FgDZLkHfgqn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 18:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B125F415CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653418754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/u3XlUG6KtQr1BQPpeDQC4OLmlAGTwSNLNWZkdYSkog=;
 b=YfICYk1DtlgD5jQRw+BhJIfe4ve8rvI87YHCO9ZkdHxoUqiWfo7t7BI1nCWNNGn8l3jBul
 pTOH0RV7onGljkYVZYO9ze2M7skLkS159PQb/yEfPrGfhjHhFjEdwC8q5i9rv/Vuwv17Cj
 8pnj7q51Y8wNYptFE3S1EGJMxJ9je80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-w1u2qDInMciRyxuwwSeKWA-1; Tue, 24 May 2022 14:59:13 -0400
X-MC-Unique: w1u2qDInMciRyxuwwSeKWA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o23-20020a05600c511700b0039743cd8093so1637652wms.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=/u3XlUG6KtQr1BQPpeDQC4OLmlAGTwSNLNWZkdYSkog=;
 b=yFodmkK/coiZmCzMXEMkvkYdhMMGuF7926BfRHpIlyIvcYj0EEOTN6gCD3G7Q5UqVE
 ut9Kp2VtLcY04nzYtpjN5xJ8KRTmcC5yHswenlAgU3G7448ULfMh37Is/7ZZLFvrW4A/
 oe5qgibb4OPhk1PX2bhEmTh87ctoc3MinVbIOWj/CBzymODhNpkGSaK+AdaMLmTb1puD
 mMwfaE4LsuQvgkVFG5pPoSDvpg3anEH40l4W4kICarb+WlefgOcvmfZDHNjKZrKIrGz6
 vhho/oYgo7OdOfOcdh6vcKPWrDT6ZDev7+b9AmoOZRNEOZcFEppnuqGxAbsCd11SNJS6
 /0pw==
X-Gm-Message-State: AOAM532S+R3ZVFjlQoKxknB2kON4enEEH5PBACKdWzNZvxHZ1mSoSoPs
 vIhHXpFGhnOKiJtDE4EYgijJaJVzV/3yM0L+HoNA/ie/ERYKWfBPnFUiv+k4J33zWQvjvIGkYT2
 Q7CYOegZmLOOEv2HB6mPgJ4QQ5yY47VcH75AdhfQDHQ==
X-Received: by 2002:adf:c80a:0:b0:20c:ffa0:6a3 with SMTP id
 d10-20020adfc80a000000b0020cffa006a3mr23572800wrh.360.1653418751820; 
 Tue, 24 May 2022 11:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGSz2pcp7eL3O58tziWOYGbUj4OEBI4+pd8yfPiv1mrR1trcb64B+iGECL8KJSWE+HJH27zw==
X-Received: by 2002:adf:c80a:0:b0:20c:ffa0:6a3 with SMTP id
 d10-20020adfc80a000000b0020cffa006a3mr23572784wrh.360.1653418751530; 
 Tue, 24 May 2022 11:59:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:5200:b78b:b654:3bbe:992?
 (p200300cbc70a5200b78bb6543bbe0992.dip0.t-ipconnect.de.
 [2003:cb:c70a:5200:b78b:b654:3bbe:992])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a056000014f00b0020e609dd274sm187544wrx.76.2022.05.24.11.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 11:59:10 -0700 (PDT)
Message-ID: <68a4a96b-9c66-6509-e75d-b1bea6cd55d1@redhat.com>
Date: Tue, 24 May 2022 20:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
To: zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
 naoya.horiguchi@nec.com, mst@redhat.com
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
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
> Hi,
> 
> I'm trying to recover hardware corrupted page by virtio balloon, the
> workflow of this feature like this:
> 
> Guest              5.MF -> 6.RVQ FE    10.Unpoison page
>                     /           \            /
> -------------------+-------------+----------+-----------
>                    |             |          |
>                 4.MCE        7.RVQ BE   9.RVQ Event
>  QEMU             /               \       /
>              3.SIGBUS              8.Remap
>                 /
> ----------------+------------------------------------
>                 |
>             +--2.MF
>  Host       /
>        1.HW error
> 
> 1, HardWare page error occurs randomly.
> 2, host side handles corrupted page by Memory Failure mechanism, sends
>    SIGBUS to the user process if early-kill is enabled.
> 3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
> 4, QEMU tries to inject MCE into guest.
> 5, guest handles memory failure again.
> 
> 1-5 is already supported for a long time, the next steps are supported
> in this patch(also related driver patch):
> 
> 6, guest balloon driver gets noticed of the corrupted PFN, and sends
>    request to host side by Recover VQ FrontEnd.
> 7, QEMU handles request from Recover VQ BackEnd, then:
> 8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
> 9, QEMU acks the guest side the result by Recover VQ.
> 10, guest unpoisons the page if the corrupted page gets recoverd
>     successfully.
> 
> Test:
> This patch set can be tested with QEMU(also in developing):
> https://github.com/pizhenwei/qemu/tree/balloon-recover
> 
> Emulate MCE by QEMU(guest RAM normal page only, hugepage is not supported):
> virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd 0x61646678 0x8c
> 
> The guest works fine(on Intel Platinum 8260):
>  mce: [Hardware Error]: Machine check events logged
>  Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
>  virtio_balloon virtio5: recovered pfn 0x61646
>  Unpoison: Unpoisoned page 0x61646 by virtio-balloon
>  MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010
> 
> And the 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.
> 
> About the protocol of virtio balloon recover VQ, it's undefined and in
> developing currently:
> - 'struct virtio_balloon_recover' defines the structure which is used to
>   exchange message between guest and host.
> - '__le32 corrupted_pages' in struct virtio_balloon_config is used in the next
>   step:
>   1, a VM uses RAM of 2M huge page, once a MCE occurs, the 2M becomes
>      unaccessible. Reporting 512 * 4K 'corrupted_pages' to the guest, the guest
>      has a chance to isolate the 512 pages ahead of time.
> 
>   2, after migrating to another host, the corrupted pages are actually recovered,
>      once the guest gets the 'corrupted_pages' with 0, then the guest could
>      unpoison all the poisoned pages which are recorded in the balloon driver.
> 

Hi,

I'm still on vacation this week, I'll try to have a look when I'm back
(and flushed out my overflowing inbox :D).


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
