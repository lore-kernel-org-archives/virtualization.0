Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4162512F5
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375252; cv=none; b=W2G8HThLdBPPCU3A///TlsrjpJ6vTl1n4mCpJcXJI9M+CX+yvmXU7Q3+lE+djf/0jO5DR5aqhEJ+bz/Bq+nA9ajgPvy0C/PuropMxUyGlIN//SVg/CTAKjW4mVJA2KzqwCQ+HYxo+4Lzh0IojmkvEHfKeO4kLPCooH9iQNxjXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375252; c=relaxed/simple;
	bh=hEJVrnzm4GUSEpbeNp1hb6r5W3k5q0MPjzpWEDaGbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZoZqSg2xCrXUs/CkTkqJmPvIk5zcrG/ojMM+C2aQb3wAYg9wIxJ1bO5QoC7X7Z/Br3Zfor0aOwqLI2tTsGAQ9ZDJWMo05/9vCZoN4E/NEZuciS+cWM4h1sc8p4qj6Gthze5QUmgLyml1k2g6PvYSDMa94zBTsvXuiSBd1nSvzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/AD7JIj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/AD7JIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742375249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
	b=D/AD7JIjeZQeLpjZ2dO/3irlT0tFqTueLVBHLg2dg4XU1aibSTrYotKxDW2knvqSCXrzbD
	9RmVvsmIt6vr/UQs2P6UDp4ucYwUkHCCqcCusVnFivS8x9ui0PZp3UR4A7oaGYPz/on9cG
	qnXgFGAbEesUAB3MMHirSDyK44TB6hg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-wOwVn-wFPHS3fWsP7blnPg-1; Wed, 19 Mar 2025 05:07:26 -0400
X-MC-Unique: wOwVn-wFPHS3fWsP7blnPg-1
X-Mimecast-MFC-AGG-ID: wOwVn-wFPHS3fWsP7blnPg_1742375245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39142ce2151so3035296f8f.1
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 02:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375245; x=1742980045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
        b=Sx4t9Z4gt5+vCFrjZRixa8VgM6ubygVIzp2a39Gs5C8GRcuyw0Rfpt67L3tdXKMX8q
         /VWyIxPqGwl5Tje+ofaba4SVH+eeYFFyoxjDdOR3jiuX1ktxNUYS/hNPKIJVe525xCiC
         cfb92d67xSTYQb2zl+mpeb/XceE3uyolT3DzDECRwLEvGDqHMvawGdZu94gakTqyH12D
         LmDnf+UTvM63e1uUwinGqNgk36XlVSAU3atvjV/+TB5QmPX+PXOPlHZw7+6U2MJZ5gF1
         HPzy0FbGtE5id1NF2r2oiDHieWgP9j/1ShpQ6+cZD/bU1AmjBqN/94t4pucQ49dyK2NL
         M8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUFpRsevxCBaG3qXKfdrk7gHMUIrjYm9YJWPOzga//wnP486IBYtVkDHD2sTEmpJDgd0OaNTEDZxErvWGV4Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Gwlf52lIGYYtMcUyDw/0uXUCRMdKwjnhdZdH8mXl4n5JdI4A
	TImrhdBJSFrI5AIfP93KgFsPCrkR59cJCrSdq6QAyU50QWAbAyRCS3lJ0UuYQDJA38aen8MLq7S
	jE/KZWtwPXucXoA/wgU3zbAC/wZgNnXXjvO1or3n7XxS+iF2u61Le/119jGS0ho0a
X-Gm-Gg: ASbGnct03X/BqMmrv8rnTsXmbPw5IVBoFJLToL5Xfulz9BLlxkbF6G2yAVAAz4nAty0
	ld9+skKcw1hJuweBhnkg02CBAV19EFgr43YliQ7T9jT6rzIjVNN7PQaYBXkexRtMpBez1WQ0V5G
	vfErJxEKbfB45SiE5BdVLsqWirOpTBUvEBEhcQIibQyCoLaySt5+3MKTPJBJ3qlCiSXBO7TvRmp
	16Hm5iN7aFD12biQHOFzwhaR211RATLV/Te9JrCdy/XWOW8ZUlNAMwAci0kBWOx4F0Grxnc2CdL
	N4KcVDpY8w==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1203013f8f.36.1742375244962;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD2b47NZYxg5uLG0ig+ZUAWSFTONEyHXxR8MWacA+06Zt020C+c8ArZXSlhSHTCWh815vtbw==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1202967f8f.36.1742375244436;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a12sm20348037f8f.75.2025.03.19.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:07:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Message-ID: <20250319050708-mutt-send-email-mst@kernel.org>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zUtfeykBPdkwZ2LppHE1RKaoVBPRVAxDODz2j8pAOC4_1742375245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 06:56:50PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>

