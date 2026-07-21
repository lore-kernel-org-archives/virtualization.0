Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D818381E9F
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632764; cv=none; b=fXFf499SIXQ4PMvL724bv8McGZcV90XlSduWVD4ATqGv4WzTOvTAsviq1In4N0jngfnTs6oN/6OpdARs8XXmGoHzoRUFIEIyX9Xt9sIps54NBY4KZKXGlny78suvscmVZ6T/gZJ49/fHN+VefBYsMFgWXH/A5dR40oAaof1IwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632764; c=relaxed/simple;
	bh=xJAhNcViqgxaoHWIEmJNFrtF1OLjmyQnDUZ3IbhOx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKmHdQxoAI1K6M4zuRE2JDvoCV6SLBrpJBOQ1dn1wRkWl0RJxhstPtYvKmTBLOj3KsnmCFhjQ63W1vHe+RHTJsmAFLXRBGMXuW82kFIdTssmXwGCcn4PODsj4KeMK7tym4X4W+fZBAHjnC+j1S3dwZ5kN6dii6eLPTkLYZW+lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTgCD0ue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTgCD0ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784632761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
	b=gTgCD0ueU3Ghwx/GAhT/1I+maRCKMZ66oH4O7YzoFbFK4wkkzKyphalKLbX843wGhv1/UE
	VOG2LCJUid7qkaVYjFauo2EujNe4medjysFCd/4ELP8IX+y3UxaO9V5Vgeah4AMMjkG2Sg
	mLijkpBuVuaxdZOwD9w+oJlBfc4uKdQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-j8bgvBfYMietgtva9Fhmnw-1; Tue, 21 Jul 2026 07:19:20 -0400
X-MC-Unique: j8bgvBfYMietgtva9Fhmnw-1
X-Mimecast-MFC-AGG-ID: j8bgvBfYMietgtva9Fhmnw_1784632759
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475e540a0ffso6392992f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 04:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632759; x=1785237559;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
        b=jfBdwy+SJvQ7kkNC8z57iOkiWMATRHAndCTnNqAUcczB36SYqnT4/N76zeHuj5yBao
         NR0BDVfMdCBJoYc/GiKLmTD6Gyj9RFVx1NfoCjeyNKF0JgaLGso+SRmjXsdD/6TC0KjD
         7OZn9CmdCTb17lG5F922SS+Y4dixtKo5KvZGo5e4J8Aqv3C/Sri/6xVB3o1h8TJOTaky
         GsNHqaUX9RwSErl87DFUqm0TJTYYYu7OWYp5x3/OOHKxV1TzvQqgxYTKD+0dsU6xb+ox
         qRGCfYzMO7XWaHVhLZWh5W6UEEzyMC1NyOBVve8YJSRlOEo0f50U+af3TtG7us5jLGqX
         S90w==
X-Forwarded-Encrypted: i=1; AHgh+RpB1C/Eklu4D12xHxupp6kxjzaefHTTzpLEFI0sVSDLgHCPs/4ufeX0ROzClnj6xXFio86UMQe1z96Fw4XU+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkkj2hC+WIl326bFJTosw9Ia8R2fhTJlyXXgljZ1z6HEIKT77F
	bxesCH1zoZcJK0U+nxlzTzbB6ggLdeV3TMm2VmOkqEtDfD6DAI/GITnHxdt3G4CaVtFgwxxsdiY
	ZP6mG/zfwGn4gugLjaW2DEiNK6O455tVk7cAw28JcisJjM/OtTpVhtseQJMbRRyeQCL/Z
X-Gm-Gg: AR+sD137XpzH6masldqel3PW68XW7i4XmKn8N+BRwCdM771uSAkRRyddRUrwQpBTKfJ
	208GNXBPgFDXF0lW/Ot36awsIXoXp3DR/EfDly7KRct0ISEbYY7LHJQDd4L0Kt6QF7+3RbcTN4b
	pGkZ2no9434DKnnoGhnQODW0B2yy0zfXW8iL/2tkEpg1piEtLrWWo40NF0MR12re4bUHbSU7new
	fDQUmkkSfH1J4lZCj8mFFD8WrBgQ8a1gPITQJNvr4zJofiA7rAStmtQgAPdYlziJLs7+Zjyk2IG
	/KsQLzl63GqPiHqZxugS50cw8IkfIeKVA/eqvE0Q10gH7wbi6DdcOclVHYMMttQs5vUstwCa8KO
	ybjtKtf/o1exCbYToGT7EE1TNZ5IjVF+8UCfR3dg2+aDUa+p+oTiHoaVR9ONkq4IgAysvAGdcnG
	LYgA==
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477180f8f.24.1784632758926;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477122f8f.24.1784632758406;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm37465633f8f.37.2026.07.21.04.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:19:17 -0700 (PDT)
Message-ID: <03f49d98-c6e1-4dd2-bf25-f42e424fd59c@redhat.com>
Date: Tue, 21 Jul 2026 13:19:15 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
To: "Michael S. Tsirkin" <mst@redhat.com>, enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
 <20260708124901-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260708124901-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i98N0Tfab-1FjzkB4t3mWL8gM4VcuzZCX7EY3mX1pnU_1784632759
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 6:50 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
>> From: Enrico Zanda <enrico.zanda@arm.com>
>>
>> When vhost owns the virtio-net header, i.e. when
>> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
>> meaning that no header will be forwarded to the TAP device.
>>
>> In the current vhost_net_build_xdp() implementation,
>> when sock_hlen == 0, the gso pointer can point at the start of the
>> Ethernet frame instead of a virtio-net header.
>> This results in a wrong interpretation of the destination MAC address
>> bytes as struct virtio_net_hdr fields.
>>
>> This can, for some MAC addresses, trigger -EINVAL and return early
>> before the TX descriptor is completed, which can stall vhost-net TX.
>>
>> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
>> using it as a synthetic virtio-net header. Restore that behavior.
>>
>> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
>> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>
> 
> 
> The fix looks good:
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Sashiko thinks there's something something security here, but I think
> it is misguided. It's just guest hurting itself. driver breaks the
> device it gets to keep both pieces.
Out of sheer curiosity: which sashiko instance? AFAICS both gemini and
nipa are clean:

https://sashiko.dev/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com

/P

