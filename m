Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700747A0D7
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815439; cv=none; b=H4Z6EsE+2ovtkeww3iIpAxxSuT5fbeKOBxyd4itYqf38zMikugzfVKnuX1wnHLTD4Z+0N9p1jHBwkmuzcPTDMKLGbffrVhzzz2af2UCuehyoDBlApoT3ZuyYT1831mZH72X60QPvuE/qnhCbqnUL2XYU+COm2kEH2C2dk2XMhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815439; c=relaxed/simple;
	bh=I8p9bOzJeqZgehGIA+FcFwpbNoVWUs1LHPhtCD3/XTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cgv0W4JmNMaP8dCkvyXpwAflhXDWwbCIgsmsbh0bXKeUKfoUK8CAR2UCHEfWuOkvV6pXv/YMdvsAq82Fb+n79j8uv+pjK7iIi9vDGOwT6ze4SzYVP1hzJY7DGGk78OU7q0QC5hKi9XiSaIxg26RsK1vH4R6XdYg7mWmGWt3Y/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ali+vb6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ali+vb6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
	b=Ali+vb6fo+EjqIRgx/QkSh2GZxRhKerHb8WDQz9rXM8pTeHyYhCBwaWhiWFOQO6iQjtVjh
	3hq0GtTH0SkEVORujh6TLXrt50rl1mhL4rkBOOSxBTw68ewfFu+3Rdkn7LFoaSfeRLKt55
	8kKLBLDc6tFTDMCqxVKHr0qGsGOkuUQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-I0De-hntMaa-Emjjf5Y_QQ-1; Thu, 23 Jul 2026 10:03:53 -0400
X-MC-Unique: I0De-hntMaa-Emjjf5Y_QQ-1
X-Mimecast-MFC-AGG-ID: I0De-hntMaa-Emjjf5Y_QQ_1784815432
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so719032f8f.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 07:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815432; x=1785420232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
        b=mb8N6rSmkwQX8jdNY2tvxlCPjW5tuSa66bTaK5B+gwmOMcC9/hP1FASxTn+CGhj1ks
         titKe4GzqinfJ2PXb2OuK0DXz34cA298He+8TZA8QzrObpMbG5sjtm06i6RtgkhQQoHp
         XfoplL/sSvyZe8cLIDhgT6BzjEskeZMr/0B9o4ED8rczKeom/xuW0neg8aU3IJXVSAJb
         zFzz1BzV6WbHnFbnbVgAkU0KqYL9AGcmfhmkipSQnXvhycoo9D7fAFkcfXktRGh6TF3F
         06Nw+zx72tOr0DBmYobNcp40+Iy3C01JjyErYsSoMkBjvcBAkFyk9XWS4VGTXeCnk5hh
         l+dA==
X-Forwarded-Encrypted: i=1; AHgh+RoXtosfMHQWpLPdw2Fy0xLIO2GQD+2cJqaFfelfmhkJ2oG87ldcv26Qm09FP4fDPoeWGB9DQzmFOH9iqV9kDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWwnXmOiaDKb7EPkjd9Vqq9wRTVEi6ck83uatlyg/fkwtOxsP/
	yWw1QtcdUs5Ev2ZGIlfxNQclvzZDhF/c03jAgqT+DjZPC14UvpdB/6OYlf3eEYwZis/IjaPcX6Q
	o0rDOuEroPhZxQ0N7VSpripg8ikeG1qR2ESPtDhsklsTSGP/iUamgVddz7ZMh/wA2F2w7
X-Gm-Gg: AR+sD10gsRqFPId+1BODgnrH628QFq/a9m2tv8GuSRdvRYYQdKsSmujLFoMIXrRqroM
	veSJpQss4x9QdUKm9MaIOodwRgQj+EzCrnpY1PC2e4rXNhIRdimykSlD5uGoX9piO7z8Q5jIO3x
	MtGt3YM0fAEoZi8KMC6ISnlnjSYRJg9E6oWRFueYN7Uo2mNRqubOm9HVOwBbwASDurj141Gqux1
	MOwpcEbdb78N4WGmMF+/5lZ7xctgPGJTGLJsJnmkmodMeIlBb/TrFJClqmCsey+yR8ozG4uypIC
	FpWwP1jvlFo9QyFyrRUSFyog3oTtT2ZYYk0xHlEvKxPMYVkaYm8BhbuGQZj+DKAMVZ3Jg9CdqqF
	Zy8XmSeeE/yAu2WXAQc7cYGSR+ZPCbDWVCysYMm7HTyeyNn/kSA==
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26184f8f.43.1784815431666;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26074f8f.43.1784815431081;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm15087177f8f.11.2026.07.23.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:03:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:03:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amIfNOLGeKubXu-2@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oqvH-3VnBci1skkhjDxbxEF7JT--xCKJ9-0-F-eAPEw_1784815432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>vq->worker and queues work on it.  vhost_workers_free() however clears
>the vq->worker pointers and immediately frees the workers, without
>waiting for a grace period.  A caller that fetched the worker right
>before the pointer was cleared can therefore still be queueing work on
>it while it is freed.  And even when the queueing itself wins the race,
>the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>future attempts to queue it are silently skipped.
>
>None of the current callers can actually hit this: net and scsi stop
>their virtqueues before the workers are freed, and vsock unhashes the
>device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>in vhost-vsock keeps the device hashed while its workers are freed, so
>the lockless send/cancel paths become able to race with the teardown.
>
>Fix this by clearing the vq->worker pointers, waiting for a grace
>period, and then flushing the workers so any work the last readers
>queued runs before the workers are freed.
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

