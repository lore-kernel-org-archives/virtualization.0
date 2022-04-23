Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841B3C433F5
	for <virtualization@archiver.kernel.org>; Sat, 23 Apr 2022 15:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20248415CC;
	Sat, 23 Apr 2022 15:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVuLAU1Y3V1L; Sat, 23 Apr 2022 15:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 693EE415AF;
	Sat, 23 Apr 2022 15:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F50BC0039;
	Sat, 23 Apr 2022 15:55:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66F12C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 15:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D15B60A6D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 15:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=blackwall-org.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CQmpkxx6DgWv
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 15:55:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83F3860ACD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 15:55:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id g20so13792755edw.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=QnKErwSXat4qexxkmNgihC1z6Q4C1GOP8emnalj3zKY=;
 b=OQKqojjRu/6u2nGcFEzeCbF7WQb9pnrfzXoQLTFHY3iuQOBh4rLzAt+C8QvI7zj6DA
 NTG/CZybdXl4Y55ZPVjGogIBNN4gJn6vO3kCOsmgtZCaaTB9IEqZxVX+nTyH0U8dno87
 DYJ/FkS0l++SrLFuJZ8n4kXnu4fykqSFg3V9hUF9kw8CJl3UJkNu2ZC6zmS80Ry/8voK
 CnX5Czhm+1GPrfIXrWJaFqCHUapQ1fl7aNqyw8W82yDiyDpTcktu37FCp+iUDpkD6DZx
 dxbHKzQhUemRqGCi3DBtFIiexp2gTZHClgFbdm5vpMVJ0AU5/Rjf0ajdWhkwKTTkP2ZI
 KplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QnKErwSXat4qexxkmNgihC1z6Q4C1GOP8emnalj3zKY=;
 b=Jbgz44g+l7pLUJQZDnFpvy6ct8cFthl03YwuNL6gNCMgib8RGVmGX7n1IT3tCYQ0b9
 zIIYXLEA9pDLGPjPWcTbb79Hz5/Kh2cN4Nj/YyzF5gbo1XYAiL/LEM9cRXCWZV15Gqky
 u74zpNe/j8ul+S5OB+lmmLLxE3xQp+E3qpdYnRX44X+5/10s2VTDrnhv6KA+bjK4UUy7
 u82H7n8OXJf5KL0/Bkz1cS2/1+f/4Fp06VY1myKumV9lhZsTGIH4W5jhYBR7SyxyfNZ8
 0rGF+rD9WNKE72BpxmnKPrmCUTHeqKzEzuEQg+Kw0xIrrv6CGxFCEV6AG2zQvR4e3jKs
 /xcw==
X-Gm-Message-State: AOAM531pOPD/lH6Kg63J/fUQijV+p5lOn8ObtTBrSI9UlpdV7+JVM4Or
 3oUHnerXN+DBgdPwePqKfnc/qw==
X-Google-Smtp-Source: ABdhPJwGZhxtcU/CjjffaxobWl86iaqzRUjZp8xTahkgEnX3UO8k/6sfG2jNT3wExUAZ7uSST2P8Hw==
X-Received: by 2002:a05:6402:3587:b0:423:fcf6:e979 with SMTP id
 y7-20020a056402358700b00423fcf6e979mr10703888edc.137.1650729353673; 
 Sat, 23 Apr 2022 08:55:53 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
 by smtp.gmail.com with ESMTPSA id
 kx5-20020a170907774500b006e1382b8192sm1806933ejc.147.2022.04.23.08.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Apr 2022 08:55:53 -0700 (PDT)
Message-ID: <9e7db66d-8925-be38-c740-b7e3d21c2060@blackwall.org>
Date: Sat, 23 Apr 2022 18:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH net] virtio_net: fix wrong buf address calculation when
 using xdp
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220423112612.2292774-1-razor@blackwall.org>
 <1650720683.8168066-1-xuanzhuo@linux.alibaba.com>
 <8d511a16-8d69-82b1-48a1-24de3a592aef@blackwall.org>
 <a58bfd2c-4f83-11fe-08d1-19c1d6497fc2@blackwall.org>
 <1650724608.256497-2-xuanzhuo@linux.alibaba.com>
 <c206c147-ad7e-b615-2e96-572482335563@blackwall.org>
 <1650726113.2334588-1-xuanzhuo@linux.alibaba.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1650726113.2334588-1-xuanzhuo@linux.alibaba.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, davem@davemloft.net
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

On 23/04/2022 18:01, Xuan Zhuo wrote:
> On Sat, 23 Apr 2022 17:58:05 +0300, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 23/04/2022 17:36, Xuan Zhuo wrote:
>>> On Sat, 23 Apr 2022 17:30:11 +0300, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>> On 23/04/2022 17:16, Nikolay Aleksandrov wrote:
>>>>> On 23/04/2022 16:31, Xuan Zhuo wrote:
>>>>>> On Sat, 23 Apr 2022 14:26:12 +0300, Nikolay Aleksandrov <razor@blackwall.org> wrote:
[snip]                                   metasize,
>>>>>> -                                                      VIRTIO_XDP_HEADROOM);
>>>>>> +                                                      VIRTIO_XDP_HEADROOM - metazie);
>>>>>>                                 return head_skb;
>>>>>>                         }
>>>>>>                         break;
>>>>>
>>>>> That patch doesn't fix it, as I said with xdp you can move both data and data_meta.
>>>>> So just doing that would take care of the meta, but won't take care of moving data.
>>>>>
>>>>
>>>> Also it doesn't take care of the case where page_to_skb() is called with the original page
>>>> i.e. when we already have headroom, so we hit the next/standard page_to_skb() call (xdp_page == page).
>>>
>>> Yes, you are right.
>>>
>>>>
>>>> The above change guarantees that buf and p will be in the same page
>>>
>>>
>>> How can this be guaranteed?
>>>
>>> 1. For example, we applied for a 32k buffer first, and took away 1500 + hdr_len
>>>    from the allocation.
>>> 2. set xdp
>>> 3. alloc for new buffer
>>>
>>
>> p = page_address(page) + offset;
>> buf = p & PAGE_MASK; // whatever page p lands in is where buf is set
>>
>> => p and buf are always in the same page, no?
> 
> I don't think it is, it's entirely possible to split on two pages.
> 

Ahhh, I completely misinterpreted page_address(). You're right.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
