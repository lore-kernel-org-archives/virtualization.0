Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C2215773
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731703; cv=none; b=gO/jkO3neNNHyblZzsLYa0NzHtZpRVBT789UVVpQtedZbOXmuEhsKxUWPMap/7VCdJ0ly1gxhTAda+pq6dkq36j24tw+VVnZlo7cPhwjwrNWGF2kdZt+jkz+u7SgCe/WQAmVLa3rrdNvWzaoracExg+578W6P2LArUD0LVf50SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731703; c=relaxed/simple;
	bh=m4gQAyHYuuJrm9YUv7NlPCUouAw8kLG5UfeMrAnYE6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e/RdXHQ5e76SafEEty1CQi9ny1eqscYBW+X0RTHCF9IkvPKHIz3t3jLoohSjk7N93YeVf1XnMa8EkEGyY7lXR3N98ExpHQgNaBlHTeboWf5ZO07sQ6Uxl4mMXOgyo52tlKKMeuVEahL3rfH4rd+FyRF17sFh0CFSjBP2cFv0itk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d02XGtx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d02XGtx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752731700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kE0G9wXRbk7fNnfl6vFgdzVxCOzno+UfAnUTQ9t+cLI=;
	b=d02XGtx0H5tdFQ23iThenHE4Va6vi5gIqllKQqHXKtfxzJkxvH7NN9Mnx0I3cWpz38jB39
	AYqu28rlxQqZOErZQL3xPUj/8ANbI6ZYhMfYg00YBKDxG+/FoWpMI2EZ67suM+v4kRH5UI
	88zn3dTMQClfRdE75B57VOk0xkxVWOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Q0CyuQpUMBi4by2u3gHXfA-1; Thu, 17 Jul 2025 01:54:59 -0400
X-MC-Unique: Q0CyuQpUMBi4by2u3gHXfA-1
X-Mimecast-MFC-AGG-ID: Q0CyuQpUMBi4by2u3gHXfA_1752731698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45624f0be48so2414155e9.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 22:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752731697; x=1753336497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE0G9wXRbk7fNnfl6vFgdzVxCOzno+UfAnUTQ9t+cLI=;
        b=o6OKyZ3Fy3lUXlNZWEIeag32ep2JGs/+P2SQhNudU4oLheu8RMhrCy0GZkjoz+FOe3
         s1zm0qDtu2kwjiZJe5D32EwiveiUCk8YpdOCiGk8q8h7nrHH+XN1LUaT8a3JPeADAMok
         Ejfzia5D0qqIQCdoc0e9oBtEEc4DfTCjbWP+BPmNyxPMFT06bvZan6JaBh+RdHj4UcKE
         HLB9XCLTuheCL+I5IOH+syw2Iz1DJr31oTdRYv8EKnlBi4epGlzvGeAxCFmv7mk9fEQl
         /oMuoBitFQ4hscku35afzX9FwZfZzqqKujtUKneSlIfkgkSa3jZZDERSarZB1WLkzAi2
         wj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu6s6F7WJ0aida1nq+JIi9She6C5Rx24DRGR6z5o1v55GWUUgFoKN+Z4rHSHHD6322/fzK5LJt2THW2SIgVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXtqj388XQdTaN50+8eVj6UezukxqFZlROt3knRXjeVtyl4dM8
	LZEm0X2lXyxmaC+EoTue7EN/QiBwu+ibe6cDCNa8QGsY/Gr1yo5uMDiWPajKNPGLCiBnbqqqo8O
	mU+AMU2ZBTDDLsUsGbm92te1PEUTBWAPk6pFADOWCH6GomdefQQgjZ0axO32WRBBtBCDJ0VLC2e
	xF
X-Gm-Gg: ASbGncvwc8yPvH/bDAJ/1aFQU99KQiw2JdCfpiDOH8uTup5UsWlOliIiK0HZXV9aPri
	v+R14uDdrQ6Xtg2zHEgAMStqhnLAGMs7Qycsa1oLXOVjwHqYAnxKfWm89SOiiZArrmDNY8yhnQU
	h4k369/6H/3P//dt71S9TYP7l91/EuyJeIRBk8zXtfQuCm3qO852k2WyBvpbiqMgyHkI0nYILr8
	vDHMiZLAkd/594AyPpEZFj65XJSj9ON/eClfVWcU/KoG/NOZmjiu4yDAzM5gbZTZRo8SmIodbFZ
	lqQ1XATrpUIFMQp5fyRN1+KEAK3wNBxT
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr31847265e9.33.1752731697635;
        Wed, 16 Jul 2025 22:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyU6o9Q3CoUlYWFKgakh+xAw1rIC3vPhNwaIEN4/uUvZfr53w1uYu1w84EorH+yJxtkxDubw==
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr31847155e9.33.1752731697218;
        Wed, 16 Jul 2025 22:54:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634ec9162sm11757495e9.0.2025.07.16.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 22:54:56 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:54:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250717015341-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtPQFNa7AJDKrP69xOzCa5H1q30Kdq1SxtkQh0Hek0g_1752731698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > > feature is designed to improve the performance of the virtio ring by
> > > optimizing descriptor processing.
> > >
> > > Benchmarks show a notable improvement. Please see patch 3 for details.
> >
> > You tagged these as net-next but just to be clear -- these don't apply
> > for us in the current form.
> >
> 
> Will rebase and send a new version.
> 
> Thanks

Indeed these look as if they are for my tree (so I put them in
linux-next, without noticing the tag).

But I also guess guest bits should be merged in the same cycle
as host bits, less confusion.

-- 
MST

