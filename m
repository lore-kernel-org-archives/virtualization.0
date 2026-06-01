Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9D390CB4
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306342; cv=none; b=nLDJUiyFAV+GlLz/2R+ozwZnUXvcTputv1+ZLypamtECjwoHm50qInjcvRWsxec/01pWjTe7xvZIPjF0YjDT/CMKhnMBwPWVcpk95z8H4clrqKjB5AdWCvwsnheHWoFakTGTwXZYFwGzwtL4xmQlN2b4X2GOLhsO8qFHkBz0QNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306342; c=relaxed/simple;
	bh=92tjw0qOeTMiu/O2oXMKbRtKwgW0ttd71f9F8miPIDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGVsJiSN5l/pAwql4EYgDXbhH2vKweViOQMXGHBSeHihfxAHoAZGkDjb5IwFY9itv3p0aITLLK3ecgxqgdStigMPDt/h2g5rDHhcV8paWNdsaFdXCR5o3Z8lj1OsYMXzn2TGfFu81QP4GSR3pJmD2ohfQQX4ai6pSxWdiizr1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI2RVhRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI2RVhRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780306338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
	b=ZI2RVhRa65EVKBUfogeDTcpO550egHrZ3+QwXt1OF51Eb3nbu4TLkx16oAdu7Jhckdx/Rs
	neeDXjyd4zjoAoU0ezdyw2sdHB3+PNMaaf2Xksx6fpXH3IWKWO8EodieowpZqio7Ykhj9g
	lcREQDCdSRSPM7P97P3gb37AKeP3zB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-a5QNh0ZBNQ-UN1EHhv9yqg-1; Mon, 01 Jun 2026 05:26:02 -0400
X-MC-Unique: a5QNh0ZBNQ-UN1EHhv9yqg-1
X-Mimecast-MFC-AGG-ID: a5QNh0ZBNQ-UN1EHhv9yqg_1780305962
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso1686662f8f.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 02:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780305961; x=1780910761;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
        b=CQWURR8kXP+kTfa2130itpQjpO87apZ+48ZktwQvrYyLggTrRb/E6UeDd44IdXfx15
         ZVcVqr1buw33yWryX3+8ANPgdhFEwKC7+LxZb+mM0wazMEpPtVuFqiN/UcEwIZgkwoqe
         K6FOAX97aKimKaGRoSyBSxRl5NcMw67PoTIgjFqHaRDeEdKLZ+rQWzG1/H1Uvy4GYejd
         WGg/YWqVN1JStBfI+SReH517varUuLYNqHu8TiKmx209USE6sMdXtBgB5NgL33zz24JM
         rQBy9KfBhYaI2JYDXm+BxlW7HjubtmhhpqMhoRZPI560Bfc/J1tCE3X+Lxmsw5DBMhmY
         xOKA==
X-Forwarded-Encrypted: i=1; AFNElJ840dxsMAQ5ctj/VXcVk2KT6GmckTV0lTlQ3ZYdKOC90jS/UUXZdGTxhfHhsvqDBPDdULYohmmoeXedjELv9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRwsLGumccp8rRAhqaqsIrP6LiNSnSwp9U1JQOrUt+FWyHlj1I
	daotyT4oGoki81JiMRleWRy636OYAb0oq3510e31MRb/2oW0DK+xn5riMSIyCS4pfkpKLAy0SBB
	Y5GdLMiacuiNBu6UiH76LQTuEoFL52MtBqDbvhRQUIoGNWipyJu3ALEhAhsbVdOV2Cppt
X-Gm-Gg: Acq92OGmdOLMVxlImmVwLnLwviulmDrTGnqP6giLtn+hTfl7wC1KAxaLpUvna8Btyc2
	nKQfADka2OQjN9NhUHmuPilT9j6NPsTf0ypmUYe5AGCYO2sMs/X2lhMIopCmV9JhxpddLVOEKS8
	a8nGfOfERbvx1NuAVszB+GmZtecij2v0hanTliNFQgqzMiiusqdFhb8L+r1yFo+P9M3QJT5xxBr
	Fj8M0nkKgVNKjQd39c3P+WCob4pXK20rW7G3Qhe6lWeZlL/hHu+uli0sFupntXvNqAFFJGBte73
	n9JS4rE7t997ifM8CvRAi8j2V51TkZIKZPIOhEZYiFxcnUyVxEeq5RQOwpo4WoruQ/P6m7xC+y8
	IoIIwHnf0bChqxwagIOhRpQm8HS5JZOkjtGMFssLdeQfwfTyXIBQfwoucb2eKVjB5zJm0
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765426f8f.37.1780305961538;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765397f8f.37.1780305961103;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm21777598f8f.27.2026.06.01.02.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:26:00 -0700 (PDT)
Message-ID: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
Date: Mon, 1 Jun 2026 11:25:59 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
To: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org
References: <20260526104356.469928-1-rafdog35@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rMD2rlk81z-l0aqi3WmoNSflYOoVN2He5Fy6ZELxbg4_1780305962
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 12:43 PM, Raf Dickson wrote:
> When vmci_transport_recv_connecting_server() returns an error,
> vmci_transport_recv_listen() calls vsock_remove_pending() but never
> calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
> permanently.
> 
> Repeated handshake failures (malformed packets, queue pair alloc
> failure, event subscribe failure) cause sk_ack_backlog to climb
> toward sk_max_ack_backlog. Once it reaches the limit the listener
> permanently refuses all new connections with -ECONNREFUSED, a
> silent denial of service requiring a process restart to recover.
> 
> The two existing sk_acceptq_removed() calls in af_vsock.c do not
> cover this path: line 764 checks vsock_is_pending() which returns
> false after vsock_remove_pending(), and line 1889 is only reached
> on successful accept().
> 
> Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
> the error path.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Waiting for Stefano's feedback - should be back in a couple of days.

> ---
>  net/vmw_vsock/vmci_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index d2579380f5..88ccc55455 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  			err = -EINVAL;
>  		}
>  
> -		if (err < 0)
> +		if (err < 0) {
>  			vsock_remove_pending(sk, pending);
> +			sk_acceptq_removed(sk);

I'm wondering if sk_acceptq_removed() should be bounded in
vsock_remove_pending() ? (even if that change would probably be net-next
material).

/P



> +		}
>  
>  		release_sock(pending);
>  		vmci_transport_release_pending(pending);

