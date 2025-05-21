Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0261EB5D8
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846201; cv=none; b=EwtoUgcB5bisQbMGTCKziMqolpwlYSMPbs41PYb+l8V7X7UI+ohlStHCHHVknoooMQZXqW4WWqeh3uvq00W624CZUJghY6U0vdUewUQymibyWVIeql9glxkYCquOZz30LyAO5UOxAaNCc5Icg8wZ326SEpnlsjNqvX74RfK5+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846201; c=relaxed/simple;
	bh=1dJoHE8GeNtckzx9RFaomoN/xQ5MjUgsn5hhVqqprxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ay7AksQc4vs9h9N7zudRA0XHyjBIZ6ILqOhvPN9ZOvupT/Z+amSzuUBsOHZKTU5Nmlmhw34zrElP5aVMi2kLHbpw5ryARpqM0mNypcOfRbzKC0chw7RL4adQo0Lk7PzLTpYTSePrF2PxZl+EkOqpXDxernhofx4WO2Sp/6ggLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjakcZ/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjakcZ/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747846198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
	b=MjakcZ/a6RwcYrcawlzN+tGolKkBNLnRNB4RWphj+E5pchh/Lmp0qkIulorjqcSxmgzdQN
	ekBWFRNdaqm8Ab10kczGsg1H7SmAEWaOWuMoP00OGWn5sewyoWAvDmabS87nChda17Ww6x
	+YbjrKcAUPThOSMNR0QLsx0Jukt55h0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-YFx_uAwDNkujOXmUp5d_Bg-1; Wed, 21 May 2025 12:49:57 -0400
X-MC-Unique: YFx_uAwDNkujOXmUp5d_Bg-1
X-Mimecast-MFC-AGG-ID: YFx_uAwDNkujOXmUp5d_Bg_1747846196
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442dc702850so17873505e9.1
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846195; x=1748450995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
        b=KUj+kwYBIvfn5d6HFpTQc9u+m4uQNYIdiR4XwFTqhYWB3ZMiDzCwSNfX9qjgwm8KNq
         iSRbuJYHR2XCqNUcmRwZZU6xdkJvuZSvR8XEaYL3mJO4i0qQJUjlz6QJegsZ0ZHxuTDU
         p1lMfDluchpQ0qGzQaZVNIe2smXQuk+BDVPzFWgSRuyRU5Qwt2jsscsROhqrHKgzw2K4
         ZepGKF4ZW8aV2JIs1eqWTuqIQkwgWdCw6nRpAm28fC9kZfrjXy+T6G19NLgmaliKubGZ
         hlZvMwvkwuwVVxw3Owa2/OUcvGYzxw1ECBsaiOhFZtkcjkQTSPF7UAkTyKkRJpxcUScl
         W9yw==
X-Forwarded-Encrypted: i=1; AJvYcCW/spz28gOS/YY6Cp/eeZQqA+v3obfJHgF29c7D7u9M0A7XJXAl9KvWbfG0BwaJ65dvGYHwhOGW0pL9qJzfJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNqI93mhVxBW/RNAptg+4kxzNFGMjjBN/vdMgt1m78KjBO5Yx5
	MkXCBwhaBNhmsjy0QTSHqc9obRa9Vtj1YjZShNYgubhwPonTS9GQOluSriVobfvN6jgRTiCdJvP
	1Tu7IoIxqWHtYnYRHgs0MK3HmlaG0MT/GdvrH9RK+u/sVi3omWfFzzqvXuSDWAKAbnM9tFqHmax
	3CzoI=
X-Gm-Gg: ASbGncsR89/KWCKWfvQfj5/CJ6c7qPDdKABQIkPfrUB8U9Iyz0UmB0U//2YxtyOLLZe
	tnrxumkc7XkouJeHlHBX3fh/RSGKAMmEQ1OgLB/QV26gv8ONSRXw5JOeZ68SQ4b+aGN3v4drIt5
	pex2qOda4ryoSY6L5ejLGj0vD5KuuiPFUSqwVrgUdQ2MX2HIQ6JuqB2vHL53kyNf4Hr63Jr67D3
	qpDSfet/02wehipN3VjwX6KeQC15JC5DS6m9Jjx2Artr0bWfUeyOTvYMKJ5X1a5MvconzbY8TfZ
	sAS5YA==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334615e9.10.1747846195659;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOuXLutdPh0G1kKuu4RDEal4trFfwrT0Z7nnw08VTOi+Znj4RUK/v5fHXWo8/k4A36IsxuQQ==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334255e9.10.1747846195270;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm74037525e9.35.2025.05.21.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:49:54 -0700 (PDT)
Date: Wed, 21 May 2025 12:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521124926-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521063626-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: US9R8WFEo5aCgXAuTZyu5je_c3pf0uXZEAjgCU1mFsY_1747846196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2025 at 12:40:10PM +0000, Parav Pandit wrote:
> > You can include this in the series if you like. Tweak to taste:
> > 
> Thanks for the patch. This virtio core comment update can be done at later point without fixes tag.
> Will park for the later.

no problem with that, either.

