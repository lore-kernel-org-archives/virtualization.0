Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD449476CC0
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330247; cv=none; b=CT8bUFi5NXoeLJC7luGRdXR0YBqFGdHnxVG1w19yx/Xh4q7Hsy8gCxjynRtL4i/CLlEWqlVm5yA9La158P/9CVgCBKeakOexDftdjvr988ps0MA9CvOKVCXqD8FLp+kpnayWslvdRvw+FuuqUgTAYLeEQQuOht/YJ3Rj592FUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330247; c=relaxed/simple;
	bh=rHONvYkRly4JHQc3sEmXa0oaad+YJFPHRPuElq78FDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uvLxge00RwUmzcpNd94bGjWvkyddAox3ZVWmD+1V5i3W4ZadrUbaDAQak3sev27kpAxLhAbWd6RwwPlNOHbbCNiXCePAn/eLUXi7oyPOY0w6yR6ipQ4/doKTnrMN1jDFptN3fqiZ2IHaykL3ZAAQrK1TqFyFK2k+uu/Fsd21J4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1Nnk1J+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1Nnk1J+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785330244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgeX7pS1oE7oOwVax6SP48v1RjAPFIqZjlMXeyQpwoA=;
	b=R1Nnk1J+u7A8eBnelBxWXZCYiR8D5VCpXwEe3U8jnDzUXvYx+GGIqlFBRLqjHeu0k7EqJV
	UeZc1aQPkR3k6dzowOZfTqKEVIADXxnfW1GWi9X5hCm4OLJJ7Z3OJIaBhTatSZrmBXr8Tb
	+zldX7NNtwgY0l6EadGBhSBYql4MBs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-BKs2WggFPYWeJge4LPTWZw-1; Wed, 29 Jul 2026 09:04:03 -0400
X-MC-Unique: BKs2WggFPYWeJge4LPTWZw-1
X-Mimecast-MFC-AGG-ID: BKs2WggFPYWeJge4LPTWZw_1785330242
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f84ac1990so693435f8f.2
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 06:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330242; x=1785935042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgeX7pS1oE7oOwVax6SP48v1RjAPFIqZjlMXeyQpwoA=;
        b=Cx8JMOkm31uoWX/AkJLONvPR3FBLEeNvX9ue8fIb41IDF8FyEy2PKyfLh3w7Wz497v
         k5Pd4qdf/fWWkWSZNWoSqWLCY0RkaMHBvwf5hWkLjfKIt+85sSo5N6BTRx8OBXeuUlcF
         WIPmiA19Ir8/hqdhCB740e4MYh29Fzj//r28LA7z9EbAmped1L3OYzjHwQx9IzWq5DTY
         Jws/tRatZGKYpuPduocNmKQcKW7lQxC+mIE+GL+dVG+F2oh6T74lXyqTi9PawOcy+/tf
         TP8kLd1clPrf+wYjhTkod6mXzoa+fQ624rEOzE/1k5WPTSN1J7/mAOXsBR6oz3UtV3wU
         OwpA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7/tPLTJRq5qKOrmGNEiGNpz8MlFojao+68HVzw0HWvCXBattIhNVKhbNKQezqDHXrB2Mm8Z40A8BGugYlXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRqO79m90ZBH8oXU4mEZ//1rA3BMhbtD/7Twa9SaF/U/60E+14
	PSnr/LpO0CmxU7ujj5bF4Ucl0uhqRnaGS22kNbI2p3ibFh9zUaGebrLi+57KA1axxBeBNRss5Gd
	IMyU4C+xZNolvnLp1y2ix91ufzGv9KB1h+Ik/jiXfGCL41+5n4phDy7SDl1U89Zbl4As0
X-Gm-Gg: AR+sD10iUMHc5a5W+5ZuMiUg8LCqP/BMiu78wnC8D0pP6DmriOlUAZ8sJBKnW7DnZLM
	hJDbeYEdhuEf6URg+V7TSihKxxNIU2pAWwVHj1AqN4ReD8cqFmsS2zOUHcXi/tgpHxLF9+9q5Xh
	VpQ1vAHBR/AtWdnBY1e5v2I/JEeQgFvXATw7QCiILahn8NKm3L+DpMb/K6s9aUG/Xs+fDKdHQlY
	z1VuPrOcdFbPJu9qMlfC8eE1M/MGYaqVfe0YG1z2sRKWid8qhOjMGvecVUjym1rX2BUIUC+lRgi
	Zv6Io4Yfv5gz1JRhMCM34EU2u7b1v41rM7JwJiafEv7Z2D6U6flRFqAednQClIoABMtIsmIeCK8
	cgYyDT7L9/dUuaXGSL3t+cbXZp9yCVDBjG3Ui5f8jBMM=
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id ffacd0b85a97d-47fb1e5ce09mr9025385f8f.6.1785330241689;
        Wed, 29 Jul 2026 06:04:01 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id ffacd0b85a97d-47fb1e5ce09mr9025298f8f.6.1785330240970;
        Wed, 29 Jul 2026 06:04:00 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f295sm7727863f8f.22.2026.07.29.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:04:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:03:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amn5vWcyY0f5ErEM@sgarzare-redhat>
References: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LBCaGtuadGknssecdZc0mhFrff4MVrgc3CyN5_mmvMo_1785330242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 29, 2026 at 05:46:29PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 28/7/26 16:21, Stefano Garzarella wrote:
>>On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>On 24/7/26 05:43, Michal Luczaj wrote:
>>>>On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>>>...
>>>>>>>>>Yeah, we need to handle that part better, I think it's 
>>>>>>>>>a leftover when
>>>>>>>>>we generalized AF_VSOCK to support more transport than vmci.
>>>>>>>
>>>>>>>Speaking of leftovers, I have trouble understanding where 
>>>>>>>does vsock set
>>>>>>>sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>>>checks for it?
>>>>>>
>>>>>>I can't also see where it can be set TBH. Should we remove it ?
>>>>>
>>>>>I couldn't find it for listener side too.
>>>>
>>>>Removing sk_err handling from vsock_accept() solves the problem, right?
>>>>
>>>>thanks,
>>>>Michal
>>>
>>>Yes, confirmed, removing sk_err checks from vsock_accept() does 
>>>solve the problem.
>>
>>Okay, so maybe better on going on this direction. WDYT?
>>
>>Stefano
>>
>
>I'm still a bit concerned about how connect() and poll() interact 
>here, even with the sk_err checks removed from vsock_accept().
>
>For example:
>vsock_accept() now lets us reuse a socket whose connect() failed (call 
>it r0) as syzbot reproducer does. After listen(), r0 becomes a 
>listener (sk_state == TCP_LISTEN) and works correctly -- it accepts 
>connections.
>
>But poll() on r0 still marks POLLERR, even though there is no error on 
>that socket at that point.
>
>As I understand it, sk_err holds an error that has not yet been 
>reported to userspace. In the blocking vsock_connect() case we have 
>already read that error and returned it to the caller, so it is no 
>longer pending
>Shouldn't sk_err be consumed/cleared when vsock_connect() returns it 
>to userspace?

Yeah, makes sense to me, I'll ack the v2.
@Michal WDYT?

As cleanup (separate patch), should we remove the `sk_err` check in 
vsock_accept() ?

Thanks,
Stefano

