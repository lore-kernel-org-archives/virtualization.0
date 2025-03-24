Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A02EC2
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788907; cv=none; b=H/b4BMAj5Petc4CqVghRY+LW77uX9PuXM9RJAyRQdpyu45oq1n47Ym7loq2EzxoLSxfzOXA4T/ZhHfhsQuXwezVhM/BNpbKxjQ/bg7FFVvk1DOyVDe7fkssvgLIJYxfwdWZsagDXgvBTnsbFn5gdb6k1D0HhFWnPPvlMGP96ij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788907; c=relaxed/simple;
	bh=CGSlvFYaKu2MQWRWu1e9Hm6aB6LcidbseISLkc9BRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odMUqMgOzU1l/xhgHlRr/egjCktNhcJagnxiQ9Qx7M6LGlTXu/BR52gXnJmvy1jcSBal514EJgfND+mTWm+9oZJl4IYbRJJq0SIVNenkA/VJcbKr6rX8aFNTMXn8cDXQYfu6ebgfEfBfTrRA7P63QBiU4yMJjVQqcN2nIX6oPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ger4aU3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ger4aU3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742788903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
	b=ger4aU3YiSJNU0pfEFjiUhC0dSLnNw8swRRhO+d6HOeo7pGVcSAwReaebiUQrraXf2U+5E
	OWw6nSyS+fQWTacSNxC+qiR5SEomF9jN/CtAv26417UDj6Y+AateD2gKFlPa/jpQQ2+tjV
	tTeGvHApp4KaZzSzRrzpjBBJY2wIrE4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-pMxYxntwP6eclJU-DDtWWQ-1; Mon, 24 Mar 2025 00:01:41 -0400
X-MC-Unique: pMxYxntwP6eclJU-DDtWWQ-1
X-Mimecast-MFC-AGG-ID: pMxYxntwP6eclJU-DDtWWQ_1742788901
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so4815292a91.3
        for <virtualization@lists.linux.dev>; Sun, 23 Mar 2025 21:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742788901; x=1743393701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
        b=gTVAJRKRup77ZxH1CZZmBCizbUuyC7jPHKqgunlo46QSV95RZcMH1dwDm95KgHfYCO
         ikZQzFTsISSmziW17Xk24JLY5eEfUumLMVuLpEH7SXtmSMkC7moz7ioCWlvUqh3plzxE
         CC35LhEBy9dc3v+NfeMMoOgg7YKB55UItJtgJXXmyAQQT+CNRrm8N2LyefgaDVYG68BL
         lY60IDsWUhNFsCrx1jn2AbS4ZjdtNhj77cE7/CuWlJOlZwH5iG7SUg398McdEGo5srS1
         YQoHVndAIvJr2w7VwrmXJjQHo9IBo3QVhFqcvzI1ZAPQKvpxeGhRKIeOKhZfyews3a/S
         Kacg==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ21QRXoKpn08kBri5n4My7IsgkvZRE2efUn7vDHL3Gao2+iQAhzrtf7RI/zugTN5a5dG9bRMReAOnoHoPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfO4iddRNj6ns/P6dbFvH6ASh14HWclgCiMStQ5IgX6i3A+sv9
	a9DxytBcUr2qBpLgZ79t8jAKbeXqjvXnXH3YajKJgcATVdAIyfgbMtnDdMnEXwx/gzYGwGbBwDG
	V/OPMcCEROgX2R317iW0XizTlpOjn/5qwppHGyRCvQ5wH+hyCGU0lnpWa+sAwhM91HP0/2dyDU5
	x0ZVUYRpXgBVNAH7x6YAEZudPlhHHuIeG+qjbwFIE=
X-Gm-Gg: ASbGncuYD/bPUV1jfj4uMV3Uq6JVpPYm20IiAb9IQ1pWclz+HmVRyuPXjtMg8Z+LO8N
	vHPY/jwem+T4u3fNRoCOzwp5vxorC1+ltrtqJdU2GPOFDHhQzpyNPFCys34UNiRGkHGCby+4=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-3030fe56af1mr15735748a91.3.1742788900694;
        Sun, 23 Mar 2025 21:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtwyi1gJ0zaQFQsrBomqFHMj2VHAekCjI+gMhb1MAOqbuMYR3u5EZtG37zC0QeYxAC9WJADhULBbYtaVCZnck=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-3030fe56af1mr15735694a91.3.1742788900080; Sun, 23 Mar 2025
 21:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Mar 2025 12:01:28 +0800
X-Gm-Features: AQ5f1JrJp4r4sxi_4HFviIS8ywunUbKIEpVHOsgca9dqLM3KIjeU47-OoEZtJNs
Message-ID: <CACGkMEvQr=cj2iXZTH8qwjByVcWwsAowOqpDy+n14sxyvQw4rg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Use new RSS config structs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	Lei Yang <leiyang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1yY92YkryN3iNB5sTiR3nurey2RQVEcARaeXsz_BQBM_1742788901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> The new RSS configuration structures allow easily constructing data for
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
> for the command.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------=
------
>  1 file changed, 43 insertions(+), 74 deletions(-)
>

Though I still think hash config should use a separate helper, it
could be done in the future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

