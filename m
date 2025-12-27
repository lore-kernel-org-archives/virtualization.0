Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974331ED69
	for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851250; cv=none; b=dFEozCdAIZDoHnt4BFkJdKyuPB64ZmHE8jq09D8IQGI4OOlpmjDvmz5/nI1I+h3t0PyuRTE0q4bdu1uiqm7E7MpLJ6rhmCrJFLAvE/aW1ZumQnagaI1ThoIyvFzWlUTQgea0js+TfDRbxv5wDyU9gpshUUPFs0sF3Gn7U1CI8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851250; c=relaxed/simple;
	bh=lcuvBY2m8iD7c7dHI2UnTehi9o/oOqtZ3SoF6v0FUlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBpgvZg5O9/TjhSvQRn5ggX7/eLRNDXEJ9Ozk1jPkANnrjPMbV0wynXsXai148C11f0Bj+/cCrVfwvu5haqvkl2Ewk/jKpKAPIPfFqOktWE4DyYw46F22r/s3RRgYQqgHtw7G/sBw0onMhfq4JrOevRSqxrJ7iLsS4UX4qTYqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTyDpC26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTyDpC26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766851247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUjyEByrb4N0ONuMDPVPmOr47Yaw1ycFDG37WrD/UmA=;
	b=fTyDpC26Ems41VxIUKwg7KGBZBZMSnDi0wBG2W4rl5c64wcWK2iVUigEhhAYhdFLxorDLf
	5bAMB7/uX5D3WFqE1jnKT9EhDoW2aQPEIFDuu0S/hoTQXCGJyN6pYW9S01o7sb2jodHlpO
	L8ill0V+E+osoVBnbaDL8EfKFfYBm/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-_k_Ze93hMS-WAIRs6F2yrQ-1; Sat, 27 Dec 2025 11:00:45 -0500
X-MC-Unique: _k_Ze93hMS-WAIRs6F2yrQ-1
X-Mimecast-MFC-AGG-ID: _k_Ze93hMS-WAIRs6F2yrQ_1766851245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4d3so4333553f8f.1
        for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 08:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766851244; x=1767456044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUjyEByrb4N0ONuMDPVPmOr47Yaw1ycFDG37WrD/UmA=;
        b=wNPfzahO5keXHuQMsyJz+lBPwYEhnCLLqv6UkKCiPDp7hnnK5q+oadOQoaoUKqCQ5n
         mDtnQjl3yEWiv+Zi4HbrjzJ+6pbqjbQRF8YjfbNIFAHrQg20xIvspb16eGYK21YOeZfi
         bpODG51IaDdiSD04cfaYL0pMlWR79BzZ5Se6B8284XxRJbmSBeZyuFgzVydZmycmvmDD
         senzdPuP2Qd+uReSfUc9A1vheMJAQAOkQIPZ3+uFcEkrZ2KckB2hqMV/2vyBjqrBC5yH
         51YQ8gP7CRaSNkyYBSrYPO306wY0cB462QSO1rj/HlQXaYmPhuze/LokrC7Z7Sgx+7uJ
         xgEw==
X-Forwarded-Encrypted: i=1; AJvYcCUwYqxs9pDVNBALlReyOJbUB1BdngzsCUeDO/TPtHTjC5+815Gpkbln8ZxE1JRSN2EVWREH95cm26k8li+XFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzEuJVahTe/HAkEtOzrfcSeXHZwL7AUpaNwbzjhNwKy7WNnoQw
	iZV0nKMy7IvHBYbF5amzd72RZua0OcRxIfLjhWpHilGVWsl/JtpGQqYURvswbcR/hsxCes97oWX
	brP5JCW6g4b0rD0WjhpfqqGsk2rhjntAYH7N5M/nz6npu1ccHw12C2126YmXNKT/fN1l4
X-Gm-Gg: AY/fxX60XC5EFNayRbSc3+tuqkT6ubn/1MAoVBSeOSPgyod9579WNVqoGgp34Nn2Hot
	0uHAW1R1r+RhlMJIywz/L59MWnR1Lik/6SbLaTCkiX1FKIaatG0CBz+e+nDNZC6WzCvyZ5kxoY4
	lYA234YSKJwkTYQKwL5S2nNzgLuJ8bH3+P3fhVkvYzBMJFsdnTgX1eIDukWSBNE9vFs9mpCdAbq
	EmweNWw6VnhzIE9nufd/T08RV/HTPtM46pyEelo4NjKd4JPrMqOO2A4ZQDOcmPkorbmy+Zr0Zts
	eFTB7QytmiZuR6TpEINOcBdQJ+FJCi1cOOJuUDtbEkUbWqoohzOoCaQWyGsGqGlFYMoNTXt3str
	vaj4OjCBl/voLAQ==
X-Received: by 2002:a05:6000:430b:b0:430:f736:7cc with SMTP id ffacd0b85a97d-4324e3ebf79mr29498337f8f.1.1766851244501;
        Sat, 27 Dec 2025 08:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQ990ZAjKC9Xc/EGp7gWnlDf0T3OHO+QMebAR5RxVxtFTl7hbC0j3cx3WcWXz0mwHyuhA8g==
X-Received: by 2002:a05:6000:430b:b0:430:f736:7cc with SMTP id ffacd0b85a97d-4324e3ebf79mr29498301f8f.1.1766851244058;
        Sat, 27 Dec 2025 08:00:44 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm18816981f8f.11.2025.12.27.08.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 08:00:43 -0800 (PST)
Message-ID: <d4a97f0e-a858-4958-a10f-bf91062e5df9@redhat.com>
Date: Sat, 27 Dec 2025 17:00:41 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer
 size
To: Melbin K Mathew <mlbnkm1@gmail.com>, stefanha@redhat.com,
 sgarzare@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-3-mlbnkm1@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217181206.3681159-3-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mQ4nHEMoFRBgOiZO2EW7vZmBJ-3OGe6LaXdyGXoTo4s_1766851245
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 7:12 PM, Melbin K Mathew wrote:
> The virtio vsock transport derives its TX credit directly from
> peer_buf_alloc, which is set from the remote endpoint's
> SO_VM_SOCKETS_BUFFER_SIZE value.
> 
> On the host side this means that the amount of data we are willing to
> queue for a connection is scaled by a guest-chosen buffer size, rather
> than the host's own vsock configuration. A malicious guest can advertise
> a large buffer and read slowly, causing the host to allocate a
> correspondingly large amount of sk_buff memory.
> 
> Introduce a small helper, virtio_transport_tx_buf_alloc(), that
> returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
> peer_buf_alloc:
> 
>   - virtio_transport_get_credit()
>   - virtio_transport_has_space()
>   - virtio_transport_seqpacket_enqueue()
> 
> This ensures the effective TX window is bounded by both the peer's
> advertised buffer and our own buf_alloc (already clamped to
> buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
> cannot force the host to queue more data than allowed by the host's own
> vsock settings.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
> recovered after killing the QEMU process.
> 
> With this patch applied:
> 
>   Before:
>     MemFree:        ~61.6 GiB
>     Slab:           ~142 MiB
>     SUnreclaim:     ~117 MiB
> 
>   After 32 high-credit connections:
>     MemFree:        ~61.5 GiB
>     Slab:           ~178 MiB
>     SUnreclaim:     ~152 MiB
> 
> Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
> remains responsive.
> 
> Compatibility with non-virtio transports:
> 
>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>     socket based on the local vsk->buffer_* values; the remote side
>     cannot enlarge those queues beyond what the local endpoint
>     configured.
> 
>   - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
>     an MTU bound; there is no peer-controlled credit field comparable
>     to peer_buf_alloc, and the remote endpoint cannot drive in-flight
>     kernel memory above those ring sizes.
> 
>   - The loopback path reuses virtio_transport_common.c, so it
>     naturally follows the same semantics as the virtio transport.
> 
> This change is limited to virtio_transport_common.c and thus affects
> virtio and loopback, bringing them in line with the "remote window
> intersected with local policy" behaviour that VMCI and Hyper-V already
> effectively have.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>

Does not apply cleanly to net. On top of Stefano requests, please rebase.

Thanks,

Paolo

