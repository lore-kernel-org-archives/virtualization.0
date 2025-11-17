Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CE23185E
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376628; cv=none; b=h4A4bu4NtVcTpOEqN0FKOKy5H8Ka70OGsv6V8gno+ZOgha8N06mr7V0XAjFv/cMO19WQ/gkFMB727+Z7/otXM6fiK3lLBNlQPSjCO5CSr+MoZWsC2TGveanOWBjeSsQKT/K0feE7OGAkTMiVke7xZaPx5/HmAs4qLqZdq2u51c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376628; c=relaxed/simple;
	bh=mg5Q+IpRVr3OMWZZo+BKznwgFoJqhrDbBw/ilxIPjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VIZ8qBL+Jm0UPeCowKptLJ2Czsl6+0NgqTFxdl7djwU9P//rC2S3Dg3fv+qhCvyZrWRelwp6gXtEIlN0FtaQQQzR0iXYDngkss1jSjPsyYUv9bk6Z4JuhXB8cE1lPWmuPOAD8JOVSEJ5cqg3NuGEGfNrRUMccq9n8ycxZZzVqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvK+LYAz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvK+LYAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763376625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuX0aPSVd/d7iLB6bbasM0NpI015d3K/jXv3pcQh+us=;
	b=ZvK+LYAzo1/Jp0udRUHe/pQdrxLrUMIklr9fOR3J+2fSr0hFj9ni7DA3QWpyktHH2QC2fg
	b9tu9362KLayLE+7mST20pZDGpOdIGpTSN21a4+YA8TOmQlBXzzmWgFqZHc8L9VdWYLq5f
	FAcbpU15RusH+1qHGnO4Jg3FASa45QE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Yv1b7DqaNKiZeIxTiP3fpw-1; Mon, 17 Nov 2025 05:50:24 -0500
X-MC-Unique: Yv1b7DqaNKiZeIxTiP3fpw-1
X-Mimecast-MFC-AGG-ID: Yv1b7DqaNKiZeIxTiP3fpw_1763376623
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477771366cbso25787635e9.0
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 02:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763376623; x=1763981423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuX0aPSVd/d7iLB6bbasM0NpI015d3K/jXv3pcQh+us=;
        b=b1zjb1ZrgNxZeXP9M8E5AX4F2EyQviZrbxNOsUCQzCpvY3LVdi5cu40YdRsZnKBa47
         2bBltHQzO0yRkOGdm50zPMOWwDfoMXnIv+imBlEERbQ71WdExkxSMC6SVM32LrfhK0f3
         fZur90kw5EN1+06G3vPx/YV/tt9nF7w5iz/7DnwXdA1TRggV3v15KJh+BPYYhHcp3bBC
         KgqM4LPhbQZ8m8XPG/toKzEywmVM9r/R5Bx5LEUN8w4cQZQBYUONCTk6yunAmuGisjuR
         hi19uEiSn/MeQle4diG9y6Xo0drBkQ5VNoHzGr0LvlvhmGh8nKyBYEFmJiGsDi3jvLqZ
         +M8w==
X-Forwarded-Encrypted: i=1; AJvYcCXTZcIBGD6gYcv8irD3kiun+LF4X6Q79vmi6MGKINnFMyMX955iEaJ3kjqZ37ojHL4m3ZMl1/b5h/x3gizRzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjWEJEYlx52sR20kE3X/D9vPmdyNfzJBSyNddrvE2ObhRs95EG
	TZtTOrsx2uiI6MTPPZFKwg20FTwhbHi+Xm9QxX3IicFLTuRbmvYOjbdrlF0/hFKk3y700ddYmQ8
	YMBZONrQsGbYMU0VJhtmrp8nyXfovYRJgjJzmnQHPLBfUcjF5ApWvghZYEzlRKKMXMzee
X-Gm-Gg: ASbGncvdORGrVw9CGt7Mg1jkX0OK8Hs23y4obQ8hMx+YBZFEojVC94SET3D05r4Mups
	pZ+17Gu7KkaF7q0MLtfkXQUyti/Y9gNzyvda0biiaivOcxBA0GJdOJyOmjq6oYGyBG3mJTFLlne
	uAZOEh9olhBuPqnQnDkPOnKAof54QF1BoWx3/3z2rCWuIykoQCeHxHJyMWaNqk1y0ndTg07N/8o
	/pPJfbit/pFYbTVkSQscB0q4cTjmvMyuc0OTQpwLi8S/ew0AveTvJ63yKYwVL3j9bbtoSA+FO2y
	Q/wb2s0fzfAJ/clB3yxUn+VCSYUIjP45I79VOJXqIgqtkYLP80dhVs8k0/33EY27VFsqPVssVea
	/KYbxKsQeB1LJKggMhxg=
X-Received: by 2002:a05:600c:1c0f:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-4779cdbe7e1mr63411385e9.7.1763376622788;
        Mon, 17 Nov 2025 02:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUG/kfaguZEJ7FDbwjxH60OTb7c2HOk6fwWxSJhNyaPv2yIbfRnBhN8Ld7zJ4gfuJClKT3eA==
X-Received: by 2002:a05:600c:1c0f:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-4779cdbe7e1mr63410945e9.7.1763376622277;
        Mon, 17 Nov 2025 02:50:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47795272c53sm162240925e9.9.2025.11.17.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:50:21 -0800 (PST)
Date: Mon, 17 Nov 2025 05:50:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
Message-ID: <20251117054850-mutt-send-email-mst@kernel.org>
References: <20251113115558.1277981-1-eperezma@redhat.com>
 <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: scT1HYuuaZGmCG3Qm_ozK69CsOh2i8cvM8F0cz3pZ1o_1763376623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2025 at 12:25:03PM +0100, Eugenio Perez Martin wrote:
> RCU is protecting that the address space pointer of the vq group is
> not modified concurrently with the access. Ideally, this should be a
> full lock, but just making sure that all accesses from the reader are
> coherent is enough. Userspace should expect nothing if it uses the map
> and modifies the vq group ASID at the same time anyway, but the kernel
> needs to be sure that it does not see intermediate states. TBH, we
> could move to a READ_ONCE / WRITE_ONCE, would that be more clear?

generally rcu itself does not need ONCE macros.
these are for funky lockless things, and rcu can be
seen as a kind of lock, after all.

-- 
MST

