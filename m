Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CC3AEF4C
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131707; cv=none; b=LWVkJ7FkssBFrGeUySZNsE6z64fV+voBFOXEtj55ETdnfCFffCDviZI5SCaSD5XwOWf6sjXT5td1dKBuG1UwASy7iw9FAzV5oh8ES8ZPa5F4afbJxu5mp7QUQyTiJuhAvkM1YEbd/hH0wXlLYrLXM+gLgZ7dHd21zNuVOFq76gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131707; c=relaxed/simple;
	bh=IySk8aOJXFKLTeSfFGGxEn5/svlzvTqjICY9barvUCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J7chC8uc7paUx/FmjbwXPUATG2qOYF7yvdG3D+yI/IFrY0mRU05py5JMXuKLRzAdEsHCjToc9fqRARrlrvQyCBB2xSxxmGSBRLAaGFJl4FlLaybGu3ugR7bL8jY1EIBTWAD5et8itC7rgy0U7ysEd8CP9A5Nju9HXrmrce7ZM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKTWtFZa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKTWtFZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773131705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IySk8aOJXFKLTeSfFGGxEn5/svlzvTqjICY9barvUCo=;
	b=YKTWtFZa8Ta94GE7RIQn3figu/xksegcpYVtH0y2jePLXndmooLxRMrzU6JWLW/SRn65Q0
	5LigpuzJRwiUlAft2r0YWUvcnwkPjYrACH03MC1G5WQCYubwCNTEo61aGzPmzAjzk511Lb
	S2xDjPUH6UJMzo64bojR1Bw18wzwl0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-KTL78YfFNiWbvFyaX9-c-g-1; Tue, 10 Mar 2026 04:35:03 -0400
X-MC-Unique: KTL78YfFNiWbvFyaX9-c-g-1
X-Mimecast-MFC-AGG-ID: KTL78YfFNiWbvFyaX9-c-g_1773131702
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485375aa56eso16988025e9.1
        for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773131702; x=1773736502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IySk8aOJXFKLTeSfFGGxEn5/svlzvTqjICY9barvUCo=;
        b=ng61CAMBh5ExN9xzgJuv0Dj8ZPetpEESMW5vFfQD7QRWF5/f/G1hm4j8pQlvC1fXwn
         4biueCBwIkMkHscqGsn21tNM3mqrOtz4e/r3aSN9AweaIe7qtQr7uHds5RQQCrwZ9JtA
         0Jq52eDo+h4y5HfhIPICyEHJoZtudpgBjZlegkLdP23+k2LHDgyVL0xse/ksujMJFBzQ
         XTSuxsjWsxM4r3SESeowZG4xe6Ea5JgS/Konz3P4anZmwbgQ10YBcdZTsxK1Y6Hb2OVS
         yRCiQ0S4Mk9JNYR6MlYsRk0+TRRGnZKqkQA5IjMOBM7AEgAjQl0t8r7KrY/cNcx3LGRc
         6scw==
X-Forwarded-Encrypted: i=1; AJvYcCUPkYkZj7YgaawitPHvbmLh+N9Do2WudUvvqWBMnkAwbdUH5M/DJgbaPVrPur4ws/Lf5YFgzHitPmaclgQ0eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykGF2K+Bjrwm/f3653XXksqFI72w2JXGOiiwzbyu3lDbczIzSP
	IDu0PWM5pExOZwAONy5La846jS7n7DQObO2Tq4zWJ0BMebHpCgtva+cl+eM5+NURckI+AmhYDJD
	zLwu3GnSgMlyYa5JS5y4Si64aHQYEwq7PofSmSc2VytJEJ5/ffqQX4ERmGGAd+KPPYCkb
X-Gm-Gg: ATEYQzx2FmNcZAeDwQVjEHtnEK0THrgvwaiCJQYgUqVumn6roiwj6MK1Rv+t8KKpDPB
	1VjFpex+uV2KNgE6gBkKs7LNpxQISpPayQBuNc9Bssxo7YpL045ggnyToIGKer+Rrv+lQFnD3tA
	RjhcivViPmmCwd09XHtl/QXov/cGoUuFpkMymrD32Eg5hkjQHFHZfU1so6r3RKUftQ5K7MAySgo
	rrqjRyViY88ef9Fq28kH4XUbhjjhlYMxyW3gEg/C0aeUVdGNy54jWv2Xlq2VvlC3SWJzMduVRRB
	8VNartz4a8US36N2WDLamovvu3NIKeVvAhPNpnvus0cfFaCqRJuzpluxHT7S0va8bTaRdNumz7s
	IsGXh3l2Hm+1sfUdQxAeVCijQPZAt1X24LXBHnidKkUYlAA==
X-Received: by 2002:a05:600c:4507:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-48534a29447mr140215835e9.33.1773131702290;
        Tue, 10 Mar 2026 01:35:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4507:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-48534a29447mr140215525e9.33.1773131701834;
        Tue, 10 Mar 2026 01:35:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a9e549sm58769855e9.12.2026.03.10.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:35:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 04:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtio_ring: Fix data races in
 virtqueue_enable_cb_delayed_split()
Message-ID: <20260310043426-mutt-send-email-mst@kernel.org>
References: <20260306022448.216131-1-wdhh6@aliyun.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260306022448.216131-1-wdhh6@aliyun.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l0lcOjr3eWkx0K-WOw81wGVmioTv6rpq2SkC1e2hsEM_1773131702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Oh and subject should be "fix KCSAN warnings".

