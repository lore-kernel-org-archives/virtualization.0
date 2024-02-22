Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B6150985
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616496; cv=none; b=qJsVhvqRvQ2zDsWxR/ZgmSQdpJAtWz4wShLYTxhp4ybx4PjxFcV7gyc1xRpes2l1itv59Yx2zE/HHf/IXM694qjAzq5idUv/ijLM/jXbNq/6R9Y77Iu4pjvgALFCrfzr7OHx3AXnFf1CCQVpFpfM/p/13C5JYq2mP7nddZ7OXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616496; c=relaxed/simple;
	bh=t2Y541NBTF20XK3dcuTaD4MfPwHo6wDUA3Kzlm90WZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mCDqLHeLc0ZPuYMkIzG7EUxXyG8SzRkkXKQXQyxp6l6oHf6qq331I7/0XyInwRtWE1CVVOYfY+IvZ0vAt1EVGxr/809xHTUSmjWZoulVHR6eK3BXxKDfZcaxaEk3jQfPfuMxuI0Yxyf5CXc6ZAA6fYrQPEgQiXXSiG5DR9+Lc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crVvQVJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crVvQVJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708616494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ohgWeecE5sLvAbR1ati6o7mII8imwpShQzkYvL5vVU=;
	b=crVvQVJWUGcpe1JgVC0EWZHnRHjpTR4dbXeRghxifHmbyY1NQMSvtepavK/FjBTNjVjHU2
	4bwWwqLKc2LaxBmx8nmFHOAwb9pYDBou1KBabRJ7pwT4CjLY/hAXwKt1rPgQw8Gmal/iET
	bAt3MmemMomzzdDFalOigVBLjNtTXDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-hrDUaNFhMROuy4G4JKzqkw-1; Thu, 22 Feb 2024 10:41:32 -0500
X-MC-Unique: hrDUaNFhMROuy4G4JKzqkw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4121ac8634aso34008895e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 07:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616491; x=1709221291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ohgWeecE5sLvAbR1ati6o7mII8imwpShQzkYvL5vVU=;
        b=CvXf8sga8q5Fd/ENNIwpO/pcBR3+uY/dsgeMXTP5RIcJwxsXUxStO2yk6JRtwsZIQO
         0tRaAxzScZJbCEhyMWtF4Z0evKIscrHMck/yC3Kmj8g+/5HAc9AcB7P0Uc+SPj+mag8B
         lY8wErlQR6OVKKbCY2xRfYH28EavlKg9XJs1U9dszV58hx686+qjfT4K3i+YBPmaE64M
         u668uKjzwfo4WOZGbu+q87GzDjysECz+y0wp5JRpZo+yAoMEBEI+GpFP5L+EmrWhqwgZ
         hHrsAgbIxEQRyUIumv+3hDXQi7Suq00WUBZQMA8KqeifG8/N20cZnl8JGFs9/73fSIxi
         4q4w==
X-Forwarded-Encrypted: i=1; AJvYcCWn0nVje/XjVvdT8g0s/E5XM34Y5jxdc3aINcqiONDa7uE+95PTyYF1U0+PSvOvKpJ6AL/q4u6vJ9ZsyweNchIhoIEH+HACHJCmJSBMx/Y=
X-Gm-Message-State: AOJu0YxM4YKHd9uCOepMXkgxu7UoGs7E3T0HZW2hres/IaD8lt8elQde
	JT3Eq6S4tVl1v2uQwyfrQoxGcH+gB8FPNsT/AqXBmJPZSz8UTxhuoF80T3owxq2qxHWUlTqyo2e
	a8qXVkjpRhb/OI/3L/tHfYUGxUlqdqLSWSef60zVnIriIr54wf/i6hGl/rHpWDihP
X-Received: by 2002:a05:600c:4f82:b0:411:e6fd:4ad with SMTP id n2-20020a05600c4f8200b00411e6fd04admr17000830wmq.5.1708616491548;
        Thu, 22 Feb 2024 07:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtqkR0KaYBzcVyqpjgYX963S7RxaFGa+tK0UVfi315EcYLlqk4dk7ACCc6QXbmqO7Qpvbbag==
X-Received: by 2002:a05:600c:4f82:b0:411:e6fd:4ad with SMTP id n2-20020a05600c4f8200b00411e6fd04admr17000815wmq.5.1708616491215;
        Thu, 22 Feb 2024 07:41:31 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:1600:1669:f0ad:816d:4f7])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c365100b004126101915esm6463325wmq.4.2024.02.22.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:41:30 -0800 (PST)
Date: Thu, 22 Feb 2024 10:41:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lei Yang <leiyang@redhat.com>
Cc: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [syzbot] [virtualization?] linux-next boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240222103932-mutt-send-email-mst@kernel.org>
References: <000000000000d305050611b50d09@google.com>
 <20240219022853-mutt-send-email-mst@kernel.org>
 <CAPpAL=y+-YrDUsKYVBig4dc-7+Cg1Lk_VWXPOKeL=s2Fitf3mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAPpAL=y+-YrDUsKYVBig4dc-7+Cg1Lk_VWXPOKeL=s2Fitf3mA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2024 at 11:06:55AM +0800, Lei Yang wrote:
> Hi All
> 
> I hit a similar issue when doing a regression testing from my side.
> For the error messages please help review the attachment.
> 
> The latest commit:
> commit c02197fc9076e7d991c8f6adc11759c5ba52ddc6 (HEAD -> master,
> origin/master, origin/HEAD)
> Merge: f2667e0c3240 0846dd77c834
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Feb 17 16:59:31 2024 -0800
> 
>     Merge tag 'powerpc-6.8-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> 
>     Pull powerpc fixes from Michael Ellerman:
>      "This is a bit of a big batch for rc4, but just due to holiday hangover
>       and because I didn't send any fixes last week due to a late revert
>       request. I think next week should be back to normal.
> 
> Regards
> Lei

It all looks like a generic bug dealing with some refcounting
in the allocator.  So, a chance of a bisect there?

-- 
MST

