Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D53314B9
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570556; cv=none; b=BzDrtIoCNuzh+s1Z7Zj4CtXOCgiB5Z6xp8Q3hoPEItsYNtNCxVa/TOLSk3gCDDC4LJ/TPbriI/vj9uwdmhTpEe5OEiZHt/nMw1mWzoVzjvxFER3nazc5wonWfMa5anwWu56Z53JvGjEoS4mEpWf+hRfU2QiUItVKOaPlTcvqxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570556; c=relaxed/simple;
	bh=7PDVjOFFBvB62jh1T+5fxxeccqZf3wobQfN0ejWBl+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+ApCj3HQp1ghk0f+a3YdobhmbRzdARXr/snGeFOB5nviamJctDt3+axSO7M2ucuMaAwWz3b4LAD+Vv6r/TrAV5nB4K+D5Y5dmymptyH7ibOvhOAQ+fVB9KPzhsfLFw4Kz4edtMvSiiogbrwTzDzYheQavJEVCccQx0/DoKy5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6WlenL/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6WlenL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780570554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
	b=W6WlenL/M7oHVRp9ZoquNNBSuLbQToiMFOhiyTatrKopA+IYkHoOmPbvXWAK00fXxdRKYA
	S3WTy1PWVUJP+nvTcKOUKreU8kRvYv89fWeIVgqemYBxOc8e8uKNYczm6C5UV2RXf6ZID5
	chZNYLFvbaG7BP1UZsBFhFl6WlaaEN4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-IcEGC5bPPS6IxHzGA9cz3A-1; Thu, 04 Jun 2026 06:55:53 -0400
X-MC-Unique: IcEGC5bPPS6IxHzGA9cz3A-1
X-Mimecast-MFC-AGG-ID: IcEGC5bPPS6IxHzGA9cz3A_1780570552
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa2f7009so366257f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jun 2026 03:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570552; x=1781175352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
        b=FMANmNYqvRbUFW/cW9lfLbO+u3AXd+pcKDVewMq+mImSzEKgVvcVk5ZkFimGC6gYjQ
         CUrjJ+lPIhfELD6Fg9mXndMRzC2yhCdSikAkG+PbGd5FqL8ZeVFs8JwOvuEnoRhxLwhe
         4LOUOeOqfVdPkMgG4BtuBPUmU3BMK2FcXeUvxLOGQVzaFMhn2C8H14lyUR7Hoj2rIeZW
         12eZQNNe3+cq0tia+EU8h1IjrGYcqdUbSlxqT3q64/JG8uTSE8UcE/LpMS79t+U0Lzam
         lowyD/TDcc6yAho9clmbd9pOqeMaBqsUwXQ+qrtIKSrJbvuUht7HrLBahVkjSBQgGRA1
         BMxA==
X-Forwarded-Encrypted: i=1; AFNElJ9DAr5PLcLgsvwSPFJLUyPrKtszUi5CH7EtKxA4rJsb5dgnXJQ3dLEWVlfO7/XrpKjwfgQ5xiJ5v8Vz41a/rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNwXS8GFzQ/DYU2xTDL36W76z8oxRyOAzSQ6N5RLNLygIdE44l
	1rsYjPHWm9nt2lAoXe0dmiOzxjQCKo8krg5vMypY5wuJkJNJ+Oy6fdC7PeR51e+bDsyE5OACeeS
	8WE4VksqOEfiRgNFLkx94NydGCGa2xV4QTEEH+yYFlNr3MJo8+kodwogMeM/fnZusBvKv
X-Gm-Gg: Acq92OG2V2hzb0VCWj/6cPABcnQdWK5ibtnuOcLJjkSgpVbfAkxG2RtRVtbXlvynosH
	vwayVVXdOh9IiDxoXqnw/cBQdM5K8OKMvtItCq9CmEZyJSUz5vFDYKlK32diXk9tfAh5JbaN+Jm
	W52x3JOr1LG7bws+PRVKyVRc7kX7e4L3MEWETpKuBrem/w1FqGN/KHsHn7QNazc+Mh3+JOrfUtr
	jnec69OiS6ynRkxIBLWnhg6txEyGVDlhWA3PmnQT2UFMi5kiKs/VhUX78W9TsUGaL/AOLfoONY5
	PVezMsXQqB8jOfySNi71MZUwxtrTAVOqQ4P3/jdutArfFHhBz8mFcZ3RUIRqavuHZtu/TzCPwLx
	IBiuu4GzsQD8jnnoVYICH3PzzW+ksZh8cjKMro5ocOyZodCevUzNBZY8KFyAIy2cJ7hg=
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984906f8f.4.1780570551760;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984861f8f.4.1780570551302;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm15330789f8f.28.2026.06.04.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:55:50 -0700 (PDT)
Message-ID: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Date: Thu, 4 Jun 2026 12:55:49 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
To: Qing Ming <a0yami@mailbox.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601104300.197210-1-a0yami@mailbox.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260601104300.197210-1-a0yami@mailbox.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kv5k5BxNSLs6Q2B-CUR-FxdlrxhNm45tdNvqfr1VgmE_1780570552
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 12:43 PM, Qing Ming wrote:
> vhost-net initializes one ubuf_info per outstanding zerocopy TX
> descriptor and hands it to the backend socket.  The networking stack may
> then clone a zerocopy skb before all skb references are released.  For
> example, batman-adv fragmentation reaches skb_split(), which calls
> skb_zerocopy_clone() and increments the same ubuf_info refcount.
> 
> vhost_zerocopy_complete() currently treats every ubuf callback as a
> completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> descriptor completion state, and drops the vhost_net_ubuf_ref even when
> the callback only releases a cloned skb reference.  A backend reset can
> therefore wait for and free the vhost_net_ubuf_ref while another cloned
> skb still carries the same ubuf_info.  A later completion then
> dereferences the freed ubufs pointer.
> 
> KASAN reports the stale completion as:
> 
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
>   vhost_zerocopy_complete
>   skb_copy_ubufs
>   __dev_forward_skb2
>   veth_xmit
> 
> The freed object was allocated from vhost_net_ioctl() while setting the
> backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> removal, while delayed skb completion still reached
> vhost_zerocopy_complete().
> 
> Honor the generic ubuf_info refcount before touching vhost state, and run
> the vhost descriptor completion only for the final ubuf reference.  This
> matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> skbs.
> 
> Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

The patch LGTM.

@Michael: to you want to take it via your tree?

/P

