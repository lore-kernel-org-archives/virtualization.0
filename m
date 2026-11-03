Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698783;
	b=nzWzFSKdOAOdoav55A7fymm7ozpHeA9ktRfln0+iTQKeDv5oFAAqbdnEi7ZS2i4h0rPj
	 mLuUUFiSubLnGSXK+9IkYX4/23Itwi4Z7nOnICywu7/6FV9QHhnMLq3ufW5pgHP9jK9qx
	 oVsC0/bv9BFkhWoKyhHfG5LUyXlziRzaEBpjKf84/QmZqd6xlGvjim7KwhEDWrBP+EOom
	 Kv4EgUdv6Sv3p1hLRVeHAqUliU1W9BJhNoghUr3M2NbjQ5mvzawLJhE0NAJji27CY5BUF
	 tpM2rLYc6ZZwpUiiZj/rs2sQd6ZEnDVaog+WuaPELZ5yfScqVKpn4TBo8+IuFJ6DeBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698783;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
	b=Pob6XblBEvPR5QLnT7X3szVQXcgZnBGK3L9BvrJno6i664M+6Tv2/VkKs2Py21Q5q3Qr
	 kzdIL0A0k5a6r9bCWj26QHCzyF+l/cHTHIt7TOVYu3k2WpSBy777R32bZKPJHSj6uG2f+
	 yF0DQSsNbK9/EeuQxQMHAg4Llj1TYLAvMMYKW8URm3aqm4ERCle8rEWzdKI6qRVyqsIyl
	 Y4ilPHvEyqRGV0djbX3HDyOoBIUmcBw/dfhZpDGX2W4L+twegtFaTlgvpScR7REKdiuwo
	 I35UfK1/oaGSL2P3NasBBBQILj9fIsK56IsijKc0KS4l/mh28Ny3U4dMlwZXatVYATQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCSn7L3H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2815606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2815606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCSn7L3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
	b=GCSn7L3HQMnR3VbQsvN8PtZAzNf9SenMWmQPQlYfjRildQjy1jCVN/5mlAEu0ZSKss/OPE
	By1L9Y92VGn8ManQVqYG4t+aYAHFKdxr7PbPvKScn+VvHh1cTbkx3ObgItRzLHrnMT/LMA
	waLfewiWk3GmM63qB/8/VY9iLYag23Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-FYOTW8t8OIqoyPfc0k_o7A-1; Tue, 03 Nov 2026 04:39:39 -0500
X-MC-Unique: FYOTW8t8OIqoyPfc0k_o7A-1
X-Mimecast-MFC-AGG-ID: FYOTW8t8OIqoyPfc0k_o7A_1793698778
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so38821065e9.3
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 01:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698778; x=1794303578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
        b=uAbrMnLdofQkeErnd3RO+E5STHe+kCVGRilyRcKGpPP1hu0Xgk57m+xvpnrfoB/Jkc
         AQYt4fs/WROLXKdHjIBrxyjnCrqSsHUo8TpT/U1cPMhTgmtRzIAZmh1fhtOrWbuvrEOJ
         Uiz1+FFJACI5yC+Unsshd/NocVEl5c/4VwW9CSWEiT216gLsFPJ+3lkwm0ADDy79Kj/K
         y3bBf1d4mSy3yJ3fHYQpQ3QRL6fAHWl8oszl/7ZpuAqwdb1/Mq++778AM9ktu6Fh915T
         aEsAiW26EGTMux/xb87y6VEaEd10O3abr2gYM9L+sQG7XRDLNSLB+3JC+0j9Oae9WnPM
         tLiw==
X-Forwarded-Encrypted: i=1; AKwUvBzVBUz2Vcu++XGDsE8e+gL6Gy+jQjO+E6ubVfc2rVqaw5+Axpq23gBLfAmbK2QtO/b3yKzfaTHOiCFAXzwPnA==@lists.linux.dev
X-Gm-Message-State: APuU4Z988hTD7bEvoXrVyoIimYVF5+dRSfPPBaguYepe0n6ar9Xjf3a1
	rzJhsP2ZglaTwIO2q0G2JEm2ZKUzJnjTnqghsnkopjmOfsyZsRrvlHIWLFyvVMTqRasbZiTMuaK
	F00z3sMmlOfFaMqrdGgIOwGLnaboq6DQ7FeTuXFJAkR6iEzTJ222GJgs/VYfhqMqDkKVrCCD5I5
	Hw
X-Gm-Gg: AYBFou1oWx2x1QhJZLBnR3jRkB/YNJ/UuPt49gu0s5Ef5Aed90gezvIlP7Aeh23eAOS
	Uxond+l/DDbmPwl86hpWBjv9kVmaGGw/DRLOnVaDEa/pIbCQChUH276qVrmJ5yCU/5aIQ55OwTC
	YCeA0U5or0JkizEGqLfBCQc4g74o+f0KEeFSdJOxLpkBrtK0wKTY+tQRVHjXcuYMs929HhVDw3i
	byVdcYiUzdGzkekJBhn8MWtvQNEjis2iKyuo/UmC2SU9BzNnEWgzyAtRTQmcm0d8ljrM58WrLhP
	BKKP2/x9oUZmIYtijjxATg3QbduAOUn3z9kotKYXaKEjSUDzU21frEox8DizODVZI6sKLwnMOyR
	46M6TyZKoPYtCWO1SRv9pJZ0HKx4VEj97I82pm7oYgQ==
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b0bc65ba2bmr112608925e9.35.1793698778154;
        Tue, 03 Nov 2026 01:39:38 -0800 (PST)
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b0bc65ba2bmr112608485e9.35.1793698777670;
        Tue, 03 Nov 2026 01:39:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm190245005e9.4.2026.11.03.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:39:34 -0800 (PST)
Date: Tue, 3 Nov 2026 04:39:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: amit@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio: console: check the control packet size before
 parsing it
Message-ID: <20261103043238-mutt-send-email-mst@kernel.org>
References: <20261103084156.426810-1-zhugl3@xiaopeng.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103084156.426810-1-zhugl3@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cncGkDjdpiFFp4j-7Sq0Dflhiq6Ctb_rWVHzID485cg_1793698778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2026 at 04:41:56PM +0800, Guanglei Zhu wrote:
> The control queue handler hands whatever the host wrote to the
> control queue straight to the parser:
> 
> 	buf->len = min_t(size_t, len, buf->size);
> 	buf->offset = 0;
> 
> 	handle_control_message(vq->vdev, portdev, buf);
> 
> handle_control_message() casts the start of the buffer to struct
> virtio_console_control and reads the id, event and value fields
> without ever looking at buf->len. A control packet shorter than the
> structure

That's a broken device.

> makes the driver parse whatever bytes were left in the
> reused buffer as a control header, and the uninitialized event then
> drives the port state machine.

So what?

> Drop control packets that are too short to hold the header.

And then what?

> Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
> Cc: stable@vger.kernel.org

Not clear why this is needed on stable.


> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/char/virtio_console.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5..5e2a4403dbf8 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1597,6 +1597,12 @@ static void handle_control_message(struct virtio_device *vdev,
>  	size_t name_size;
>  	int err;
>  
> +	if (buf->len < sizeof(struct virtio_console_control)) {
> +		dev_dbg(&portdev->vdev->dev,
> +			"Invalid control packet size %zu\n", buf->len);
> +		return;
> +	}
> +
>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>  
>  	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> -- 
> 2.50.1
> 

