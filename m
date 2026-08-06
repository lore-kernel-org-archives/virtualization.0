Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2862DB798
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025535; cv=none; b=d8M2HfA+f+23nyYDEFdQJeDwO7JNkncmxlGPEf864XnHV4A0qjXElA4e91zyzoqUSJpkmKkOV8veiomZjCrEjXVdigF76b79rVLEfA5vZWzZpq2nqNH9kp9MrxK2D4OF4yclDRLu243hHo7vFEG4nyEnpw7DJAUZ9pIZX6OGnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025535; c=relaxed/simple;
	bh=tKT2WtltnHm9yotRiXX+eFUmEP1+4NC/PxFzeHnanKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DPVp+d/zpRWLYvaBLdbAp/ye4FGNn6HO27NBHSp5i1B4QW90PnTyugt9eZP9Pq7qqHVYOitaR+oxbZiK22M82tUuO9mRPxxGL/0jPvgBKb7Zpq6mRmq+QkocCBlMwwrjnIx+wgW7fPFgXyXpyfs08ARRUWNFwi7JiOJYAfD4pm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMdonyuX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMdonyuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786025533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
	b=PMdonyuXUhoh+yr+pDghVlar8BuOBW46ojoRqHM5Go8qUhmJhfTJPDu8dqlw8lprHA0mWx
	K+Hyd1WT3HV0VMqV5ftJsZKonyqYtoU1at6R8rwkUJzuDH9toVP72is5NjHYviyN1FA9zm
	WgyCo/SRHRcnAXZ73Cd+kSVuUR6WMI0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-HhrA9fYYOzKmaN9iQ7aEbA-1; Thu, 06 Aug 2026 10:12:11 -0400
X-MC-Unique: HhrA9fYYOzKmaN9iQ7aEbA-1
X-Mimecast-MFC-AGG-ID: HhrA9fYYOzKmaN9iQ7aEbA_1786025530
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso13367475e9.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 07:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025530; x=1786630330;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
        b=YjDVAFDOvwoOUYbFcRdmCBhiC6cijzx7xH/W9ZcRTEOq8hIwN5q+LE9Dvo+DcbDD4Z
         kBG3qw91Mc+r16T8JZnHLmV3x+hn+1FCZDVo69577SycafRA9oV+LJABM/v0lAPJrwG5
         W2ldyR0A+FJsypKE6Xfte95XEKYu3IsTreisGoBpZbF3yGEwZglsM7TPTUvfHp9bTJej
         BkvkL7zhZ8niW0rG/uZyXUPkYKDP1Ex+deEpDBxfqkjwM5XwFuCMZwUkuFVX68R0J70s
         wEmC23+RNaSdfHQbgeo5j6JUJoi5g7s+gDDyddm9SVFZKItVKNvZh2s2yoHDbBhL4LKP
         iZqg==
X-Forwarded-Encrypted: i=1; AHgh+RotgdLpP3q2uHaAWCCuaaV3Mw7Hqmx3Uz+v/D2G87TrIkAYsW1jxp6Jac/Blrr+sc1ZhAFjeFeyC3qx/kcdhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEa6E6ujHR3Up3VQk6hY1T+WeBuMyZnT1d/v/pB5Rjji2eKslf
	/GPLqL5f95XEA+hWjEsSX18ozuzOPJU+wyRIEq59rFqKwx/d+Lqmtqwre0Nj+QCfRWYrbO9jKor
	fIc0cnBZk7yPFR7BKpW7zxyiipCFCogk3p5E53gW2azphxvGnLVG35fbpDroqU9VGZyGW
X-Gm-Gg: AR+sD10IcAzObd6vkA/dBEfbfDq6ytjNNorYX7Zjsd9OwuaXvGO566JpXSyIVSjBrgq
	xQE8/FGpTRrJrI/oEdvI8+/2l0gyv9Oxq7hxv+yIUcI1g+U7ItxIcXfWeAD4sm87D/J5J9LTY/K
	O2liVppv1BPCq4OdeV8l4YgrNelz+W8IkxZoXc8Bn1q26XoRbOoJ5cblhWT6zUFYvIxtC5QiD3p
	FRvuqF62SVOJeMb9pGBYyujvqEzwXBxvwiDdsP3oiuUk8KqyZWCkvAzIh2HOb+/hUjf3Pkfo8Nn
	ETRDQftI2L9OrXcK2FINU3oAgcGBgGwZYZ9go08lzqwfZ5ECeZBRIT8l5jgI0j6UoBu106e6miZ
	9cPw=
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191371085e9.2.1786025530353;
        Thu, 06 Aug 2026 07:12:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191369505e9.2.1786025529693;
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49952dda992sm35827965e9.2.2026.08.06.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Date: Thu, 6 Aug 2026 16:12:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <anSV9yFUHLubu7v4@sgarzare-redhat>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
 <anSMBpQJ8x-vXYy2@sgarzare-redhat>
 <anSRyFTNGC-XcFM1@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <anSRyFTNGC-XcFM1@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tw_5P2FoKWgsXIdCPlqkTxm8rtx-fD5O0P18yE7P20k_1786025530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 06, 2026 at 06:53:12AM -0700, Sean Christopherson wrote:
>On Thu, Aug 06, 2026, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>> > The effect is harmless in practice, as this only happens while the
>> > owning process (and thus the whole device) is dying, but the lockless
>> > write is inconsistent with the rest of the code.  Clear vq->worker under
>> > vq->mutex, like everyone else, so that all writers of vq->worker follow
>> > the same locking rule.
>> >
>> > This issue was found by Sashiko AI review.
>>
>> Can you share a link to the review?
>>
>> I don't know if it's common or not, but having the link in the commit or
>> after --- will help the reviewers.
>
>+1.  FWIW, I've been using and encouraging the "standard" Reported-by+Closes, e.g.
>
>    Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>    Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
>

Yeah, this makes a lot of sense to me! I'll encourage the same.

Thanks,
Stefano

