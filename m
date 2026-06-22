Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A72DB7B7
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129260; cv=none; b=RtK9B597nFcf1cTCcxayw8wQsJ8yFvs+va0w5IC+RJjJE6sCCYt159LrOfXxCYrUyAYqiH9nCIx4Y6xuoMepFlJCp1RoNEmSDw7sIX1mXikfTXqJhba6kZ3MWhVktLccWxVjitkbuubcsZtnR8+shQMkkibVWQ+IZY4LXl01fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129260; c=relaxed/simple;
	bh=jMBYk1I26Z01N3yLPy9S3F29MdPVnUU3Dfav2r4ilsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KLobHJO79aexNPCIY2wbagan5XqV9MLADi3d9j8baaewWcKr5ksD+chn++Lcj9XiKjXIzyKQlS73Ns9bJW+v1rygnOgnYEFqFGfRTlZfs/1nffpTOlnNyJ4cK8lHknUQfdUu4gUsJ8GvFJkqmW4jMdJeb5hNA8SJEfoMLphnVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1cgt6uB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1cgt6uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782129258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vVHuqQ9WD2uTyMiPGWc9jmJ0mKld9JHXnm8ba8rY2w=;
	b=G1cgt6uBTkjDbvljLaRGRw4jS/VJ2Rga7tcL4Q6QyQmm23UfSfZwY+9S0pxaWBsIPDp4Wu
	9njDmvvZkmhAOk9V8fWcjJqMyTvXcBB0wa03emQAcub22wJ6sfNhaXpY9cKeCP/Mk0WHK3
	HKY6V0nF/uHXXemnKmgCR3ULNM4OcnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-ou_Qi8a9Oyi8_gJOGj96pw-1; Mon, 22 Jun 2026 07:54:17 -0400
X-MC-Unique: ou_Qi8a9Oyi8_gJOGj96pw-1
X-Mimecast-MFC-AGG-ID: ou_Qi8a9Oyi8_gJOGj96pw_1782129256
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4625e71d3ccso3590443f8f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 04:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129256; x=1782734056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vVHuqQ9WD2uTyMiPGWc9jmJ0mKld9JHXnm8ba8rY2w=;
        b=h+s5SVCH9NEZxnB1DJ799dsbxwEHkpGgsj+R4AEIzpBwpNjYJpLXuR0FYQUHM3I9hg
         uw5PHDUvrQgUZZbnqF1/qXCOH4/+FwSgoe9tTNvOMAL/2EIABxLTAS2JUdyCP7i21/io
         OVlDX7sVJBEEQV6UCG45sUWIetvWQ4Lt+OiGAE6guRk2Pk1VYxSTBI6yoNU37cM9VI7V
         eVWNjXUUIRQUHzzvHvUPnUqUh82X4t3G1hq0x0xJYFfiEbzwQXpwxezAofz+j0pFkUXA
         LOVbcV1Hs+A2SFoW+62MVT0kaoGLbC8vU5PfNJkIB/JuQ7G2u2qVUj7o9+15ja4uA31J
         Oekw==
X-Forwarded-Encrypted: i=1; AFNElJ80szM3gbjbiqm1DXfCmCVKY1BjRY9iyL6Jm6xubeKxU7LPQ+zDr0Hm9ra6aapIeAispGfzVhzTutLkbIgwzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv94Oafa9XTeASjckF3CkEZMY0j1l7b8mBFpgRIyW9LqamYDpP
	vauZcWyfyGyaMX9gdiR/WuhHd0XTxGaW0dwGYgqNRVhfRnRk3yWRD42witrbOPcMVw8cbEj7Ymi
	bInlJdMpRKHKa5bXVOWnKcvcnUAc0bzzXZLLBxim3/w0acxSEYpgP4rrWTNSEqCt3p+tCvnA+9l
	nY
X-Gm-Gg: AfdE7cnPPfFrrFYVkeWvRnwzew5BhOPLYZKEsPv4L+VNwSS0caD1lY1H1ZGVWJ8SmF+
	QJeZrMrQ5QniaeE2hjD6U0K8FpUAKCsN0dWwoFkBNSDJaoGWp3cZZfqBeZwILIo6s9P18Am7yX+
	E+VK1O7Pk4dvPIp8nqAjC4qaJtoGSTGIlOANpmOP9Zs+CcA0YjkDsegxJ14azJw40z3FdjMWHZi
	kpRoTZQqySSsmaJVnTC+QiQFNu2iV0HC2L+KxqOO8W/Py7cr29kiBsHGbWHcwGX+aNfWyS8rA5J
	Wh8sgkW2zpsFu5weyJ5yTJhLPA9nZzPanlXfz80Z3h40QhlhHWOuWtRN1d5RKKcXVRrFOIEWVW3
	NOQLdrgXS1DZ6nIeP6D4Mv/L3k68AzUTG
X-Received: by 2002:a05:600c:8218:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-49240a598e5mr172439665e9.18.1782129255796;
        Mon, 22 Jun 2026 04:54:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8218:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-49240a598e5mr172439175e9.18.1782129255095;
        Mon, 22 Jun 2026 04:54:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm355852005e9.0.2026.06.22.04.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:54:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 07:54:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: akpm@linux-foundation.org, eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, ljs@kernel.org, rppt@kernel.org,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 0/2] tools: Fix tools/virtio test build
Message-ID: <20260622075317-mutt-send-email-mst@kernel.org>
References: <20260618080405-mutt-send-email-mst@kernel.org>
 <A1DCE9FEF645A3F9+20260622070113.1207518-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <A1DCE9FEF645A3F9+20260622070113.1207518-1-chenyichong@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQQgBfgWGsPp-VZhYhUiLxpFqmZVea4IoBaidmX6q-k_1782129256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 03:01:13PM +0800, Yichong Chen wrote:
> Hi Michael,
> 
> I checked the history again. The tree was based on v7.1, but I had
> unrelated local commits on top when I generated the series.
> 
> I rechecked this on a clean v7.1 tree:
> 
>   8cd9520d35a6 ("Linux 7.1")
> 
> The build failure is still reproducible with:
> 
>   make -C tools/virtio test
> 
> The first failure is:
> 
>   include/linux/virtio.h:10:10: fatal error:
>   linux/mod_devicetable.h: No such file or directory
> 
> The two patches also apply cleanly on top of v7.1 and make
> the tools/virtio test target build virtio_test, vringh_test and
> vhost_net_test.
> 
> I can resend a v2 based on v7.1 with a base-commit if you prefer.
> 
> Thanks,
> Yichong

Hello, thanks for the report!
the commit to try is 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf - that is
not in 7.1.

