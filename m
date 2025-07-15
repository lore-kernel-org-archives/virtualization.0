Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23064BA42
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573732; cv=none; b=kdYpviS5kccH71KcsMBi82aq58sVolyx/vtzcQvN21qeVOnHse79cYAi+4Z0P1qQGRhc/bv4F76F8EaDVNg5pCkEtY6ovVgMjZ3d4Car2DxU6zF4QCbwRrppk9EbffHwpRpjfBrN9qZOASpOckoTw503pg+WVADPhf6ce55mw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573732; c=relaxed/simple;
	bh=/Esi2LSscF1WVQ+nHVOWsWxA9bkfWvoVCVYFUIPTLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=leuinIQLZIRywifvVSnoV5Ut1KKpL7aw6M/VZzvsVIdb6DnX6Du10jjCoL03kZMu2q8qn4AvfHDP2cnzSFRoCyQa5neJLooCApKdah/kW9wHsXGFTVohhm/IVvVpvG5HbVloE6WEDMiljTAGfeVMCResymuQO5LehELx+PmoqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdOW+Hk4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdOW+Hk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
	b=XdOW+Hk4eClJR5CyPWH1jJv1dv89mR0CSxN+84Z5gZnJTSiyuRTCdKJNrX3E/lrd3mDRm3
	ja7Oj6gup3SI3obEQnUTDJ6+vnJTDju9oNj68qyFm5+3ZKdiapTSDuakuTj7WEuNeZSGAL
	4a8pZv0feMU/9UJUCsMI7Q+Jh983B70=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-BimgVhuYMW6jPB-0uU0G7Q-1; Tue, 15 Jul 2025 06:02:09 -0400
X-MC-Unique: BimgVhuYMW6jPB-0uU0G7Q-1
X-Mimecast-MFC-AGG-ID: BimgVhuYMW6jPB-0uU0G7Q_1752573728
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3642ab4429so4156327a12.0
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573728; x=1753178528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
        b=vAlWAhHtnKE33ODF9WAZoYZHCwffrYqYJzONN2caAQgnTdmmFgrorpdduVjxhlIr7x
         sHdCt31b3PmxHYXrpMxRwPsFlG9bOQoAq0SC+kNk8KOl2iA5IZHIDqkCR+R6ndTssUl5
         dBmJ623X55YbYGO5wbcKmXXbJ8Aapv/7Ak8TvEvbeEetBtcMbGvHlg9+LoPXdNtsGXhk
         k+tMhDne9xyI1Sqgt12hF2p8tTx+6FbUv6Vcz2GYMbAxaSkSK14E5Jx+fB3Sf886xHSJ
         DrSFIBkXONFXv4tRVAKxiImjVjlZfIvjNvndA20NI3sqq0TgiLePzrZGiWiRmTMteTII
         5u2A==
X-Forwarded-Encrypted: i=1; AJvYcCVe5E9QJSwqRDEeEbpAsNbLorZJMTLUV5dLUgszgK6USY6pyU9bQPm+osTYSQuIyQhbuS3MIfU5c0iyblh0rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxbjcrwz1IVZnRKCLAuIrg6TyE+DY9UiXae3eijyf4O4XIG1MHt
	8UmT1SoAKsLJE8jXG/YqA0/osImNYDfb3epyFuBkWi9ZozEt/NpJX/IX8ig1UrrGbI3dAZqHzyZ
	JnJQegfJ8RTm4LCJJc7WKiZmxeVuuNNvqiz03/bgpuv45c3wgcOa7FwBHeiAYxljPG+P5
X-Gm-Gg: ASbGncuZN2JYN/ec3sZYAb5AMHaxFcM6iVPwE29v/e9zhm/9S4CDyG1+8RbY6jxkY4I
	8lGRUaTDlGJWRmgJIaUJviAotFYb91og72IP3t4D3MHrqoW/r2aBCPF5HiI0TlFxQ6vb7s73Y7M
	zRR7z9mm+SzxpTIgdJ+347ZVSp//KjMzGW4CK5KaiCYWdgCc9L9P1LQJNrrot0smV0/2xxtKmrZ
	lv4fGOcj4MLFdECYL85+D+oF9YaVQrZQT8q/PegHwPGgrf8F+l9Byr4QMhmiC4LO1oDxbj2bKHl
	eL49cjXsha+VNpJx7lLJeNiNJ/Vwj7BKuTyWEHDgug==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556982a91.2.1752573728006;
        Tue, 15 Jul 2025 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF43KPk0Mv+KOem1eKuyhOhWAxYn+8QkkyVrOQLCDBIs5jSRYrwTAbV1ZjwkxKobKwqVaLB3w==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556922a91.2.1752573727386;
        Tue, 15 Jul 2025 03:02:07 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e958166sm11589778a91.5.2025.07.15.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:02:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:01:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <opdsodne4zsvgdkp4v3q2xggjzwjtk22j3knvpntlo63h6t767@jsuxmvgucatu>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NHekKnbSeLtE4wjImkzsqIt0ZKo6CjSXEHh-bR6nNjs_1752573728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:54PM +0100, Will Deacon wrote:
>Hi folks,
>
>Here is version three of the patches I previously posted here:
>
>  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>
>Changes since v2 include:
>
>  * Pass payload length as a parameter to virtio_vsock_skb_put()
>
>  * Reinstate VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE based on a 4KiB total
>    allocation size
>
>  * Split movement of bounds check into a separate patch
>
>Thanks again to Stefano for all the review feedback so far.

Thanks for the series!
I left just a small comment on a patch, the rest LGTM!

I run my test suite without any issue!

Thanks,
Stefano

