Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7343AA1
	for <virtualization@lists.linux.dev>; Fri, 27 Dec 2024 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735274055; cv=none; b=gixZAIIRy3vOW8/i8rWjhaCe3S94wTqJVBDLqc8xPRHmwzJCmjyyBy3ZrWpKg3E81lP0e8zbIXgMjD4hO4bohnDD9nOhGRE9XLur97XBt1nwvSRS9rJzdbwKtrZdUB3/kVIiXs5W341Cg3aDfsLNuJPNHYnBB11WBlR8h5Ax5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735274055; c=relaxed/simple;
	bh=FVW7XNY64xuydDmLofP+sTKTUNUDp24hB/HXdgDSItk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1RvIrMcEjf4ZqP2RJMIIXBU4fOQ+BoLo3eTmvNKYhh/0Kns3D6jWmEU2rhsuPopG4srTy/mRFmuq+EsvbzWbMbmds1zZJXHmnEpslOBvnbDUwm7Ol6xkIAKFhDQAJXN8T1wFMyxSFjSg0M7gWcBv0B8BGnyPAsm+0vsf8fETyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=u7TavqZY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="u7TavqZY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso6531628a91.1
        for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 20:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735274053; x=1735878853; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwCjjlIrKBk+YtuDMOqh5H8o6TB/HNBq181H/Zb/guw=;
        b=u7TavqZYErKtiVfkuyxX+Lmy5kh6qypyiAk1y0zReaBas6nNBcNlqMLjco94VlrsP/
         4bcTArsWrS2P6QugrSGxVCONkBSsnlskE9BKyQhLR6u8k6jqAYb2uAj1q2XTx0c2D4Iy
         YDd2SL2/KQabCa8MNuqeEG7+exV6CI5ceTbTWnIywCiOQG6Qn0kpIIlZEa2FKK5hYqs5
         d0RRyA5S2EQOAmlLM/zBuWz33m/pkEqpscrt2mvWE1gPS6VSKw1uFwp4orFKC3jqDGs4
         o3eatso87GkfXxoc2VU5dTWbHAeMfZ38auWVqsio6chZrDjKjlUW1X7WMa5mES1DpEVI
         FoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735274053; x=1735878853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwCjjlIrKBk+YtuDMOqh5H8o6TB/HNBq181H/Zb/guw=;
        b=gMfGGRdhzEo0wBwG1E3+Yt6D6d8qB+/zTVCDviWQVxTQchdnIIoqnJlghp61Puo0fQ
         UGyLpunajHJ/wbnUjXnW5N4RN2/q+LSXJBlJYE/HtouOgdgxSPDJYXMFAoFNy9PnqaEh
         /IwEFSdbXm6+7LhIqQtHgVSEKPBiWRu3jnxtdD9JxBx+Iam6k6zZ/5Oc7L63hXRKd1o+
         oVQ5d4kAt/GONPXeKWSmSNQzHAAyjeserp+Zw02qb3Sm47AYMlybIBB/aKJ5QKY9xYdd
         C1apGRDnUYtZC5K5Jw4sNJIw3CWkbNi2gf7oAzUEno0fVz81KZy2QAgUeRYNRXAt+Cez
         x4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDM2rqaG3r66NaHiAAGRZmVjrSjRaVqHNGHczUPDVScdBnSc5E+A8iinsvlNpeSKLlfOPjzS2ygjDmXB9Mrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwC1bbveOKrE6XzoPh0xA4+jCl1KpECm0SIDKV0lDXmkCyK+Sd
	08owH58UtLjIHvYODIMiu8v3U6/T9Hc1R3f4riARCOgZOCMLaNBqkPWrNCBGUvc=
X-Gm-Gg: ASbGncuFdTwx4LJ0PVON12+VCtaOFvT7Vrl6ci48bDCSNEGA1w7NAdDogdscg/CAGvk
	vl5wV0UHaMv1uYtDbZgvHVdJaCJZoeQEwJR2xF94mHe9NDZbcuJBUefwKVy128uk326qPhkBr/y
	rhlkoNQiUYNdE2rsNKrLhW3biV/PQdUsVItSVigSL7bwmOIVDu3woGouKvsimUOUOsOqZz5BKmc
	PzXVeY26SZy24tIcVWd0m06h+TQReuhxFqQ10ewnp8jDjuHaYSZfz+wseIWr9VXBw40MA==
X-Google-Smtp-Source: AGHT+IHbpgq5016PFvFeTeZ6RoKGAfu8Cv7iPr2JE4+A0XviJrDeYl5kAk/GomPB/LPyZ9Od5C0lCQ==
X-Received: by 2002:a17:90a:c2ce:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f452eb24b8mr34814458a91.23.1735274053570;
        Thu, 26 Dec 2024 20:34:13 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478a92absm14894900a91.44.2024.12.26.20.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 20:34:13 -0800 (PST)
Message-ID: <cd4a2384-33e9-4efd-915a-dd6fee752638@daynix.com>
Date: Fri, 27 Dec 2024 13:34:10 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
 <20241106035029-mutt-send-email-mst@kernel.org>
 <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
 <20241226064215-mutt-send-email-mst@kernel.org>
 <CACGkMEug-83KTBQjJBEKuYsVY86-mCSMpuGgj-BfcL=m2VFfvA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEug-83KTBQjJBEKuYsVY86-mCSMpuGgj-BfcL=m2VFfvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/12/27 10:29, Jason Wang wrote:
> 
> 
> On Thu, Dec 26, 2024 at 7:54 PM Michael S. Tsirkin <mst@redhat.com 
> <mailto:mst@redhat.com>> wrote:
> 
>     On Mon, Nov 11, 2024 at 09:27:45AM +0800, Jason Wang wrote:
>      > On Wed, Nov 6, 2024 at 4:54 PM Michael S. Tsirkin <mst@redhat.com
>     <mailto:mst@redhat.com>> wrote:
>      > >
>      > > On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
>      > > > The specification says the device MUST set num_buffers to 1 if
>      > > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>      > > >
>      > > > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
>      > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > >
>      > > True, this is out of spec. But, qemu is also out of spec :(
>      > >
>      > > Given how many years this was out there, I wonder whether
>      > > we should just fix the spec, instead of changing now.
>      > >
>      > > Jason, what's your take?
>      >
>      > Fixing the spec (if you mean release the requirement) seems to be
>     less risky.
>      >
>      > Thanks
> 
>     I looked at the latest spec patch.
>     Issue is, if we relax the requirement in the spec,
>     it just might break some drivers.
> 
>     Something I did not realize at the time.
> 
>     Also, vhost just leaves it uninitialized so there really is no chance
>     some driver using vhost looks at it and assumes 0.
 > >
> So it also has no chance to assume it for anything specific value.

Theoretically, there could be a driver written according to the 
specification and tested with other device implementations that set 
num_buffers to one.

Practically, I will be surprised if there is such a driver in reality.

But I also see few reasons to relax the device requirement now; if we 
used to say it should be set to one and there is no better alternative 
value, why don't stick to one?

I sent v2 for the virtio-spec change that retains the device requirement 
so please tell me what you think about it:
https://lore.kernel.org/virtio-comment/20241227-reserved-v2-1-de9f9b0a808d@daynix.com/T/#u

> 
> 
>     There is another thing out of spec with vhost at the moment:
>     it is actually leaving this field in the buffer
>     uninitialized. Which is out of spec, length supplied by device
>     must be initialized by device.
> 
> 
> What do you mean by "length" here?
> 
> 
> 
>     We generally just ask everyone to follow spec.
> 
> 
> Spec can't cover all the behaviour, so there would be some leftovers.
> 
>        So now I'm inclined to fix
>     it, and make a corresponding qemu change.
> 
> 
>     Now, about how to fix it - besides a risk to non-VM workloads, I dislike
>     doing an extra copy to user into buffer. So maybe we should add an ioctl
>     to teach tun to set num bufs to 1.
>     This way userspace has control.
> 
> 
> I'm not sure I will get here. TUN has no knowledge of the mergeable 
> buffers if I understand it correctly.

I rather want QEMU and other vhost_net users automatically fixed instead 
of opting-in the fix.

The extra copy overhead can be almost eliminated if we initialize the 
field in TUN/TAP; they already writes other part of the header so we can 
simply add two bytes there. But I wonder if it's worthwhile.

Regards,
Akihiko Odaki
