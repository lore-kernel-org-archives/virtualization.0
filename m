Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6551B4C5D
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530120; cv=none; b=kmDwEn9VB0sw+UTG3kU8onnXBwjUSK28kMwOGuIxIgx82/FA6U3L/wC8O+XCsaQUmHga8L+b+sN2zsA4OAXc8J5TFIBZyUi5KuIyYmnS7N6xFdt1DhL20zqj80fBMlLAdEcg0BtYeUhaF+9AuIklGHTGaSGErZK5O+jampf+htA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530120; c=relaxed/simple;
	bh=epQcZml1KFHD/cAYF1EPI6sbtGZHn6QCLdxUDPlEPdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkcGwLMgSnNdHM5lkd4kdhadZhPSykXyvFQQNrgP+oZWe77t7Iy17akndFpQIa0svLwwG55imZj4WXgEuzlNnn5b8ofE93WjQ71xY7tNqhPLQ2YxWTOUKL9B7jFNWydfq1mrx3tR95+b5J2mcOpx80i1h+EvWOCm6Er9pvdiRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVTlc5eq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVTlc5eq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cfdafdb914so1591995a91.2
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722530118; x=1723134918; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/T4t3jzF+nFkAWEOEP+qO2FrWc+IPdqT2e1MH6ST1k=;
        b=OVTlc5eqsDmQa4XRyaeEYuypROebgAeFH5gQ39AP48qqWGlwJfuHjvAoBBahbBsVa0
         8vs381IsACDDxYDv5vgYQtfrjSAgSOddZDQaHYe4WG+ZrRJgSpD9p9Rw9HQ7WiY9JBZn
         04TAmPQWVIIUfUvakzj+EcaJRJtHZywbKTjZd8CDFmrT7MmGVH6sjnXLbVqu9iEc+G8b
         zOcX8T6r5xoAcU9DWN0dSdknVys/wpLBa8e3C5IqdZnSXjruUrRh/Ow8RH3DdiBBDFwq
         ljw7IYGn5C148j25hm+1fGUQKfTDb6qn0DPc2o7VZFz2+6ku35GVMH2PCYl22zP7cGhm
         ko1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530118; x=1723134918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/T4t3jzF+nFkAWEOEP+qO2FrWc+IPdqT2e1MH6ST1k=;
        b=oO/bSotc55BjYAKmrD1LvOI/G6lDL3ne9/96kc+UxB05iu2yNdKkgjzeRtG9g0/Vqx
         DRK+cndWgQOr4vjZhD1CR+4eydiXT6QW6FgCX6eOFYTdQaQlVI5ZwsGytOCiPw9Rkptb
         jciggr/PNq0WVHjtOwu5Qhbp18eZ0Jq4dnWZHIxawCBZwCC+h9I7mo4egazBIlRL2jyp
         K7s97SFq/iosd9gO1IE1PAuB/XUehGuEnE2dT7u708YZDo1BkwFUIaGxDgjppjHkqcMv
         j99fdyuvIr3iU7jw8Ow5ByYRiM28zDj8egzYGIiePzJ3W5Obqu3Xpty316E99pTfT0mM
         Gmeg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Yt8odHP9gDXrPyhU5L4Y6meVbYr7JmAqIe+8tEhBOBRz7rYTd7uRM1DJYTlh1iTgm9qRLPbCww91R5mNsgKZ48KRGaa20iaguUk3la0=
X-Gm-Message-State: AOJu0YxjZgEV1OWcVUkaGeTQRfDto2FwYLrRPIebi/bi+eBwJT2U+mAo
	8/5NJ9eNrr7mMCKoBB7d/Yo/wLX0vA7KBQWFecZ4qaKaluTMI/T1
X-Google-Smtp-Source: AGHT+IFPzIKAAGtrIboS0JIgBIcn/RCGQZX+i6sR6dJvOvCnViybU/zZEgesDQpsFrg3VVwYreSuHA==
X-Received: by 2002:a17:90a:d34c:b0:2c9:80fd:a111 with SMTP id 98e67ed59e1d1-2cff941b716mr996111a91.18.1722530118409;
        Thu, 01 Aug 2024 09:35:18 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:dc43:fce:b051:e6e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc42f9d3sm3599577a91.18.2024.08.01.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:35:17 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:35:16 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: luigi.leonardi@outlook.com
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net-next v4 0/3] ioctl support for AF_VSOCK and
 virtio-based transports
Message-ID: <Zqu5RHO2x+1uLmeD@pop-os.localdomain>
References: <20240730-ioctl-v4-0-16d89286a8f0@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-ioctl-v4-0-16d89286a8f0@outlook.com>

On Tue, Jul 30, 2024 at 09:43:05PM +0200, Luigi Leonardi via B4 Relay wrote:
> This patch series introduce the support for ioctl(s) in AF_VSOCK.
> The only ioctl currently available is SIOCOUTQ, which returns
> the number of unsent or unacked packets. It is available for
> SOCK_STREAM, SOCK_SEQPACKET and SOCK_DGRAM.
> 

Why not using sock diag to dump it? Like ->idiag_wqueue for TCP.

Thanks.
