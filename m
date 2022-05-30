Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68218C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 07:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C94261100;
	Mon, 30 May 2022 07:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9H5_jn3gXqlD; Mon, 30 May 2022 07:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A50D960EDB;
	Mon, 30 May 2022 07:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58EECC0032;
	Mon, 30 May 2022 07:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FAD9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4705B61100
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzCkX3fFIWiC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E88760EDB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653897214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lW8fZRkPKfhJnNOw18gq2IWP/lJEsxr/x1aT3dj708I=;
 b=SCujWkYkawSu5Ur9OUPTVS+UIXCRpPPQBM4ZPnGCeGu3Swpx9lYuJx7d5KmECJL1MOc7nw
 iLdhVaePuXBn56v7KRnIeZzhlCJhWxKf6E/e2iB439uag+R4Sy0u4YB2g3Jac4UOge88qA
 2uUw9EdOYwCF/BWEhZ3Y/c8dFpjMhl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-qlvPOTQxPGaoJhUoSpifXg-1; Mon, 30 May 2022 03:53:33 -0400
X-MC-Unique: qlvPOTQxPGaoJhUoSpifXg-1
Received: by mail-wr1-f70.google.com with SMTP id
 h2-20020adfe982000000b002102da95c71so364170wrm.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 00:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=lW8fZRkPKfhJnNOw18gq2IWP/lJEsxr/x1aT3dj708I=;
 b=GjFPN5vGIBtYgGVqt5x1vJqxuXJDXikcSJg16+zNvXQW8VrGCNOD3S1J4PVns+Ih2J
 mXhs2PE51uUaoaqviag/NNZUlMNHIX3AAdvyDJYFCqQPJKmEzvgqv61j6cBg848+ZJD3
 pX69sRLRKEZETIbFuq4yA6tbXD4kkBumppVR5oH0X2M9gSKRZTIBcKQD+9buR3Iav0BE
 udZDWYl4yN0bpk4y/yLfpthpxFZH0fkUAUq/+7IktIeCbYHuGP55CxuGgA/ORRHisxc7
 1VntJ+MOZyeqDCs+iZjjcQ5cFPln2jL8AjZ10YAAS9rp3L4UooNzdBP8qNds6LSALDcA
 YNvA==
X-Gm-Message-State: AOAM53254vkhBHHgLUAJX1UHd5uzBV1K74KTIhwIiuDIQ/cZjC/L2wHS
 zr2fYXOZCwp57BZn9ku4btmqVPwr0yHYeyAKtjfFqakJaaRLCIPv1bR2OllXARPLNq5PLriqRnJ
 7gdxX/FCJKFlvJ2WXTKCfG9xIrbZYJa7tTPtU7VMUrA==
X-Received: by 2002:a05:600c:3543:b0:397:7565:ea4 with SMTP id
 i3-20020a05600c354300b0039775650ea4mr17556017wmq.86.1653897211918; 
 Mon, 30 May 2022 00:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXMX0mVia1YfTVILgUPjxKu9Fq37hgGHboYr/arqWNq5GxPQTIQAE8Q8/KSnUDs6PSNUeh1A==
X-Received: by 2002:a05:600c:3543:b0:397:7565:ea4 with SMTP id
 i3-20020a05600c354300b0039775650ea4mr17555999wmq.86.1653897211629; 
 Mon, 30 May 2022 00:53:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736?
 (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de.
 [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adff486000000b0020c5253d907sm8266521wro.83.2022.05.30.00.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 00:53:31 -0700 (PDT)
Message-ID: <fdbdb249-8f8f-5ca9-509c-6b4a4b94236a@redhat.com>
Date: Mon, 30 May 2022 09:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
To: zhenwei pi <pizhenwei@bytedance.com>,
 Sean Christopherson <seanjc@google.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <Yo0zmP28FqpivlxF@google.com>
 <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst@redhat.com, qemu-devel@nongnu.org, naoya.horiguchi@nec.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org
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

On 25.05.22 01:32, zhenwei pi wrote:
> 
> 
> On 5/25/22 03:35, Sean Christopherson wrote:
>> On Fri, May 20, 2022, zhenwei pi wrote:
>>> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>>>   	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>>>   };
>>>   
>>> +/* the request body to commucate with host side */
>>> +struct __virtio_balloon_recover {
>>> +	struct virtio_balloon_recover vbr;
>>> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
>>
>> I assume this is copied from virtio_balloon.pfns, which also uses __virtio32, but
>> isn't that horribly broken?  PFNs are 'unsigned long', i.e. 64 bits on 64-bit kernels.
>> x86-64 at least most definitely generates 64-bit PFNs.  Unless there's magic I'm
>> missing, page_to_balloon_pfn() will truncate PFNs and feed the host bad info.
>>
> 
> Yes, I also noticed this point, I suppose the balloon device can not 
> work on a virtual machine which has physical address larger than 16T.

Yes, that's a historical artifact and we never ran into it in practice
-- because 16TB VMs are still rare, especially when paired with
virtio-balloon inflation/deflation. Most probably the guest should just
stop inflating when hitting such a big PFN. In the future, we might want
a proper sg interface instead.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
