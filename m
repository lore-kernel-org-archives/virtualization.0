Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44651127E2D
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416633; cv=none; b=NvwIS2uoiwke3u/NByf5GABI7xqiUutCyD0tE4S5H9n8rclUqo6Idk2YVGIPVOHNhdYjkrLrvn0XdK/ZcIeROemIQK+7Pluo5nz4ycXYwaKfDUbN8wFWiqm1rl/IjI9QFvM4dwm8ok7icbbiElATE00X1JRM71p2Qed44TTJjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416633; c=relaxed/simple;
	bh=4BM15V5T8ZCJlfeNEJbWlVWcJsEzsXEXtP5ugGZF6aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R3QkNnVx8RgzIhSerR7sNkeAE/v5L6xT6olSg1DZi/qicKjjuYceCR5csuBJ77kwdkpMe08ZAnNtZIlM8s9hzBoPn6bjnFPNjhvu4L0PvoOkhLHkkieywxpe8eZIUB8NzasSxWkwzb64k82XF5GkNLSwWmcBG51PwoMQFdCaK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRKRu19V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRKRu19V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/isLP1aYjVL55Cg0kF6I/0JVsi7H8eKx3IvIq+SH1r4=;
	b=cRKRu19VbqSMm5ae7cxlxcFu4h3uJdv5eZrmPeuOzvWKDItmvwUwKQPEgI6yMeDgNYOwOB
	4wa81Hek45lbV4SHIp6f4QSxYe5kUqhOBDQRpKiTOWJMu0WdFyX3++yNV2wTDJWQxHRTC8
	6uVkTi+VisbPGAE/n4RnVjjfJYr7w7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Ya1jLSo8NAqViXzZRrhT7w-1; Mon, 29 Apr 2024 14:50:30 -0400
X-MC-Unique: Ya1jLSo8NAqViXzZRrhT7w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d1089a3feso710318f8f.2
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 11:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416628; x=1715021428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/isLP1aYjVL55Cg0kF6I/0JVsi7H8eKx3IvIq+SH1r4=;
        b=caHE4avIabn9URCtTaavL/j8g+DokXZkhIJ03IvkyQ4CpkS/iKE7GkZiuuteIcsZdS
         QRgRGYhnPSIxOEKPf0COl7OqCwVKpc5sfqLhUL8n93C/aoxsy/jP6P4FC7g4zD7Qk8Wi
         Avg51zF0+b+AIagHzzAOb+UDriG7whA4lgD98D4JBWxBXmp/4kkNFo/ReK1yAw+MzjvQ
         WQW10KuKTBCoNcsVbBSyGfS1Ee3nz4BQ6Cd3YNIjhTeQVhmigSlFM4IE6hNaQoxovKep
         inAR0BAAuz6W5BFX3+AKBBj4qPPst9lbjD1QlTj+PNqESNqHpfG13d2KgEzxpX9NkcWo
         uXEg==
X-Gm-Message-State: AOJu0Yw9aFszOmuDNudpHw7zMDV7aHD9Qv34jz8U0AwWoat17d4AVZmC
	UvBkUcCtqk+OfpluQ5uO3LW2Y3/gSWrvi/jtnsGdBhkA8cfEWhODPC6HuZxcpPyj2We6nMjy5x0
	G2VhdjDJPmacQBktPPOz0QWkgvLxaVnRMeRSWXb1UOkGj/jXMofyL+LtJbA5+acHp4wMVnLf8
X-Received: by 2002:a5d:47c1:0:b0:34d:1d09:f06d with SMTP id o1-20020a5d47c1000000b0034d1d09f06dmr3471559wrc.13.1714416628184;
        Mon, 29 Apr 2024 11:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCS6P+mXwyMYwBiy2uI9J8aurHOzbMg8kg0FzOrjkGy8BER+E7fyt9B9XmUL3CPWbTmJMWgw==
X-Received: by 2002:a5d:47c1:0:b0:34d:1d09:f06d with SMTP id o1-20020a5d47c1000000b0034d1d09f06dmr3471538wrc.13.1714416627641;
        Mon, 29 Apr 2024 11:50:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id s11-20020adf978b000000b0034d0a64ed0bsm3592659wrb.77.2024.04.29.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:50:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:50:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 0/4] vhost: Cleanup
Message-ID: <20240429144955-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240429101400.617007-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 08:13:56PM +1000, Gavin Shan wrote:
> This is suggested by Michael S. Tsirkin according to [1] and the goal
> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
> the caller of the function needn't to worry about memory barriers. Since
> we're here, other cleanups are also applied.
> 
> [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/


Patch 1 makes some sense, gave some comments. Rest I think we should
just drop.

> PATCH[1] improves vhost_get_avail_idx() so that smp_rmb() is applied if
>          needed. Besides, the sanity checks on the retrieved available
>          queue index are also squeezed to vhost_get_avail_idx()
> PATCH[2] drops the local variable @last_avail_idx since it's equivalent
>          to vq->last_avail_idx
> PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
>          for vhost_get_avail_idx(), so that the relevant sanity checks
>          on the head are squeezed to vhost_get_avail_head()
> PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
>          as the terminator for each line
> 
> Gavin Shan (3):
>   vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
>   vhost: Improve vhost_get_avail_head()
>   vhost: Reformat vhost_{get, put}_user()
> 
> Michael S. Tsirkin (1):
>   vhost: Improve vhost_get_avail_idx() with smp_rmb()
> 
>  drivers/vhost/vhost.c | 215 +++++++++++++++++++-----------------------
>  1 file changed, 97 insertions(+), 118 deletions(-)
> 
> Changelog
> =========
> v2:
>   * Improve vhost_get_avail_idx() as Michael suggested in [1]
>     as above                                                     (Michael)
>   * Correct @head's type from 'unsigned int' to 'int'            (ltp@intel.com)
> 
> -- 
> 2.44.0

