Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172854644F
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936319; cv=none; b=WJgB0EYrpsu2/RgQKFrA3srvqyf0Gw8InWnzZccZmp4rFKAh5NeXOdKir9VVIHchdGJDYvkA1travsRp20laq+jtorsHLTrOCXblOf1T+afwB8RVzo7gZBFT6oOu+emEhCJ7Wbvn9J4FJOAwAt6vQlM8upfDvIJGZA/DeNr82Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936319; c=relaxed/simple;
	bh=Dygiyz1OnjTfaz+BngVouI977noQ0Hft298bDIocTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F6JMfIXaQtKHFbzMv3sN7ldk38ZMBiOs7SASyyZzO6QnzlPJh3s8TvGrBRilTQqQvLga95IPEedIVMrZky3VjKauXy4U49HAU/+5ziubOxjv7olC6tqiOeDwV0B0xtd0aCZG7uZgCPIXb6fQBGWcUP921xMOW3b0h5cp26ECkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aER3L+k9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aER3L+k9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
	b=aER3L+k9Mgqmu94blCLAAZt4ThQ3X9NYaWySQNsAYJfktjdSD4VwwJgxqczZmqzWTWfsvO
	f1P7pysggwkJ0CBB8KhNchn7KiHsUkNb4h7MNvzE676UfI7PBuZwDgesu03mWhktlQorvN
	bfbt+ccerL5wJ3j5bYRFh10v95TVdhg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-7XLkdFXhNb6PU-PSHbMkqw-1; Mon, 26 Feb 2024 03:31:15 -0500
X-MC-Unique: 7XLkdFXhNb6PU-PSHbMkqw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3e94bbb22dso192995166b.1
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 00:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936274; x=1709541074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
        b=PwnXTK4IR7TcGocvXw3Tbi3WcBiyCy5kYvYmhHHTpyRK8uIO5CRnA3DKchTikL5buw
         xxDWr/F6/S+8KjOmkkQ2l1NglYdQjFJd56sz1CBrOYt9WGXLpMvT3bDQdKzK0tf2qtbH
         XBcziJnqsrokhhl4JaegWRQ2/XPLTjnY1oGVi4xSiQsbmlle801RJU8HwTaGDNdNWRyx
         horrSGHVfbTm2gLQ3XkJ9YDWgsMeVV1vl/Zbc4zjePjCi1q7Ge1DUcxUZ3LFiekbwI5D
         IBPuIZoPrx5AjZe96jRj3YF8oGjYc91iqaJGPmSifmPck+z5SroKqD9fsm+1EkO1Qfdx
         QiUw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJfJnc1VjUIyN0Q3EIUVdgOV4RX6ALFCjV36EJJuqpPsUxsfqt/AqPT0QEzPZVulNyAIpscP5rqVXp7WxDwiGyUgFcwmaG9MJmVD0qY4=
X-Gm-Message-State: AOJu0YzKohFl+Tb++4WUdXN6jbMqew0s1FkDP0UfIWjFutTjt6TKUExo
	t2kS9abI8//nqWALDNTnJ2JyCGTMQXQhXBuB45vr+aNTJbxjQhekn8Jmh0XWSZTzKkuGSz/oF8P
	+ohstIee+N8y7kHahIXWt6vd5dZY3oT3r6D9RFTB8y6C6eilauWfCF+tHZen4WL4Q
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010966ejb.50.1708936274466;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkiK6ZRARULAZlIUD5UEKkd5/oLyZp7eTkoe/Z67A7OQ0GXsH51rC970dStdoLZ85YatD2eQ==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010953ejb.50.1708936274154;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-148.retail.telecomitalia.it. [87.11.6.148])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a42fe08081fsm1874734ejc.47.2024.02.26.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:31:13 -0800 (PST)
Date: Mon, 26 Feb 2024 09:31:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
Message-ID: <rqyg27a7ukbrg7wz44jqliv3ckl6ub6fnpdcpxsutw3yyczajm@iqzvhw4rqdy6>
References: <20240223115839.3572852-1-leitao@debian.org>
 <20240223115839.3572852-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Feb 23, 2024 at 03:58:38AM -0800, Breno Leitao wrote:
>Do not set rtnl_link_stats64 fields to zero, since they are zeroed
>before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> drivers/net/vsockmon.c | 3 ---
> 1 file changed, 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
>index a0b4dca36baf..a1ba5169ed5d 100644
>--- a/drivers/net/vsockmon.c
>+++ b/drivers/net/vsockmon.c
>@@ -46,9 +46,6 @@ static void
> vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> {
> 	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
>-
>-	stats->tx_packets = 0;
>-	stats->tx_bytes = 0;
> }
>
> static int vsockmon_is_valid_mtu(int new_mtu)
>-- 
>2.39.3
>

