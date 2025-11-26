Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD862BE043
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141328; cv=none; b=ZkjwRU0GigKJIfImf9cm5Ci2SEWwDvM1t6cVofERp2EKu6TonThk9GbTp8UCpqaOjIumuhmOVIUf/xQWEM+ffcTTVxAhUxUKg50jJy4WsYcyTcm/PS8gKRU4n6+SDBG7iJ65I4YNfjpHsyTTLQPRDjorFnEfUohX109cSJ7Hn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141328; c=relaxed/simple;
	bh=mkf/uHCKMjQSjVKT+d3VdATYkS+teAGvnv+BKYIEsOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HY1PCidzM6o27smdG8pnDKbrPS38TOglyj+RpGORVHiVU2CDPdcXAB/0naemzLKkUOkeaLmau7VziDUpevyK/hHx4kbINtjvZVC6bauOMbEi5T+B2AkQI9uHKL6w+MvOp6plnVpftNI9HDvw2A/LtE8D8rZa9/Z5Sm6ZB9gjHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXs6BaHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXs6BaHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764141325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCcjoQrJmDMV6tt4i7nrzjlVcToLbxZK4bwTpqKMBw4=;
	b=eXs6BaHTEiWku2++Q7B7jIpni5gNVAFRUZyH6ZEa+j51D1BYGh/q36J/CSuj+3s2Lbb34b
	mov1ysT7avIzzwhgDp1NZPWCxf/kT8WsccTWm93Ql7lusE09OlqfaZIKUGWRlkTaIFvH2C
	ACJu4xBkTT1Eg6KLuXJ3kthMJRwzd7I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-fBbxJJX4OSu2MMXcliK-Mg-1; Wed, 26 Nov 2025 02:15:22 -0500
X-MC-Unique: fBbxJJX4OSu2MMXcliK-Mg-1
X-Mimecast-MFC-AGG-ID: fBbxJJX4OSu2MMXcliK-Mg_1764141321
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so3200593f8f.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 23:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764141321; x=1764746121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCcjoQrJmDMV6tt4i7nrzjlVcToLbxZK4bwTpqKMBw4=;
        b=g60/s1/7KABZEbtpSWr7Emn6vEfowP609w4MgDV3uAYoasPB8q2B1AGyCwxOVPS5Wr
         iwir1wQVx/u+jUQ73ULWi9UGzPabgPTaZT4KEj+9NTqFyX1VElUKw5nY6CdDoyJ2enmV
         QDAwr+M3fPzLSYOzxLfV/+k0PwUtbn24VwjALddo45jAD7f5uebHeI82Vpz3iBbMfm53
         prc2+DLO1dKusD99cpSgPNLSP7NslOIsEh85KfljsxFUlx3rjovtB9mcyVqSLFNUJFpi
         pzHCpdFiNgXLajgq0lohw+EPp1tZbmFMa4I+yRP06b6kociB9Ue8RVjxOcGtdcR8P6jt
         jLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz7wVtbsOKQUDufU8fr2CFaJmmRQ3FETlJFN6ciAdAtWlgp7K2ghDw1jC7t0Dc/klRffm3b158+3O8A6jFgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi58CEOym5sRnTOFjfsDBGlqS5RC3vSydsGgjtN2D545/L9Y2e
	SZA7pRwyJZUs9kHdmTJ846OikwwoUjhkF8o5x0OLv5RQlNEYy8RHCuI4983DiKtpcTqdlI6K3TX
	31WgPTx5aXuMiRLMMBFC0ArN6TZegeZ36gkilXlYMPKbrF3C/Nbz3BgbYaHY31m4jiZ1y
X-Gm-Gg: ASbGncuQK3IuDt6z4N4R52yFaifkIzfYg3vMh/yFpAsngo01oYZ7OhDykYvITedjuco
	nYvw5eNYyBmvb4ho07aPmRPvVSsKHJ+mx4I9q5Bh8JHnIgxJqYc43JlIxkG1jFLAeVhSS16tPns
	eaH+OVJ7c0hWBS2zAKgiY1dxedblj+aNtamnFvIqM7eAIuqh3yl/T5OULLdQxZ3V3XIRh/DSHs4
	asXCcvtHR5oht4T4LYOtEPgtVqBzLB2S3F2qmDZjnpRJsPpzf0D4uNDxIgZPqoWTIvm6RsodKvP
	jjBtJZzNd5QMUyI/rhnYeoSlDYNW9CxmHXwMo/0I/UcLo/4nmXg9C0pHLTZmV3im05H+JyFT8Py
	qtsHssTVIOE1tM3EkI4SxyPrAqhgv3g==
X-Received: by 2002:a05:6000:40e0:b0:42b:4081:ccec with SMTP id ffacd0b85a97d-42cc1cbd1b9mr17399182f8f.18.1764141320697;
        Tue, 25 Nov 2025 23:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxNo/Afpg3Lg6XEk3Ct+TLvZVCI8wWmYfzMD7t72pHQNYX6jVKGgWygBu70JI/2p3ZTBPPRg==
X-Received: by 2002:a05:6000:40e0:b0:42b:4081:ccec with SMTP id ffacd0b85a97d-42cc1cbd1b9mr17399153f8f.18.1764141320200;
        Tue, 25 Nov 2025 23:15:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm39412154f8f.18.2025.11.25.23.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:15:19 -0800 (PST)
Date: Wed, 26 Nov 2025 02:15:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 0/8] tun/tap & vhost-net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20251126021327-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com>
 <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DarohXlw0G8_n0L2BWL_Rwqx3Ki_53KXTJoXpIpgWdY_1764141321
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2025 at 10:22:54AM +0100, Simon Schippers wrote:
> I agree, but I really would like to reduce the buffer bloat caused by the
> default 500 TUN / 1000 TAP packet queue without losing performance.

that default is part of the userspace API and can't be changed.
just change whatever userspace is creating your device.

-- 
MST

