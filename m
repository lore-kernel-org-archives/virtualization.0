Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CE3F4121
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722191; cv=none; b=fxoEs0JrZkwU16dWHrBegDauiqJKjGbdDnA00snYBepJJhqcZJKdi3d/nyIvK979+O2wyCKd5q7vxMNuiNVxmsv7wfF5JNHZS0cTxFmWiBGx2Xuyur2V/a5Kqba2GmwQARClMVbLMve4WFUX6Je8EJWpeS6n1L8xfDk3EkoEegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722191; c=relaxed/simple;
	bh=AJUSWFiE6Q27sPZdsP0TJj9XuNjCnHJMEQ5y+0iZRbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mI3NzSg0iAIwJo3eQhMOC7ZQN5Pzle5p4gaZAqZUAR/Rbi5QNBLvjSOXvJ+aOKSt6k5YoDocybfd5u9veBlCsHjRq0jEZ22w8W2/ahT9aBhA51gb748h3IWs2JzHXicyQNBdX2Cxflqps73F0KPV9OxaEgKWYPrTablUA/D6cRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LguTpTI6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LguTpTI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779722188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRIUymRBu2V1hz/h+nW5xnuAvIV3Q2kXa6qoE0y+ue8=;
	b=LguTpTI6BWaTZH5ABb/3/RebpIGBfLjK8R2TXfxdx4gqJ3ZxGF/6fJ2KhhQ1dVqwTZrYGf
	kzOPyntBBL5YHpIzhPsAdtnOpwG7d60gFU4kaXOJfH6r9CPB5QMnxXhnlC7Zg21QB5KE+b
	9rPyz8oFIz5Yhi3RXpJKv3+uC/caXyw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-wbeHvuQTOAKI6lRV2jqtww-1; Mon, 25 May 2026 11:16:27 -0400
X-MC-Unique: wbeHvuQTOAKI6lRV2jqtww-1
X-Mimecast-MFC-AGG-ID: wbeHvuQTOAKI6lRV2jqtww_1779722186
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso8545850f8f.1
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 08:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722186; x=1780326986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRIUymRBu2V1hz/h+nW5xnuAvIV3Q2kXa6qoE0y+ue8=;
        b=ZDjUCho+OS49dcBXym5oonNxQVXfpngZ8JYGVvXfuALuv8uRSbeqbog/y/XU/LT4lt
         QzWwqHrHY6QzwGsQJTqrk9DW+bpp8ia9gYC2sZFDYtCzh7KQewokESDhH+WJvMWT6YBq
         lWnC540yh9VNaW5wtQ9QiS8KlzH4i1IDUL/YM8+v8AV8b6CmHJtimga5m8tdUtIbAgRi
         C7DNyP856vsCdTU8ORmwDAQ5M2cSCvpBCGCGctsYt+cQ3UcGo6Hv/udaelyMJx4f0LFH
         JZCvczdOk9NmdQidcyh9r0JXPqAIBp6hrLf6zSPIjvwKxZh99OMxGCILf85VrJu0qtZm
         Pe7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gUqbh5TsAVu7WIuc1iaMzc0dJjB2XRF1zRXlUNrcJ1Kdo+0vzUUQi0Gw3ViLp7xZeK+vVAZcossRpyhbCfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV7xsHiBiEVKCkQ9njqYCVfHVbG7RrOonm53ZJwGHpU1MCPQEr
	blpE5ahOwa7cy7u0BwrSb8coxpUa435yqn+GqZBZPJVguZSUwRDfecOfTQYeuZAj9DepjLtt03e
	ocfik29BVoml2iagUZPF9+lRUlERGvOACJn31XdgaWi5+E0TN58xrZVtc+34aNJrCEsvM
X-Gm-Gg: Acq92OEtT9Vi6wHqaNN3VeYotInohhzvpqeCYWoBt7vnD5TMmwhy39xn2LRdlwXwjLu
	3GErrZ9WrqXcLLWqdJzGD5+DVxX45XxJ9oskebBhFkpoTp4yv42zY2SRAIN96gm7p/S1knEtVqn
	5bEd583Bczkc1SynHYKRMHzuN8wcrkJ8pQHMBJhuSevWRAz3juZmYifpEVOoMziV5GrNqPWaaVD
	y0iAtiQUIbfaImTRoivOYj7ubE2gcKtrSjBoocl4J5kJFnrstVd7EggMLsNuWtTwZtjC/Cm5kfD
	AI8EvclYgAz38NPgLDx617k13y1v+yuxrMNI29kLfI9+vOntLN3U1Cj0l9dmaIxMuBByslB+kbG
	DnQfdCpHMs7Ud37OgWfCpW2/oeV5Y1nObOo+6iHcUaDv8eFnaKs1G5xAk8fLTik7IsVLazt0=
X-Received: by 2002:a05:6000:29c8:b0:45e:8526:7dc5 with SMTP id ffacd0b85a97d-45eb38b3902mr16847538f8f.28.1779722186152;
        Mon, 25 May 2026 08:16:26 -0700 (PDT)
X-Received: by 2002:a05:6000:29c8:b0:45e:8526:7dc5 with SMTP id ffacd0b85a97d-45eb38b3902mr16847494f8f.28.1779722185615;
        Mon, 25 May 2026 08:16:25 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9de2dsm26855784f8f.4.2026.05.25.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:16:24 -0700 (PDT)
Date: Mon, 25 May 2026 17:16:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	horms@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com, 
	davem@davemloft.net, jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahRmBTnNMrg-oano@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
 <20260525083859-mutt-send-email-mst@kernel.org>
 <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
 <20260525155322.240fbd87@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260525155322.240fbd87@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0aCHHuinM-5binI5KvijWVWScC5s-bXjyjcp4sPRMjo_1779722186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 25, 2026 at 03:53:22PM +0100, David Laight wrote:
>On Mon, 25 May 2026 15:09:54 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
>> >On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
>> >> On Mon, 25 May 2026 11:57:45 +0200
>> >> Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>> >> > >On Sat, 23 May 2026 02:20:29 +0000
>> >> > >patchwork-bot+netdevbpf@kernel.org wrote:
>> >> > >
>> >> > >> Hello:
>> >> > >>
>> >> > >> This patch was applied to netdev/net.git (main)
>> >> > >> by Jakub Kicinski <kuba@kernel.org>:
>> >> > >
>> >> > >Did anyone else notice that is isn't a bug?
>> >> > >
>> >> > >There is no way that a 'count of bytes of kernel memory' can overflow
>> >> > >the size of 'long'.
>> >> >
>> >> > It's more of an estimate than an actual calculation of memory usage if
>> >> > we queue the incoming packet. In theory, an overflow could occur if the
>> >> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right:
>> >> > the memory should run out before we get to that check.
>> >>
>> >> The calculation is:
>> >>
>> >> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> >>
>> >> skb_queue_len() will be the number of items on the queue.
>> >> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
>> >>
>> >> Unless you either corrupt the queue length or manage to allocate skb that use
>> >> less than the minimum about of memory that product can't overflow 'unsigned long'.
>> >>
>> >> The later calculations might wrap - but the multiply can't.
>> >>
>> >> -- David
>> >
>> >
>> >Indeed, I wasn't thinking. For this to even get close to overflowing
>> >we'd have to have almost all of 4G available to the 32 bit kernel taken
>> >up by this single queue.
>
>Except there is usually only 1G or 2G available to the kernel.
>And all the skb would have to contain no data.

`skb_overhead` was introduced to prevent exactly queueing skb without 
any data (essentially containing just the EOM for SEQPACKET) that we 
plan to fix properly in some other way instead of queueing empty skb.

>
>> >
>> >Revert, I'd say.
>>
>> I also blindly added the cast to silence sashiko :-(
>> I see now that it could never actually happen, but semantically it’s
>> correct, so maybe we can avoid the revert.
>
>Lots of things are semantically correct :-)

I see :-)

>
>I didn't look any further down the function to see if it could be
>'unsigned long' (or even size_t - but I like 'proper' types when they
>are always correct, I have to remember that size_t is unsigned long).

IIRC here the main reason was to handle the next check with u64 to avoid 
overflows (buf_alloc is u32) when it was introduce, but maybe, after 
commit c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to 
preserve full buf_alloc") it could be size_t.

>
>The problem with the (u64) cast is that gcc is very likely to make a
>'pigs breakfast' of it and do a full 64x64 multiply.
>It'll then try to keep the 64bit value in a register-pair which ends
>up being spilled to stack as a pair.
>I've seen it spill a constant zero and do a multiply by an immediate
>zero when doing 64bit maths on 32bit x86.
>I think gcc can hold a 64bit value as two separate 32bit values; that
>can generate reasonable code. But if they get merged (eg because of an
>"=A" asm constraint) it all goes horribly wrong.
>This is why there are some asm 'helpers' for mixed 32bit/64bit maths.

Thanks for the details, I'll keep these in mind, really useful!

Stefano

