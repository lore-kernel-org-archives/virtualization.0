Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD423C7E13
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579061; cv=none; b=V8WrUoBMdWBXMw6EXMKBlR1m1WHwR0t4XqtqATekZrenMCXHEjspRSZZOSWy9LBriIzrCrCAM0khzt/1pr0HqzLOfQt3aDe32scfBzqyBVnpphv+QcYU/P+iWZFuWzBl8/eYRxgxv4enNZvdu4HbnfWl+jlqPkrujkTQHpPlgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579061; c=relaxed/simple;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VCFiQ/a8hY3WqUfF/tjRKqtQVtVs2qT6f9ErF62YTOmoILvBY1eTQ0iPs5zfBQnKJHoR3boQ1EMq6zmihALUKx9iZf5FEB86dkrdqnwR705xhkA0U/728Vyn4FFIcDkV9mgyDBKoN2obs8Hj4ADZAIssBx/sz8PQ9rRgnIt5Gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYdFIy24; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYdFIy24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775579058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	b=eYdFIy24/D3FtkWPAceEji9riLNJgNtUqhVHpdE/4E4MCWlW8cfWLQG86/k93SeD9VTjSq
	qoRTuO1Rbu0Dr4ZA7yY8f70IixtTeJ0lNVBWgJjrecM9RiES2pHJHmlDpKj+IlTSZli8iP
	t0/axC7lyp+ilOvKxQufzSNKdQ9NKz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-FisS2NwZNsKKpK4qSxtPmg-1; Tue, 07 Apr 2026 12:24:15 -0400
X-MC-Unique: FisS2NwZNsKKpK4qSxtPmg-1
X-Mimecast-MFC-AGG-ID: FisS2NwZNsKKpK4qSxtPmg_1775579055
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4887d32788bso42037895e9.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579054; x=1776183854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
        b=SQ/Y+OVoQVIaqKCB53DayPTs06h9p/Ow101vxhonhx/njspFcME7K/YNhlsEe1FdSp
         42Wfr6VgobMbvTaJlcAWI5z9dIqjVyC8oGWuaGZPo7gw8I/XFEwY1dDqB6pATAPzA+qK
         rZjx8zK42643xYuqh0OXRAv55g3edEXLNcISovcptNGBNlodzPklzeIGnVRIYBcC2wO5
         mkdDQjhFGN2wNYKFuSSHgMHXewCXJryFmjPCzTg426QwmQOM3eH6lN2C5YHOWHfMagmn
         vk3aFQAY/9ZPfsSXVtUluLqyHRmdztKBYem9CN1TjPYr1g5cP9/MukPAqBcRqJSo364U
         UNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqQ4SgZO58HKGmb0+Je920qZuH2pkT/Gp7wz0CDIPmndEJMYGgCtWSfd+oe3u4bIUExLM9h0h+Wc1TwSANFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzYBoEWyHrhLAEs4fhs3ipvS9Imyvk4DsnH9xfe8I39sUEzTT+
	hhud1/cF4E8xHZyA4ieYx4uf2dJqoevrH2yeZ9BCZhZbFNOgpiC3BglZqL7vaJG+hpOHacR4dGd
	nxyzgxPKlbCZSLraf5V6m3K4tV2zc501l8Z9ryHzCzHR+cYATuxBCHtDhsaiyEAB5Jrd2
X-Gm-Gg: AeBDies/NdWOj25bFYC4qudV+wMc0ecbcNEhjFH12u9wFvr58/5cUthYtEhX0pdWsCB
	ulqqlckp0Bls/ycJOo8mFl2pqKlW6yfR1UYdDkRdXqch3bTkieGkTnc0J4EVSq8/1eGdeObcNcg
	MMQGZ8FkfVPBiIs+1mknazm1QTO8eyPv1LD6N3YMO+O5+JDc39QK8yxCnBMXyJu8WeiwKqBLMNL
	a2fvff4r5Vhxls9FZMODDb5MuxqIflzY1sy5XgIzXoC6rDdgnj0u93fYgtm7lyr4z9qtDTHW9xF
	0+4imluN8ngiJSIbZC2DOPsOgl8ZMYpUwK82LS+5OiIjLHf/vfUTpwIUwCQ0g2MuGrlwSw1HFPp
	lWH+mt0N3OoJTm9ROTTUmJG/HWJ4=
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251016165e9.15.1775579054546;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251015655e9.15.1775579054035;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1043018385e9.2.2026.04.07.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:24:13 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:24:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvaIOLFcmC7tgt@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efx7XmiRrkCz2ULiaxCjxOVQVWfcTa1Rj2gCKFh_CUo_1775579055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 07, 2026 at 07:16:24PM +0300, Arseniy Krasnov wrote:
>
>
>07.04.2026 17:31, Luigi Leonardi wrote:
>
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>
>Hm, one more suggestion, but not in this patch: may be we can also remove 'struct vsock_sock *vsk' argument
>from 'virtio_transport_send_pkt_info()', because it is also included in 'virtio_vsock_pkt_info *info' ?
>

Yep, good catch!

Thanks,
Luigi

