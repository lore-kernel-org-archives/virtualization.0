Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EC476CEA
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706938; cv=none; b=BsgpSXrdnPza2ihI1j3lXJFs6DTYK6lLRxVX/r4yh72YaIJrXI+quqvmqUNVDB4BxXTgsPeFY/DOU5B2j0u+vmDfomcTKqOY0pjzR8FzBzkVh/+07nOEvr9gMboNrh2WAHr7iuNTopjnnI561UIcuDIqNrX7L1DDXT4LzWOBpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706938; c=relaxed/simple;
	bh=Xx9sghwnKgI4fIxeF/d2xK09aWg3iZvHjBXrHQegByY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nSIMchKcS6P6FfjP/0M4wkHPwa1AjeiqvZHKt09d0i8WKmoc/Bf+kQ9GvBJ4XUp6/Gjwe/yPVOcdJOBgob5Z0KFxKsFx0I+i1d3PHB9MgJoA9r8ucTdi4V9fRSYEtIj3Aq9pL2jRCiq4of+uQcKiSF2OPGQF/yASmSzuHx/7is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GroCRByo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GroCRByo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784706935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPG0rooSRzO/25F209RlQglMVA0XYnQGnrJRERDKE5k=;
	b=GroCRByoOWd6KvtgJpU229w19NdHxkkw8ZKcYK+gBsY0BwWkkPWzpeUz3Viumuw7jE/Hj6
	Uz9oV5tmh7PocEX9ZdW2nqz4sm42zZrfhKGgb/t/Rfzyxl6P2qUJhl+KnGZSURQveDjAjP
	ZLWn9iyy2tJj5H50Y8p59W8+XMa6OWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-3tfZylbgPaCL0dCqZOB9gA-1; Wed, 22 Jul 2026 03:55:33 -0400
X-MC-Unique: 3tfZylbgPaCL0dCqZOB9gA-1
X-Mimecast-MFC-AGG-ID: 3tfZylbgPaCL0dCqZOB9gA_1784706933
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955e865174so20188755e9.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 00:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706932; x=1785311732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BPG0rooSRzO/25F209RlQglMVA0XYnQGnrJRERDKE5k=;
        b=nWsp8A617sspfqtKYqF7+cBsfpdR2PPHtGNvhP1JwqVE8p6LqBnYQZ40hvuwUuvpFh
         +x4snO6y7WVuQABdqZDglq7FWZdDNDKVR09Fm+L7GPnZzi9Uk6DFTdGRwpx7LMA210zz
         uZEJjCOlESu105IHaSkhIa7ps5YSZDM4/+wZq6FV+tXONGsTAXURnQ6avJW75OMtnVuM
         ok6M90KziW7MrYZ0BTYSqXH4CcG4IT/y1ZPVVbxw5VA42hDrlQGeLjD0VqHZOsBE2OV0
         hXz6bsqjHjVV8Yy0N2mpguYDsWH3GmGOnrHvNPG/J1qOlGLzOk8f+m0hrd1FMdnriohp
         MYtg==
X-Forwarded-Encrypted: i=1; AHgh+Ro88KOR3dMkgzqlGHBV4iMozx4nqLIFzwupBXtbcKavgQuo1Yc+CJrZR2t24/uqxj5xLZ6tORDhezgVcc8gIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhLmfezv1VVEGSUIMbXSI2ZGVm7jgKgVLnQVqpkRUr+lbsuklm
	QdQ3fvI4SNGuZnAYZieHvRtdy28Xc/7RO4AJhLBkoeN9K8OwhDYvsEeIS9quYvRVIDq8ZFo4rbI
	925frt4eCraXCXeaI5UzNTM6EIs1D+NJCweVIhKAfWVnj9V5zW/4ssdYyxy8eYIm38LCq
X-Gm-Gg: AR+sD13IA0Sn4R5QmMKr8ogK52VdfrPy0OJzdVgYuZQCYe803i2fIbGBwog5IdWKz2C
	lTTytKpuMpCWD8Pf0DJeXt8Q7EuIE5wMoz/SviFX6LxcarUFb0OhaxxmppHobAJkZU/3ihC+Y4T
	c2P+DNoIyyjb2VMWqU/FSr7f2ZrVA95fRhP5NVwJmN1Lw3rB6zNh3F5jI4GN4UEA05CBK98R/Hi
	eo+SDHe/75rbQ3cCNlWCCyMr4TlmdkeBUQcD/mu/0fYmiftKMpmFfKO6W2/2pkX48Y5qbAVqPAx
	y5EUWD3bTuZgAWEbz4jZhOIzeq1QSe0eHuo1k2J6Z65+turozRZqfoBt/uYW58xWwAdgwRpZqRt
	iPfo8cCdB2mqdtYhCMzKtqdJmXrHnWp7s/1tzueQdf1LOY6wlBA==
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-4954aa1a10amr234396245e9.36.1784706932517;
        Wed, 22 Jul 2026 00:55:32 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-4954aa1a10amr234395945e9.36.1784706931995;
        Wed, 22 Jul 2026 00:55:31 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b0571f5sm29377185e9.4.2026.07.22.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:55:31 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:55:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Phi Nguyen <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amB15TdzPAEk9A9C@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7KDbelThrewre4lwauEnw8VCvZvmUhL2wJIEte-kmIg_1784706933
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>After vsock_connect() exits the wait loop due to sk->sk_err being
>>>set, the error was read but not cleared. This left sk->sk_err set
>>>for subsequent operations.
>>
>>So, is this a fix? If yes, we should put a Fixes tag.
>>
>>Also, can you describe how to trigger the issue?
>>
>>Because I see this in vsock_connect(), so I thought it was in some 
>>way already handled:
>>
>>         /* sk_err might have been set as a result of an earlier
>>          * (failed) connect attempt.
>>          */
>>         sk->sk_err = 0;
>>
>This only handles the case where the function following the failed 
>connect is another connect() call.

So, can we remove that with this patch, or better to leave as defensive
action?

>
>>>Switch to sock_error() which atomically reads and clears sk->sk_err,
>>>so the error is consumed when returned.
>>>
>>>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>
>>Can you explain how this patch fixes that issue?
>>(this should be the first information to be put in the commit message IMHO)
>>
>>I'd like to understand better if this is a fix of real bug or just 
>>an improvement to the code (which is fine by me).
>>
>>Thanks,
>>Stefano
>>
>Here are the steps of the syzkaller reproducer:
>
>  r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>
>  bind(r0, {VMADDR_CID_ANY, PORT})
>
>  connect(r0, {VMADDR_CID_LOCAL, PORT})
>
>  listen(r0, backlog)
>
>  r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>
>  connect(r1, {VMADDR_CID_LOCAL, PORT})
>
>  connect(r0 -> self) -> -1, EPROTO
>
>  listen(r0)          -> 0
>
>  connect(r1 -> r0)   -> 0
>
>  accept(r0)          -> -1, EPROTO
>
>Basically, it creates a socket (r0) and triggers a self-connect after 
>binding it. This self-connect fails with EPROTO because it loops back 
>to r0 while the socket is still in the TCP_SYN_SENT state, causing it 
>to be incorrectly dispatched to the connecting-client path. The 
>unexpected packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This 
>listen() call succeeds because the kernel's listening path never 
>inspects or clears sk_err. Then, a new socket (r1) is created as a 
>normal client and connects to r0. However, vsock_accept() rejects this 
>incoming connection because the listener's sk_err still holds the 
>EPROTO error from the earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to 
>never be freed on virtio or hyperv transports; only the VMCI transport 
>implements pending_work to revisit and clean up a rejected socket
>This patch will prevent the rejection branch to occur in this scenario.

Okay, get it now, thanks! Please include a summary of this in the commit 
description.

I understand that this resolves syzbot's specific test case, but it 
would be best to handle rejected sockets more effectively in af_vsock.c 
rather than in the transport layers (if possible). In any case, this can 
be done in another patch.

>
>I think we might schedule the cleanup worker to run in the rejection 
>path for these transports as well.

Yeah, we need to handle that part better, I think it's a leftover when 
we generalized AF_VSOCK to support more transport than vmci.

Indeed this part is a bit confusing:

		/* If the listener socket has received an error, then we should
		 * reject this socket and return.  Note that we simply mark the
		 * socket rejected, drop our reference, and let the cleanup
		 * function handle the cleanup; the fact that we found it in
		 * the listener's accept queue guarantees that the cleanup
		 * function hasn't run yet.
		 */
		if (err) {
			vconnected->rejected = true;
		} else {


Would be nice to handle everything in af_vsock.c in some way.

In conclusion, the patch LGTM, but please expand the commit description, 
add the Fixes tag, and target the net tree in the v2.

Thanks,
Stefano

