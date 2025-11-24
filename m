Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA432C333
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018367; cv=none; b=ZHHzRoVgd7eALZDLxmbviYdIyeY1b/gjZYz0kC3ZbtHUZ9byeM5U7WCdNkO1Ge3KrHaBv2Qx7jOeVfvvcLXtly4Tjlu5Fcqm8cnW5WF1VVCrVMnAVo8+eqWC/WmzWBYeu+4t7BZpumUADWFZlhXviFyOaYj2mYWPheHoRGa8Ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018367; c=relaxed/simple;
	bh=g/E8beR8tUDQn6lIaWmMe0snOaMj2hJxdE6dQ5kv0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pm0+LHlzshBC6RUxbGkbicMeSYQlldTilMOCOlgrGn3gHFE/oB0YdM6PQAyaFOPT6w6XObA4hrPYcL2YOrllGfiMzYpfK8DkJnmq2BZACEWBzA751WzLHMn4zZpyK5fsD+6Cdz+BKdr8NBY/GGnM5mNBjCaYcXzcipRwDTK1D4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Td7ABa/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Td7ABa/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764018360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlzuh3Vi/CtH9Lvd65m1lkwNjxQfpqQltMC5UipnhYM=;
	b=Td7ABa/JkcC7669WHmyS1ZXjxinoYk0Qa8uuUxKCzw6+hCcItenyEtxY/q+Bou6mjS7QL6
	QPC/4jYFzFRiVAypqmGiEAD8H8HBn6XG45mtUcs+GDKColHyMngbig9qghIElaG0+9nGhx
	huLD+b2Xuy4j+T7ltqKB+37KseFa5eU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-WuFFDnvROOqTEc6935DHqw-1; Mon, 24 Nov 2025 16:05:56 -0500
X-MC-Unique: WuFFDnvROOqTEc6935DHqw-1
X-Mimecast-MFC-AGG-ID: WuFFDnvROOqTEc6935DHqw_1764018355
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbd8299cso2281613f8f.1
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 13:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764018355; x=1764623155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlzuh3Vi/CtH9Lvd65m1lkwNjxQfpqQltMC5UipnhYM=;
        b=ipCEpKS1mFpXKY25Rr0bm4gKnnFktVNHZ4gEyIgcYFBol/T0vrcNkqjT2wU7Ix0y+H
         IbjEmvfvtbGMsveBYqaE6d8pMSKN7OjdPjI+l2wu5wup+QndEbqVpFBA9G0xm/9l+yqB
         Evj2dBU+wR7Dm5njVLX96NKHoCdJ1Egrn7I3FLBWyEfEjhm9w0G+vw1asOnq9XzobSte
         Pd7yn1xJTWfjLCFfCvy+eARxCYfimJ4GDLxDxxlCkrxLEahVzp9wjuSwYdzzPRjig82G
         hq3qoUdA6N+gRE4LfkbvaVeaC1+WNnFeZS6ugpGKbUOQudUg3bZ5gSltY4K2SrqxgmAA
         QV7A==
X-Forwarded-Encrypted: i=1; AJvYcCUVjImDoc6nf9Io42/WjEUDLPvn/pG4qoxc/ywQLXEngcMAFBIh9dgixtgO53+dyKYHnw8rFJ9aJ5qGdNc1Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YztnmbsEGo9N4Y6q7PWgvSAPv9jFwSOxln38UkbhhiYdJnQqspO
	TnSRy8DPST0GJwfian4kB1SBKjS7heuGCt+Ez8XH81WVOGtLmfiAUEAHhjuzeGYFKV43E1AA5Fd
	LO3RDB1rPFfZnwN8lhoGov2hv2GWMQcYq9/GU+ZjouEj/FEyg7EJcI56Kd2vCaxwMQg/p
X-Gm-Gg: ASbGnctqBYtCktqW/Kw0z4yvIq2fg47qRaoFWAEUgQhlIOg+uWkFfLsgMKfTu/6KWc2
	i62DGfmB8drh7omqUqpVdvoadc0C0rHxw9YCFxYkOJm4+D6Ui57xu6izgkEoRGZzjiOAtrXGpUo
	jog9hbR1bhVaH+oLQhbjapvsxzkPDrxEKdt76ArlnMVwn2lwrGtX3VPKoZiTPU7qQlpSvi608Fj
	IvN/rhFtsjB5Xn2b6zqJ5BLVgX42cMO1VRNaC23m66QxwkI6rhxHiLezo3fB2O8m1n463G7qp4M
	cpI4JdfJS5uis5g8uyxmNbAzvDM4AYXIqhzykKDaJaeoOLr3462YHUEw42oJYy7I84pDMTeWAdP
	he0ihwIcDlJtoCp0gnhcHQx7EsA/XSQ==
X-Received: by 2002:a05:600c:4ed2:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477c1164cebmr127649485e9.35.1764018355418;
        Mon, 24 Nov 2025 13:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrr0g8aeqLZwRJYhQFNtT44/ZArFpgI8tE/z7srMCZDG4NbIPNu5jRQhTGIky9yZHR5HEr9g==
X-Received: by 2002:a05:600c:4ed2:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477c1164cebmr127649295e9.35.1764018354969;
        Mon, 24 Nov 2025 13:05:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040c70c5sm3152165e9.4.2025.11.24.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:05:54 -0800 (PST)
Date: Mon, 24 Nov 2025 16:05:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251124160517-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fUl9FJnjhmH8t22y5LVDnYNdCf_2WO89zioQn5NAtXo_1764018355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> @@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

should we not wire up get_rxnfc too? weird to be able to set but
not get.

