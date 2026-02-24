Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A111EBFE0
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945840; cv=none; b=QMhT8OuG5aRg3wuRjV2JhdtfujaI8VWUlD2xPOFJ8/D8UIOzcStNUwOU06xphN2ML7QAXVb4wSG70d8CBSoQGQN/dIvnkEAhCP7Ydykv7Yw04ljWPIYLbP/dHV4uf9rE3IyoAQoY99eMSrg/4atY53Bz0chC3IPzPvzoisoWICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945840; c=relaxed/simple;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WnpEFVCQ1DJLsjHG9UFAnLbmikdrTIDQ30L0f4Sc5REU2yEnn/+S+IXX9uOH0oC3lP6m7/b+Tb1jLOqRmOwZlWBYcPuESvVYpwihC/dlUROVdAPvRpZhysICB4yZTe7A1CSGeNVcAyEta3d6Q1ivDm8nMk1db1GRNnsJGr0KoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8BZBiEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8BZBiEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	b=H8BZBiEAK/gaF4kW89vzvCvJwvv5kjeLfj4rs7Lsg7KMZIGSFZDbx+7T3MikezmaHsyHjV
	0fSZUOcvTyfKltIrzPgrm1uGJb1140gl2DO5ZK7vP4xSCgrpygTDxoIQnHMd8bjmtQCCWr
	4p9XSGfOaN8wf3tptK7V1iO7pFvK4OI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-kSRkhJXAMnSzwabOM-e-2Q-1; Tue, 24 Feb 2026 10:10:36 -0500
X-MC-Unique: kSRkhJXAMnSzwabOM-e-2Q-1
X-Mimecast-MFC-AGG-ID: kSRkhJXAMnSzwabOM-e-2Q_1771945835
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48372facfedso56190765e9.0
        for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 07:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945835; x=1772550635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
        b=MZYRlCqWW7ijJM3iIZoKrpFvZzbOZqaN6FhnuayAJFq8imryWCo1QmBs1E0yvMmjnA
         HeWiasUiuQQcek4Br+vOQNKA4iDKxcngY0FsUE/jjr6LNCamAzH4oroA4QEwaD+bmbod
         nZDCmOQxdAbPj8C/YFM+7nO8CpxwEJmgOwyUqzpDrGl5XeAlpWGPd/OLqlAZlk91iT3S
         csoDJobYlcML5JhMbSNlKraq3KOPtYIo2nKSq+jqzrAq3Ke59iTxpcg4us61layVLBC/
         OovBKD15u8qLyPigtz/YJTymBfJnlXPGCpp5Accep8SjZVl9z7yQ1OqhzECl5RKFUTui
         k+qg==
X-Forwarded-Encrypted: i=1; AJvYcCVBqLNnsQc2DNoaf09+/UJguv3Dgw4/LPgrwT2OG8eQfyP3CU3mtk6a7eQfocc9mVD4L0il43YYWUoLmwrcGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9mD17qDS/mivbXHr4oQIoTN7lqNEQmjVg8cimRp/AErDIDmdW
	oDoWGfZuBZeG+iB/1trHUB3K9Uo7Jhe3zoXI5JVi+7HkKttfHtu4gKzAFGee1Vu02KK4EXdF0Ai
	AmuLTQF3sPiOjXAtX7A4r5IO/j8WntaLHH4XJDcWYBjy+WHlFK9bghR3c4xfX3qkJVumz
X-Gm-Gg: AZuq6aJmo9GZRuocm4RKuq748WuFtF0HlCLVx8E4uEBSI52uZR4lCHiZ24eBa+Lb1QS
	sh1jTKFgtVZ5q+plLOC3CqgTsd9r4qIj6AWhyV7dWA0/aq/WLG67kv7wT1qF7QX4McTUL9VxUR4
	uZWikP0pN2HKPhV41LmGHfjWts9zvv7x29TsAD3GQtjzDlbvZUmQ2QtgLhxWoo6uzEjRgkfCuQR
	rh7OM1SANQA4Vs7cJgvX2np2AeR/qz/n/kTOPl4L5CUApSpk8BaRKs7MsvsRDHoyrMtvob/pIFP
	plIBfjv+WbATXgswEyV/UxPDXu9yjN+ckOmsv9Dg12+R1NwXWaz1c62qQLGjK1ZRsqrJ3xxafi+
	S4+ccrlOuAHeTvPzf9kgYmzbqq3yhoy1qJzHf1kuBQEbCTxDXLtIf7LM8xYM4C2RoQiJRX+M=
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686735e9.10.1771945835277;
        Tue, 24 Feb 2026 07:10:35 -0800 (PST)
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686325e9.10.1771945834815;
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8791a0esm73910215e9.0.2026.02.24.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZ2_WfJ5NVuyZJSS@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
 <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tMSgS4Amp7zWwp337z1UdnppHL63jth6r6PsFlBRrsI_1771945835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 23, 2026 at 04:24:07PM -0800, Bobby Eshleman wrote:
>On Mon, Feb 23, 2026 at 02:38:33PM -0800, Bobby Eshleman wrote:
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Two administrator processes may race when setting child_ns_mode as one
>> process sets child_ns_mode to "local" and then creates a namespace, but
>> another process changes child_ns_mode to "global" between the write and
>> the namespace creation. The first process ends up with a namespace in
>> "global" mode instead of "local". While this can be detected after the
>> fact by reading ns_mode and retrying, it is fragile and error-prone.
>>
>> Make child_ns_mode write-once so that a namespace manager can set it
>> once and be sure it won't change. Writing a different value after the
>> first write returns -EBUSY. This applies to all namespaces, including
>> init_net, where an init process can write "local" to lock all future
>> namespaces into local mode.
>>
>> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>> Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Stefano, I wasn't sure if you wanted the Co-developed-by and S-o-b on
>this iteration, but I added it just in case. Please let me know, if that
>wasn't what you intended.

It's fine, thanks for that!

Stefano

