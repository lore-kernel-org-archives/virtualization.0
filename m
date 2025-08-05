Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DC23717F
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378159; cv=none; b=usbynDYJSFMCXqZUJpAhRiFU6QSZCpv4kR1V/OS4tV/72i0sljH3xR3BOVMGNPSayufbffI/sKE2kOm0Z4Y6KzbIbsz2ZnWyya17UzanDmv/bcBLWgMSjFJopCQSNe6Rdk4ljuDbxUizHD3OlFF8SAKrVLW9CFA71IxNBWG5kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378159; c=relaxed/simple;
	bh=ftuIf5p693pbIE28Ca6q+2oPAzEBuJqq8byNCo2RqCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K6ywYnnAQMDi8QqLjm94Phwva4V3xNr1KEi3BaPbnjklfYfCMHNct0kc4uaTyJHIU/F3fTdlo6jz9laoweDEbh5fZW/CP7rzPcaV+PiRya3GOjzOELnXjpcVqcDGjgEfYLH1Ux8dq6RXb2NHTFhkdaqSJYCa7pzLMM/qdLrRMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAC5lkzG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAC5lkzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
	b=AAC5lkzGtstfCJ3mop2YdxE3i3rFIV9ThauKJEZimNZgXFQV4Ur4IFEFMGNPjlOQa/t6JZ
	YsZIqKJDunu9ERbCVfd0hN2D5gv7H1moS5dFm4LILlZzal6v3mIHXM4dhG3EY3O+QMarrE
	o94dmVKxlagtP5RDz9G72ID+S4Tqidk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-4pimCehXOlqk7dkbpW2kQw-1; Tue, 05 Aug 2025 03:15:53 -0400
X-MC-Unique: 4pimCehXOlqk7dkbpW2kQw-1
X-Mimecast-MFC-AGG-ID: 4pimCehXOlqk7dkbpW2kQw_1754378153
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7464e3bfso53434231cf.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 00:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378153; x=1754982953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
        b=a+bxIMbMz4Z/r8ToZZmLUl7Y8ViMEkMZMssjIhbJh1da7q5IIyNypW6hQMdJsNUx1h
         2kIjhy17l415mpiGHFPUkvEfSlau7DE3K7zW1kRtyJhK7Q5Q9VuqDAbenbnb33swiC4P
         HWpTyfeJfZOxSYpS1NDU6T9xLmiC7aXWKYmEWtIqRThQbF4dOmrsQqLzU4B9U2GatpV4
         +rzxmocmLElGS204MMnnZt8nSljFuUjFvrOWr3yNrUrJ6RiUsj0LprXw5Lrb0Znzgw5H
         SVzF7xRkFaJyL4z3moQXbOdgvZhEOShJDgXfGrm9BRfyViL4/s9QSzA+jJ6ERDToI20r
         +dlg==
X-Forwarded-Encrypted: i=1; AJvYcCWQzCl8ml8yczzCAh//IdPCOv3vAYrWt381fcAi3vdvhDI1I4ZcthRFpgCwRb5yYeVh44tx688jgStlinet5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw3mrXDcX2DM7lgttLUXvqseXQ9G885mnvsQeiop4iCvVq1Zg/
	TByq/AbBRvNsFA3+uWlgG8/NRcVcvJA3TbxGW1Zo2YwO0cb3Z8sBJI+W9e6xzhwNs7yEzvlvCJT
	2i0ZQiuo2PTzLLlI4/qO6wmBAnABHeJOIPPEZonUFeLiM/CRO72SPHiQzhkeU+ajCramh
X-Gm-Gg: ASbGncsZJ55W+TChHHbJR1KlU4SZ7qVGUNQcnqgXAQndOEZeqld5cEXUTa+uyiMAoGJ
	ptRykaOfzu/6WA/+f8c+bTwGf1SoZJfTTDS1JifPXGKrHxet102zVjKMWdXXyr2SikLuwY9J90Y
	9rOwdg+lKqKxvi7sxYO7fiIrq6Sef9fv446kY7lBgAiLgXQQFeSRlH5+CeWh/EsTUQtBdS/KdV5
	M1EkIvAB/MWbO3EM2JIHOijxyYG5S7KHY1cu/ClxqY/GmLWbVGlqLxR7nNvOaWZz3jYBwhaUjj6
	cujs+1dF31oO8ocQQHk+FO3zm6P1TW5LrtFag78O8VmXgkn9he74ySDZNkjESK5JTD0jzxRwqqY
	f+07ttY/Wu6aDjjc=
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762306d6.43.1754378152799;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZ6fig7Xx657yIfyOJPg7qs7PE+/ypJzBtTrd0P+Slx/GHljmbFT9/ITIdPwSIwQdwRhc6g==
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762006d6.43.1754378152227;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm68273536d6.36.2025.08.05.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:15:51 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:15:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: bsdhenrymartin@gmail.com
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v1] VSOCK: fix Out-of-Bounds Read in
 vmci_transport_dgram_dequeue()
Message-ID: <jqgnivkquty3gdhhedbx3vub7wguhuxyorelkpvwhu6r3mfvzm@q7voouptegpt>
References: <20250805062041.1804857-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250805062041.1804857-1-tcs_kernel@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Ni9AmB_5Nr5POP0y_VGWtCgY8wtF_99zPcWqY3T_aA_1754378153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 05, 2025 at 02:20:41PM +0800, bsdhenrymartin@gmail.com wrote:
>From: Henry Martin <bsdhenryma@tencent.com>
>
>vmci_transport_dgram_dequeue lack of buffer length validation before
>accessing `vmci_datagram` header.
>
>Trigger Path:
>1. Attacker sends a datagram with length < sizeof(struct
>   vmci_datagram).

How?

>2. `skb_recv_datagram()` returns the malformed sk_buff (skb->len <
>   sizeof(struct vmci_datagram)).

The sk_buff is queued by vmci_transport_recv_dgram_cb() calling
sk_receive_skb(). And It is allocated with this code:

#define VMCI_DG_HEADERSIZE sizeof(struct vmci_datagram)
#define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)

static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
{
	...
	size = VMCI_DG_SIZE(dg);

	/* Attach the packet to the socket's receive queue as an sk_buff. */
	skb = alloc_skb(size, GFP_ATOMIC);
	...
	skb_put(skb, size);
	...
}

So I don't understand what this patch is fixing...

>3. Code casts skb->data to struct vmci_datagram *dg without verifying
>   skb->len.
>4. Accessing `dg->payload_size` (Line: `payload_len =
>   dg->payload_size;`) reads out-of-bounds memory.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: TCS Robot <tcs_robot@tencent.com>

Please fix your robot and also check your patches.
This is the second no-sense patch from you I reviewed today, I'll start
to ignore if you continue.

Stefano

>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>---
> net/vmw_vsock/vmci_transport.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7eccd6708d66..0be605e19b2e 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1749,6 +1749,11 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
> 	if (!skb)
> 		return err;
>
>+	if (skb->len < sizeof(struct vmci_datagram)) {
>+		err = -EINVAL;
>+		goto out;
>+	}
>+
> 	dg = (struct vmci_datagram *)skb->data;
> 	if (!dg)
> 		/* err is 0, meaning we read zero bytes. */
>-- 
>2.41.3
>

