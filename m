Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA92433D1
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263783; cv=none; b=oORYC2s/wDXsWZ4uHSSuye3Iu9BiUiIf98THqp5KJ8cGjuaoCw2+H6eFLDxVJ2ST//aVFcL7IEUOhZwCP4jv/W5iUFgo9jxIfPdn4zCtClgaAmcPq76OZUfA/G7N/Nd8nrS16+HCXalqwO74PB8nHvViI16E1NwcQ5XXJxso130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263783; c=relaxed/simple;
	bh=tGGe6R9k07bfXinl0nS+60J8kkCn9Msd7ZYZxAChr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=STrM749sKU3pSI83ToIEc3AZRDKsRSkG5e3ztZ/XsrTQ1zAUiTkm0fF7X3+bXyMGMkyix9mm7JCWVXqGyS5NuNqVVsinIoimdIPDqt3cIhzN5mqapok30hDy3BeeGpWhiIetfGmz/ndovMHYHhh7Fx/hjlhrZVCX9XDFNA8TpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRhP0661; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRhP0661"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739263781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LRMrU6yeeMWRAhnsRZJcbJf4YV+OqMKei44I5o7lAMg=;
	b=CRhP0661Y7fWgDMgWjdBkixpKdUX+Mwj36oK/xgbczE9/IbIKvkVuxAfmjcMyWaPxcAzjP
	gvzjVeoffj1AIzC8uI6ixxvbJMnstWvVOEgkD96cy7mnHRjgIoyzeEJ5NhNUoWgH2ctI6W
	Ng3VRyivbnKMh5StutajlP5HcdFOmWs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-n0Xi10J-PauqkpukWqbyGQ-1; Tue, 11 Feb 2025 03:49:39 -0500
X-MC-Unique: n0Xi10J-PauqkpukWqbyGQ-1
X-Mimecast-MFC-AGG-ID: n0Xi10J-PauqkpukWqbyGQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dc6aad9f8so2047567f8f.1
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 00:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263778; x=1739868578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRMrU6yeeMWRAhnsRZJcbJf4YV+OqMKei44I5o7lAMg=;
        b=PAXAQHxzUKr2nF8z6psDuUHMDsscoLaF4ri87Ze9vSCSPsaGmK7rLZzJ4Va530010O
         SNYT0WqoaDP2WCXw9OyiJRDpv2dsPxAJLb2cGQywCzQSqYDiu5IkmtVbeqjsrcilB4EH
         A3rpvqUjECRlYbPLwMV4G/VhuNMwM9y52tUPYXy4Ay1INeSAfZuVPsvkFm6D4sf35VWd
         oEA7w8u/xTRiwceSVJkdg3qA8NbMyjtiDTGxk2pWh0dOfqS5ISkpgUd2Xcp3zBTF6n6w
         n+l2oHyXMDMA+XV4hHTPb8qpHyxHw9UfdJ18KpINd9Go21tt55K3UP+qZLAuM60Yu+yp
         7qtw==
X-Forwarded-Encrypted: i=1; AJvYcCXxF8Dh2rnjxKBlIY27mOHfNnMqtPLdqiW9Y0z+Xnamh07AO1yngSeWAh/v5NipIsv9VdQrAHduObBYe0qYHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6n8JmgwBZERF035uJr/gcpmS2QxqzFnQ6QEotvlHtprMwrrPB
	L6dYCrC0+kRuY7Uzu2hvpW23v7tHWrqXMHeeqrZ2iV4yFRLwW50sq/CY68h1GGmocjYKNUnIAuU
	S6AjjczjEnzFSLqA2w5KaLD5ln62l4MoXjNow94yQFn+HlRt8KyjKxQL5shJIWsHR
X-Gm-Gg: ASbGncs5IbJPeaaj+0nBlybHqzKvuwy7qjF3HageggvEOKWmbFRw8pX0IIaEX/HUc0i
	GroB/IAI9MCkItLTcz54Q7hDmjRSrsrZcwsuUxZpwl6zQNUmnKHgqwpJYq/rbTx0S8p9YRRHuup
	5eRmox2MJQGnblTz6yGEWCLyYKqBZoZcp9yFJeKEsGEXQZQOYn5Yv3BqckSGsO2ZAqOjI3qQbO7
	XTkQqBbySe6QVunrChFqxs0glXNZ4OCEpoyScIJiVjqzXPxpvAAPloLwJ7U3g/xu+DH7BRUpVr1
	yf+9SenVUq0/y4/b12bmThaF4I3+SKhEwFQHfSqCZXTjxLs5qwV3ig==
X-Received: by 2002:a05:6000:1a8e:b0:38d:dffc:c14f with SMTP id ffacd0b85a97d-38de438e616mr1875232f8f.1.1739263778449;
        Tue, 11 Feb 2025 00:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeTzJoifNHnY5TL4dY0IJ4mNA0Zko6YQk6M6uAACokDE0hpUh2u8Fm8WqTwc8m/eZy3oWQ1Q==
X-Received: by 2002:a05:6000:1a8e:b0:38d:dffc:c14f with SMTP id ffacd0b85a97d-38de438e616mr1875201f8f.1.1739263777811;
        Tue, 11 Feb 2025 00:49:37 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d7c7sm202714805e9.14.2025.02.11.00.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:49:37 -0800 (PST)
Date: Tue, 11 Feb 2025 09:49:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com, 
	lei19.wang@samsung.com
Subject: Re: [Patch net 2/2] vsock/virtio: Don't reset the created SOCKET
 during suspend to ram
Message-ID: <cmpw6mtpzkhsdqvsls6zutnswwgf3exuwdqvw5f5673fzuktol@y6fpwfcb73ns>
References: <20250211071922.2311873-1-junnan01.wu@samsung.com>
 <CGME20250211071946epcas5p3c2afde3813ab81142e81cff110ab7afa@epcas5p3.samsung.com>
 <20250211071922.2311873-3-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250211071922.2311873-3-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cBkVxA_LkXeINBsaVs_XxS_U6MhE29SqarYiyf-P3PI_1739263778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Feb 11, 2025 at 03:19:22PM +0800, Junnan Wu wrote:
>Function virtio_vsock_vqs_del will be invoked in 2 cases
>virtio_vsock_remove() and virtio_vsock_freeze().
>
>And when driver freeze, the connected socket will be set to TCP_CLOSE
>and it will cause that socket can not be unusable after resume.
>
>Refactor function virtio_vsock_vqs_del to differentiate the 2 use cases.
>
>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)

We are still discussing this in v1:

https://lore.kernel.org/virtualization/iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb/T/#u

Please stop sending new versions before reaching an agreement!

BTW I still think this is wrong, so:

Nacked-by: Stefano Garzarella <sgarzare@redhat.com>


>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..909048c9069b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -716,14 +716,20 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
> 	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
> }
>
>-static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>+static void virtio_vsock_vqs_del(struct virtio_vsock *vsock, bool vsock_reset)
> {
> 	struct virtio_device *vdev = vsock->vdev;
> 	struct sk_buff *skb;
>
>-	/* Reset all connected sockets when the VQs disappear */
>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>-					virtio_vsock_reset_sock);
>+	/* When driver is removed, reset all connected
>+	 * sockets because the VQs disappear.

You wrote it here too, you have to reset them because the VQs are going 
to disappear, isn't it the same after the freeze?

>+	 * When driver is just freezed, don't do that because the connected
>+	 * socket still need to use after restore.
>+	 */
>+	if (vsock_reset) {
>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>+						virtio_vsock_reset_sock);
>+	}
>
> 	/* Stop all work handlers to make sure no one is accessing the device,
> 	 * so we can safely call virtio_reset_device().
>@@ -831,7 +837,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
> 	rcu_assign_pointer(the_virtio_vsock, NULL);
> 	synchronize_rcu();
>
>-	virtio_vsock_vqs_del(vsock);
>+	virtio_vsock_vqs_del(vsock, true);
>
> 	/* Other works can be queued before 'config->del_vqs()', so we flush
> 	 * all works before to free the vsock object to avoid use after free.
>@@ -856,7 +862,7 @@ static int virtio_vsock_freeze(struct virtio_device *vdev)
> 	rcu_assign_pointer(the_virtio_vsock, NULL);
> 	synchronize_rcu();
>
>-	virtio_vsock_vqs_del(vsock);
>+	virtio_vsock_vqs_del(vsock, false);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>-- 
>2.34.1
>

