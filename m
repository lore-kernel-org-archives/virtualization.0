Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEA1DE881
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057689; cv=none; b=jlSZhIJ94ZYyEy1gn98F87zMMIPMZaU8suNJ09h+fuc25FL4vel/rS9wxxgP/b0/evB0+mjPGsUqyZkfsXlANOF1SO9C0fm0KTEdlLnoVBV4M1IxtJOrXFYvLsY17UaeuVqEJXymPCc6KM3ZQHxzbXnXVYtL7ojDG73rDyz7/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057689; c=relaxed/simple;
	bh=ezc//63ABGnfEJIAG6zgWRh3da9q8ac7TWanh0tea2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fAIGXdZRfflSonty2iFN/dUyzS81f8zn93pGD20nNszso5iolMF3GquAmQVvtKXH8ZxKgXxIGCwYUR4lG4cKeTifbXEYhJEWncod33k1K/4rnsGZw6jO/mS4c19Y1jfBqk8yPldg3POKQ8v0EjAytPx1Mu1x/aouvgXTtCTAKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN7B3DGx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN7B3DGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731057685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUob6CfRFwWBXrPo93L+5jKilovByn2fvvak/bmVvMU=;
	b=AN7B3DGx3guhrFs7ODf6t9DGzdFLHJu+Q5oQFASMt7ZdWz5mIC8UdlW54d1chX3Pjyk2XB
	HV1qRt0seuWcNBcWMjbocdlYjYeYEn8q0YrogjuFxnZ0U9mLkeOh636EWGv5//t1iBYJRM
	AAuTiDKWnB8a71eVbwrT07c+W2on/B8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-xnHqDnOfPMiNv2NqbBU-sQ-1; Fri, 08 Nov 2024 04:21:24 -0500
X-MC-Unique: xnHqDnOfPMiNv2NqbBU-sQ-1
X-Mimecast-MFC-AGG-ID: xnHqDnOfPMiNv2NqbBU-sQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d589138a9so1004059f8f.1
        for <virtualization@lists.linux.dev>; Fri, 08 Nov 2024 01:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057683; x=1731662483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUob6CfRFwWBXrPo93L+5jKilovByn2fvvak/bmVvMU=;
        b=E7CONS/wF2AQtKox5z0deX2tRJyg3WjiHghCZ33d5adBbm7kEgvGNSFxym2OhyWa7O
         a/cdN5jZJAOwh5tqEszCVipMjvQK4EgZE9h2tAdiMtkeS2P3AUVFU+QdPCSwD8Z8I9q5
         Ffbt7CfYMevCAr1nuI3J0NFdQftebn6DosW3aY4cCvXKqsf26iIGiShQFtusqH7MWTIg
         G1a+DT8phkvouQT3IDANrixDTRa3jnOlpiRKI1ugOoC/R6Dh8nI3zkCp+EwmuYy2pclo
         5a5OvdXU1fFMDT8717ZCBPuaTQ1yOIoVSQq6zCq35hIJRA4y3sQ46zvOVlAnOXpG4jaa
         G5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/K89yFUzpQ10KJET9orkDwYYX5QOJdjn7TKAG/qwTEib5/6MtByBoOBA87t36f/GklY7IyfyEchVYkMnFYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9pGmPI8f0oU+SYZvs5lwZPnMC5l8ZJdthnF8PU4JFCOq/H+xL
	tJzDt7Uw1G5l+fW6UYTvnq70Oe3NGwVwB5tfqGgOAtw6D0DDwmjHbh0yAXpOw3TTbcDeZ2YZY+p
	Od6J3rbNeCXBkWR8F+3hLstiqfzyBtg7217shS6Q7KAoqY21v/apNSuIvDFTwGAay
X-Received: by 2002:a05:6000:4702:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-381f186d35amr1592724f8f.21.1731057683326;
        Fri, 08 Nov 2024 01:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVGfs/L7NKnoBA2cG/5GvEXqRNWl/qXhKUu3SADHB8yVXgRwxSaP0RSeWb5Sly07JEpnKcdA==
X-Received: by 2002:a05:6000:4702:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-381f186d35amr1592683f8f.21.1731057682650;
        Fri, 08 Nov 2024 01:21:22 -0800 (PST)
Received: from sgarzare-redhat ([193.207.101.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c037bsm90748985e9.22.2024.11.08.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:21:22 -0800 (PST)
Date: Fri, 8 Nov 2024 10:21:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] virtio/vsock: Put vsock_connected_sockets_vsk()
 to use
Message-ID: <unazjzgdqrv65uxobcdvz6djts44zk67h676vvzy4fzl4wvghx@ofn3ehx3d6ck>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
 <20241106-vsock-mem-leaks-v1-4-8f4ffc3099e6@rbox.co>
 <ucfa7kvzvfvcstufnkhg3rxb4vrke7nuovqwtlw5awxrhiktqo@lc543oliswzk>
 <14fbd6da-9ef5-400c-9dde-afff3d2c7525@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14fbd6da-9ef5-400c-9dde-afff3d2c7525@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MGCZv97exIsprzfE2WyzzUglwK2uZ6w_8To4695QxUk_1731057683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 07, 2024 at 10:04:03PM +0100, Michal Luczaj wrote:
>On 11/7/24 11:22, Stefano Garzarella wrote:
>> On Wed, Nov 06, 2024 at 06:51:21PM +0100, Michal Luczaj wrote:
>>> Macro vsock_connected_sockets_vsk() has been unused since its introduction.
>>> Instead of removing it, utilise it in vsock_insert_connected() where it's
>>> been open-coded.
>>>
>>> No functional change intended.
>>>
>>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>
>> This is not a fix, so please remove the Fixes tag, we don't need to
>> backport this patch in stable branches.
>>
>> Also in this case this is not related at all with virtio transport, so
>> please remove `virtio` from the commit title.
>>
>> In addition maybe you can remove this patch from this series, and send
>> it to net-next.
>> ...
>
>Right, I get it. Just to be clear: are such small (and non-functional)
>cleanups welcomed coming by themselves?

Good question, in this case I think it's a good cleanup, since we have 
the function already there, why not use it. So I don't see a problem 
with that.

If you find others cleanups, it's better to pack in a single series, 
otherwise let's send just it.

Thanks for the fixes and cleanups!

Stefano

