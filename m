Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19213CEBB8
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369367; cv=none; b=tGCDm3SWHXxlL8pFKVRVEXyRbrxGyuutpswI5BT+NoUU9yAebCwjUoh/qC0VIAewnH28N5S0XHtoxH2TTDicRp98OlJzPchONU9saFPYjoMmQiGRv/E6UM1J54xvjjxAiQmVhPYgu5pxjmaKY2Dsr+6wzCj9TpysDCw2VTfhEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369367; c=relaxed/simple;
	bh=C/yq6jnVx6xy0u3cZDQECiEbThOLiWr86BOsSowwW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WsaSbhqii3rI1+WeDFPnRQSRqhthU2M2bER6Gjc9wrWbaMlRYmOaHxIzas7j1xvwHWr+gSAIPeMSi6kqSdrWNnjAEdZnIwKmIaGAEAfjE8cx3ljK3+Hi8blQ/uje7bpwYQttvgjdx3AhmkElU89ua33Rr1gFr09IReCblZBiRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gga1okmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gga1okmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779369365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dh4jGIyaM+m+wkuHxmldgBlU9wnieEbvJbfFxAyJXTU=;
	b=gga1okmkcuhLss0q4QJ3DAKHw4uHbtmgMltGD0sR/pX0sxO3MkyrA6JwB9WqvXhVs8XLc/
	YvVP/U+oe9wBK2FYSKZe3T9DUBr18iG+VM+CC5mRsiANnRvRvLaT2FL3c5UQGimrGWPOYD
	L2pA7rsS+ZE0DeBWN4ZVYhmBKpG67G4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-XlHwLL0kOQ25OOeBy6_g5A-1; Thu, 21 May 2026 09:16:02 -0400
X-MC-Unique: XlHwLL0kOQ25OOeBy6_g5A-1
X-Mimecast-MFC-AGG-ID: XlHwLL0kOQ25OOeBy6_g5A_1779369361
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso44012875e9.0
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369361; x=1779974161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh4jGIyaM+m+wkuHxmldgBlU9wnieEbvJbfFxAyJXTU=;
        b=DeGDVlXbQhR0sjlMdNcRKdpSL6sTmYDXnkCcKL9NWRZTI3W1ZmUN6Glshmlb4UvTRH
         e9BKZr6II6PsBMGmqn/YjuP0OXKcZjFBwOGNAi8BgVGulIaRPMyTDJTTJcTWNyZhg4hk
         JyPo80OWOtonJka6Zn0arFEXqZBYHR8qKBCzb5yJw4lwpiLEDegvXhrhR9dNF1xZde1N
         rMC2HVKxS5fSgtoNfPYzIz3BsZe4JvY3dJENd/gOfhsVF2YX2cSgVMeozNH8q2fLr8D5
         6OGcgoIYPTIUZyj0pmZhYCyNeY649LQKlKuT0VJrtQxFfymEmJMujiEluf8cEKTTjGlw
         E81g==
X-Forwarded-Encrypted: i=1; AFNElJ+MZhesHOXogs3fmr6fSzZ9tzqSPEwiIWW1Y0nwix/v13BREGrGP4FdRhz3sbQGRSJqTBiKX7JQC7JASyOyog==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHBooTwpPH+xfPAXijcJ+NONUXiyq05psAfRANDELybM4ngwNj
	//RdJh1ZUNjKQ8c72iWHtV/9wLceNs4oxOGo1Y5C7Z4LHFPbdx2fejsQcuwJVtf+WKOCfDH5ZqO
	FXDX0ozjugsCTT+S38P0R4yiddrc7JA98Lpe/TjTtvcnULfgP4KS3UPeN9sK4IyBaLAZZ
X-Gm-Gg: Acq92OHUutPPjA0px3bX30e2ASH9xvn6mwEzGVmlCbOIpziTLBzy1be6zGQZywGAm1J
	WS1ao3LK5DYp0FkXy1+XlZAd9u529zwxDj6YyMOwlG5FHFegJqPENVO/zU0/1nOGwhx+gss7zv4
	oVbVxMJgGmwOwhNBXO5q7nqcuUiOS75f7nVzF4Xchir2rIKpZ1nlrKruDR3y4tz+Qxt8D3Ti6Ea
	U28jL5TU6jHx0bpUPQttoftied5ooHEZkRHUygv4lDGsubfQ/Ord8YXrZXsWNrsoVi0UZndvwj3
	r7ChYjiyLMRuChyQgHpHill9YyR+kt0x3ioKVA2TTk4IDSsgQcY4HxwZ3s+1FqEF6/OkUhMgRDi
	0eb6GX1ZlFvuyvrFZJihNOVtmEQIYjptj5a340VD3lh+vowTHzJhplk+AYHZJL6yqw1CNhFjniw
	==
X-Received: by 2002:a05:600d:2:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-4903606b108mr33413425e9.12.1779369361100;
        Thu, 21 May 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:600d:2:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-4903606b108mr33413015e9.12.1779369360634;
        Thu, 21 May 2026 06:16:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9b004csm16148155e9.6.2026.05.21.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:15:59 -0700 (PDT)
Date: Thu, 21 May 2026 15:15:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, AVKrasnov@sberdevices.ru, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <ag8EvTp29B-Q3nCq@sgarzare-redhat>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-zTzFZkdBF4WdKYysMoavS4lq_Msag7h02vt88Y24Y_1779369361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
>> > What's the status of that fix?
>>
>> Stefano posted v3 and is working on v4.
>>
>> >  Should it be reverted elsewhere?
>>
>> Donnu. With the change we have no DoS but the socket gets silently
>> broken.  Eric felt given the brokenness is upstream already it's better
>> to work on a fix on top, not revert.
>
>Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
>follow-up once it lands upstream.

FYI v4 is now merged in the net tree, so I guess they will land upstream 
soon. I CCed stable on both patches:

a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve 
full buf_alloc")

Both are related, but the second is the main fix of this patch.

Thanks,
Stefano

