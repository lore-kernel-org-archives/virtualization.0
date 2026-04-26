Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C7364EA4
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777215437; cv=none; b=ZDS0NxAJjwcmbQWsRPHeAWgDZwpz8J5v4o1hQltmLygGUE0L65WpyEQX37M5x5jZL1OMvyinjyIMCl2XugtZvoFOYNubFx+g2ALhPmETgp3EFvEp6W0PDL9Pdf2706Y+hWGocREvbDTHLQsw4OBcpiKkRIa2JlEjMUGdOQj3r3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777215437; c=relaxed/simple;
	bh=Da3h31ILjSd+OhqcR2qMl0bv6yvTzdY/Jv1N0Vv+h8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L/DKUl+JFeMH3uJvXkIiNqXyHVg6cFNxlrPDLCv2olSe675CGqtD4ws4TIJyI1iI4ZcdJaSEpeHQRFwYtBygP3DuF3mrPg6V1vlzUyDlAvdAdVD7nZk9RwYSIxGQnJGVlf+Asjm9dj41l8Nm99vPlCca1ymM/pz8VvEnSRRTVlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJtq2BWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJtq2BWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777215435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7ZzOjyRGpyBR3LqN+JXORsZ0/yDKulQae5A8iv2MDw=;
	b=aJtq2BWN32Nl+kF5FRSRZjqVnKiSORQDnjz5qXg0OD03Q1Dv79PGO+cMucDiflU5SBoHt3
	n7c5C5WIFaoVC71+GEB9HpWEPf/21RNh97ZuLE42WfpPbukRuka9CgImtZnz5U+2kUgyAd
	FTW7aPsapRb+4SgJRavZFsZgQXdwZgY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-rXWbEVWANUeKiPHKy49_6A-1; Sun, 26 Apr 2026 10:57:14 -0400
X-MC-Unique: rXWbEVWANUeKiPHKy49_6A-1
X-Mimecast-MFC-AGG-ID: rXWbEVWANUeKiPHKy49_6A_1777215433
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so5747657f8f.2
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777215433; x=1777820233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7ZzOjyRGpyBR3LqN+JXORsZ0/yDKulQae5A8iv2MDw=;
        b=NlebOoN1OkCXxaGYQZAN25N8MQbQXfm3kJNlYj7XwprplaiF3LyNYGTkSNKmsDjx8G
         b06LqL0w+sULyfBGzeRxgxK54jlhTpJCK9QCow48/9HBdyM1zN0oPu3XvxS/P9hx9mJr
         UoF+4PWcTgx5Q7MldR5lVphZDrRhUGHE/VAaFmmXEsT70+OyVmqFiGSydl+qRObecDzu
         RQ3ArGVy3m1dRQamiERivVSWDqC1p2IUzlth/ArNHZoHv8/G1SLKBwSba4tfifVhiUFR
         jWM7As7J8S2vloNoIqib/0wPhWRllq0LoW2PmathNkaOQBL2u3m7n3EFZzYRmLvq7FgT
         wViw==
X-Forwarded-Encrypted: i=1; AFNElJ8CpcwW3NHwW7dI3DR5d91YK7JEdn3U06pKgLHPxH+MNeR3aoUhpP0kgnR9dn4azeNk2Ps+7WfeteiOElfyAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC/R2wBV+slacBtz+Kdmdf293q3qeaMM8sfdZb+oELiFdSXlp4
	FC5/EFr7jefBcXAHHlobQp5iWEREsQQfmKnaV5mYd+jKDC0rY0sddwYbzSzJ6GB/Yeh4BQr+dG6
	9TZa4TkTs3fYXNrGqCgVcS3aAMoOeOdA66+gPgwfqs31f/ZNwoTNadzr5TQcpe5BuLqEW
X-Gm-Gg: AeBDietz/X2j/G33blqUYX1zZjI0zINIMgdpNBZUMMJdb59DuhFbz2vg2cYpMyUAx1J
	ch2ycsLwOvoArekOcBCccAwOA5ia1rV9LT30n3CSv3mCzfaciAzN2CTDMl2WMg8jJ0nQk3elqaz
	nQwEIDO9otigaMfsXtp5ciPF0bSUCPSg+Y24ex7h+2RmO5QpyCWpuaZePC4rBbcGpSB2wuJFYao
	uHMCmy1xlkaG3ZUAQSJMZ3Yp30uMXhZKhmLcWUqGxuM0zw3pjot2El4ufamhqkZUZ/Fmyb0Fghv
	lrx5yNm3uloptg0gO5PZVEtbn95FlSIDBrCj/RqIw7iajrIUqje7TfC96nh51pDODGc1M7u/pnV
	01tmW6cBSiJkbINzkGMG3hjs+kl+9mUaOBq68fytAb2RXjbYlHlomi8xx
X-Received: by 2002:a5d:5d88:0:b0:43d:7d6f:f535 with SMTP id ffacd0b85a97d-43fe3e10c0dmr59157468f8f.35.1777215432985;
        Sun, 26 Apr 2026 07:57:12 -0700 (PDT)
X-Received: by 2002:a5d:5d88:0:b0:43d:7d6f:f535 with SMTP id ffacd0b85a97d-43fe3e10c0dmr59157430f8f.35.1777215432534;
        Sun, 26 Apr 2026 07:57:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm43871698f8f.1.2026.04.26.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:57:11 -0700 (PDT)
Date: Sun, 26 Apr 2026 10:57:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ammar Faizi <ammarfaizi2@openresty.com>
Cc: Link Lin <linkl@google.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	jiaqiyan@google.com, rientjes@google.com, weixugc@google.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated
 virtio_pci_vq_info
Message-ID: <20260426105644-mutt-send-email-mst@kernel.org>
References: <20260407212521.934620-1-linkl@google.com>
 <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
 <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
 <20260421175107-mutt-send-email-mst@kernel.org>
 <CALUx4KRuJcW+ea7wrupQAd_cFJvzRxcrYq93DTYMDyB2vkf96Q@mail.gmail.com>
 <20260421181640-mutt-send-email-mst@kernel.org>
 <CA+KFgX68PJqhHg1-DHwxEZVj_Dn7m4jqUHUnuvWyQajDrkZV2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+KFgX68PJqhHg1-DHwxEZVj_Dn7m4jqUHUnuvWyQajDrkZV2g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b5VSOKBj27YKju19hY0vg1X6s2wBIJXCkxN9BgYsLhk_1777215433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Apr 26, 2026 at 09:28:15PM +0700, Ammar Faizi wrote:
> On Wed, Apr 22, 2026 at 5:16 AM Michael S. Tsirkin wrote:
> > On Tue, Apr 21, 2026 at 03:15:55PM -0700, Link Lin wrote:
> > > Quick follow-up question: Do you know if this will make it into v7.1?
> >
> > I'll try.
> 
> It seems it's already too late for the 7.1 merge window. Maybe 7.2?
> 
> -- 
> Ammar Faizi

It's a bugfix, no? never late.

