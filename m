Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639E1BDAB8
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Oct 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555872; cv=none; b=s51H4uqSc8uNnCFWx+4QVIizkztmqHep8QktDmuL8OtgjMJhSqywDhKaUedm0D7Hc5ZLYTkqfWOeDA0aRJnujc9ANYShHlkOPvGL18dVPeB5ZuZCyYlCLJfcqWW1algK9KSLAi/cVvsB+FIKePSumQExfinZknIWI2BrRy6KAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555872; c=relaxed/simple;
	bh=dErLelS0VywvYyN9Kv2ZUBxx7lnD4/yZ97kq+cRYSPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m02vFNzWIgcGy8kA9UdEWT8iDJJmrc76TD53LxeDJ8zEwv9l7D2TUvxTY8a22VAyjegHG10JQlhkAGg0QIHpx9PgI/qOUflYrOKnd3nRwoma+Fep/kZ9kj5c9ibHCQlbBGx1asOVcQ8pjLk8vNKbRllT2l/UZJczUdxPE8WGLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKpLw0bp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKpLw0bp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06DCF60ABE
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Oct 2024 10:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hpm3XBXcbtu4 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Oct 2024 10:24:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mvaralar@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C4DF60ABD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C4DF60ABD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKpLw0bp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C4DF60ABD
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Oct 2024 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728555868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cvSPpukCLyQeYmp96LeqyJ28kNZX41riUrOiQ+DwTko=;
	b=fKpLw0bpaIFJDlS3zNZTJwLzOwlm8iIhpXkZ4jSqpIWNrPXmZgDDn95yZFkyiVLlWGDzmS
	RhzHETBfh8MDLMcOZE1B/JqtHt/efw2K3F+CnCNNixGz8Go0DqZJJpot1s8MMwGshv/Ui8
	h1jd9QKtsuUFlmi66HuyAOPNO1Cigx0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-yVXlLJMdPZ6quu_-HHOo3g-1; Thu, 10 Oct 2024 06:24:27 -0400
X-MC-Unique: yVXlLJMdPZ6quu_-HHOo3g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43112243946so6470835e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 10 Oct 2024 03:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728555866; x=1729160666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvSPpukCLyQeYmp96LeqyJ28kNZX41riUrOiQ+DwTko=;
        b=hYazwE0GQVjcziFsyD8Vh63hCi+gkvgFPsiu+3ib7zH8SQi36u2q39KP/3pljpTXID
         GUiV9lUqbLmFsxnFTGIy/owm8QYfmiByyfGTv4K2QNTcRB5rXAbcZRX3Ai10jZGZNUIS
         XX5Plgz8pmaDyIiIqbBKLMnl8/StDLh9WENQ7kkwWYw4cjLwSDOplkpEyH0GdmttG7z0
         klQRh2DY1L/zSDoDdHH6wXsnAfbP2pm3LC6odRMcXWS5pVvYTYFg4V5B7mZx0pL9za4f
         +99RJSFZJfR4UOokjRi2o/4AyvAcqMKZfOgKKHf/IpPCJTgKe954p4Mdp9Si0EXNT7jq
         BbGg==
X-Forwarded-Encrypted: i=1; AJvYcCVkT6rgnAzUi3hlJNQJ/sO+wUUb+9onP06APLBf9uOPPl51Ok8fKiO5liMfQTMJN/w/LYk+CksZFP8zhBqkwg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzorzNUQOayr5xEdFjgBtOktmkZLRX/uyzCjM2/ftaeQthM6UA7
	LdgT6tFA7opTK47nn796UQiBn59tCwriU9lywssmPoXi53yl1kCEkE1oPUcoQLWq5hWB3rmIF2f
	nb/OoIb5rkOHl3z4OsoQCtajpRe5uxhvTVpef2VNyQr83xOjBszGnAZ707XqEmQBd1kbYvXv3gV
	tqCk0=
X-Received: by 2002:a05:600c:468a:b0:42c:b220:4769 with SMTP id 5b1f17b1804b1-430d748ca14mr64848715e9.32.1728555866020;
        Thu, 10 Oct 2024 03:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS75DZsNnQDdS0crH1J8cBaqlkVN8RKvOwe9cgLKUmaSylW/ojQC3V+58pP6DP/38WF+CSmg==
X-Received: by 2002:a05:600c:468a:b0:42c:b220:4769 with SMTP id 5b1f17b1804b1-430d748ca14mr64848435e9.32.1728555865583;
        Thu, 10 Oct 2024 03:24:25 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51753sm43991845e9.23.2024.10.10.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:24:25 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:24:23 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com,
	nitzanc@nvidia.com, benwalker@nvidia.com
Subject: Re: [PATCH v3 1/1] virtio-blk: Add description for blk_size field
Message-ID: <ZwerV4qPST9bbJ1O@fedora>
References: <20241009160512.8390-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241009160512.8390-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, 

I wrote some minor comments below.

On Wed, Oct 09, 2024 at 07:05:12PM +0300, Max Gurtovoy wrote:
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
> 
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
> 
> Add description for this field to provide clarity on its constraints.
> 
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index 2712ada..caa5d13 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
>  
> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.
> +This field reports the block size of the device, expressed in bytes.
> +
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
>  the number of queues.
>  
> @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
> +device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
> +logical block size.
> +
> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
> +MAY assume that the logical block size is 512 bytes.
> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>  sending VIRTIO_BLK_T_FLUSH commands.
>  
> @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
> +Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
> +offered, devices MUST initialize \field{blk_size} to a power of two greater
> +than or equal to 512.
> +
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>  if they offer VIRTIO_BLK_F_CONFIG_WCE.
>  
> @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
>  and VIRTIO_BLK_T_OUT requests.
>  
> +The length of \field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN
> +and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature has been
> +offered by the device.
> +

I would rewrite it as:

`When the VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device,
the length of \field{data} SHOULD be a multiple of \field{blk_size} for
VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`

Just because people tend to read from more important to less important
within a sentence but I do not have an strong opinion about it.
Apologies if I may sound bit picky ;). 

> +The value of \field{sector} (multiplied by 512) SHOULD be a multiple of
> +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when the
> +VIRTIO_BLK_F_BLK_SIZE feature has offered by the device.
> +

For the same reason, I would rewrite it as:

`When the VIRTIO_BLK_F_BLK_SIZE feature has offered by the device, the
value of \field{sector} (multiplied by 512) SHOULD be a multiple of
\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`.

I think I would follow this pattern in the text below too.

>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>  VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
>  write any data.
>  
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
> +\field{sector} (multiplied by 512) is not an integer multiple of the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
> +the device.
> +
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
> +requested \field{data} is not an integer multiple of the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
> +the device.
> +
>  The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
>  discard, secure erase and write zeroes commands if any unknown flag is set.
>  Furthermore, the device MUST set the \field{status} byte to
> -- 
> 2.18.1
> 
> 

