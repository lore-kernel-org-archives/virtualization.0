Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017E2E764B
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073038; cv=none; b=QPzu9B6JAi53DMqN10ctgNmf0Dysa6xjbNgXzN4a/3AUW5LtLW1Ynn6cZyauF8rSvHODHyFWlrqC2o0Phw3X25pZ+ANc+HNm6QSFh9wJcSUwnvOl7C9Q27Nz/QRDt1f2n5NxQntUwcR2jFYJ6dGxjsqNfFm62k5U4dytOCy6ayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073038; c=relaxed/simple;
	bh=z0KeUw8GcTcwQDMmgIgnjnCbBlIeSkXI6NxiN+WQ2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kZeBUiOz3BBhsWa46FoU/PpcP/dLspGC9Fgt/jfqWc5OjeoWOxUvVV/LF93a8NwTHsmEpYBU7eyPTd9uOeLIF2FjsDqGSvk1/YmTv4pwTuQBcAC+TvfwSegJNyco+BDscDp/Oerbl9GZKJdsecoB+IJiN60pz3oChqm0x4fnEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDdDW2s6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDdDW2s6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
	b=QDdDW2s65GzkmW4uEFB+St4/qf6wH3NbFKUhpyDJN30Ekt9bBhijahimUc2EONMPG9n9j8
	kUllBslv7i/Tou3zjUyjfqQr9HeOkthaQyQg3nyu2Cq1TXhLzBoPyvgOfLjAixBxCoWSOG
	9bP77/1lqOYix6oNHFYnC+0s/hx3hPk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-g4dlmSg6P5W9o3YJ4_5OOA-1; Wed, 09 Jul 2025 10:57:14 -0400
X-MC-Unique: g4dlmSg6P5W9o3YJ4_5OOA-1
X-Mimecast-MFC-AGG-ID: g4dlmSg6P5W9o3YJ4_5OOA_1752073033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso6815f8f.2
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 07:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073033; x=1752677833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsDh3n8LHJ/HdhnBV4kSQtvnM5Eyl5B2MMoNaxxIWlI=;
        b=Fue4/UE8Ap4e7FLGyEvpBxhf+yS8IWtjSLT3nA1Dh2GnEcSm8Fdqa1GwUwOXyQdxbs
         6TUGgU0qctTgT6Y71cBpuogDFw7GdEucl8JZWDfwbN4eNQoCkbkwqXAWxw9vvCFAOZCT
         1CtW/HjC4Zcf8kveD2MyrLDj+H0ouqJqh5r6Sw1+eWO65BG0AjohYIpKXHFeWBcfvvhq
         4yxlnFbAqahAGtm6ffv48s4QQnNpGYJ822IhOpj8iN1QKOanOCo/ue70u3k9+DhB8zBg
         jV1AnAs+eektJtDQsiq3IYRxwnPHBKBPtHWPphJ1s1AqAELdATT0rNun4PLWHeey0Ydd
         Oe+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXEXY/qI1RLGn3Ow8V6pLRP+kLeTWnw1/iW0Eg63AZy6FGfV+ueAAnGj9h8lRo4IQoDijV7dzyP0PBcTIfAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq5ru5dA4JCC3T5BrzanZyABywaYUgUkGIqb2wYEBtxzPc25TU
	RhQmjYNhb6/lzX0XObbu9VvzhrFpzGR3CwsICGB4rtgXeFubQqTcYs11Meb7dSS48fyHd06vz50
	YSE3gOPDGGVXBB8QsYXD01yRTqQp7Bc1Qui8OuS4v9ez0qTi5b84GCwNQp9xhWpprtbLr
X-Gm-Gg: ASbGnct9o2JC1uI1hagSd2WWMt4MdgBTQHiLB/5NBHe+seAggkbhLm7KAJ2s2PwAqZa
	kxxv8KMX8lvVUmD54e6o+fDQP7yA1BA1JLyVI0SY5JFVcOfnwRFGK0uI9Xr2GPCieq5ugVkVDbO
	r6y1AM68Chf6SHHjBiwhCogBUVeMGhfU+8/8acNBGSHgIRJgTjXW4tcXInRos5bN4JIq+e9aGC9
	QEqwkyFEauiG8jqDvx0IqRNfvwDKWrxtU9ylCbOrjRQ/fzZiBk1DHIL8Fk276oRgXfq6Sm6D8MF
	VR1bPhPa0tE6dUoY4yQ5IDV5PeI=
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545136f8f.21.1752073032700;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIDgDZ3ueCPe4xupCxLJP+j8s5t9RvUgCvtE3idf3c2mnCCVDXZoHffqrFFHgTqOqncfSl2Q==
X-Received: by 2002:a05:6000:2f8a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5e44e60f9mr2545109f8f.21.1752073032312;
        Wed, 09 Jul 2025 07:57:12 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm15802090f8f.46.2025.07.09.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:57:11 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:57:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, sgarzare@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <brnvavvmkbxcvzy6ahwyissqnmjl7db2w6yfk5pmipuhuvsdu4@qwoeyioaues6>
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lzTI7KXHxqLXuto2UrcDxdh9bNDJVOmLC4BUwDpX0bM_1752073033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Konstantin,

On Wed, Jul 09, 2025 at 09:54:03AM -0500, Konstantin Shkolnyy wrote:
>I'm seeing a problem on s390 with the new "SOCK_STREAM transport 
>change null-ptr-deref" test. Here is how it appears to happen:
>
>test_stream_transport_change_client() spins for 2s and sends 70K+ 
>CONTROL_CONTINUE messages to the "control" socket.
>
>test_stream_transport_change_server() spins calling accept() because 
>it keeps receiving CONTROL_CONTINUE.
>
>When the client exits, the server has received just under 1K of those 
>70K CONTROL_CONTINUE, so it calls accept() again but the client has 
>exited, so accept() never returns and the server never exits.
>

Thanks for pointing this out!
I had an offline discussion with Stefano about this issue.
This patch[1] should address it.
Please let us know if it works on s390 too.

Cheers,
Luigi

[1]https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/

