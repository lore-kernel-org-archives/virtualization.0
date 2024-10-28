Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64401DED79
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132038; cv=none; b=nB52WJym9atS3Dx1TVBK+ukSDGBxukD03ZaTc/ljD/HJvedZQCJ74pb5dbL6QrGOvV/uei/6axQ1nUtAw3C1UsldWlT99R1zCRL7rgrps2Gsfpks8ZUfPYxCyvZuvpY2cbJdlS7mgyTGS6WVDJQavazel8stluE8dFBnQh4MwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132038; c=relaxed/simple;
	bh=dK8AQpVKB21DbhsoIQW9s6DlG17ZojcnqNzJw+AtTTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY53QDfohFCGezd98jKanAPdtXCuPV25810IHnkXqfkKs75pb6F/FlbinPyAWfQSyvIWlOO5IWHcovRVGS0A2OagvDMGqan3JY6TvDh/lAMI29dMe0L1X5gWvayrzbqEhRnnVNLaQUzmrwj461YV9CfEffH1AamyJ70DYYBniUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJkdZIrp; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJkdZIrp"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DEE3409B3
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JslNWiP6rY35 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Oct 2024 16:13:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7D8E2409A8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D8E2409A8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gJkdZIrp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D8E2409A8
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730132033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtWJL992p0JNzFg6tkj4TLPGZxbfATTHqwcgArlMt9E=;
	b=gJkdZIrpBpCGZZNgl1AE+H4jILQlGZ6EhAFGbmazTVcfTHrNjIzfir1t7X1Z3w3HQ/4+85
	CYsAp7uP9sLcc/GCR1rUPN1iLZQCcz+jX9NItmR0O27DXk2xMh6EfZ4CsIrhIO2S4t/5cN
	wsbfFX/1HAV2nH51Sz7+mDx/kxwvzXU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-9PLJkjleMWqkLqJQ2cbkZg-1; Mon, 28 Oct 2024 12:13:52 -0400
X-MC-Unique: 9PLJkjleMWqkLqJQ2cbkZg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-837875efdbeso51112539f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 09:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132031; x=1730736831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtWJL992p0JNzFg6tkj4TLPGZxbfATTHqwcgArlMt9E=;
        b=aCppfkyTQhyAPnXLZXDFcynJ3p3TKT5Xu/5+QIAgmG49fQ9MbUgCXu+V7S2jYTfc4b
         rkn9jMVEq8sGQFrzptavkolfZ6wsnR59My0PXS/vZYlX1MaAcxCo65rmpZ9u0cWqcUBe
         RrEVKrcFVzVvkTNsF43X6bOMrxyIHLVHR0Vvw1GNtutxuXqApwfnR4fMtoZlO4VzgU4+
         oBC+fm6euw7Ae7Gjqxb5E8L9uwRHuWkRZ2nsnJR4N8Bz3osc120FcziMXeG6kIJfgh0j
         8XhS5+XEv2NSJblD48HUdDPKnxHSvFooY/Ku+jgPZ0BjO1GNComr1Xlw5cOq5M14TAdX
         X7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUWat7Nq5Ss45TRkGd/JSSUDZAaUIBDQ2hQRrN1DtaEUaYHMFmEOlVs+X0vKmVo8pZi12jrSJCtFKnLjm1VGA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw199lhlSR9mWF2ZbIp9RG8qXCouSvNcVW+xJKSo4Y1xE0J2/q+
	c06Z+3CmFF7BE2hJNNxy+5TdTrvA2sDPrdKrjIh2NFybziO1Sm03ePoIVv+YITUVly+e5+fZdmJ
	H6IlXVCz/k2yO/ROs9mBncEp1zmOn7Nldrdb5orkHQljpElnd06SLdHVMA2YcFsiDPquxDH2sPb
	CmWa4=
X-Received: by 2002:a05:6e02:1fc1:b0:39a:f126:9d86 with SMTP id e9e14a558f8ab-3a4ed1c7c60mr17996415ab.0.1730132030976;
        Mon, 28 Oct 2024 09:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa5XaZPju6ifo8jMYf5zEpUlSd3TWgjqJVomkmU2miBGhP7PkMhDxDpdF+6n2OQvmwdKH1TQ==
X-Received: by 2002:a05:6e02:1fc1:b0:39a:f126:9d86 with SMTP id e9e14a558f8ab-3a4ed1c7c60mr17996335ab.0.1730132030568;
        Mon, 28 Oct 2024 09:13:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72784e31sm1757568173.152.2024.10.28.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:13:50 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:13:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH vfio 0/7] Enhances the vfio-virtio driver to support
 live migration
Message-ID: <20241028101348.37727579.alex.williamson@redhat.com>
In-Reply-To: <20241027100751.219214-1-yishaih@nvidia.com>
References: <20241027100751.219214-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 12:07:44 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:
> 
> - According to the Virtio specification, a device has only two states:
>   RUNNING and STOPPED. Consequently, certain VFIO transitions (e.g.,
>   RUNNING_P2P->STOP, STOP->RUNNING_P2P) are treated as no-ops. When
>   transitioning to RUNNING_P2P, the device state is set to STOP and
>   remains STOPPED until it transitions back from RUNNING_P2P->RUNNING, at
>   which point it resumes its RUNNING state.

Does this assume the virtio device is not a DMA target for another
device?  If so, how can we make such an assumption?  Otherwise, what
happens on a DMA write to the stopped virtio device?

> - Furthermore, the Virtio specification does not support reading partial
>   or incremental device contexts. This means that during the PRE_COPY
>   state, the vfio-virtio driver reads the full device state. This step is
>   beneficial because it allows the device to send some "initial data"
>   before moving to the STOP_COPY state, thus reducing downtime by
>   preparing early. To avoid an infinite number of device calls during
>   PRE_COPY, the vfio-virtio driver limits this flow to a maximum of 128
>   calls. After reaching this limit, the driver will report zero bytes
>   remaining in PRE_COPY, signaling to QEMU to transition to STOP_COPY.

If the virtio spec doesn't support partial contexts, what makes it
beneficial here?  Can you qualify to what extent this initial data
improves the overall migration performance?

If it is beneficial, why is it beneficial to send initial data more than
once?  In particular, what heuristic supports capping iterations at 128?
The code also only indicates this is to prevent infinite iterations.
Would it be better to rate-limit calls, by reporting no data available
for some time interval after the previous call?  Thanks,

Alex

