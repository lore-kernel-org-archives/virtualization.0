Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883A3E122C
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960683; cv=none; b=HOaCS1g0mdY9krx3PqbsqmnQp7lpKAjnOPrTsyKf6nzkjzuJeVEVlFQbg9iovX0yq+UzrENDLhy6US/wmpn4C7XMgsHs4dKClZWttrrAbq74UWRkoYYKgw+U8TOlU/EAs0q8nxuLVZPEG4tTUUSlvV417sac9hOVgKE2eUX7ylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960683; c=relaxed/simple;
	bh=WyQ1KWk2tLGzM5pawO7qh2AFOjdX00b5vnT3sEq6bbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tywvZR5OLSu0/Pwr98aqfbR/2tbpBxT05DTfblvRFeb3mSdPo4y1CL4Pp+YJc8ShrdjWPw8yvFabwXfPrbDIUQclRHGsOvnpdK1OG3/IRF985PiJ0YXrL65GI11yg8rp4IInkGYE2aMKDp1ivrfamx69sWpgEGaP1sj+/QiHCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVCxKPx8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVCxKPx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774960681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzhsTZpeiHM1+rlPEAX0sxNpD7HCMbnEx89xRuI/9Vo=;
	b=UVCxKPx8mscLlUCerZd2zDsgmk5reU3r5cBEy3/n5Ze1i1sNIC/Fjpm0zuZFEfh+gvX94w
	ypup5id5JE+oMqWSTm72ceEz2bikcb6qQBfgeoKbCHgaM0wLzdvP4S4sHdt/5lyvK6/y/A
	VzqI5MCVp5QSQGi6P/kNC2e96rL6S7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-734fXoccPPet4Phz9ggFyA-1; Tue, 31 Mar 2026 08:37:59 -0400
X-MC-Unique: 734fXoccPPet4Phz9ggFyA-1
X-Mimecast-MFC-AGG-ID: 734fXoccPPet4Phz9ggFyA_1774960678
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4871f6712ebso33327565e9.1
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 05:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774960678; x=1775565478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzhsTZpeiHM1+rlPEAX0sxNpD7HCMbnEx89xRuI/9Vo=;
        b=mVi4kCX4H19woYNk6Kjqxd2IHpeXxEf+ubMMnouFCsuf5IN09sP876H9VudYGSSesJ
         vCrWlne9UruNxrYTR3PGZK/z/cxMuuJgfaJ+tG+TaSwtwODZyZzrTIMVAsyfqOWAU2fF
         Aa2ilNC7LlkzT+EaeEjxmu074yvouc8pdMwAxUm7c5yO6Qsyhpe5m2MfEI8/RF27GQAH
         A/ljZ7lFs0R+CQmwah74zK9pxNV+lnFJJIYht2yRrFWeyTDTXNC2zLz/oLuou6jy3xx7
         pNVOghKKFuhKk73qholsTKUhXtYq96/VdcPhUspYZCrB+YpAgxcxGDifC3+p/BUvpE2T
         AioA==
X-Forwarded-Encrypted: i=1; AJvYcCUr4S7fS/ZBeqjM+5Dsj79ljuI+vnz8xz1zoyHOK6SjIDSxyImDzW7rwZApwNZv7Jkupc87jx0RJ1Gn1bC52w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzboSAYxD5kP/4/ADivt/RoymKz5zma/CEfXJICz7wpRFoG55n
	46Hbd3j1Di84Qtburnk1tvHf7WTgp9KDTed37MJd0jqhLIjXBoezWg8+sGxIRV742m+UoLfDTQx
	M6q08wtpZVM1Jj7fwGfL4j7h4ZIF8xES0o5uomW2Lozgz02zsROPWZWt4awE2EtpsuKuf
X-Gm-Gg: ATEYQzxi2GtDhV+GI6jxNmyUsX2FPJJLHnoHoHSUTiyZifkSyMGCwMkIrAOg+4bTuCL
	UnucJLBS8itBSeKhAlegRI/UqVxEKNpr7IKUECvUiK2GbW6rdnZTUIIj3rKLAsRzKxM8HRPx1av
	ThuIfIaAqV3C1//ZY0C76LIZoTcRURI8CnPMjxkS+N8bapxpBI5lm4I8UhZUAFgFXRSFsCJzmSN
	cidjqfQFr1PIn9Y7GoxFBJ35IOS7rApGbCp4GGMfAaJVbd68nPEkR6YbBgn0JxOMRn3Swdfapcn
	94N2/yVRYYIurWUt0YJ85M4XRAEMCB48ZDoxerGqcKGJEu/unQxLu1h1fOitTbRgCvKSNZhN+vK
	yjC/t7G8VuFM//ukiiQgrLMP73lkDe4vlNB/WVGESkY3pLHrIoM5Vca7yoUKGPdR71MujZGZpW/
	Cf
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr266099615e9.4.1774960678327;
        Tue, 31 Mar 2026 05:37:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr266098995e9.4.1774960677780;
        Tue, 31 Mar 2026 05:37:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80148csm35693595e9.5.2026.03.31.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:37:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:37:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
Message-ID: <acuKUpZQq6z1DY_n@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wWURA_aGqx3RNC5-cfJ8ZuuTRYE0lFtdcfyceBVuFbE_1774960678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 24, 2026 at 06:28:12PM +0100, Norbert Szetei wrote:
>Hello,
>
>we have discovered a bug in AF_VSOCK where an unprivileged user can bypass socket
>memory constraints. This leads to refcount_t saturation and OOM. While
>refcount_t prevents a true UAF by saturating, the resulting state triggers
>kernel warnings and kernel panic, depending on the setup.
>
>In vsock_connectible_setsockopt(), the SO_VM_SOCKETS_BUFFER_MIN_SIZE 
>and
>SO_VM_SOCKETS_BUFFER_MAX_SIZE options are used to update the buffer's minimum
>and maximum values independently.
>
>The vsock_update_buffer_size() function clamps the buffer size to the maximum
>first, then the minimum:
>
>// https://github.com/torvalds/linux/blob/c369299895a591d96745d6492d4888259b004a9e/net/vmw_vsock/af_vsock.c#L1950
>if (val > vsk->buffer_max_size)
>	val = vsk->buffer_max_size;
>
>if (val < vsk->buffer_min_size)
>	val = vsk->buffer_min_size;
>
>vsk->buffer_size = val;
>
>By setting buffer_min_size to a large value, the second clamp overrides the
>first, forcing vsk->buffer_size to exceed the intended maximum. The transport
>layer then uses this value, allowing unbounded SKB allocation that saturates the
>32-bit sk_wmem_alloc refcount.
>
>The fix should ensure that SO_VM_SOCKETS_BUFFER_MIN_SIZE cannot be used to set a
>value higher than the current buffer_max_size. Conversely,
>SO_VM_SOCKETS_BUFFER_MAX_SIZE should not be allowed to be set lower than the
>current buffer_min_size.

Okay, but that wouldn't change much. As long as the user sets the 
maximum to match the minimum you set in the POC, it behaves exactly the 
same way, right?

Maybe we should add a sysctl to set a global upper bound, but this is 
another problem, I agree that we should improve the kernel behavior 
around min/max.  I see 3 options:

1. Just invert the checks, fist check for min, then for max.

2. Simply adjust the min and max values so that they make sense. For 
example, if the minimum value being set is greater than the maximum, the 
kernel could adjust the maximum to the same value. However, this would 
not change the behavior of your POC.

3. Force the minimum to be less than or equal to the maximum. This, 
however, would require a certain order when setting the minimum and 
maximum, especially relative to the default. For example, if you 
increase the minimum beyond the default maximum, you must adjust the 
maximum first; conversely, if you want to set the maximum below the 
default minimum, you must adjust the minimum first.

I'm more into 1 or 2. 3 IMO is too much.

Do you want to send a patch?

Thanks,
Stefano

