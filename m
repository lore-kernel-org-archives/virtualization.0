Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429332DD5EF
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508662; cv=none; b=aclS7Yboic11giiFi7skNCZFm4C3U9M4+a0lpOPh89Yby4yv1wtfeDQHFViuTcf7jfPIGxUI2+wnfY8WaoscHnDAUI95WQb1U6taBHxAjhIjp12FnAfaqN3p3TwUhiTFglN9kQBSwC8Ty+Q5aoPSwuiQOdMPynI9CAjmCTgSW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508662; c=relaxed/simple;
	bh=oeeTQc9kh8tiDzBTogIJh4tx2yTZCyvYeGymBiksIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nNdwhPSKTmgHX9kzfkLJ9a8J+or4nUCQV4IWpWvEIlICXdbRnE3bjJAXEAor/tqakoJaOGRSRczzSlRV+yHqR36AJEzOflfmN9dxjOiT+WRoZ9aAZ/QXaLFS6QopRNSnpMZ1Jv1BAaNfd8xSBwfjpbMH3CIIrCDf0JphRzLuyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTvvtuaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTvvtuaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766508658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqJClaecT7bQO5wRvV9Omgfdvbdj1KDOA3tj0f3pjp8=;
	b=HTvvtuaqT3OxJMSbCtX4aRpQvMwDwh5w+Uxlkd/LuZFc0hFShVj24rBJPqOqzEvgWVCUjS
	T2QCjE2/mf6CvFrK69VRFBI5FSQBpfp+xe/pGKsai9CMtPI2EyL1pwKIKctYgl9qnulXTr
	ARzB4whZ9AEXPXh1TZR2B9/HDO6gs68=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-1MqCre_bOjGq0AY1niZ2nA-1; Tue, 23 Dec 2025 11:50:55 -0500
X-MC-Unique: 1MqCre_bOjGq0AY1niZ2nA-1
X-Mimecast-MFC-AGG-ID: 1MqCre_bOjGq0AY1niZ2nA_1766508654
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b763b24f223so74203566b.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 08:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766508654; x=1767113454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqJClaecT7bQO5wRvV9Omgfdvbdj1KDOA3tj0f3pjp8=;
        b=Ztw77o7IWHgyxM8C6zAjiuVnDjZph2Hfgt7TZy19oZn4VBjlYLPH0yx/yreUkkvgOY
         Fr8us03BACOip99t5gt8/dBQckHUE1bqaZAx/6QzDkkHFfmOq/3foSSI1xficYnWxlan
         H4P7IIsOXsS4AE6AY7ZGrymQIG2/GCjZJaXFGa2s8aVb+Twf1+pPd+h6P9xbJAjPOPU8
         fZHg2Qtu2+VAt9sD1fDMnsinqDpFJZHOf3AbC+m9eit6dARNzAb+Du1aDPg/yCWiQnNe
         +qO5/xfeiRLYSPEV72aHwPAxDhn7wyh9y4ITODjRRGZkRJk0+u9pvLmjnkDopm4/GhMR
         ds8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUplUSk+c5YwTN+ptbl9LXrN8LCr4vZWhyh2eZEK6LQsujxyLGfMjI2BhjErs5XEiz3UjLcmNoI/qTEJvkwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwW+iTczIdxgbe0MSOTm5iDdQ4ajlzXLVZqzijoBAkS/RayIyA
	G5D+hA2YNkDlxXRde1T+lL8v/MGhVdAMNX+4GJEX5zER/XnfDiZmQhQbHOnaD3t51H6Q/U5BW3r
	ZVZbKsanZJ1A4PDmj5q3KViVrWhOmpj3jpjoa69v7jY6F9pq7IaM+AKiVSL/4AJZ7uAGH
X-Gm-Gg: AY/fxX40KHvmjFo3SXX2rpeOm3O2VyYojbcwEfbcgx+Jy3zMX1Y+OeIzHN5a2gHynVn
	OCXAoUb20G5e+tAvQqZ7tO8QYzoGu6GFFyPPs7XhUZtWtBBgD190QQJSKZi1v/L+o8ProPGC4Wm
	cJf87kxB3GvjX4MITnV+Cd1EqQcmlxzCP2MGGzYUeWxd9tUs99qLdqUVXP8eINzhGujFgJ6+gTV
	HUFwq83WO7Bjsw/UCF1EUadbnnjrdalwx2etVPCt+geEbMGi5bVT9stsTQl2p9jxzKt7CL+PWDO
	9vVvYCY61iHXaRjfG4gdj+fqt7UzwYA7n72BJVquLd2zov6487WEptt5PcT5ZlU4l4oH5aGS1ey
	4y6cvwwfRwpa4o3Xt
X-Received: by 2002:a17:907:72cd:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b8036eba988mr1360525666b.9.1766508653962;
        Tue, 23 Dec 2025 08:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFngH3YLsbRayu5ybgJw8PMv72mVXGzRctJqQbYOaNglPLvvDbrvjX+L7BBepansUQFsg6KPg==
X-Received: by 2002:a17:907:72cd:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b8036eba988mr1360523666b.9.1766508653521;
        Tue, 23 Dec 2025 08:50:53 -0800 (PST)
Received: from sgarzare-redhat ([193.207.129.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm1431627666b.39.2025.12.23.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:50:52 -0800 (PST)
Date: Tue, 23 Dec 2025 17:50:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aUqWtwr0n2RO7IB-@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jExhvF4qeIhGeVNYpLAiT0AtlHLmeKDMc6V-rs92i7c_1766508654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>On 12/23/25 11:27, Stefano Garzarella wrote:
>>>On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>handled by vsock's implementation.
>>>>
>>>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>---
>>>>tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>1 file changed, 33 insertions(+)
>>>>
>>>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>index 9e1250790f33..8ec8f0844e22 100644
>>>>--- a/tools/testing/vsock/vsock_test.c
>>>>+++ b/tools/testing/vsock/vsock_test.c
>>>>@@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>	close(fd);
>>>>}
>>>>
>>>>+static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>+{
>>>>+	int fd;
>>>>+
>>>>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>+	if (fd < 0) {
>>>>+		perror("connect");
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	vsock_wait_remote_close(fd);

On a second look, why we need to wait the remote close?
can we just have a control message?

I'm not sure even on that, I mean why this peer can't close the
connection while the other is checking if it's able to set zerocopy?


>>>>+	close(fd);
>>>>+}
>>>>+
>>>>+static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>>>+{
>>>>+	int fd;
>>>>+
>>>>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>>>+	if (fd < 0) {
>>>>+		perror("accept");
>>>>+		exit(EXIT_FAILURE);
>>>>+	}
>>>>+
>>>>+	enable_so_zerocopy_check(fd);
>>>
>>>This test is passing on my env also without the patch applied.
>>>
>>>Is that expected?
>>
>>Oh, no, definitely not. It fails for me:
>>36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>>accept()ed socket custom setsockopt()...setsockopt err: Operation not
>>supported (95)
>>setsockopt SO_ZEROCOPY val 1
>
>aaa, right, the server is failing, sorry ;-)
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>>I have no idea what's going on :)
>>
>
>In my suite, I'm checking the client, and if the last test fails only 
>on the server, I'm missing it. I'd fix my suite, and maybe also 
>vsock_test adding another sync point.

Added a full barrier here: 
https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com

Thanks,
Stefano

