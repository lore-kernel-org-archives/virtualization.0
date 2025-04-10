Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122420D4F9
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323923; cv=none; b=YWlxCqZlWKeGcyzrYhTu85NRoREWMoX627g1wIy0HtOGNcWxn81saZBsYfJjcmu3Fh44vvOmKBrYmtylTR/+dSdchiPLOOP/h05uHp5BYipcvVJETqks5kap2WxNKxCJ2J5KJMNd2Vk3jBbxIOYfM/3K7d+QovK4HesyUStd6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323923; c=relaxed/simple;
	bh=mfywADYqJ4ew9xI3CclYYcgrZFl/YoOSYDIBc9Dd5cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmTGb0M1HSNp9O3XsSWZn2MjdLiqXCfcsJo//vwI3bLQDFru0BfBbCffmOA0KkxaJJsKuMSdhROyn2rueEAEXhpR88lhqFZaGSiDarqBXBZXvnG2m105+odugWcAE2hCl2aQum4/NPwAzQ5/LQFvvDYly+l3JzQhR9H09PjgIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODCwvPht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODCwvPht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744323920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYR4fCas43gwQw++5uVITo+VmUSNg0r33Tx+gqd6wEw=;
	b=ODCwvPhtAlOznRhuW3gn6LYvi0U256nNQznMxqZ+b53kHFhpx7wdrLxeuynL8X0Azws62e
	dwaHPaGJX7rzLF1Wk3w1m++7h3XaAGc6MFn4ajZ44EORHNLH3lh+GOr1wKFQMBuaKz5OrD
	hqB0jZzyZUEyJh4UUPx4l42QGonpBV8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-D0yEXhq5P9mdzydOlRyyNw-1; Thu, 10 Apr 2025 18:25:19 -0400
X-MC-Unique: D0yEXhq5P9mdzydOlRyyNw-1
X-Mimecast-MFC-AGG-ID: D0yEXhq5P9mdzydOlRyyNw_1744323919
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85e80e2fbcdso13919439f.2
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 15:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744323919; x=1744928719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYR4fCas43gwQw++5uVITo+VmUSNg0r33Tx+gqd6wEw=;
        b=byMGp7ZkV5tXCTS0+3Rt4MvTro5KTVT3bEXOqCOYsE/NaRf6S+tN7RVMlF7iOJqVd0
         U5Ru7CFtWcR9WKBqkZqjMxyEvSftlmDg1cAPeMVaMvom2iRwegzQq31TzphCvQFr7RfG
         1JjLS3x6dYNZj8Krx8RWNeYXOGzhMsXSTrnTn3ePmADj7zWO8ucv9YicGlL669WPBX0e
         U5kCyGPfU4EKJoU05MpEXiEN8jFSMDZADQfjU3/xkbCAZ0t54U345BFzQat8usudvFkm
         blyDCor8fWFpOcnZ9E/Fe4t6yAe1UbhC3KL87yjo9DzAudfiLZVvL9Fi+nFIxgHjqlm0
         UL6w==
X-Forwarded-Encrypted: i=1; AJvYcCW7JxElxgr5Vi122psoHzYDj5X8KeK4COn2Yx0LOxNK2FypPQbr5X5N2x49E7rnqwKg8eT2P8KLn+W3WFWN3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YysMKXpcfZpC8o25L0nnpYxLpf00bWNdc35oiH+E4PL5bzeziNL
	lRBzyox3d1khL/Bzcrgfo01WL3p3jTsSrpfJ7YLPiw0hu6RjPLJZN5VVtRs7X9exOzAFaxFsAlk
	K5ewKwPvm8cZ5pLyrlB0jhnXDbNSar9zOzKRVuifYnTH3xvx2oVVn2T+zyBafTW5k
X-Gm-Gg: ASbGnct6rJ6Qr1JjNY4mgdY1HsLa7s49fbVDlkhRmflHDOm56P6RO7wRaS31/fdJnqf
	RPLKCo8g/M0hMF8wYc8yBrrVp8wTXh5NYjoc/2Y+SxP8kwc5oiERCrz7FVcsEMcPp5xh6OfJWqo
	sl06tvWn3hHtNh9a3deWJt6cLBBaujO+67actodyx2GGyOtQnhSawrDQYvPoaWyZxS4q47RmUjI
	ZE5+wjaYHMoOWLP/DdlRAZjIztlvJtroCoIrSFxW/tQPnmvTlXl+z6SYDTULUktWF2djjSpMSs0
	XjzHW4SnCN0+5RQ=
X-Received: by 2002:a05:6602:134b:b0:85e:7974:b0ff with SMTP id ca18e2360f4ac-8617cc2c796mr15149339f.3.1744323918870;
        Thu, 10 Apr 2025 15:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQkXdAZ+OEzU4A2DZsacWYyZwm7ExYFaPxcS4RRuyEG/aWoQJVBgD7p6QneavEDnZmQ4ZUXg==
X-Received: by 2002:a05:6602:134b:b0:85e:7974:b0ff with SMTP id ca18e2360f4ac-8617cc2c796mr15148639f.3.1744323918540;
        Thu, 10 Apr 2025 15:25:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2dce4sm941729173.110.2025.04.10.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 15:25:17 -0700 (PDT)
Date: Thu, 10 Apr 2025 16:25:16 -0600
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
Message-ID: <20250410162516.6ebfa8ee.alex.williamson@redhat.com>
In-Reply-To: <Z_hAc3rfMhlyQ9zd@google.com>
References: <20250404211449.1443336-1-seanjc@google.com>
	<20250404211449.1443336-4-seanjc@google.com>
	<20250410152846.184e174f.alex.williamson@redhat.com>
	<Z_hAc3rfMhlyQ9zd@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VYONvTRBBnovjLvxqPOKRdG-6AkgiFsN8gruguY6-AM_1744323919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 15:04:35 -0700
Sean Christopherson <seanjc@google.com> wrote:
> On Thu, Apr 10, 2025, Alex Williamson wrote:
> > The "token" terminology seems a little out of place after all is said
> > and done in this series.    
> 
> Ugh, yeah, good point.  I don't know why I left it as "token".
> 
> > Should it just be an "index" in anticipation of the usage with xarray and
> > changed to an unsigned long?  Or at least s/token/eventfd/ and changed to an
> > eventfd_ctx pointer?  
> 
> My strong vote is for "struct eventfd_ctx *eventfd;"

WFM, thanks,

Alex

