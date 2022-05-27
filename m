Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A36C433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 06:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93DB1404FD;
	Fri, 27 May 2022 06:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WvguaWHH886C; Fri, 27 May 2022 06:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29ABC40470;
	Fri, 27 May 2022 06:36:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E77EBC0032;
	Fri, 27 May 2022 06:36:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21B17C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F32E4846B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edZBrP4X9eZl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:36:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B875846AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:36:54 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id i1so3351909plg.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=SuokLXZBT769hHza25K/JKzYPz4okNLCTIvug/IPsOQ=;
 b=w/Dtt17bexhMQfEO6bZdS8g76rcXfd1fCxzoZiPupXvbG6D1PCjYICkTcZoXMchs33
 XwQDdljexH8C7HWpuWkcd0aabZDZmfOs37/pSWL2o/Ma2ckuRkSN4tVLxE3BGT8SjmmZ
 /JHpZM9duuHTTZ/hqxVnt4BMWzchBWwfjfx1TZXxxn3s7cEvgS8S/aWR+aakyvAW8LGi
 BUHH0av/nN3KGi26NcaMjBdfZ6bmAo2QAxjbYMkVFw675/L/X8gkdLIELP7ZP9Myzhz7
 vQ/X1Rz9UX2xuO+xfYfn6QqA/MsysGxlfvyPQco5aSoo19c6jl7B2GTMxIfcgqs9i2YR
 xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SuokLXZBT769hHza25K/JKzYPz4okNLCTIvug/IPsOQ=;
 b=yGEP/bKOfwX5Tr7JrOId/HyWTUFziWDejTWyVkBO47eJhWaYcMTJK7wPcWx4Zl4v+H
 6LlJ3ofn0gOSHPOUfE+FY+gxJqyTrjKc+BwOXHh+HnjBjLLu75hxX86BbdGyEfwIgGIu
 /M8qYxkk4OyhdG4e26X8tDnlBRho/d/G6+Z+HgHz1tqeh8Qh5d20s9Sez/ijrE2pJNGv
 P1PyG2Lp/mstC9efPZrZGIOjZElSB14qEIo2NLvrlyi39ZnG+urZ6X9Sf8FtyIxnHrqq
 s/x6pDA5Yt0JAzsSvcPLyOxjp01k174WKM+FxkmnJWVYzjbxh4oDrOf4Fidy4HbQnnQp
 7qOg==
X-Gm-Message-State: AOAM530l3qUj7ir9E90CGi2Fvah7pg9+R5sGveLd3kC5Rh1QXW9omtZY
 fgqFBnysEdi6BJVj7jl/Nxqwfw==
X-Google-Smtp-Source: ABdhPJxOPiXIhe6VKd4CALjITeyKD3bUphXadgcUtVKUa901LvCRw8JDURlFy6QfYahvehfnBi6M3g==
X-Received: by 2002:a17:90a:bb17:b0:1e0:ab18:4491 with SMTP id
 u23-20020a17090abb1700b001e0ab184491mr6583871pjr.120.1653633413656; 
 Thu, 26 May 2022 23:36:53 -0700 (PDT)
Received: from [10.255.70.20] ([139.177.225.235])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a63ed49000000b003f9d1c020cbsm2619464pgk.51.2022.05.26.23.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 May 2022 23:36:52 -0700 (PDT)
Message-ID: <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
Date: Fri, 27 May 2022 14:32:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Jue Wang <juew@google.com>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yo/I3oLkd9OU0ice@xz-m1.local>
Cc: mst@redhat.com, =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?=
 <naoya.horiguchi@nec.com>, LKML <linux-kernel@vger.kernel.org>,
 qemu-devel@nongnu.org, Linux MM <linux-mm@kvack.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org
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

On 5/27/22 02:37, Peter Xu wrote:
> On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
>> The hypervisor _must_ emulate poisons identified in guest physical
>> address space (could be transported from the source VM), this is to
>> prevent silent data corruption in the guest. With a paravirtual
>> approach like this patch series, the hypervisor can clear some of the
>> poisoned HVAs knowing for certain that the guest OS has isolated the
>> poisoned page. I wonder how much value it provides to the guest if the
>> guest and workload are _not_ in a pressing need for the extra KB/MB
>> worth of memory.
> 
> I'm curious the same on how unpoisoning could help here.  The reasoning
> behind would be great material to be mentioned in the next cover letter.
> 
> Shouldn't we consider migrating serious workloads off the host already
> where there's a sign of more severe hardware issues, instead?
> 
> Thanks,
> 

I'm maintaining 1000,000+ virtual machines, from my experience:
UE is quite unusual and occurs randomly, and I did not hit UE storm case 
in the past years. The memory also has no obvious performance drop after 
hitting UE.

I hit several CE storm case, the performance memory drops a lot. But I 
can't find obvious relationship between UE and CE.

So from the point of my view, to fix the corrupted page for VM seems 
good enough. And yes, unpoisoning several pages does not help 
significantly, but it is still a chance to make the virtualization better.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
