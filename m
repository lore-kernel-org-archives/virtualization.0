Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C8EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 13:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A408B613E4;
	Tue, 27 Jun 2023 13:28:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A408B613E4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OBSlu2WL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrTMZmIOXS2M; Tue, 27 Jun 2023 13:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2002661319;
	Tue, 27 Jun 2023 13:28:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2002661319
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE790C007C;
	Tue, 27 Jun 2023 13:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0461C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C0EB41754
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:28:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C0EB41754
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OBSlu2WL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6aoFHUPZ2sWk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:28:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C30B64173F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C30B64173F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687872517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1F41av8+wMhP4CJ1H0298QHpYv8u0abzMXHMFh7Es0=;
 b=OBSlu2WLkOUteeURGAnHSy2zYOUiV7xjdNpOarVcrzez15mnwJdL8USnIbbvLyToy5yd2+
 CszU7cFRyhkqr+wTVgPHgkP0WrdlKO5iQXdopFn1aFeKao+ns0eNL4Ab8U/E3rUoqxyAW2
 Gjt19pJwimkpQsdjVQGh7xO869CptbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-8-3vTPKxMLCjF8k9--1Q2Q-1; Tue, 27 Jun 2023 09:28:34 -0400
X-MC-Unique: 8-3vTPKxMLCjF8k9--1Q2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbab56aac7so353165e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 06:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687872511; x=1690464511;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1F41av8+wMhP4CJ1H0298QHpYv8u0abzMXHMFh7Es0=;
 b=dTdiI0sklPwTxrSBSo1b0IBcahUKKRRApI6vDdRl9vi2FAtk2ULCX7tCwfNHcxk3In
 OoCuDr8UvEc4O5jYXBvSjAmNvSKuxircbQ978dUS2pu+jjOLy0t5LR34ffEbDUezqn40
 jG+SD2UBtJP0eHHrbqecMpAGQhm6/599415Jw0gRADk9U6aIHCt8D7PQpticYR1j/uLV
 1ohDUZiSueNZ7FgpgzWVdgHQMubif3y2ZTvzQR194/jVdfuowky0sly3uIVEPx2EQkPd
 2iJASuyL/D708BKr/znhuFMS/2odlFd1OqCagmB4nF/tTp+aL1p948LHcZJsgUC3eMWb
 BTmw==
X-Gm-Message-State: AC+VfDyk2QoAMs7gcZPcaBTH2plUh5Z7+5ygRQiYIFE2IoxI5U7HrGun
 wpOofdenADhpbuyuJA144YLJFKC9Rte6eja/Tv/KjwZAk+PpyUTZMD+m5BJQxC2PAb5ffozEiQq
 y1cmwqtpaNmi7Ivvr609kP3n60r/ILdhrMmNXoG+MVw==
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id
 x6-20020a5d6506000000b00313e95365d0mr6912942wru.28.1687872511316; 
 Tue, 27 Jun 2023 06:28:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rGglwsM0YLmdqMWWa4kXaIrL7nG7zLUTkixpcS0gxe239QLF5miJkniLyx0Nc3/UTwb99bQ==
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id
 x6-20020a5d6506000000b00313e95365d0mr6912926wru.28.1687872510925; 
 Tue, 27 Jun 2023 06:28:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b?
 (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de.
 [2003:cb:c737:4900:68b3:e93b:e07a:558b])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a5d6e85000000b003063a92bbf5sm10524234wrz.70.2023.06.27.06.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 06:28:30 -0700 (PDT)
Message-ID: <d44b7a42-f89d-5bd5-9f29-e8643f6ee17d@redhat.com>
Date: Tue, 27 Jun 2023 15:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Michal Hocko <mhocko@suse.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-2-david@redhat.com> <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only in
 offline_pages()
In-Reply-To: <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>
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

On 27.06.23 14:34, Michal Hocko wrote:
> On Tue 27-06-23 13:22:16, David Hildenbrand wrote:
>> Let's check for fatal signals only. That looks cleaner and still keeps
>> the documented use case for manual user-space triggered memory offlining
>> working. From Documentation/admin-guide/mm/memory-hotplug.rst:
>>
>> 	% timeout $TIMEOUT offline_block | failure_handling
>>
>> In fact, we even document there: "the offlining context can be terminated
>> by sending a fatal signal".
> 
> We should be fixing documentation instead. This could break users who do
> have a SIGALRM signal hander installed.

You mean because timeout will send a SIGALRM, which is not considered 
fatal in case a signal handler is installed?

At least the "traditional" tools I am aware of don't set a timeout at 
all (crossing fingers that they never end up stuck):
* chmem
* QEMU guest agent
* powerpc-utils

libdaxctl also doesn't seem to implement an easy-to-spot timeout for 
memory offlining, but it also doesn't configure SIGALRM.


Of course, that doesn't mean that there isn't somewhere a program that 
does that; I merely assume that it would be pretty unlikely to find such 
a program.

But no strong opinion: we can also keep it like that, update the doc and 
add a comment why this one here is different than most other signal 
backoff checks.


Thanks!

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
