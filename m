Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F9384253
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714625; cv=none; b=j3UHpSWxXPKNWoA1XZiiEPjRKe6JJfP4V6s90cJNrb5hd7beUnXCFhdyJVKqy1bTGhv+MKhD28zdVab7G6EBROCtGZJR2rhVYLIisuHbFyYpf2mNTV27PAGTTLLnk3tdEXevMEqFS5/MNV4kV4mvTpxRnXkqL7byeEP8VWIrXE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714625; c=relaxed/simple;
	bh=BGZXA1mN8FhVP5FiDTI8b7j+Ir1HdkD6PebA7BvFpSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DEbGV9nYUo1u5xe2LZGXqt4POVNClzq3noYNZCDrikIWPzs3wiB2jMZs09gLqz2T+W6xjdQKE62lWFs44u0B2gox82LbhQV3EuFF173ZTQ3mqFYRpeW5tRXnMkFKNAPJT6QYvPDR7N3LPcNKJinH5FVYhyKyfiq7Dx1GLy3HRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJqt2KlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJqt2KlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779714613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
	b=gJqt2KlHQ7/8fTa6bPelFllEfeUJ6f3LmBisFEF5UivNDOgqigiVN+OLZ7GxlXKJTYzkEY
	jWlcd8lXohnxSj0aGH4r4lAsQdzVZKA4Kq8V4gdMdmA44uBjlHV0o+hgx03mG05FPtvv10
	3WRhT38u5cYxNukbrrQs2slNC7rAXic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-yGbSJ2vJPYWLK-u4Y3qkHg-1; Mon, 25 May 2026 09:10:09 -0400
X-MC-Unique: yGbSJ2vJPYWLK-u4Y3qkHg-1
X-Mimecast-MFC-AGG-ID: yGbSJ2vJPYWLK-u4Y3qkHg_1779714607
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49051422d55so18952645e9.2
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 06:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714607; x=1780319407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
        b=DU1fR51wGFW30NS/2xNNnuBUrUHKVdZS10T7zxgaDqLJ48SjSp1n87Vr5c7tjWCSwx
         CPv7gqv+3Ku2BqNG3R7ppHf6TJ0KxmOQ0c3GyPW3bGJImonxh8LdZJGLbeIhwM4kbGgo
         9u1Pvo+x4OrAFcLkte9hsmcOhBAMuiqwcHgk/VRLJaCUJyHc5s5J1laD25V5cikD5qIG
         lSEhx9tRPGJF7ef//HgtQvpknBU0AiQAA9q1WM8LfR2nIjUtIvf4AKjrJ6HZkymxza2k
         gacw6g4mrnM8b9fQKP4+Yes43Ge8KiUXf9NRhPv39rgbt50YR8HBhzGCJghab73NdIIs
         TA5g==
X-Forwarded-Encrypted: i=1; AFNElJ+tHs78KtcQdNl2mZAZH8AjDuVCKLq7Y/8EuvKEoVIx9qz9EL8tsEwjFRuWqKuMzpX6FL5VsYarGuyktLevZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjaCMuu54vvVpUOuk5+NOzJpYdzG7tQOFLzmi4OR+bxK419Dpo
	HXPNaHBeGtgxVIO9tgsm7dl916Sysn6tUi0z5qLKJ8gcrg33vaEacuph6h2wpuCOe2safa0c6Uq
	yogkd8fHDm72DHfUUGIqr64M2ZGSh+zZ8texVwyzWmYtkDiNQroE+NZVwkwvfdK9XuM3OvKtbE/
	jF
X-Gm-Gg: Acq92OFeL4Cvx9xN5bYD7xCnHhOmuFstcvIHe30HUpLrNnUIH01DgIhXy4dnD/HxF5s
	p5l403yOcbNWaRjo42oIjwdxKa0R7sdF89b1VcGRjZ2kgslIbE75mpDjOa1U3fi9BzCVyxOxIgp
	a+oJWS8sBxzJxBCN4Yzt20pbC/BdTpHSzJr1BM8N7ylyjFjvtddOwa4Kk9mEFQfrdQfPUL5P/93
	XUsGcr68QI3U/3YYQLBVs6KieH2iwKx9eH8Ei35wbg/mueFx8aGlyvQxg9dPU/GQrM/R/MEeT6+
	JFJTbaq/PvnUFx03x3PY7TiLMGvkBoMoUCmEd3VfyZE6bgFi+c4aOAQmSwb6oLIelCuVBbIBjP/
	PtPnvLqeTyQixB4G3JvvaX8Pcq5V2InY+E0VIQUGBa8xSSRG7AF5pSj0mhWVlUpZtB9nsvsbfmt
	ARY40n9g==
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270213785e9.18.1779714604272;
        Mon, 25 May 2026 06:10:04 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270211505e9.18.1779714602516;
        Mon, 25 May 2026 06:10:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm118548825e9.5.2026.05.25.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:10:00 -0700 (PDT)
Date: Mon, 25 May 2026 15:09:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	horms@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com, 
	davem@davemloft.net, jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
 <20260525083859-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260525083859-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wziKpIkepx8Bo8__-4HZelGy689CsgcxSNvzTIRXEqI_1779714607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
>On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
>> On Mon, 25 May 2026 11:57:45 +0200
>> Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>> > >On Sat, 23 May 2026 02:20:29 +0000
>> > >patchwork-bot+netdevbpf@kernel.org wrote:
>> > >
>> > >> Hello:
>> > >>
>> > >> This patch was applied to netdev/net.git (main)
>> > >> by Jakub Kicinski <kuba@kernel.org>:
>> > >
>> > >Did anyone else notice that is isn't a bug?
>> > >
>> > >There is no way that a 'count of bytes of kernel memory' can overflow
>> > >the size of 'long'.
>> >
>> > It's more of an estimate than an actual calculation of memory usage if
>> > we queue the incoming packet. In theory, an overflow could occur if the
>> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right:
>> > the memory should run out before we get to that check.
>>
>> The calculation is:
>>
>> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>
>> skb_queue_len() will be the number of items on the queue.
>> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
>>
>> Unless you either corrupt the queue length or manage to allocate skb that use
>> less than the minimum about of memory that product can't overflow 'unsigned long'.
>>
>> The later calculations might wrap - but the multiply can't.
>>
>> -- David
>
>
>Indeed, I wasn't thinking. For this to even get close to overflowing
>we'd have to have almost all of 4G available to the 32 bit kernel taken
>up by this single queue.
>
>Revert, I'd say.

I also blindly added the cast to silence sashiko :-(
I see now that it could never actually happen, but semantically it’s 
correct, so maybe we can avoid the revert.

Thanks,
Stefano

>
>> >
>> > Thanks,
>> > Stefano
>> >
>> > >
>> > >-- David
>> > >
>> > >>
>> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >> >
>> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > >> > to 32-bit values. The multiplication can overflow before being assigned to
>> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> > >> >
>> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > >> > 64-bit arithmetic.
>> > >> >
>> > >> > [...]
>> > >>
>> > >> Here is the summary with links:
>> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>> > >>
>> > >> You are awesome, thank you!
>> > >
>> >
>

