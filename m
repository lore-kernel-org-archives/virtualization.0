Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B46EC0015E
	for <virtualization@archiver.kernel.org>; Fri, 14 Jul 2023 09:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 901B84012A;
	Fri, 14 Jul 2023 09:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 901B84012A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z80bSIfh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbxhTAoDQZRn; Fri, 14 Jul 2023 09:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 274AB4173B;
	Fri, 14 Jul 2023 09:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 274AB4173B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA4E3C0071;
	Fri, 14 Jul 2023 09:55:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C1FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 09:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61E3F41F06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 09:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61E3F41F06
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z80bSIfh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wfk9iV5nrULm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 09:55:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC1AF41DBC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC1AF41DBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689328533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kf132iRZ20EenuRtRXLIaAVz4mLH2YgT891kbbdMT6M=;
 b=Z80bSIfhZ+bs8XuqkaPX4UqRhKHNs+6L+3gKol3WeGYbte+uMGmiFV6aKtoLFFano/lU6O
 lTCrac/WmaFHyxiMrYH331TY9FIJG5p1ivUI9WhXcVjuqzkIbz95Q6YClyC+34pO7Ggr1C
 d6tVgm1wfrxSywhJbbPAjXLHe20vflc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-mMYJuzxaMaaJ1Rdlff50xA-1; Fri, 14 Jul 2023 05:55:30 -0400
X-MC-Unique: mMYJuzxaMaaJ1Rdlff50xA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31596170243so1143028f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 02:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689328529; x=1691920529;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kf132iRZ20EenuRtRXLIaAVz4mLH2YgT891kbbdMT6M=;
 b=SmyvLHCCMMlLiLVbX0M6QN4A6IpFV+awEKwQnC4aTLSsShSTPubk5kPCwiTQ0tfRGA
 ZeXp1pW3sjGvAuK8Et85H2Qhp3oe5Wcg+tUQtyRKns7hRqkpca+hOrpbHy2yZWYkKfBl
 gjDeNmG3iHBsgShzulzzHkY/Csh4sJy6diRp7BKDHWe8UU5kw5XoEeVbMUVF3urLBfAV
 JGCOnRwuCdzoWUMP11zARDDJ2i9sIcwdf3zoDAXmLs56iGkxwL41PgvrdCUTebo0cWyy
 C16JiIui2VKQSv15ld4AT5ztnmsMX3m3WFGtVgu/ifEjHjpESbX1WMOqwuKS6+fH8u0E
 5geA==
X-Gm-Message-State: ABy/qLa9oBH9yRXWArtYS/xZIr7E9XKZC5VXPx+hz/haphdyWSu5Erdg
 ek/gXVaVgpIAMSJ/hSUHnkSEQKSIibM7BK7HeuKBiKI8DosIlNTiX2sLquTqdAEpMr9WsHbNy8o
 mX1PyY5/3bH5zYR8FNu5JhgEOnTxFs8blRQWthT2Ivg==
X-Received: by 2002:a5d:67d0:0:b0:313:fbd0:9813 with SMTP id
 n16-20020a5d67d0000000b00313fbd09813mr3466957wrw.28.1689328529635; 
 Fri, 14 Jul 2023 02:55:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdlUo+JN4v1o9lTJZqXuq/+tLZCVapgyI00wczrknXcEiLAc8BYt3hBc2KTjJX7LpL9n/i0g==
X-Received: by 2002:a5d:67d0:0:b0:313:fbd0:9813 with SMTP id
 n16-20020a5d67d0000000b00313fbd09813mr3466946wrw.28.1689328529256; 
 Fri, 14 Jul 2023 02:55:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb?
 (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de.
 [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a5d6810000000b003144b50034esm10371315wru.110.2023.07.14.02.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 02:55:28 -0700 (PDT)
Message-ID: <e609bed0-b6c2-1905-36a8-f94b85fd350b@redhat.com>
Date: Fri, 14 Jul 2023 11:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related
 cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230713145551.2824980-1-david@redhat.com>
 <20230713110235-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713110235-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On 13.07.23 17:03, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2023 at 04:55:47PM +0200, David Hildenbrand wrote:
>> Some cleanups+optimizations primarily around offline_and_remove_memory().
>>
>> Patch #1 drops the "unsafe unplug" feature where we might get stuck in
>> offline_and_remove_memory() forever.
>>
>> Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
>> nicer.
>>
>> Patch #3 handles the case where offline_and_remove_memory() failed and
>> we want to retry later to remove a completely unplugged Linux memory
>> block, to not have them waste memory forever.
>>
>> Patch #4 something I had lying around for longer, which reacts faster
>> on config changes when unplugging memory.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> This looks like something that's reasonable to put in this linux, right?
> These are fixes even though they are for theoretical issues.

Yes, but these are not high-priority fixes+optimizations. So if you feel 
like we should be delaying them, fine with me.

On the other hand, getting them in now also shouldn't really hurt. 
Especially patch #1 might be better of just going in soner than later.

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
