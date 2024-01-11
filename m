Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9CF9C3
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz8ry+Pe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704962136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hfgr8luhidQ8t45xaZnA6f4xkfrL7aNRQ4EsXAkGR+s=;
	b=Fz8ry+PeD3iQoRtifOAc1QXKX4/Z/Hz23kr3xIKtOqSJ6lAFvcDrnv4oW83U3P6YLAwraa
	bH5W4AEUQeEiWxJG8DIpWt/AF1h0Y1rqrg5HZwBDD3U604+B/0Y9kS+ase5K3MYGhtlpaD
	+iu6vDw9lWLQe+7Qlb0taT8jMaOs1mc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-BvUfL8hOP0awM0cbAAgfqQ-1; Thu, 11 Jan 2024 03:35:35 -0500
X-MC-Unique: BvUfL8hOP0awM0cbAAgfqQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e6d41ebc5so4209047e87.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962133; x=1705566933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfgr8luhidQ8t45xaZnA6f4xkfrL7aNRQ4EsXAkGR+s=;
        b=WguEheJGTbLvq0/t+w/bfOghQUWXdq1Wn8IE6FWC5MuuHw2kNvkSrnGU+bLIDHO//2
         71Y6PWvG72x79/HICt7M8K9xd93ilHb2lXzsFgxAPwG3mliBoJ4zD+EXBiAH0LbZ9XNo
         o9BgnvUy4zu8M7K/YsOgFfS4wymubnbBjOjEyPd0aIutS6xTSbJFDQXN3yvh88pWc8p0
         L0GuCJxrVKUaGRhLo6OyeK56DlcxhSHlUivJ1jbFPDhpt92DS5duQQr/NCwoQeZPOKqF
         xonfWtKXolBe2oI+Ym9NOFDqFL40QQgi+beZBPjz7MDY5n2c6omPnyeDpe/ajA644SSS
         aHnA==
X-Gm-Message-State: AOJu0YyRGxdP3nhWLEOSDpvdhiVhS1EN7YNOd7XjZD1uf/MPbWO32cYK
	eIWVcPVgsKUaWVYSKEz4QnVLsJ6HlE1PnrC3KW4iXqvgp1VE/ABRE4QDDuPHXG/xO+0bxEwzhN5
	dD3tS0MhRHozA3y0alIXf7ijICFO1s/EYCeQ=
X-Received: by 2002:ac2:455a:0:b0:50e:7702:a189 with SMTP id j26-20020ac2455a000000b0050e7702a189mr336991lfm.22.1704962133701;
        Thu, 11 Jan 2024 00:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIXVep2DsKilS9Z/pqpHKylxXmICMLJvIHSw+QvZsD2fzOXFaIxFf9ImRKMqhaJ+yEPo/2hQ==
X-Received: by 2002:ac2:455a:0:b0:50e:7702:a189 with SMTP id j26-20020ac2455a000000b0050e7702a189mr336980lfm.22.1704962133264;
        Thu, 11 Jan 2024 00:35:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:f900:6099:1901:b863:450f? (p200300cbc747f90060991901b863450f.dip0.t-ipconnect.de. [2003:cb:c747:f900:6099:1901:b863:450f])
        by smtp.gmail.com with ESMTPSA id u1-20020adfa181000000b003368d2e729bsm595581wru.43.2024.01.11.00.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:35:32 -0800 (PST)
Message-ID: <10db6936-c951-447f-bf50-aff016008a53@redhat.com>
Date: Thu, 11 Jan 2024 09:35:32 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
To: Zheyun Shen <szy0127@sjtu.edu.cn>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: mst <mst@redhat.com>, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
References: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.24 07:22, Zheyun Shen wrote:
> For now, SEV pins guest's memory to avoid swapping or
> moving ciphertext, but leading to the inhibition of
> Memory Ballooning.
> 
> In Memory Ballooning, only guest's free pages will be relocated
> in balloon inflation and deflation, so the difference of plaintext
> doesn't matter to guest.

A Linux hypervisor will always give you a fresh, zeroed page. I don't 
recall what the spec says, could be that that is a guarantee.

> 
> Memory Ballooning is a nice memory overcommitment technology can
> be used in CVM based on SEV and SEV-ES, so userspace tools can
> provide an option to allow SEV not to pin memory and enable
> Memory Ballooning. Guest kernel may not inhibit Balloon and
> should set shared memory for Balloon decrypted.

Two points:

1) Memory overcommit means that you promise to have more memory than you 
actually have.

To be able to use that in a *safe* way in the hypervisor, to fulfill 
that promise, you need some backup strategy, which is usually swap space 
in the hypervisor. Further one might apply other techniques (ram 
compression, memory deduplication) in the hypervisor to make that 
swapping unlikely to ever happen when overcommitting (because nobody 
wants to swap).

Assume you run a lot of VMs that mostly have private/encrypted memory 
(which is the default). Imagine you previously inflated the balloon on 
VM0, and that VM needs more memory (you promised it could have more!). 
You reach out to other VMs to inflate the balloon so you get memory 
back, but they cannot give up memory safely.

In that scenario (a) you cannot swap something out because all pages are 
pinned (b) memory compression cannot be applied because pages are pinned 
and (c) memory deduplication cannot be applied because pages are pinned.

Pinned memory is a resource that cannot be overcomitted.

So I am not convinced the use case you are targeting can be considered 
any way of sane memory overcommit. You should better call it resizing VM 
memory instead. Then, it's clearer that the hypervisor cannot promise to 
ever give you that memory when you are in need.


2) What about other features?

What if the hypervisor enabled free-page-reporting? Would that work 
(unlikely, I assunme). Don't we have to block that?

-- 
Cheers,

David / dhildenb

