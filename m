Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13464429CFB
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768232; cv=none; b=PJAke8x5XWHiULMCynEFcYouYw8rOW4VsIIgMFNZXlg5O3ysrEiQ6qlvOTRY2+0jpxOZEvlHdYtiztJagGqUkm/RdHMhhpifC6oqziJEoCWhCZr6yRUacABhQCahO/zuzrVjHgh0l/Z0Zziyz2moQWR90fL0RRSj/Hh9TDsmwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768232; c=relaxed/simple;
	bh=wmhdTlozBmFoYEFKSTbuXzEqCAXVERRyi58TT6Rb4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZZLaoLqrjrlOM/4CVF9b6Z1DHT7JQ2lZaeub8u1dK9xCSvt6y8A421U5loghbXfD/0ovVI5Z3DvKEaaL8tDJME8T3qIpvuUvVd0ZJnRhpcoiGQFPvsox4lpCwHfk/lQY+3bQz7cVlDeMewowgorCCgBCRbQ2ogA2SpdzEK535Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaGKGMm3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaGKGMm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788768230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S01/akrLSba7r0QPArIs2eHPrcFzuABNmLC8uce5/dQ=;
	b=XaGKGMm3miQWzCW1Q+LdWdWkeb6a9dfVbAmX/cUDu/sqp7WY8X2cjjRiPSU3wj0mmMgRsy
	fx+YParlHqDaGWm2my0NPplK/PVOVXDLoH1QWTKkGdLxVHU/Y2zc6QZVciB15pmHrpKQCE
	jVuC3/FOiyTmvokSVRI0m1OgVvl5qwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-chVLp19IPtqXGMYEErnofw-1; Mon, 07 Sep 2026 04:03:46 -0400
X-MC-Unique: chVLp19IPtqXGMYEErnofw-1
X-Mimecast-MFC-AGG-ID: chVLp19IPtqXGMYEErnofw_1788768226
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so36795665e9.1
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 01:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788768225; x=1789373025;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S01/akrLSba7r0QPArIs2eHPrcFzuABNmLC8uce5/dQ=;
        b=OLF074ss7yCcZRGMTon3ra+lR+j3v1FFt7w6Rp/o/B+e9b1oMtdyEU5+Fh/23W7mE0
         JkE6HQc59k3W5ovMajcsE8RSVi+290xxqmOO7lm+IO3VrD93sultOhnBJvET0NpiAMgq
         86nSiGmsrrZZ/GySdCgP6vpHQCY99rfqkxUJme3GsSJMGu2YOxM+f0Zn6knxZQjYDbPQ
         +tiMRtBMXODekHExonyN/8aFzPId0vvCQMDpqggEux3XaluKkLNahi/4gOt/AoV3iLZm
         Fgpyy3KPMr+Ay8JNUMxDD3tl5O0m6ewJHhfA71tRg5/4TwzWLGBw1dOb1PfnDYczPHER
         exTg==
X-Forwarded-Encrypted: i=1; AKwUvByndujF3LBZfdiWRzv0IIeCqCEcznyppeMRswSYUFI1rA70g77BcJjuLr6BUvGz2Z2BLaPyxbXU1Ma51nWZPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lf8o2Oi4VuX8stbXPqYBWxfJZFALNEPOPG1lc3w3GcIjU471HE
	kWWYKH/y5PWCf+iN9W0ru9eUbtlwKlubzTjpKklnALvQdALeAc3IqFaTHVH+ROfwTDBrJOYZk/a
	Co13ieTnZY6wVW9zB1cklDPhgbo+dTmqgYIBWF7hcx3Nn1HSTuToFH2aX7fA5aMRfa/QYzaNwR1
	3z
X-Gm-Gg: AYBFou1BwimTgZ/aIJf35xFJLQK8ZJ34sdGfrb+ef4g1W7wZS1i8HTsM+cW105n+Sbi
	nO2VUK7Z6U4FZ9/8fUD7jdk3Q5kmwOdZOZwWfOdb7z+VZ9iWyZ7CXJMJOSHX+3g00ogix5TvS7f
	vXqLQvqh5WKcSk9OhY/FmOIiXI/rPyvCQYtq7MpyEdRmYUDZ11U5lSpeXtotNeWtg9dmiJuWFzB
	GictljTup/CZQlAbmPf3URghqmdvsaQIt3aiGGnqtS8+2Jw93IhUrecRpCytBIK7RUPrDFrWmrm
	QhDj/+XriIn/geRddKo2eXSjMgDN2/wIWKseCWEHAibpnT29IDXtP8M1jiFAcevtS6PyLeog+iV
	B4pEALmsothgJw2iJAR0mfDiQElyqTlUYDEpHhQFMEyVrUw==
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id 5b1f17b1804b1-49d05fff5abmr106383905e9.1.1788768225150;
        Mon, 07 Sep 2026 01:03:45 -0700 (PDT)
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id 5b1f17b1804b1-49d05fff5abmr106383095e9.1.1788768224533;
        Mon, 07 Sep 2026 01:03:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm200078385e9.13.2026.09.07.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:03:43 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:03:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: weirongguang <weirongguang@kylinos.cn>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Rongguang Wei <clementwei90@163.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1] vsock: validate buffer min/max size in setsockopt
Message-ID: <ap5uSKRcfnjhXyC3@sgarzare-redhat>
References: <20260824091257.136269-1-clementwei90@163.com>
 <20260824131632.2d325c42@pumpkin>
 <e16178ad-85c6-42da-931f-f0b2f8240828@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e16178ad-85c6-42da-931f-f0b2f8240828@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46rFCX21p5fVH0dFWBRl_I-vu3tcinu6ZQQ6d1WDdgQ_1788768226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 07, 2026 at 03:45:54PM +0800, weirongguang wrote:
>
>
>On 2026/8/24 20:16, David Laight wrote:
>> On Mon, 24 Aug 2026 17:12:57 +0800
>> Rongguang Wei <clementwei90@163.com> wrote:
>>
>>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>>
>>> SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
>>> do not cross-validate against each other, allowing userspace to
>>> set buffer_min_size > buffer_max_size.
>>> When min > max, buffer_size is silently clamped to an incorrect
>>> value. For example, setting min=512KB then max=128 results in
>>> buffer_size=128 despite the user requesting much larger buffers
>>> via SO_VM_SOCKETS_BUFFER_SIZE.
>>>
>>> Reproduced with a test program:
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
>>> 	   512 * 1024, sizeof(int));
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>>> 	   128, sizeof(int));
>>> // User asked for 1MB but got 128 bytes silently
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>> 	   1024 * 1024, sizeof(int));

The user set MAX_SIZE to 128, from commit d114bfdc9b76 ("vsock: fix 
buffer size clamping order") this is the behavior we wanted, to ensure a 
rational limit on memory usage.

>>>
>>> After that use getsockopt to get the buffer_size = 128 and
>>> buffer_min_size = 524288, buffer_max_size = 128.
>>> The buffer_min_size > buffer_max_size and the kernel accepted
>>> contradictory values without error.
>>>
>>> Add value check to fix this issue. Return -EINVAL to userspace
>>> when setting MAX_SIZE to a value smaller than the current MIN_SIZE
>>> or setting MIN_SIZE to a value larger than the current MAX_SIZE.
>>
>> That is going to break userspace that sets the minimum before the maximum
>> when the new minimum is larger than the old maximum.
>>
>> David
>>
>Hi, David.
>Thanks for pointing out the issue.
>
>Here is an alternative approach:
>instead of returning -EINVAL, automatically adjust the other value to preserve buffer_min_size <= buffer_max_size.
>The trade-off is that setting one parameter may implicitly adjust the other, but this is preferable to breaking existing applications.
>Does this approach look reasonable?

With this fix, how would that change the results of the test program you 
included in the commit description?

Honestly, I don't understand what we're trying to fix.

Stefano

