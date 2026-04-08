Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985A23C4F3
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662282; cv=none; b=frg4hLhB5sxYLXNBmHdiSh8S219s/9kM3aY18Rmo3RBP82+S38ViB7dSu4oRQj63B9M/Pd+hWpTtJWYEXkqKmjbPKPDNxX2svA1qZ+i3FhobWrYvUn8dCi5CkYr24Z4apojbQEg4nCxIxMsNyBAU2ZaJ+Col2LXwqUUVH+dnbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662282; c=relaxed/simple;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TQbV1m2JCSKwJhSqlPOXI8aCIjc9xva1c49YbfmJwH7g6s7wVRPSJGTObBUZRfIem1MNwbwjOtNBsu+EAs91/Ou+Ie0HJpgjpUwwD5mC3E8MwXLt+iK+hE8/RGApzOhRiMTF9A9CUqnuqkqC1HxO3tprhLbC+kByJZNAk1a7tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdeccWlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdeccWlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	b=ZdeccWlFOYPzlgysN8/yHc0mUjgWZ2JCB44fmyRHH+K1n8trkzi0uPjhdPVv2aW+U1vfK8
	jfdtg3dUM3oq0CuNN3iSFWsUGHw6OEXDabWfaft4LIetXcEJSA9EtFCwz91J0wwLzf/0vw
	rV9ar+jJwr7ntRtSvhZ/y25dRherb94=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-xBRoj_ZPO1utkU8kIza3pg-1; Wed, 08 Apr 2026 11:31:19 -0400
X-MC-Unique: xBRoj_ZPO1utkU8kIza3pg-1
X-Mimecast-MFC-AGG-ID: xBRoj_ZPO1utkU8kIza3pg_1775662278
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7aa1e8734d4so2273917b3.0
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 08:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662278; x=1776267078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
        b=orBmarHj75oJdgbTq2Nzp/lOtO5gtcKg79Dm/3wTiHks3qCIuMMpKcZV7TFXyo/LRm
         QPuXoHmVxvZk9Gw42CaEowkoQ6nUf9nXHGYq9bhEz0ubRjJi1coA/yI5TvMinEks6Aly
         YPKg/2uXDZzW3nEO+uOGWKmmHUJZ1F4f1JMtHPgixsmh2zCtEgzX/VMcbPUzy8l3yGz2
         w4/W77Yw1DrTroP/4cPGnmqLQqdIrAXRie4cBNyna3OMUBn8b7Qn5HIcJJRNMnIPA+Mc
         puGvOyF9x81wghwlF+CeH1K57vnDEHVzt5X+1Ad4Xb6zwqLsoT1AtgmAqdKWv9XY57t4
         YPDA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZBUBLcgbbs83Bu+L18Uw3m/RGPFrxGGhoDKYhKSZQhEcaxdHIvjEZhFauVnQKn2PqLNThIyV6PYX049GCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/4eW/htTGrIz9OPSeSPzmmcE6t2ZF9WqcZCEbNA3xKhk/Xfby
	zjydM1I41cKzG2DZU0rmA5Y81HV9JdmqDwhsNJq1TQPJMoPjlLrGJNao6SF4fgUBMyV/7XV8Ncn
	TRoK9RVtKt7bVfCm+vLDQtXSkU5voBxeJP1iWKfe+ypHqVIqDgx6dOmIycpPkoeK1Cdot
X-Gm-Gg: AeBDietnRFu9fggHMDvrYZm17+3lzlweLI7Je+HidroLsN9mETCYLm0hxNBJIIodLV1
	GPbI6WS9kM0j9TV1CBNgrBnyhhOinSPFHqH98NHUOnobh8Dde1uZclILtqVeJ08pjkSThQNwSln
	ov/txoc6OVs0KlXKhgk0WWC72jfarn8g+Rn6187i21XsKGOF2PqfORp2256ZvDyfVUZhIT9a5TF
	ABrOi6MSJfzkBpVS6mFxpQjJXOMMh58e7FmJMJQo5RwGzHaInG7SMTlThUJySE6zbq0sKxn/Rm7
	Wc/sbEK8h74WswqVwpBkrOghP50oevnh3JmD9qeQcttvSSwlGEpgjXlGZy1HqD/rG/8b439v/L9
	PWmHHO5ohgyCFaR8IZdl5URqvgGvIfxf5EsiywHAMGViOSi5IA2WfY+9WmRqGvhwGSFQyoWlXRw
	==
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194747317b3.8.1775662278375;
        Wed, 08 Apr 2026 08:31:18 -0700 (PDT)
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194746647b3.8.1775662277684;
        Wed, 08 Apr 2026 08:31:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac4c10cb96sm49299076d6.39.2026.04.08.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:31:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:31:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adZ0pWsWQcbTAPEw@sgarzare-redhat>
References: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ROPdAdIlxPO6tptWKR5KOoBBgmmORLdMu2bQZCVHdmM_1775662278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 08, 2026 at 05:21:02PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Removed Fixes tag.
>- Picked up RoBs
>- Rebased to latest net-next
>- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

