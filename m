Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78918F9DA
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916273; cv=none; b=m+3Zrdqnu00MzG/B/N6eTb1TkCno6Eajv2SZZppmExKD8eSdE2uEqxsiuJWi0IjtHB7Ze9F0OqnpeDXB2frRygXUg01mLiLbrIVdNq7S7wbkPmqs3abySiQBhwoJBj4trokOXLRRYt39m8ZP125jgNVOhdNF1BT1RPWvI6LbqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916273; c=relaxed/simple;
	bh=ZtlGlGggHtnbN9op/Y3ICIexBhUAY09LNseAJgwj4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gITa7elP4SfqsMr0Bl2rCyMDkBscGtcQxO5BQIft8XBCSYmERNqz4DKVSXfzKuuVk01iIJG+UhjdOV+DVTxoWggoERQAsvuuVXeBYm1VRTpmnE654jmtrjO2TAl9C38n/8QJOBJU2oRn/57Ce/qipFOZwkw3NQlYSNb3jQyLGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2z75S44; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2z75S44"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C3D1810B3
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 14:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nye1YoHH9xdG for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 14:31:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mvaralar@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C719810A4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C719810A4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2z75S44
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C719810A4
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728916264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uHhN+YniCsyF2iyrPm8KbMOZhKraGT5+k8i5zy+Jqus=;
	b=h2z75S44mugEd5qRSJWyVWTZjoNb+rB74VXd2N0qljMM3LYNKf1W1EVbWrVsxD1PVWsMg8
	GuulFF0XtKh2maQvWRTAWCJJt0flAPpHxCw7YNzJCqUzgjlXgpVwORJj39zsdBnBe6w3bs
	kNRkUJq8khZINWXU7pP2lX4Ku68SpuA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-tX0ZQInQPpmlaGZH_8aPuQ-1; Mon, 14 Oct 2024 10:31:03 -0400
X-MC-Unique: tX0ZQInQPpmlaGZH_8aPuQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c513582b05so95884906d6.3
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 07:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916263; x=1729521063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHhN+YniCsyF2iyrPm8KbMOZhKraGT5+k8i5zy+Jqus=;
        b=TyvduLDz0/Mg+LYWJCUz+dl0rQbdhzEWQqNulPI5v5/8vCz4EuT4phmVmMyLoqUq/6
         DMzZBZXQ+YVjbYNs4DPIK6ScB43qFax6xAXqJsG314CFdjAZkb8m79qWiftEuuPAQj9J
         UnVOLRHyfUulLdDd4KnQfcHHYYuW8DoRDmCVUGzj1SG5sTfFS9oDdoA3DVwoKGtB4p01
         9uXCJvRLI7vOxYhTZ+obDYyes6hpRqhQXWQ2Z3UHBDH3tG9TFTjZTxCU8lLDstiGbsV2
         3plOUWvjhi9Hc9lVQDBe62oBuZ+hmtg1PxLHp3VHni9ldlWayhVf0Klu8z42tG/aQYb0
         Nk/w==
X-Forwarded-Encrypted: i=1; AJvYcCX9YRJlwou+oar8pqXMgFTNBiTArFpigmLE2SS2/h7mq/pxF4KPW4URnJw49vUO3B1fSJpVAJuTS8DwgaBH9Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy+Qqt45FpMp61B/EayGh7cc18XBBy80Ck89GB1RBO3jztSDCuC
	aYZpiP1un6qNxOhckx/JEX8Y6GwkLzA3m1UKDLGbvLkVkDg56gyb3eZyU/1xmZxQBSJb/Gt8ywm
	ttqmKRa7ZxQCTaPKCHgjM4IxPvkjCUVZ8DaWYh5/TbeVcx3NYBEKRs4gz97o6zno4tunW8eiXcz
	iWBJQ=
X-Received: by 2002:a05:6214:450a:b0:6cb:ee89:9982 with SMTP id 6a1803df08f44-6cbf9e76f3bmr141878846d6.38.1728916262595;
        Mon, 14 Oct 2024 07:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/qGFxpNPpeTrI8b08Ch6j1wS4HOMv28oCt0r5tdZCa134rLOm+pt6CYldbdPlHmaAjjxxwg==
X-Received: by 2002:a05:6214:450a:b0:6cb:ee89:9982 with SMTP id 6a1803df08f44-6cbf9e76f3bmr141878456d6.38.1728916262247;
        Mon, 14 Oct 2024 07:31:02 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b79f6sm46017616d6.51.2024.10.14.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:31:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:30:57 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com,
	nitzanc@nvidia.com, benwalker@nvidia.com
Subject: Re: [PATCH v4 1/1] virtio-blk: Add description for blk_size field
Message-ID: <Zw0rIWvmER623sUL@fedora>
References: <20241010160725.3087-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241010160725.3087-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2024 at 07:07:25PM +0300, Max Gurtovoy wrote:
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
> 
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
> 
> Add description for this field to provide clarity on its constraints.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  device-types/blk/description.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index 2712ada..0ddc223 100644
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
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the length of
> +\field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN and
> +VIRTIO_BLK_T_OUT requests.
> +
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the value of
> +\field{sector} (multiplied by 512) SHOULD be a multiple of \field{blk_size} for
> +VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
> +
>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>  VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +988,16 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
>  write any data.
>  
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
> +set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
> +VIRTIO_BLK_T_OUT requests if the requested \field{sector} (multiplied by 512)
> +is not an integer multiple of the device's \field{blk_size}.
> +

I think the whole paragraph could be rewritten as:

`When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device and the
requested \field{sector} (multiplied by 512) is not an integer multiple
of the device's \field{blk_size}, the device MAY set the \field{status}
to VIRTIO_BLK_S_IOERR for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.`

> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
> +set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
> +VIRTIO_BLK_T_OUT requests if the length of the requested \field{data} is not an
> +integer multiple of the device's \field{blk_size}.
> +

I think this paragraph also could be rewritten as I proposed above.

Matias

