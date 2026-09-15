Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669F41DED8
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489988; cv=none; b=e4us4Bvlha8XeXBzMF7R8NrsHISHkGS84/I+QAAsJsRyRgXZxrt9Kjsx4P9vWgpxe24+CM8MiVHfQrhv+6QYm31Sb+bWXKVEiqFfcrA+2/hLNWDvdt/lMfPkRvLJzJxVko/+V4VgrwOqexkqU9DavwYuegOdP1jS9OZ3h50S6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489988; c=relaxed/simple;
	bh=Xzgz+4tsqdIJiJ44u0qBX2B1GLvXUOfXVH0aIZzJ9Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h4RjHCLDCxmKbS2kOB4nSUDtk3sijoGTwkJazo+DyR/T36ieH0Ut5G9rUm9Toxuyfx6EJeb8GiKurC1r2gvpJbrhZ9N7K5bpNKR+TJZ1Prkn2pUygn7Wwq+0jkr99PkcWIFR5mp0XUC6A6mdRLlwieM5SbbH5Wo9kTuT0ImM3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhUfRh/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhUfRh/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789489986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
	b=QhUfRh/gS7uB/H0R9fWY8fuAh/kO/B4hvVEUc2JGtMD+GjLACx33wt8Gioplib6YAzZsxd
	IncLuuSqoERQ4GWaPu4XSrqvwMqOT8QKysZ0vgOzsWqqXsEYHbQROlUZqKxZ6ouzBDfaY6
	3p6CNLOGdnJYXPlKHzUF7/ttMZEWkZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-3XVkTx43MdCsUKhdK9jjgg-1; Tue, 15 Sep 2026 12:33:04 -0400
X-MC-Unique: 3XVkTx43MdCsUKhdK9jjgg-1
X-Mimecast-MFC-AGG-ID: 3XVkTx43MdCsUKhdK9jjgg_1789489983
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cced8309bso41805165e9.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489983; x=1790094783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
        b=FnmAiOAM3VL3jNQi4aFlhh+TPbOBogIhxMSuh4xiV5pc9kNXrB1cb8jRE/EHTRfae6
         S+NQ2vYcT1QEXg4fpUkQGbf0aeBq4QFKuhLCOk0DtxOq9HpKJ6dPPps4Wwt8KOfgcxB4
         rlcd/ZE+pVDsKrL7LyJcw/HiER3R/+PI4JbG+L0+/Pm4/C9Cxhlu+8XPa8sfBq+n2Qwm
         FbQgxbJi2dMVXKWkOoSW8YFZYveBkxXtbwyi1RZ5TXPOIp8heWxHwd1M0Iv1vssrup+z
         LqFUXTfn3xXiqKcFYnNdhVUwL4t20OLCYKmEXnBr3dbHWCbnNI5Uus7QYv2Dw1WdhMlO
         b8pg==
X-Forwarded-Encrypted: i=1; AKwUvBzMo/QqE/jrdw5T6lgWwJ4oQ7EhpmA/2bkooQMq/m1XKJNfReEv2AVbsluEFAPe/dYTq3BAM2K4N3TElvK1LQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nkVhrBa9j9HV+R8hV3lmQl+6bVaoC2JZdRFOwYrjbS2CkWUOc/
	o6hjKjVd3BsqXRvu4EITw6SvnojwK5N66IuOIgCjfFR8AjH9cus7qLq9jPQfyhjW4eJQqTCUsK8
	2dtVtabpQ27+WNWzGTVpBiwS97bAuMY2klO1SmFfM0XwZUxuiTLQrfEFPrr8kYNezW1sV
X-Gm-Gg: AYBFou2cLAQrAgu28x5yXTI1r8Z7Kx0Jzx/no/DDq7ZFzHcE5kw0ismYlsSe6I7gJI9
	1zYCwJe4FaVXDg77ciTD8aTpR50wP7ycfF4eoskNSbgGNlADavt/xAVY+VgojcZ9zYNIPVfwGDX
	aqU8RoSvNSVpEUSnArQkVG1wu9jBC+DJeOKrth7/JLeYPiO3hU5N5eBxHthm13YOEH0geoQHNEZ
	oDPsqJpLqKGISredsWvnsC+laGnQTkRicBTrxL+Ze7vIdI27xaDNvazTk04qQqQO+keAIlM96Vi
	ddg1B3LiRr2QgLjwZRPfx34WKokSSow0nUZGMQJaBO+Mg5573U/b8fwWjRNq3rE9oauWdc88lAI
	sTzhJ5ipbhWehoobxKnpAl5vPoO9xLEM2Y3E=
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26724345e9.19.1789489982803;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26723975e9.19.1789489982463;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83dba8f4sm1920305e9.13.2026.09.15.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:32:59 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqli0Mq_jv28h7eW@leonardi-redhat>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wt0e6e4ZxcYf9IQS-DLEfvriUAy4D7SllCMcnTRTk9E_1789489983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Aldo,

On Tue, Sep 15, 2026 at 11:15:47AM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before inspecting or storing new_mode when no bytes were
>transferred. This also prevents an empty write from locking the current
>mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..816d25b314 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 				      vsock_net_child_mode(net), &new_mode);
> 	if (ret)
> 		return ret;
>+	if (!*lenp)
>+		return 0;
>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

Code LGTM.
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

To reproduce it, I suppose we need a kernel that does not come with
`CONFIG_INIT_STACK_ALL_ZERO` set.

@Stefano do you think it's worth adding a test for this case?

Just out of curiosity, how did you find this bug?

Thanks,
Luigi

