Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DD21771F
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366252; cv=none; b=Ff+Tx5OvG4S5htV8n9WiXp1IoSjOtoOXP7336Y/eUKVh9UcJbEoQqSansiSNTaO6R80GoLXhXmsG32q535DAgQvQoIWnh5C5NHiv5ItfGmrTgCEpE9QmKaV8JILadhUAof3IYoT5wKdtB66dWApg/UayV3x8tugPwW9vThKeN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366252; c=relaxed/simple;
	bh=heXSovKMp8WMZ4/NmKFQEomaA05X7Vw0t+hCl43nhvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rMVzNsv0Cp0PtJHaQWrkZtYz3odCWur0ZfEdmqkMUR6d3MEU7y3q2l5/+ecrLqkTG/njT5jETMydts/1+3SXOXqOCF7YVdbcNUaGRn4gGfZMnwbfbkkN5LOs04GLtfeG8Z9QdIMm72sIKOTyDHUU56p3XItWZDasGUQpz86NwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg3kZWqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg3kZWqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751366249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2ir46AUDqqNyeG2en8npeW9OEH0djU5Wi0RBd8xUlA=;
	b=Bg3kZWqrGMOkDohS2MVzZHxtsKyyqExL6zEhzvzELiCI+wUmUWsRqFqVGGG9lWMdm1Si6S
	Vqzb+N7/MuVWfBe5WTyimxIoMkzW7O0tHflqmj265QfhOVnr4SPOCs3gZqeSjcfCKlub6k
	yPC8ARjVy5+OzjPJLWTogNak1AmTeQA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Mvzakr1NPbq2vaVVxWIpEQ-1; Tue, 01 Jul 2025 06:37:28 -0400
X-MC-Unique: Mvzakr1NPbq2vaVVxWIpEQ-1
X-Mimecast-MFC-AGG-ID: Mvzakr1NPbq2vaVVxWIpEQ_1751366248
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-611d5826d59so1396575eaf.0
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 03:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366248; x=1751971048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2ir46AUDqqNyeG2en8npeW9OEH0djU5Wi0RBd8xUlA=;
        b=KMaii1SvMg85WiR2no7mS3AY9vKlZyYuL3RQC1E4W1qPJeQQLjEImxGp8lS+LI1Ocq
         nS97MkBEkk7Qa+D1zkxIuFmvr+/BXXo6N2cK+7tRb6Q8k9O8mEUXHZ7tBxOss7MzzLnW
         j27Djuoh864GEx4ziu3kUMNX4G516LJBhvFTgZzW3hkyhT+Ee79h+l3K57knv66P2sta
         Bfb+sE/ol+MDbMGYFdLuKVtIovM9yin90hgYZvkwHQvEu4lRTDYlOGLdaG3iUXhLEOSp
         D6SHh/Ns/4A5Y0QUuLNXnoUPd2BlQetvLZo9oOjB7FM8BDpmZvL2hVQinXXIaNsMut0g
         Dl6g==
X-Forwarded-Encrypted: i=1; AJvYcCU5IgWQnQoX0Ob5MT1euvoZl25jsznP97V4YQqWGims05SLxqH6VKDkHFAjmpTzHgSuH6Q73Ab8WuKYbT6xJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM4cXtUEOzalUONrpTH7xwgkG2B2JbGtP5APLoMA7KqOcii8QT
	j9oNTH0C8jPoNFQ+i3zyyf98hjegZUUUL5RcqSNTbncuek6Agkeattj538jBypqd9tO7Jl+39Zp
	mPLi7J/I3HhT2Vu232S8E2dPgJwToajR1F+/VRIpy5rln1zW4NoQu31tQ38utjdE/9j+h
X-Gm-Gg: ASbGnctDOipsT0Neez57D85O23bNosjk8FoklDN60YwKkwpa+QYdF0ZbCVe6KoCBiBu
	FrlX89WVN/yw0faaLCY+tfuxj8/VLmREs3flcrCrxQlkck8vpCegSS1k/dTG8qcKLGXM4Ib1BWk
	EAe/ZMUhcuhTY/0gEl15P/bBhSVW7N+XDko7cgHNmzrkZ8PFqhQ1yEH+wCnJXnwEcQ8Uj9TorG2
	qTcrlWvXc9MfMPYaW4XOokQR8lPfj8RQsZ/5C/SPh+aMgabndGQoE39EpRFvU+8OZzRRg1uugd/
	MS6JYXnH8uMsTT2LXGyuL5syVp1Z
X-Received: by 2002:a05:6830:4d87:b0:731:cac7:364e with SMTP id 46e09a7af769-73afc63c25dmr9915285a34.22.1751366247281;
        Tue, 01 Jul 2025 03:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVKJMDrLHZZIEx6Kk38/Nas6gM9Ud+smX4Ebygc9Zz6lBqLLrkX5YBPiqMFvYh1w2+bHAbw==
X-Received: by 2002:a05:6830:4d87:b0:731:cac7:364e with SMTP id 46e09a7af769-73afc63c25dmr9915263a34.22.1751366246892;
        Tue, 01 Jul 2025 03:37:26 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb107871sm2055408a34.58.2025.07.01.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:37:26 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:37:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Message-ID: <njwfflmq7swifmc5gwbovtju4bg2zg4cibpichtjhlkqkprvtb@5r5giy2irbzd>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-2-will@kernel.org>
 <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>
 <aGKIO8yqBSxXZrE2@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aGKIO8yqBSxXZrE2@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rW4FeZtfhvZJw0NhjPuobAc0Uy2DkWd-tWNXpDg8GFY_1751366248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 01:51:07PM +0100, Will Deacon wrote:
>On Fri, Jun 27, 2025 at 12:36:46PM +0200, Stefano Garzarella wrote:
>> On Wed, Jun 25, 2025 at 02:15:39PM +0100, Will Deacon wrote:
>> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>> > this is only checked once the SKB has been allocated and, if the length
>> > in the packet header is zero, the SKB may not be freed immediately.
>> >
>> > Hoist the size check before the SKB allocation so that an iovec larger
>> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>> > outright. The subsequent check on the length field in the header can
>> > then simply check that the allocated SKB is indeed large enough to hold
>> > the packet.
>>
>> LGTM, but should we consider this as stable material adding a Fixes tag?
>
>Yup, absolutely. I put it first so that it can be backported easily but,
>for some reason, I thought networking didn't CC stable. I have no idea
>_why_ I thought that, so I'll add it (and a Fixes: line) for v2!

yeah, this was the case till last year IIRC, but we always used Fixes 
tag, also if we didn't cc stable.

>
>That seems to be:
>
>  Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>
>from what I can tell.

I think so!

Thanks,
Stefano

