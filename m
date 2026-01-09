Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591D2E8DEB
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941445; cv=none; b=fog6tksGuIeboM5U+SdHk2m5FBQBhLgcBCCFpYGO26aANcAJZQzyzG0cDYQyZhfami4Oj0PlrchxMLY9ZEGtYvdTPheYBWTkTtqCbPpnbfCge6Vne5SB7fJe9bDWArvk2EkMt0jIPoJEBP+X8xN1kpjY7UUvHIaB6VTKdUynFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941445; c=relaxed/simple;
	bh=iEtJOvOiVU5aWrZjX18IWSGkBx5iBhYUuqRnUN225Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GPmYXDgADs+PMw3+1GQNFsHo1TPX1BzKPxzg3ApowUpICURJSN5LszujZ+RuhvQE+kfBaVOmi1ATJyih111zxXSySpnUeaPEDf3OGgKvpeQp62HLyWd9XAKYjSfPqkCwjKkxE8px8kHNUa5iS1Tjr8KjD0nujCS8cncUIRSWgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEqd4MEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEqd4MEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767941442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+ceZQaBHtSWEXMLCYeIz4W2mWMzIw2cMZlyfXRW3eI=;
	b=KEqd4MEb1p3OpRUvlzeK8GSliegMbo+DVo5RQxG4mcvRZdT4c/m9DjytX0LHiY2pBYxidR
	c4oKvukteXLKnRQYcT3PNpE1a8Ekof3wb8nDD3I4zMmKbAHH7lCeTXihl/0n3m7z8QHZgd
	lNS8s7YCwx39VmQL//D0bPEeBqc29pw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-sMC8NFX6MbKvwRgl1M4VmA-1; Fri, 09 Jan 2026 01:50:39 -0500
X-MC-Unique: sMC8NFX6MbKvwRgl1M4VmA-1
X-Mimecast-MFC-AGG-ID: sMC8NFX6MbKvwRgl1M4VmA_1767941438
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4776079ada3so37602355e9.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 22:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767941438; x=1768546238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+ceZQaBHtSWEXMLCYeIz4W2mWMzIw2cMZlyfXRW3eI=;
        b=nl8ozrxT9RCgCy2uenFoAhLOlWlUmpD+uR8MoHzTWDSqwcByfDTx1cMR1+5ydbBJ//
         EBU8JTIEuvtxUJCnTr/y+desRD1tmqp6zQ/PDOXDhd6FiYBKP1kAymgxExsRLKQE8zKL
         vN/Psz70hXnbNyDzrFfkohgIKmdkke6l1PkcbxkROP8Kg/LLqHlV31izAAS0fEwcZhCL
         Mtyj4OYPIkON3Si6Ya4dQDhsFc/x4C/qMJBatl++Vge6r56LPGsDB6swyt1N7n3FsAAn
         qb9kLWiLuRT2rCiWOuwyAvTE3ixN5/J8Ax90AQGQkjP4LJtP8Btdh5pxKdGk8772Tb5j
         bnGg==
X-Forwarded-Encrypted: i=1; AJvYcCXOkA4WT6d2HwUdEqZNyeqylp1ffjdKj/0OLbMIi0je+HIAtVvI6A5udRhRsaNwYg0kkf0ENgXJaQ1zYmFEkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEw5Hh/ZxUtPcwoo7UT9/uKp4breFngCeBPfLqVxufKkcqHyAK
	bOeCvdP7mzj9Aj/4KR7kBJidcMJlL4fMel76+KoeCoXiGN8R/Y1QGNnSKtjpm0HkVJsVyeIzJu4
	6BG8Vo6WUVNM67DzCcEzRrgn4I1L2VA3iqHP+kZkL6jEld3fzn0NBKW//jWe1Osnh7tVj
X-Gm-Gg: AY/fxX5S08v49reIhePvgkL8vGwNfBnz5UEQajz1ShqdSjSt7tZxCxGe8p1EIq81YXi
	2qCU+QINVDK4f0tYPDR+p7HjhELjRl3iF8+keebs1VvTkajsFKYv7AYtRVLfZS+NHraC0nzmYTy
	HxblD1mO0jbiXDUznAXfRj5BTqxrPPmIpGFWrbjIiULHBHktwFo0SqnsQaw+Zt90FolRDaZLMkz
	fZeN1jFa/gq9xa1Fh4j4TNE89w1dDbK5d/NjltPZeuJc38RJOE1LKetP5MAekesFwjBRqLrlG9Z
	ubRi/DF/QKmnFwK/B8oCcM7mySoccuvt1yqFs041RFl3xop6aKxLDj/5tJEUYx7Z0FuDjRz3YiI
	sm6/T0CNT/GcEvd+TQ25q5yvFV4ZxiF+5ew==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr83032915e9.34.1767941437753;
        Thu, 08 Jan 2026 22:50:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPoTWz83P/iNwID/4Bvz08OjAhrzEJr6LK5HIHVnGFH5eW5Gjhe1uiWsZet3dbhgEY25lNqw==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr83032605e9.34.1767941437006;
        Thu, 08 Jan 2026 22:50:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm59137085e9.1.2026.01.08.22.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 22:50:36 -0800 (PST)
Date: Fri, 9 Jan 2026 01:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Vishwanath Seshagiri <vishs@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
Message-ID: <20260109014836-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
 <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
 <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OGMVgX26mJnuxv9PPIHsdUKapvQbAWMe5deSsft0lJ0_1767941438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 11:16:39AM +0800, Jason Wang wrote:
> > My concern was that virtio has its own DMA abstraction
> > vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
> > standard dma_map_page() would be compatible with all virtio backends.
> 
> You are right, DMA is unware about virtio mappings, so we can't use that.

Or maybe we could add an API saying whether virtio mappings are DMA ones
and then enable that conditionally? Because on some platforms, mapping
in the pool can save *a lot* of cycles.

-- 
MST

