Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561932C85
	for <virtualization@lists.linux.dev>; Sat,  2 Aug 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127787; cv=none; b=nEplRT4kO2JKWEFP1POTR7088lw6Y8tBjLv+Lpmh0mSjfWhJs061GDm+MAp8bT+GbXSFpHFREy64441TK1BVwgrnBwo+dJdVO1zxJOXoMqJhxPLpOnKX/t8tjEt5lQOTwoXuU/SL3ZZ8bmZlzYOSp64Qlukz0tfWGU6fAee8GWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127787; c=relaxed/simple;
	bh=LwDX/givvtGDz+Iiqtjljsja2TU3lYjcGygNaSNnTzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frAK0vCkyRLOfmAlOyQoXqISufZvUb2lGQPbF3yicAGInMtd+IZX/tmyDdLxwby9/zpu176W9JbvJJRlxMGz7y7hyXPa5q/iCkHjIP2y533llDFYo9+ncwtvzxhY94F1UYadTzZPmVUhnd3KoVjhSY5qRWxXWnj/7IpS+2cxh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=gLYSRyKD reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="gLYSRyKD"
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5729fDB0031085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 2 Aug 2025 18:41:13 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ovuEvXGyQDw3EIAnC2OBfPaHMeg92Ny3eDfRpSilftM=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:Subject:To:From;
        s=rs20250326; t=1754127673; v=1;
        b=gLYSRyKDh7uJqUJcPRnC6ewOzIE2Lskd+6h1ChpWAeUAIv92qs8hV8ZAvaQFYFTQ
         i8GOTzKT5RQN5CFGKVlSyWEB01fRUG2s6JbCaM28C1O2yk7elC+Cn9I+JlUbslsY
         Iw+uqkNUP453c+pgs7InQk9Z/3rA35V5yUXQAHw0h2HE9qXzuZvFPv/VQOA49s1C
         b0MSy6GpTJxdy6xIoYgo0fuF5oEPQUvwdJ/9h87vshPA7b2glH5GxUlowuY15TZs
         n6awUJG2EdJLn9GUx5y95zE6zgb2lam4d34LdgeiL+OHgnFBJwzk7hDS2B2fs9Lq
         crHqg0NhEiiCu7Tttk0QwQ==
Message-ID: <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 2 Aug 2025 18:41:12 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
To: Michael Tokarev <mjt@tls.msk.ru>,
        Konstantin Shkolnyy
 <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
 <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/02 16:26, Michael Tokarev wrote:
> On 27.07.2025 09:22, Akihiko Odaki wrote:
> ...
>> @@ -3942,6 +3943,7 @@ static void 
>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
>>       n->vlans = g_malloc0(MAX_VLAN >> 3);
>> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);
> 
> A nitpick: we don't need to init this memory with 0 before
> initing it with 0xff.
> 
> But looking at this, why can't we embed n->vlans directly into
> this structure, something like the attached patch?

VMState also needs a change: VMSTATE_BUFFER_POINTER_UNSAFE() should be 
replaced with plain VMSTATE_BUFFER(). Actually this is the only user of 
VMSTATE_BUFFER_POINTER_UNSAFE().

I appreciate if you submit the patch with this VMState change and patch 
message.

> 
> This, and maybe a few other fields like it?

There is another candidate: n->mac_table.macs

But it is not straightforward to embed this array because it uses 
VMSTATE_VBUFFER_MULTIPLY().

Regards,
Akihiko Odaki
