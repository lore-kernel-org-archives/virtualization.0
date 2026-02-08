Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590E2D77FA
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571756; cv=none; b=lMm2NkyZpGnDoxO91hy7xWUaVPIeOMf5B+ToWimM4kCT+iiszimGjQ/fllV48bBc5Jrk82s1wXVKkUAsbj+VvKweLSLUMiQ4/sNx/ZtAOSM0Jes+zGjMeWsL2Fp7dsDePChOY9Igu4HQM82FMKPCrC6riGdo0syrS+8JBukviXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571756; c=relaxed/simple;
	bh=Io+4WSWRnqj1lMbCNwmQ7f4A9LlUapVwpGpfF0Tsf7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d1s/u6FRX2levonrNURQPb+g05uEIesnkr8P1aCIs+HxNV1pZVtwD6Id+ERNNNAaQyiQZrK4upsQmQSGfoYoy55qSG+37GqM6kLfJFHhxVOL1l/yM0lF5GvuTjfbBg3t5BStcswATwqkqQRH4e6eacK2r6CJvTSCkOwdjIoWWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpQA5g4a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpQA5g4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nb+Zr3iAkeociuNjy7qiEZVe03m0xJIJkKHbH7Kn+gY=;
	b=DpQA5g4aJNPFWudtf10+MGNKAGhR+UFDbrf5HPpfZbiAP4VMGb7vuW3fGrzJLqjKeLcU3P
	aHdKOhSooMb4zWd4snxeYQZ7eL1PyqDa7Ghpuk4hkOT54y7yWO36yakqn4Cys0FknNmivn
	Gia7q+eCvIgGqiRgKEJ/p17McYP0Bfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218--5Y08iRAN0mwt6w3rTEm-w-1; Sun, 08 Feb 2026 12:29:14 -0500
X-MC-Unique: -5Y08iRAN0mwt6w3rTEm-w-1
X-Mimecast-MFC-AGG-ID: -5Y08iRAN0mwt6w3rTEm-w_1770571753
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435af2d3144so1542893f8f.3
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 09:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571753; x=1771176553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb+Zr3iAkeociuNjy7qiEZVe03m0xJIJkKHbH7Kn+gY=;
        b=VbdN/SImVNoDbFS/OP9kJV6ofSNh4vLd+LLRRjRxvsbNmp9k+CfrkqGhJXtiZMxYsM
         b9HuizrewmU5ImycwgNskGJwneVQXcy/f0Q1D0yCx25mo7tqRVkS6kg0TliIaGPFXnmG
         8TQH1r2jjvhxKcLcZHA3IQwLuClmeGpEJZ0/0ytPMwplUVNHf4KK50wxqFo3RYH9VuRF
         MNKl/K12AUI5TwgE3Ss44oojxHkbZg4E2V9x7D4HBdu0J1Z2FUFQi8D5y/aBBmPulNdS
         /N4W+/ZP9398DlPiszD3Ct2hJS9wFnqw5wQQtlJJOktiFIyzdEpOkjShGf2eJTxI20ZP
         NBgw==
X-Forwarded-Encrypted: i=1; AJvYcCVUiL5EY+AD3WP4z5WHffXU6DgJXkRxyE2XPSSe9fGdVN4pSzwad2BkyodkBK/rjZZ11tjlGDUfCE9YhAU0mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkGkocZursYtMXVIXf0gGSxLcA+BEg799s4pZypYTZ+1TNyuLy
	Ta/3U3Ofcr2Hwjk9/zN+P+uEDNzE9yiNa7CuGKzwz6Ia/B6GYWWFAjU8+5YoGii9tTL8IHAHjBu
	VWfGX4zBh8DiHgybf+YRYGsCxeDEzfzLhCwe8IX8A8l+jVcP6eBrWNOGR21DaOpw5gYf9qAwjC4
	lV
X-Gm-Gg: AZuq6aJP7ssPTsPWQIgutcxtdtKgm1Ggz47i7abQxHhTipYnpIZx9m1VWqac/KEViEn
	wEcY/lUdGc7WMzYzEcDfTT71OqnaNeonIfMqJthbtFq66FwYpgSNQYW5bM5hLLcygDEZxOOrOYp
	nVats0urjcQtlyjPLBNv/z6BoKq9ruExTpfdppZZNHSrMsJWHH2Ftp/3wSFbT5dH13P3JEi5ca+
	P3bpufCKlY4CnzHLfWPlKaO7Ko2wUokU8/BaTC3grVBNtJ6FYx+9bWd4XYcdQ3lKK3BTvPIbVdK
	2MbBPXkbJyhE8mb8fI1YAbSUXHMqNrAf4vAx7CAOTsfWLwT1U9NeFIXFRcX0PHWNRtzD5oWnKjh
	dLYviJkOQJt2E+WlKzOqb0e0G+F3EznHiIg==
X-Received: by 2002:a5d:5e01:0:b0:436:23a2:5e32 with SMTP id ffacd0b85a97d-4362938a46bmr13192765f8f.48.1770571752887;
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:436:23a2:5e32 with SMTP id ffacd0b85a97d-4362938a46bmr13192736f8f.48.1770571752473;
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376b62b835sm5674343f8f.12.2026.02.08.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
Date: Sun, 8 Feb 2026 12:29:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20260208122325-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 54YWKNRypu4A01imYD2ar3Hlz3inPl5Kx3MfEjlK1fU_1770571753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 04:47:00PM -0600, Daniel Jurgens wrote:
> 
> v19:
>     - Fixed ;; and incorrect plural in comment. AI
> 
> v20:
>     - include uapi/linux/stddef.h for __counted_by. AI

this is one where AI wasn't at all helpful.

__counted_by is in linux/compiler_types.h


-- 
MST

