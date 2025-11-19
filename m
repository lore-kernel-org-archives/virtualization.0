Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636933291A
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538828; cv=none; b=Rf2CMnY40KNjmY1h/uXIztCESnnA8xSKogvc5JPpkPDZbgJGQj4NHg7JjpuJdcxQUMMvWExw30xg7utxf1s8rMgbr20W+5wj1KgzNRxLHjobrwYwO3yNufIeXAzObP1/HTC1uMiwfya8kkAFd2AmRefU6PTsb+WckCqb9MsRQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538828; c=relaxed/simple;
	bh=FjYWz+kqKXceeDdZL6A5QBOjG9PhOHQiTLvMhRcd9fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lfwA1XVbOmtjeqezNRC0ph8lEVeNyzQLerobWnxs0oFEBi1dlkEm+7WWheiXX/1Nk9opC0za6PsojeXJ4DWAEsDw/4fwZnOe5UqHUhzX1LgGN7qpnpPnMm/1wDPOGE4YmbkubTqc/EDF8VW5X1tF9SgE3u6YqVrq9hUM2e6VqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlVQdJOj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlVQdJOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vucbh5rS/iiazlez28RYwrKcwogXle3E0ZGtqJKXZmQ=;
	b=HlVQdJOjbKkW6N+sxZW7PRGRmRYFBHLzTBp/hBWZVBdnzDb22Wk0C1KurwxPX0pApF5Ufu
	BAstZKoTfMkLishHWvwzltkL8KpqeKB75tzVmv09qgY1MWIC3ngxr8oi5736D/HWdgMzSi
	BQarkuvUbPlOiGIO3zVlxeJY5STPLnQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gpCl8pcJNbaWxnxNmy17NQ-1; Wed, 19 Nov 2025 02:53:41 -0500
X-MC-Unique: gpCl8pcJNbaWxnxNmy17NQ-1
X-Mimecast-MFC-AGG-ID: gpCl8pcJNbaWxnxNmy17NQ_1763538821
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477632ef599so2470335e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538820; x=1764143620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vucbh5rS/iiazlez28RYwrKcwogXle3E0ZGtqJKXZmQ=;
        b=mNNs7slzKE9oa/RPiG/Ra3uoeJGhntQp4RryYIbiaC5JyCFea208vUkWt78x2b2iWh
         2Q1moiF8MJ9mES2u3BtTfaaLh3jiLRB5jNrTiKzABrxFhuEFJlPC0IT4Js78nzAA9/ie
         x+og4kRnJ7OsqLPlBixFq+ulndgsBcrLp3FshtL3heg5dEBL2UPAGTiPTljkYhHaGZr8
         6U5k5qsbVGFDtrBnztM75N0tNHav088B4ASwVUHj2k5nImok1HyBuXC+RqREwNLOM+vx
         zzm8nHHSaYm8YamRdJhNRsE4f6UZ/QezxTqACe1Ae78+hfWL+0KQNttz7wcH3vrE4p2X
         Fg2w==
X-Forwarded-Encrypted: i=1; AJvYcCVTaM9d4InKyNP+2BJFio2q08aMuNUnF/l/6vjMGQ8z0JbUa+/0k0D1Ce8vxYp/hcTY9Q8QdvCoqkXpB+ISHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCD53JKxPjobt+Ktvih5l/ipgiQBXDpPreb05K+7pj/+o1dR5w
	dNJhUvK0ujKhyGLkGGUlfYDLhyIahhByKI9zreURyGx3sNpYnMjZdLh9zfvzXqwGaz7q75shkae
	dnlXpwNXLC16YrlFiJi7wXeGWGDMHAGaDatDEIdE4Ft/zE1AFV5pj1gzbMjQVGWj20w75
X-Gm-Gg: ASbGncumoLd4/gmWseCu91If0yKfH0O5er4Gq052CIYxYjZwDKcl5+HX/OEIHAt5oaZ
	3pJ8DOP67raluykV5H8KUw3aiC7/IK+q7IXGQswc356xKdrVCeI4D+dsnk7LVUa7CHE5Y1/BARc
	sQOdpNyJ0FTEliN/2tTz+KoyVPmqLT3PPd/Hi5Zf6XfXqzbCPH51hudnzQOaiKGWtFRNYHTLurX
	1qzIphIUwRRse+mDX9hHc+xeHj9IpQ5bmBsy713En9HGfoX7y4ZcZZSqIUkZkm5ZyOWbfDm8Ugd
	Yp7I/k1WRV6AQl8ddQnyOHZzoZbpsyZFRe9Y6hfeVlptb3LotxDB+X/DkR9bYclUpQgJKS6uLFv
	AXKgLeKgrgP2mc/4QqJuO/BMjogWzTw==
X-Received: by 2002:a05:600c:840f:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477b18b3858mr13384915e9.3.1763538820470;
        Tue, 18 Nov 2025 23:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6WJ8GNo5TuaYkMGmc4zQd9ybPu8J8JY7frBr6ZZhJdaxc0puxXCryzwZ9nWzJqD3dgyJT/Q==
X-Received: by 2002:a05:600c:840f:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477b18b3858mr13384625e9.3.1763538819988;
        Tue, 18 Nov 2025 23:53:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1037d32sm31884905e9.12.2025.11.18.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:53:39 -0800 (PST)
Date: Wed, 19 Nov 2025 02:53:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251119024647-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 77WBYgLgvB9qnqYqpCYU1yXvvR26c3h8fj30cfhnMS8_1763538821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + *
> + * The limits are reported by the device and describe resource capacities for
> + * flow filters.

This sentence adds nothing of substance.
Pls don't add fluff like this in comments.

> Multi-byte fields are little-endian.


You do not really need to say "Multi-byte fields are little-endian."
do you? It says __le explicitly. Same applies to all structures.

> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +};

so the compiler adds 2 bytes of padding here. The bug is
in the spec.

I think this happens to work for people because controllers
either also added 2 bytes of padding here at the end,
or they report a shorter structure and
the spec says commands can be truncated.
So I think we can just add 2 bytes of padding at the end
and it will be harmless.

It is a spec extension, but a minor one.


-- 
MST

