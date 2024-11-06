Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D81D27BA
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885494; cv=none; b=ebS6xn+jfwGCDSFRGUduUnOweDW0oeM/bwS2e+EgRGV6t+3U8rhJKbeLgs7PzRtAMdKWXegqyY7ona87tC9QhVOhxIqEnbkP/fBfsy3CAd0P/vkhOjd+MTRTTxgkHv4nza7U84IMcV0fYGSlJWLTWwoA4IekaVQBml9K4hD9Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885494; c=relaxed/simple;
	bh=JiQ4UZeYNmZjPUCdRREOzBbUPxshCp9ydNEIQdTxnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EvwOeVQZLr632Xixw973IBYTlcZlrbS31IRqZy58+JnkppqBTmxV3lnaHMtkhYY9+4o8YwTXUp5yqb54T11+nl0iu9G6ISVp1eTCAhxMxrL3CLbIiX7Sa4MBZO8+eIfUZVMYQX+O0k6g4vTDmB8SsTyn3GqUDulb2VuoHd5vz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9uzxNfa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9uzxNfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
	b=K9uzxNfaZtvwBfnhh1khO6ao/+vMtsQ3CVlWXc3h/D0RjoKyRi5Z1w6NqL5tzA+i5TNizT
	sdyz5fzkL0B7UZPWh5Hj8P5zARYTFFz9hl0JX4rhBz1Zq+C2ZpfHi/+S4Gtm+3B5VW9qk7
	G5kQlOvrHZXgWqdMVhxhMU90ogLq9hw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-90FJf8h0ObuTb3zHkvaZWQ-1; Wed, 06 Nov 2024 04:31:30 -0500
X-MC-Unique: 90FJf8h0ObuTb3zHkvaZWQ-1
X-Mimecast-MFC-AGG-ID: 90FJf8h0ObuTb3zHkvaZWQ
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e75025f9so3678904e87.3
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885489; x=1731490289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
        b=TQroKdog3Hy0e/i0T41Rcp2kpoX1XAeIs5Uv75upkIyIPqhGCxHclyK5/AnX18SGrU
         WfJfhKWnmCy6ZCw+eijkuF/eRMuGsHZKajMOOfzhtYzg/rIy+sKFsLHZ7lZzZvhJBB8G
         oDKX7bfQyGYTZRmA0uPMisgdq2pKnKC2uXObkLpC16MDJFFvUyNcQlMlnX4YKA/reIoB
         KT68zRCLBm2RZ1TFRbe4QD4F4iidqQfrmz2RvEQ7MJfRWhKbQeT9XZexwu91DTkR1NXh
         WH3J+avdtUkLMVAwLh51nRyncLiqan0VtVWbai0D7wletsrPAb6jaW2tky1Kx8L17IqL
         dO/w==
X-Forwarded-Encrypted: i=1; AJvYcCXESBWw0GLfmismu9oO+/D4hgc9iqmnErqkAqpaa+9WUQtJ8B6JpeR9U6VBN/d1hp5PO0Z5PWzTlvUGZm9Z3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpP3YI3SNaWXaQCEitMMffOxpRWd2uVAHn3dHiCTTMAbt/qC2c
	YCP7F/6EUqbyiq8USKPzftAKVVfKVguIpQEURSJmKPctrWZxlWLwTNl2IBJzzHPRjdRlC3aZGbg
	68NTmCgCv80pfGs7MgZslQJC3sM0pohDtnL85stdNkBCXEKk9pwYA33Q1FFsFDF0z
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637557e87.49.1730885488745;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHSH1SBaQr5jBIsa52gGokkq9bGzxMCBLmYIc/MQMKZVJdyqq8Vzi2SdL9vrY12cUu256ODw==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637538e87.49.1730885488282;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10eaafdsm18588441f8f.63.2024.11.06.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:31:27 -0800 (PST)
Date: Wed, 6 Nov 2024 04:31:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with
 queue number
Message-ID: <20241106043106-mutt-send-email-mst@kernel.org>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JPff6Tns_QJaS3lDngRR8mRBSbCXlnFcbourRPbKgEM_1730885489
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2024 at 04:57:02PM +0800, Philo Lu wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
> 
> Patch 1 and 2 fix possible out of bound errors for indir_table and key.
> Patch 3 and 4 add RSS update in probe() and set_queues().
> 
> Please review, thanks.

Looks reasonable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Philo Lu (4):
>   virtio_net: Support dynamic rss indirection table size
>   virtio_net: Add hash_key_length check
>   virtio_net: Sync rss config to device when virtnet_probe
>   virtio_net: Update rss when set queue
> 
>  drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 100 insertions(+), 19 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

