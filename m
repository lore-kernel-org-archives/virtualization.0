Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06A32BF4B
	for <virtualization@lists.linux.dev>; Mon, 30 Mar 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882008; cv=none; b=eP5WxIjzvaPe3UA9OMio/+56wv7vApdqxKPyf/XkGiECm+2jPrxj4VlcutNTLBbUctt7tEvpwoMUOVGBoIoNpt4LD1F6ObVThNTpkQWFmH7WMiMIz61/zjS8C8jn7e+3znjVTW/FQMI53IN40b8VxecnA0uLdkdjULCZWFr3VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882008; c=relaxed/simple;
	bh=+5gTHg4vDOFdaFyL3X0paJ6piTE6QKBmaZjfG+KdWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LB9o52ObnU0iYLE22DvyTeZKCMRfAyTo+eT5zhVzUvDWi6trFnYdli7yeE4WvZorsQQJ7/OqX4ngffgtbd2bjy7cirkI+dI+NZEDNDV7IYZ9uYLDC3zMzaomYZ4ay/C9Hu/pWCCwYfjn0dpBUQfQ9+A6C1Ti9XhvXVonmKWDt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL1uyN0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL1uyN0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774882006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vE5lW6KIYn9Crg+NxmWP1FduSgxGLW1hAif3uAMklrc=;
	b=fL1uyN0X7uMV7WLOoSKDXQNTHTrjNbftNf0RwjsnF8I18WqBJeizaFfRh+V0XcKNTZ9Zgz
	+EIMVZsLUh+CsvFTMe56WPFooi/ymrYzZXX80m3Pw/Tz8KfU0YcPAWR8Jw34nDKj0+MtEZ
	TdvahP1ufhY8zFPud3Df2LHasjaFq4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146--_7sfH4UMRGooh5rHZabpg-1; Mon, 30 Mar 2026 10:46:43 -0400
X-MC-Unique: -_7sfH4UMRGooh5rHZabpg-1
X-Mimecast-MFC-AGG-ID: -_7sfH4UMRGooh5rHZabpg_1774882002
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4362197d1easo3401698f8f.2
        for <virtualization@lists.linux.dev>; Mon, 30 Mar 2026 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882002; x=1775486802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE5lW6KIYn9Crg+NxmWP1FduSgxGLW1hAif3uAMklrc=;
        b=lKeOXDF1ZJcDGFw3kqu5Kfum3FulfKMdXEuVzzUqnH4hUeGC2u2Ts5S6Z+zrPuBq/E
         DCJpWJB9DFvTmdo9V/AoQGy+b45i8n181GR/GT6q8Vfk8gKloJTCTGcdrqLZn4Hy2tmP
         zAjh6EYN+B+tsAdkmUmLBjkQiXznl+MjrsGOvnkXhTpbwmj2Hbpn2wOobvy5/z+f9lu/
         s2mU3QMf9YF+H9/Ab69zNkz9nvcCss6Sfq8+/MTzUBA6InPp4cwdvw190skwmwDB7NKX
         tQiAatNHF9qAfMImApGzcAAtpAi9/raVy8S8BC72OrhhYis64ElFk8ScFRv2ur9MP2/p
         fhyg==
X-Gm-Message-State: AOJu0YwfwV3kn5Wlm05/XoheeVTBGBMHQesBjYnRCER88DG128V7D/CB
	NUdZK3ph/HRACnv9mOZhpWO+wy+5t2lv+EWwGSZfgjdhtytVJTUEQs/456+6Cre/EV7FcCbkzB3
	I9i12lIqLkLNkkUt2mrwBLpdYPBYjA4sGiOSYPshuyaJ4RUjWmG/VOBgGKRHoEzL23y3T
X-Gm-Gg: ATEYQzzbUc8iRsCYNO6MpJ5b5mv4EIQXulSchFcmMDmuElFLU1nv9hs+1Bg8Fc7zWkO
	Yy+qGjBwgKUkv6p2nCbsyutRX+IGWw0w0YzhfYRDZMWxj+ZSOy/7SkrgdhpaYW5DhuraRj4YUwR
	UBd/Ztms27VPWCgfRqiRboco511AX2BPFsCf+hxbUlAjj/bwjonTI1u065k0g86yaPd3dMUOI7B
	Hnvn/8i03GzQSjWF4GIbhUK/Mo9TbiK3hFAQkSK9/ud2ycQ2sH3+20iHs6R52EK5RltgQ14uXtG
	TXAU7796ahn3AZE5CF6LRSQmw373ZjJayQkhqO+bYwujjj7u7ogUsDW8FcoXMiSHX+KAflWM0j6
	G6fSUFLayVPnpM5eTh3uSd6/n7XVkwpjIi/Euf4t//JtmyhuCHH4JvuioPrbTc1S/raqB0O4CA1
	r+
X-Received: by 2002:a05:6000:2505:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b9ea34773mr21701255f8f.14.1774882002084;
        Mon, 30 Mar 2026 07:46:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2505:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b9ea34773mr21701174f8f.14.1774882001517;
        Mon, 30 Mar 2026 07:46:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm18330997f8f.10.2026.03.30.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:46:40 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:46:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Valentin Lefebvre <valentin.lefebvre@suse.com>, Yu Watanabe <watanabe.yu@gmail.com>, 
	Andrei Borzenkov <arvidjaar@gmail.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Luca Boccassi <bluca@debian.org>
Subject: Re: [RFC] loading vmw_vsock_virtio_transport by systemd breaks
 vsock_loopback autoloading
Message-ID: <acqLo6-IQVBzY3UW@sgarzare-redhat>
References: <20260320110224.GA140154@pevik>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260320110224.GA140154@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dbExiDLvy30dWv0t50HtvJgZoLxTO4tv2JizUGbpddM_1774882002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 20, 2026 at 12:02:24PM +0100, Petr Vorel wrote:
>Hi all,
>
>there is a systemd bug [1] which causes vsock_loopback not to be autoloaded due
>previous loading vmw_vsock_virtio_transport in an early phase of boot.
>vmw_vsock_virtio_transport requires vmw_vsock_virtio_transport_common and vsock,
>vsock_loopback requires vsock.
>
>Reproducer: [2].
>Proposed fix in systemd: [3]
>
>While I think the bug should be fixed in systemd with proposed fix [3] we'd like
>to know opinion of the kernel vsock developers in case there is a way to improve
>vsock modules autoloading.

The original idea of vsock_loopback was to be used just for 
testing/debugging, so maybe even the autoloading when no other transport 
was loaded wasn't a great idea, but at the time we thought it might be 
useful for testing.

In general, therefore, if you want to use the loopback, it's always best 
to load vsock_loopback.

What use case is being affected by the fact that vsock_loopback isn't 
loaded automatically?

Thanks,
Stefano

