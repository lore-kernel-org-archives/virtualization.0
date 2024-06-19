Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF40249ED
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831830; cv=none; b=azVIxKBtDLWavgFVLQWJwgmrbe99Up0EhAgRDzjBlOO38cxonaNdhXKKDB2sOvR4OlI9dbGqh/uplD8X4QFF1gaZj80ssyTKu+o2mKsMZDNFInGa0jEr5KhP03FBMzUOV38PWwin7mxSxZGUJbffDFBC+ehCtmUZ05KjY98c6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831830; c=relaxed/simple;
	bh=o4J+VHpc8lgAhrOCF4h67qN7kjnABDSkF1ibvjkUMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CsiCWboHHFyMZkO+lASu7R0Fr9AqDU8vyxqI70aiuD7wAav9MlF2fCGFKPj1tdjc4by6dx+ljOeHjWJo1yUYI9GAT0vd+cUNej3T7t+46QictQ6uB3bVnDkRjWm5kj3oFtLRkPgvtNWI1pX5jQI0o7RoewAmRQCjAMXFBYVwCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz4yatCb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz4yatCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718831827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaGtl7xWmoOu9CHlxjaHn+EyI5IwHc9tV/Nn5bWYHYg=;
	b=Vz4yatCb2WXUktwen8ww0o0PtLRqa4Vo/HfaPBdPdH+wwK3GJfiPGD7ql5Wt3y1cqDrVGh
	YtAx2liz5biH3PHFU43hDn+6JR26pr/O5ngQUmjNWzpzYIbZaZ9GiCEPFdQGZR5OhyeE3f
	3o1rOUxzr1hU+z/NE+qZwZr/UZz6Kpo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-yNB16Ws_OUGoGNTnxfUTcQ-1; Wed, 19 Jun 2024 17:17:06 -0400
X-MC-Unique: yNB16Ws_OUGoGNTnxfUTcQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f4a5f7d4fso5291666b.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 14:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831824; x=1719436624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaGtl7xWmoOu9CHlxjaHn+EyI5IwHc9tV/Nn5bWYHYg=;
        b=aaMXkkqjhD/htvOLTDSa92ZsVU8RLgomXP9XDK3fGF0UVREGb5fJFR9jVtuFzeFw18
         P0dONS9qXUjKlKtoK7aULL9Od8FGf2rPUKNUV8QncnPGHbhghkZ9PSlPfXTlDRxyFUxm
         nCg/5Wg/MEdwx99CJAZR6TMnC7ruVW0pNTtjlZhLY8BKhpD4hEcdvEctQWTm6smACa+N
         ji/lu2Sl6PGuNER1Y9A1RcXfDe725U/xEuq52vsE0pMh4YxxZwfk+9I42PSxXshPu7yu
         nF3pY0VEjgNe2GD2u7i/PN59ln/IMgpCWgiX/NLr5vLYUtVlNaep9yDBSr5B304aG09B
         qF6g==
X-Forwarded-Encrypted: i=1; AJvYcCXeNd9O5K7yyemnK0MNExn6nMXtQ2z3F36fY0HbU4/UzlPwo86cjG93U6p+eUnc8dJrDdPvr1KB5rjUUOTVwp9X1PCQCGa1ScHZfAFdTVQ=
X-Gm-Message-State: AOJu0Yzf1YdZL7h8VD0//DrB0DVgz7/gq9kDC3ZLO7khsXwA27SAwm7W
	llUM4JBf0++8BGuelHIaT0uVGcZuVJKh7s1227o54RfYyxpI+kaBsrhBWlIVJExx/Sz/ykHf0MS
	TeDhI0xK69XclWJjx4sLcPc/KQfl6KldNaZbTnqj0odKQcRDjLVKNKLV7v5/TKEwoBzqGRl33Y3
	o=
X-Received: by 2002:a17:907:770b:b0:a6f:7591:9222 with SMTP id a640c23a62f3a-a6fab77b448mr220541866b.47.1718831824574;
        Wed, 19 Jun 2024 14:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXs9jDkV0ByYLMnnQwvoYXJCd6WvY39C2Qk3xA2BJXIQlnCk+L822PM2Nebfis8IJiN1YclA==
X-Received: by 2002:a17:907:770b:b0:a6f:7591:9222 with SMTP id a640c23a62f3a-a6fab77b448mr220539466b.47.1718831823890;
        Wed, 19 Jun 2024 14:17:03 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9982asm693979466b.202.2024.06.19.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:17:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 0/5] virtio_net: enable the irq for ctrlq
Message-ID: <20240619171535-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 12:19:03AM +0800, Heng Qi wrote:
> Ctrlq in polling mode may cause the virtual machine to hang and
> occupy additional CPU resources. Enabling the irq for ctrlq
> alleviates this problem and allows commands to be requested
> concurrently.

Any patch that is supposed to be a performance improvement
has to come with actual before/after testing restults, not
vague "may cause".



> Changelog
> =========
> v3->v4:
>   - Turn off the switch before flush the get_cvq work.
>   - Add interrupt suppression.
> 
> v2->v3:
>   - Use the completion for dim cmds.
> 
> v1->v2:
>   - Refactor the patch 1 and rephase the commit log.
> 
> Heng Qi (5):
>   virtio_net: passing control_buf explicitly
>   virtio_net: enable irq for the control vq
>   virtio_net: change the command token to completion
>   virtio_net: refactor command sending and response handling
>   virtio_net: improve dim command request efficiency
> 
>  drivers/net/virtio_net.c | 309 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 260 insertions(+), 49 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f

