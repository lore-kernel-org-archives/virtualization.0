Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09A28EA47
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744320538; cv=none; b=SADcxjp5D7g9q+VYBA3WOrxijW++YRsUWniumCzsC+2td+JD/bGCKVR9wz8zIfnZXIz3SQ3vTb9+qtQQAelyRTazSdpk7gu/kFHHjUB6MF9ilQH1QsZEFaERfFA0edFFXfaCOpD26ZDq5TH3cJeuMOuVmMJ5WwFaIju0QKLyCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744320538; c=relaxed/simple;
	bh=PQyLMk4yD/KMsB1XsXeHfOQCgylwKZk+b6OaxBJWI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trtw7Hy4ZPyYTzrtlMF96CSjX0vxNOfqeH4sweTrmPjKGpw8q1sgXv9/zCt7ZFTYDEPTG2PWSfLdvqPfKZyU/6CnHLdh/f3Cg2F6qpNpNZoMMPUg3JInxBnDbczXFA7bNnJO/46pW4k7VABQmaFZJZQRr3CDdpe+ODv2tEBHAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7bUe9P+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7bUe9P+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744320534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wUygALbmEVMFAt4v+g0d0hTcs9oRhp7Sgk/twG05FU=;
	b=D7bUe9P+uuUCgkLxwrATaynkYI5/P8/yiHNHAko2bw3hpNsT7mPtu6SPDan+7ID8mYoeFO
	zYrLSjGYJV+9uxUi3s6IjxoWsOwjwCsWi6JvHEKTcyjm+0LSCkRggc2VE6wyOTp+Puh3bn
	qXB6ua7QrkBwNrLja8VVWPwGl/gUXuQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-wWg8NsECMjKuIAcsdKOi4A-1; Thu, 10 Apr 2025 17:28:53 -0400
X-MC-Unique: wWg8NsECMjKuIAcsdKOi4A-1
X-Mimecast-MFC-AGG-ID: wWg8NsECMjKuIAcsdKOi4A_1744320532
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3e93e052so13876539f.3
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 14:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744320532; x=1744925332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wUygALbmEVMFAt4v+g0d0hTcs9oRhp7Sgk/twG05FU=;
        b=ZWKwRsIDASOyAzyONUOfg9rFA+iF1r7Me9DwvL4tw0R1jH+rZzdI+X2JitsOxdSxvX
         6KnuCfWLU2gz48l8QyBv/ZOa5pZ09Ke2O/C03ckmcVlPynE6E0MqA7hdKWCoapYUoiJk
         718fnvIQnqMw6DfN22EksbHszySBFTKpmGUYyyimxk8fTehvSXzziRUU/bgfnDBDtK/O
         topTzUuzWNYQeSD8Dhb2IEUV2YGxj1RUZRW//VDImgtzB3B1aF833d0lARgWQOZhUgkf
         9qS/EmfGItxbisSipPLydQs0cZg3cDwTHggDX9xwhzk0u0OoRqnWJ39G8x2nqxXgy0Qe
         IIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVDnD9MTP7sumIk+rk4dRswXSFpdgM9nj8Dh5PgqwufCUCfuj+J+ChYpR0wfaztN058wBxAXDK2+9L/qVmO5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB4CKBK+Z5RQkMpTCaZdhG559udh98Vdfe2Td60qYNo0F9oi5m
	2M5T3ZiTQCXoLgM8HqMarZFgpwtpCBUEZWWxNG/c5M7YB2gZp8XdS7PN5zCD40GKxWGtAD2/EbO
	QCJ1Yok6XMtFwW48gAddCqYqc1c29ChM6mYx/SSZNUrA+1lIrmz5ge3jsGsz4Ni9V
X-Gm-Gg: ASbGnctGPkJcasZ5viDj9h31GXkjysDRYV4Lohn0s8ChHiU+5l9+YLMQojAPXUELoi1
	vLUTStsnmIyMOVicFrrLYFcoeWCk5IIDUhRBMQyvSFN87kacsUohgsRsGV4ZdJvP7xrk+R2caw8
	enHZvQbzQK/m8eFOJJzXXhSnjXKRuTuB5kATbvC+CrC6cuITHIQxIW1pIqczZrEOPjoO6lELhpH
	mfgR1AwGNOXB3e2nru09BYfFwEZyrkQN6Un8vA5rvTkAQziPoNGCKLoFGFhSY5PBeOoyeVdrN8Z
	5yqZRmUydOGfBcM=
X-Received: by 2002:a05:6602:6019:b0:85e:5cbc:115 with SMTP id ca18e2360f4ac-8617cb5482dmr14196039f.1.1744320532160;
        Thu, 10 Apr 2025 14:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObbSU7MqLRum1IP35oPdq16S0/HCvuDlUPSjApwT5xtjRxU2hDxipatt8y3sRp60U+ll1fA==
X-Received: by 2002:a05:6602:6019:b0:85e:5cbc:115 with SMTP id ca18e2360f4ac-8617cb5482dmr14194539f.1.1744320531830;
        Thu, 10 Apr 2025 14:28:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d1873bsm923375173.48.2025.04.10.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:28:49 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:28:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, David
 Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, Yong He
 <alexyonghe@tencent.com>
Subject: Re: [PATCH 3/7] irqbypass: Take ownership of producer/consumer
 token tracking
Message-ID: <20250410152846.184e174f.alex.williamson@redhat.com>
In-Reply-To: <20250404211449.1443336-4-seanjc@google.com>
References: <20250404211449.1443336-1-seanjc@google.com>
	<20250404211449.1443336-4-seanjc@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vorh7SCRSXYeYn0JPD9ACIQrCiWnLBdSpSLzyk_1z9s_1744320532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Apr 2025 14:14:45 -0700
Sean Christopherson <seanjc@google.com> wrote:
> diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
> index 9bdb2a781841..379725b9a003 100644
> --- a/include/linux/irqbypass.h
> +++ b/include/linux/irqbypass.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/list.h>
>  
> +struct eventfd_ctx;
>  struct irq_bypass_consumer;
>  
>  /*
> @@ -18,20 +19,20 @@ struct irq_bypass_consumer;
>   * The IRQ bypass manager is a simple set of lists and callbacks that allows
>   * IRQ producers (ex. physical interrupt sources) to be matched to IRQ
>   * consumers (ex. virtualization hardware that allows IRQ bypass or offload)
> - * via a shared token (ex. eventfd_ctx).  Producers and consumers register
> - * independently.  When a token match is found, the optional @stop callback
> - * will be called for each participant.  The pair will then be connected via
> - * the @add_* callbacks, and finally the optional @start callback will allow
> - * any final coordination.  When either participant is unregistered, the
> - * process is repeated using the @del_* callbacks in place of the @add_*
> - * callbacks.  Match tokens must be unique per producer/consumer, 1:N pairings
> - * are not supported.
> + * via a shared eventfd_ctx).  Producers and consumers register independently.
> + * When a producer and consumer are paired, i.e. a token match is found, the
> + * optional @stop callback will be called for each participant.  The pair will
> + * then be connected via the @add_* callbacks, and finally the optional @start
> + * callback will allow any final coordination.  When either participant is
> + * unregistered, the process is repeated using the @del_* callbacks in place of
> + * the @add_* callbacks.  Match tokens must be unique per producer/consumer,
> + * 1:N pairings are not supported.
>   */
>  
>  /**
>   * struct irq_bypass_producer - IRQ bypass producer definition
>   * @node: IRQ bypass manager private list management
> - * @token: opaque token to match between producer and consumer (non-NULL)
> + * @token: IRQ bypass manage private token to match producers and consumers

The "token" terminology seems a little out of place after all is said
and done in this series.  Should it just be an "index" in anticipation
of the usage with xarray and changed to an unsigned long?  Or at least
s/token/eventfd/ and changed to an eventfd_ctx pointer?  Thanks,

Alex

