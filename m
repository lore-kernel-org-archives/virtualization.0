Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD11E3788
	for <virtualization@lists.linux.dev>; Thu, 24 Oct 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783296; cv=none; b=ECXOFenoGkm2FJ6bnqmpbyHslRtWPmmZ9uHf6RH+3wHuvxTUHWcd3tZPmDiyrz01bvWm9zxgg8O3l23aj8iowQf6JiY2JIHikTU4YWNwwRaQ+R3LJPn4PxGmtzNOKNj5+FNL91ipnDfnwt9uv3UBduBLZv0e9u6PfdkbZTBvNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783296; c=relaxed/simple;
	bh=nW0TWG7Fc0VNjERMXMTr1agpaawOY2IgT9uj4bNwY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dTAn0EfW8tCWpLha+Ocgst8BBhSGOkiYV0ef9sE/WwZ/CAB6cOQKrO2yGKPTsM7SmP2FohVdN1EgrKaPfAHqxp+VdiR3l+GaCizmaS7eXaMN93dUisoPgJzK+KvvWKV3G4L262aCHDnvyPdSi+dEX9JZS5HsZSBd7Tzc0+ttK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBJi7pJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBJi7pJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729783293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
	b=EBJi7pJ2gPJY+vR2c0iNk8BHJrvcfmHo4kyKtk9H3KnTa7NVEio+tdnRFGA0JIJC906O1g
	ASpv+AVUKt35EuN/4Es2MNF0yZ/7rJYCHWp5I6dfOU3w0U+A4ggE8cuu3Ju4sYy4AfWpci
	gc8IeRRf88cw2I3Bhq8yf3GdwAP0yKg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-tvtUDzLAPO-QBZRsUUvG5g-1; Thu, 24 Oct 2024 11:21:32 -0400
X-MC-Unique: tvtUDzLAPO-QBZRsUUvG5g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460aca6cd0bso16766641cf.0
        for <virtualization@lists.linux.dev>; Thu, 24 Oct 2024 08:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729783291; x=1730388091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
        b=PoCT/zkq+ztPzDCsfcvxJFPXKbGRZRt3FMTUvYIn6e2z4ROvO5w5SF1C9qkvSVS9ah
         B96mFUFh1jA8LfJHcD9GNYT728x5vTTVhabdjmX891dAqsZcDnBCn6jBD51008dX8L3z
         k44Lm65EuoYwi4fqBNvt1kkhtICZL4veXpE86i802nJJmLaKejszDEgOvFJYmaCT68mE
         yPYlLRgr+dErw4tilwttPGoLCBNSNOQjXcuIzwjlRsWqvSXDGQYS9wR0sXxYYLrGi0CX
         7cZae1dutL+xMslO+mcYigUSLxQ2SdPf+p3trojAVsbJgwLT9larewTfRQOe1HloyY8T
         MIAw==
X-Gm-Message-State: AOJu0YxvbrEJbiMrmRsudRxlu2Q83hCEIWPw1A1MXE31xRGr0xIe6cce
	ozqP63E3tEtrNtCsqvBe3sFAXIEc8ETpfSbkcmKZov2hBuOcw2wKlPf4JfnQs2iLHmvF/thoQmF
	Lxn8wNxcRg7gxT9+O/7P1LCeiC+7EhG+uXkFeBoij7TegoQp3vTFCJlgH/UKw86VL
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11593141cf.6.1729783291634;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENeP1TLULS4yPvQaHG4+jzlT08mwB6uRKJpkFnJDnX+eZo+AoJiFHON/m2ibWFVUzxSQuMdg==
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11592771cf.6.1729783291124;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dab83fsm52808871cf.88.2024.10.24.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:21:30 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:21:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <4xfrphsdl7p2aqu6w7diow5shsnjq263lhfudi4yiqxvkvcmkq@ti2hcdbkthok>
References: <20241023210031.274017-1-kshk@linux.ibm.com>
 <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
 <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 24, 2024 at 10:00:47AM -0500, Konstantin Shkolnyy wrote:
>On 10/24/2024 03:43, Stefano Garzarella wrote:
>>Other setsockopt() in the tests where we use unsigned long are
>>SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
>>fine.
>
>It's actually not "signed vs unsigned", but a "size + endianess" problem.

I see, thanks!

>
>Also, looking at SO_VM_SOCKETS_* code in the test, it uses unsigned 
>long and size_t which (I believe) will both shrink to 4 bytes on 32-bit 
>machines, while the corresponding kernel code in af_vsock.c uses u64.  
>It looks to me that this kernel code will be unhappy to receive just 4 
>bytes when it expects 8.
>

In include/uapi/linux/vm_sockets.h we talk about unsigned long long for 
SO_VM_SOCKETS_*, that IIUC also on 32-bit machines should be on 64bit, 
so the kernel code looks okay, but the tests should be improved, right?

Thanks,
Stefano

