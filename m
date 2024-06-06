Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7E38DE0
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658733; cv=none; b=YpT390nDDR4rYl2JTB1t1gCIy+IRU+zOqvJJqYE3Nq2Gc7mHU2BcXiwsziT+FkFm9Iy0raGHJdv0t7K4eekonfqS/kzOclTFI+vWGvEtoOSYKM/WjeiQCXfXEUvW7hAx7QQBZRit41qgEhFYctmk6hc/Z/hS7Eai1lGrTVAcQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658733; c=relaxed/simple;
	bh=3tT5ZUjUrRevVbbtsgYFAgypdF69WL1r/DrABXBMEQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oa6iOqaFluo/R077g+SBc7WVhvvvDEkb+jsla+5Pc0GZwQ0/ED9K3LT/kCE3xabPE3hSKeHU+k9V7jWFSGN3pqUdNZBtRva6JrKFWcK+3E8C/0gREFzlMTcG/5T54FYM9niTaQnq441zikopODYFXk/G70/AlrAj8V/BaW6DwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0348ade23d511ef9305a59a3cc225df-20240606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:bdc54eef-ad6d-475c-8cd7-47e98cb3d3a5,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.38,REQID:bdc54eef-ad6d-475c-8cd7-47e98cb3d3a5,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a0f5483941cb181d6b2f9d983438c504,BulkI
	D:2406060830146BR7IUWK,BulkQuantity:5,Recheck:0,SF:64|66|24|17|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f0348ade23d511ef9305a59a3cc225df-20240606
X-User: cuitao@kylinos.cn
Received: from [172.30.60.76] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 158438979; Thu, 06 Jun 2024 15:25:23 +0800
Message-ID: <378a9c14-744f-4192-9229-0132ddc97b15@kylinos.cn>
Date: Thu, 6 Jun 2024 15:25:21 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to
 complete the memory initialization.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, linux-kernel@vger.kernel.org
References: <20240605135245.14921-1-cuitao@kylinos.cn>
 <20240606031810-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: cuitao <cuitao@kylinos.cn>
In-Reply-To: <20240606031810-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, maybe I'm wrong.

I wonder if the gfp parameter in static inline void *kmalloc(size_t s, 
gfp_t gfp) can be deleted if it is not used.

Or would be better to move memset to kmalloc.

Like this:
#define __GFP_ZERO 0x1
static inline void *kmalloc(size_t s, gfp_t gfp)
{
     void *p;
     if (__kmalloc_fake)
         return __kmalloc_fake;

     p = malloc(s);
     if (!p)
             return p;

     if (gfp & __GFP_ZERO)
         memset(p, 0, s);
     return p;
}

在 2024/6/6 15:18, Michael S. Tsirkin 写道:
> On Wed, Jun 05, 2024 at 09:52:45PM +0800, cuitao wrote:
>> Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating it,
>> without the need for an additional memset call.
>>
>> Signed-off-by: cuitao <cuitao@kylinos.cn>
>> ---
>>   tools/virtio/linux/kernel.h | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>> index 6702008f7f5c..9e401fb7c215 100644
>> --- a/tools/virtio/linux/kernel.h
>> +++ b/tools/virtio/linux/kernel.h
>> @@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
>>   
>>   static inline void *kzalloc(size_t s, gfp_t gfp)
>>   {
>> -	void *p = kmalloc(s, gfp);
>> -
>> -	memset(p, 0, s);
>> -	return p;
>> +	return kmalloc(s, gfp | __GFP_ZERO);
>>   }
>
> Why do we care? It's just here to make things compile. The simpler the
> better.
>
>>   static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
>> -- 
>> 2.25.1
