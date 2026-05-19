Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693E44102A
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183725; cv=none; b=CP9zgKQBWBPCJjg2xD2/Z4fIR7omktB5mNu1BZ5Hn8MQ3SdHElrpVIikE1EA8dC4rhbNDav2sZ0V5Q/juUc2bKnmSMpxDVILKBByK/SQ90kC0uvP1x58h73QRi8cXhnMf0bcvSTIVer9kquggJPDFPLq6alMm1+e/vbTzABNr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183725; c=relaxed/simple;
	bh=yt0H3bvBRFcuJ9DYVM0S3Grsofv+ydRaNi8hw/H/mjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nCxeq+0Q/C0zMqJTPgxSrRSZSpGAIOo9tVFx2CARZEaHaqCZPPhRtGyVDIJkS1ks+SZy1rZd4ZrwyEhYvLjH9J06Fw97o4jgZoHHRfPfRXrTModmffPH3M1NQ2YjBpYtnfrqoS6tH7TuLlLA1W+fxkO5ljL+FJCLC8MmkDX2WRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsWvEJTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsWvEJTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
	b=DsWvEJTxEjMz9QABqBLgiYO4614/hfm+wUx+WhKi81zif/3hna5r3c9rOMgvF5Ww1MvSjB
	b+B3w+PcgGTlokrpLbc41nJOF7Z1bSVl7AgO2+LYf/eXr180GF/RAElB8Y9o1RBY17T3e6
	IpLAVa2rVLpJS6gD9Vz1kmX4pgrGRF0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-hteMP1irMwWibmvs9Ggtmw-1; Tue, 19 May 2026 05:41:54 -0400
X-MC-Unique: hteMP1irMwWibmvs9Ggtmw-1
X-Mimecast-MFC-AGG-ID: hteMP1irMwWibmvs9Ggtmw_1779183713
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so2670676f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 02:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183713; x=1779788513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
        b=RVbQBP4045zhTHH5q8RQWTCU6g7csCsug1T/lLkd0da/Td3yXTQl7wrqxqkaJDE33o
         NFMa5Jz/HyfUrM3DfkP/Jz3/F/P/Ov4+W9/LZB9nhGKg+vqWODYSgmlKkwonLz6PoaVX
         rzcJmYkkJnEdg4AFQyErXYBjssWOVKaqss4YuoOGQ9ELjKTMigrvePl0iFM4aGQ3YQmz
         Wtu3NzfYjf+qZeG1OqZ7HL3LRaBOotWNDFmGWOSLsnpwaONf0aHqXJjWkKL+SUUlMvFL
         v5FpxiY0pxClIAY9We79bgxN20jBia0f6spVwikoZp/lFSXJX/y4LqzMU54lh3HsgFaP
         eN3g==
X-Forwarded-Encrypted: i=1; AFNElJ//gJe1NGllbdXHkiScvpY14aljCRXzWOyOrtkAVYoOk4Xzfa2Pv7x8MWNrvUI8TidH7s8Scbc5OGX8a6PvDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzonGawJVIMwkSCNpqAV+Bz73bAbkODINk2uHVUR17LF79XqItp
	5VpVTjfeF82bN1a7GyNHcctiO7wpLkZajyUQXUt2cPNoseWmiTG12ZM82lUoIX4MF1LhuitzCfv
	PDTOyMCUVhvOiZNSlrdWZqJJZL9qmh0ppMY3n80MUhg07bbVGRVWMaTyswM/+I527T3R/
X-Gm-Gg: Acq92OGGwy8HPAm5NdKVsoloFymsiILSUO3XFrfc156Cmw5JelYguNexm7GzkYAbpc5
	YrE9BIaHKLzIcP1QDO424uYFTlIX7caHp6CI93IKoNCkbiSRk+bcwimtFEedbtiG8P8dnXvPK3F
	tHf4hh7FwmMIx/4+Rnwi0kz+oR8WE2z6MrMo7c1QtdvMGf3RiOys4Ckvfnr1ICznlWAj1gqHRqB
	WSQ55cET/QTG1aG0hxTU5rMPIwVtoke1Y90hw1ydZweZKz1JBxvAUoiZuKeA4fZJsGUQjD+SGJA
	L2sQtMQimQBoKG5ZuGQDzQ4cKHV/E4kavCSp4Nemr9Z9XpOZXEoKmkbrrEToI7WtaXvSyDYcA1b
	cRevnYw5IiB3ILa26uNwyfnC2fBHSIvVn8jH766vn536ZP61gK4yyYUrazsaOyxyKwjnkdWUALg
	==
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164471f8f.13.1779183713264;
        Tue, 19 May 2026 02:41:53 -0700 (PDT)
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164400f8f.13.1779183712778;
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43263408f8f.16.2026.05.19.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Date: Tue, 19 May 2026 11:41:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Minh Nguyen <minhnguyen.080505@gmail.com>, Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
 <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E99z-eR7MCKbeY6GYpC-W2aZc51pJH1rIt1ljdQsSuc_1779183713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 14, 2026 at 03:26:28PM +0200, Paolo Abeni wrote:
>On 5/12/26 4:58 AM, Minh Nguyen wrote:
>> vmci_transport_recv_connecting_server() jumps to its destroy: label
>> and performs an unconditional sock_put(pending) to release the
>> explicit sock_hold() taken by vmci_transport_recv_listen() before
>> schedule_delayed_work().  The existing comment claimed this was safe
>> because the listen handler removes pending from the pending list on
>> the way out, which would prevent vsock_pending_work() from dropping
>> the same reference later.
>

[...]

>Sashiko says:
>
>---
>Could this change lead to a socket memory leak if another packet arrives
>before vsock_pending_work() executes?
>If a peer RST is received (err == 0), the socket stays on the
>pending_links list with its state set to TCP_CLOSE, and the base
>reference is kept.
>If the peer then sends another packet (such as another RST) within the
>delay window before vsock_pending_work() runs,
>vmci_transport_get_pending() might find this same socket.
>Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
>default switch case, set err = -EINVAL, and call vsock_remove_pending().
>This removes the socket from the list and drops the list reference, but
>it bypasses vmci_transport_recv_connecting_server(), meaning the base
>reference is never dropped.
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to false.
>This sets cleanup = false and bypasses the sock_put(sk) call, leaking
>the pending socket.
>While not introduced by this patch, does this error path leak
>sk_ack_backlog slots on failed handshakes?
>If a handshake fails due to an error, vmci_transport_recv_listen()
>handles it by calling vsock_remove_pending(). This removes the socket
>from the pending_links list but does not call sk_acceptq_removed(sk).
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to
>false because the socket is no longer in the list. This causes the work
>function to skip its own sk_acceptq_removed(listener) call, meaning the
>listener's sk_ack_backlog is never decremented.
>---
>
>it looks like the above is trading an UaF for a leak ?!?
>

@Minh @Bryan can you check this report?
It seems a real issue, so the patch was not applied.

Thanks,
Stefano

