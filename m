Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81164A2040
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486948; cv=none; b=RdkPnUHSBa7s6mO4E+Jp7Yo7izRc794VHzQ/wrNsAnKKjlBZOiIrYTDhJjbY3fNfAFkvLhhtNn5x6crwzgES50Hs8bx4oYrfWEr3IiunLNMxnenqBjFZFEp4UrU6m2CKVaUYvCVDIdcg0EoWgN5LTLeZO7yM8vwkj5D7RIbGsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486948; c=relaxed/simple;
	bh=E+BuIG99Fs3gW60ZhBJoousphtXqpfMPQp9AyvW4hbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bUyb7PsOOivebtn5vv2JkogtLfJqZGKLWmF/Kmt7UEkIaPNldSEG4Gj8vnaVv9ztckKhK1TpdnwMmYdOhcJ0umiMNapS9cgkNF5rvmb9t86ebFQvpS9Rh4VCY04ZKya+RfFQaCnuwwEL7CQfvJeN/GsFpTuX2GX0zLxpQLGPdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IR0VPlRH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR0VPlRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789486944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
	b=IR0VPlRH4O9oB5m3DkEvV+FLYdGtrxifAP1GaDbgnjLRLNp8c9XCYDz3AyYDW05jmcsaM6
	Z3CBFIH04WWjkPhoLgamc7LqEdl2aGd8Bb+QK0sk4OMfgyfvZBzZBbbF3a0/lElIV1Pagi
	kq8sWZpvb3axhTVu3E0xl9Tm7IH9Cc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-n-QHvZtpMcCmAfX0Hri0KQ-1; Tue, 15 Sep 2026 11:42:22 -0400
X-MC-Unique: n-QHvZtpMcCmAfX0Hri0KQ-1
X-Mimecast-MFC-AGG-ID: n-QHvZtpMcCmAfX0Hri0KQ_1789486941
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e64b80b94so27066695e9.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789486941; x=1790091741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
        b=Uo8ZwBZoltANmZx/0cf2PWSCzKo69II3jE/CCkc5IAb9V5imKdROCUiKuPjIPOezPZ
         bxX222l9i+7l+bksQiEvGk/ebzifPE5EH0psa9lbQGKzAYFNZeN544EEwtRhm1+RYbRM
         6zJgmcyCYkFSg+4XnF8rsM/3yzB87z/zubwPBVMGexfMX7stgUUqdQmRVl+3b32f9eCv
         6/2gE3jZ3FtllfJSyze3GX4ERI8DzxMUKFFzlcrf8EaLlkY4qHK3gWPQEjyuicE5jlnZ
         WO99GZTIZsM9nYzWklqnxjnVkWNBVoL6q6Pk9NNoXJqwXrnK3Ft4uA7Sv8YQ8GtYE3Sb
         AMKg==
X-Forwarded-Encrypted: i=1; AKwUvBxjQ094HPgjq/Z8sbyIFmW4/DBbaqNyjqI1Fy1xkV0UCeBGLXeUp6Sy7W63ieXgjZQ3wjyIGAEYO1OOcH2LaA==@lists.linux.dev
X-Gm-Message-State: AFuF++kyx6pJaJOxUcAUZ5LuOuqp6Ih/XfKjNyNwEbOp2Kr9EFd/SeaT
	cIj2i8fSCPEy96OZ+G24+o48pjzBfNqx0x7hwxlWPZhgK5MNhXWu/dCoJQqVY66A2uwQkOg1nAO
	l1ddUkzeMCgoqkxiQJab3rbwMZKm9kFkUHJCMr/5lHz0llR5HFJvPRSLg+b3OjsGI67+W
X-Gm-Gg: AYBFou2eYWAD4ozcBXEO4XUKW/OV5tYf4WkqcxjjWiQtulYsdFuSAt847fvh3bdltjZ
	9+Wv6pbTEA6ibtoFwgmbvv0lEuYvPWZTkxOdLwA8G5r7zC+oDvZQJEULC1nY5R0uEc10+9i1UO+
	x1PNeJsgCOOdUS7hz1LBiiLsFHk4oNYSCH49zaXsfJ1UG7pDcJcbgtfJkNJZLgc4B6EuvV1Pn/r
	8ODIryv0t0Iyj52l0IUVh1jQBf7l1Lq+mK861edEQb2pEiOhpyN9BTfetZVou3PsI3WBUPIoq9W
	2n7T56B+ODO/c+G+geUMvG6ufoAsgSrsLloqqhoUHp6ZbwNpqzHnVyYjKlSB+CAVYJ91B1qKDzQ
	It5lvo47iHMLEMZQSh0l+jpT8YgNRhCbvf9fWC1Qv6GCY4A==
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197081065e9.1.1789486940759;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197079685e9.1.1789486940213;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870b39ea31sm949332f8f.23.2026.09.15.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:42:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:42:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Message-ID: <aqkcd_oMWK-QtXWQ@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _tXcA69P0ixpebPxbecJhUzFw_74CAOWqFszZTM-CcE_1789486941
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 02, 2026 at 04:00:47PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Allow const transports to be passed too. The function only compares the
>pointer against vsk->transport, which is itself const, and never writes
>through it.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h   | 2 +-
> net/vmw_vsock/af_vsock.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

