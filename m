Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F90C433EF
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 07:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B5C641940;
	Mon, 30 May 2022 07:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_z25EEwzvU3; Mon, 30 May 2022 07:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A4A4D418D1;
	Mon, 30 May 2022 07:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD68C0032;
	Mon, 30 May 2022 07:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F722C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F368B408F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5H2F1aF0e6h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A999F400A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653896487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ioljxq6PuUu4lxQDlH2MK2dNxIoWh+YwDSpERyNHcYc=;
 b=LRGXoVwAREXrPCfx90D0BjgX77Xc/RNMGPEAME4LCi0Pduhf9UFW8fiy2ITPVsx+R+ltpM
 bPkKa5av2hxSRrl5mrjgK6FHv3skKsyayI8ygpSCO1Xe/vfS6U0t0jb9hRBqTOJnPhKR0z
 63E25nNqQqb1UEmQAmqCpGK7lbwtC7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-fN5Ms56iOf6popZmvLSfFQ-1; Mon, 30 May 2022 03:41:25 -0400
X-MC-Unique: fN5Ms56iOf6popZmvLSfFQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 r6-20020a05600c35c600b0039740f3d32dso9230079wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 00:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=Ioljxq6PuUu4lxQDlH2MK2dNxIoWh+YwDSpERyNHcYc=;
 b=8Aqk+TSRuIC/unsg7QrzKik3Ak8twOHNxYuOyhzByHENr2aImnbxTU8KF9zjd4Udw3
 tUHTgqGSqAIAI2lZDk2garR+FDqzKaLyW10j+DyRYCr30ojHMyo1ywJLaa9FAJwEucE7
 785fySa4TuGQMrK3+kf1ESFnw7JdXottKMZXVwqIqFRB1ZoaAzLqig8fehyPX0lgL0zC
 01qW1p3s0lpQQNGDN/9e4JX3bneZl3r73korxEJa69+toS3hV/ihN49HU5R1hfkFgiHe
 ohjkQ61pGc97GFKGSUsWORf6Y2wZqfwWxbxS115P8Xcr0odQEnoEdNupEje1+yPx4sSA
 BsnQ==
X-Gm-Message-State: AOAM531ZJnJzkCwyEneATHA99SsSMlQAkFToj9qdcpK7JWhy4kKZx6yw
 MYd8feVZDllITe++JVhU1j14Rc5+0o6Q2TmF8UQepESX35XODlHDdE1sdY6080rn7dUsFMjupML
 90lvcrAx7Ytv4D9xvwsmlNORHjYN2xcku9EzYZwzLog==
X-Received: by 2002:a05:6000:144f:b0:20f:d6e8:a54 with SMTP id
 v15-20020a056000144f00b0020fd6e80a54mr30927451wrx.482.1653896483862; 
 Mon, 30 May 2022 00:41:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygmIHMNmIMibGNEd206s8mAH/2ItntHqoVW3Fp9CPDeipNv0CP+C+hoSkZ/LeN5Ih++u+6aA==
X-Received: by 2002:a05:6000:144f:b0:20f:d6e8:a54 with SMTP id
 v15-20020a056000144f00b0020fd6e80a54mr30927434wrx.482.1653896483573; 
 Mon, 30 May 2022 00:41:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736?
 (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de.
 [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a7bc929000000b003974a3af623sm9688836wml.17.2022.05.30.00.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 00:41:23 -0700 (PDT)
Message-ID: <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
Date: Mon, 30 May 2022 09:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: zhenwei pi <pizhenwei@bytedance.com>, Peter Xu <peterx@redhat.com>,
 Jue Wang <juew@google.com>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
In-Reply-To: <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 27.05.22 08:32, zhenwei pi wrote:
> On 5/27/22 02:37, Peter Xu wrote:
>> On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
>>> The hypervisor _must_ emulate poisons identified in guest physical
>>> address space (could be transported from the source VM), this is to
>>> prevent silent data corruption in the guest. With a paravirtual
>>> approach like this patch series, the hypervisor can clear some of the
>>> poisoned HVAs knowing for certain that the guest OS has isolated the
>>> poisoned page. I wonder how much value it provides to the guest if the
>>> guest and workload are _not_ in a pressing need for the extra KB/MB
>>> worth of memory.
>>
>> I'm curious the same on how unpoisoning could help here.  The reasoning
>> behind would be great material to be mentioned in the next cover letter.
>>
>> Shouldn't we consider migrating serious workloads off the host already
>> where there's a sign of more severe hardware issues, instead?
>>
>> Thanks,
>>
> 
> I'm maintaining 1000,000+ virtual machines, from my experience:
> UE is quite unusual and occurs randomly, and I did not hit UE storm case 
> in the past years. The memory also has no obvious performance drop after 
> hitting UE.
> 
> I hit several CE storm case, the performance memory drops a lot. But I 
> can't find obvious relationship between UE and CE.
> 
> So from the point of my view, to fix the corrupted page for VM seems 
> good enough. And yes, unpoisoning several pages does not help 
> significantly, but it is still a chance to make the virtualization better.
> 

I'm curious why we should care about resurrecting a handful of poisoned
pages in a VM. The cover letter doesn't touch on that.

IOW, I'm missing the motivation why we should add additional
code+complexity to unpoison pages at all.

If we're talking about individual 4k pages, it's certainly sub-optimal,
but does it matter in practice? I could understand if we're losing
megabytes of memory. But then, I assume the workload might be seriously
harmed either way already?


I assume when talking about "the performance memory drops a lot", you
imply that this patch set can mitigate that performance drop?

But why do you see a performance drop? Because we might lose some
possible THP candidates (in the host or the guest) and you want to plug
does holes? I assume you'll see a performance drop simply because
poisoning memory is expensive, including migrating pages around on CE.

If you have some numbers to share, especially before/after this change,
that would be great.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
