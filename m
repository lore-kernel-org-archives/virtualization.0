Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4C332EBE
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319618; cv=none; b=k/Xbz3/a6twU0geXWNIHj1/A3iNIq/hFQ1B9nwgZxIhVdrpwDZlbmq5d6IfBlnVCit8VMSpZCJUsl8Baa9tl7hDfclnPJZiDzlnS+5MOE+Mzl1uifaJsUtvXbFl6a8tNbH4A/KvAXaeafxw5ea4FHJ/Hc5OB5BPdKzNnEvR7+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319618; c=relaxed/simple;
	bh=Rr2crUz2DUI9okAYGgwFpuu8kDcfbmW4w4rvyQxofL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qMgy0Q/8R19P6g+nTPLQ3mNhqDAWfPrVL1ApP4r9xmm6kZx1rBNWM0T34TwOTRtQqRYxRw5ujcrV7bU6b75SQFddArez3o6Ix5HeQ+x5RrMA/G40QJG/o7WDS5L6wbYKLu6QnYzfYH5Gu8KOTtxY3VWavnBEjEA3oDuliuRMWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTkz7t1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTkz7t1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
	b=XTkz7t1xNvqocMM7vFWA0GXBOARlFWTV+4S8wKv9Z+o44hevmVOa7t22dTw0UHghJmUaiC
	DbCpOhN810Ldmslkyjwaf29P4DdS1FcH7zwxeNDS6I0hvLjCpoRvoynx7RHM/KPISIsHjy
	WXxs21wRI6ulUZ1uSGt+h9BEkfs7ELA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-FlRpoQz3NryhWAf58sr0SQ-1; Tue, 13 Jan 2026 10:53:31 -0500
X-MC-Unique: FlRpoQz3NryhWAf58sr0SQ-1
X-Mimecast-MFC-AGG-ID: FlRpoQz3NryhWAf58sr0SQ_1768319610
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso51026485e9.3
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319610; x=1768924410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
        b=iXsnu7lSn4mWMQ0tdmzEJGE4oxWUVHcPvkYgC7cVnuiRWQU0nSzD7I9WYlRkSDIkD+
         w6EHJc2TbcP5ktJxNLxbmqVInv/vR/xYvocm7Z8Dyc0WOeNtsznjIt+hPQVyzWEnb/wH
         CPQhWHSBp4GEAowRy4fGJM2TMA3QeEFolccvKQ+dbw3QDJbC4UH+wzwvH7fRSuF5pkkn
         EwfoPsvo9eByqs4gbuSnJVl8F3XpRJdm2qON41CK+KEMfrQV8eRyD7LAcJ6gbVLe/D97
         kXlF40F38UcIxlIgsQU8SRLkWl5yYcgN4Ci+MGhXfb4XJ0GLwpQlPyny4YCqngnZI//M
         KzWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVjk1XCd2qFfktRG8MQCDffx3xkkXDkKr5hJ7l0iwnrOykRUR83ZPXKAIGvSM5JG6Uyy1bKW6A/fh7MXXWsg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/e1Jt+qVfUkrW3WLzsaGt89IE5Bvo4jj398w1qf3gLVuNA+QO
	EYiIrkDGCFUnb7x+VqbDDqEVTgBjoZ6HF7TdSbPZVKGMNs31cToAxWTv/uNKbEsVr2kEK+xWv+2
	3m2JmcNzYsNNvf6UuoNCRLfyKjjG4HKiTCXGcOBYB1Idf7xPFUocxRvBt5hbu3kVaSk/E
X-Gm-Gg: AY/fxX4qVA5OK4Ypn4LLWeuWcnpxHEPlXkc76/Sn9O1kmJJQP7P4OutDxhUkufpHvbm
	Vo9rXr6E0ssKM7jcpbc2EpkwLa42vKCrOujcRkmb2a5QL24pN9HoSvrdlpuNHUERp1eG+HKPC6C
	x1d7/9SS3Y7/5QF2TaULc5y2DyduwzA6bCsu5Fh9svuTnxkcPz2H7RVYwKgF8wNAye6bHXf8o+p
	4s+uSNjIxtG1FS1lA6r6J4NqMrwylAgzvXTmRzjvtyj49kjxeHtVxUwJwjrrU/2j0HCKZ5w6Mv3
	ROu0e0TI0xhMfOgErUjadupsXaJ8Z908ttPph5msypbUkVmaTpUjzNk+bNIoHbHpE4M/bXxn4do
	sej0VNxkapo2Ph8jSicMv6DSOKx/hruUXlSFPAJcF9NQJeSD7UuGIVeeO+9gcQA==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282565e9.23.1768319610405;
        Tue, 13 Jan 2026 07:53:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQfC7/NeIeIlU44iVNxdFG3KKUWSQZIDiswxSwdGso26nsC4+3O4KhbxqfJ82+1Ys/KVNR7A==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282215e9.23.1768319609956;
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm419650175e9.8.2026.01.13.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Date: Tue, 13 Jan 2026 16:53:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZqYWzhGf9gQgHk@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NEqJz8uORerP_I2WjbxVoeSlGZ6DoIFUX6YD3bJtQb8_1768319610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

