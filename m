Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E43E1201
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491054; cv=none; b=KYID209H5hbb5GNFRXven9+FXwl2+CS/6GjNCJd5YnapetbDgwEGFeCQdsQ1yFPEjh6MjOeTkBMPLNxX6pmHptGslEzSgTMUfKrNmIoFThQn2Ie/MPtmC7MWihf6E1kb/ABH2QehLb84o/5JFlgamyPrVrpgQbyc7ZNaXN1wSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491054; c=relaxed/simple;
	bh=O4R9PW4W6s+z3xFlBUuBjGuMFpMqVv3R2aRzaj5ablw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P6ntaAK3BTX8+RsfYU5H80tJRuYJxk7oScKEeX0CU0MbCQRQ/tEOgQ+l6lbQmCZz9WdZB1qhf0K3btC6XvfKdS8hg3pSPzKj88g3nLFqTE3OWEeMjJQhwgMRBvU+N50yWa2BQAU4O0BEVEzMaCEe9ugCfH9zaG1+k3oDYxKKnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo3qjnrW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo3qjnrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789491051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
	b=Yo3qjnrWKr99mEatN67oAZRgZnsKy74bmLDSvAMWFV+g6gO1Mj9NLCuBDJs80bHbxBvMqS
	goU93OBe/PYa1E6prwl+TWh1ENnM6ZiudcB69cypWSigO8YMN92JAARCAHvqn8StQmwyP8
	SROSdR5ZicMyPYlKBI5Agidposevb5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-RBGK0mhOMAebkIKYZvj-CA-1; Tue, 15 Sep 2026 12:50:50 -0400
X-MC-Unique: RBGK0mhOMAebkIKYZvj-CA-1
X-Mimecast-MFC-AGG-ID: RBGK0mhOMAebkIKYZvj-CA_1789491049
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso41253805e9.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491049; x=1790095849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
        b=ZM+e56OKvjBJWVYfMCiautsV5kseS+wc1G2wzsBY2txfn0J1im47jAsiUHtoBXHYhW
         RgM0HRU2OUuFko3iK+LBAGTqoGF5IximEvvQhDOaXo+G1bL4QAvnYY6D/FoNfX0UKUku
         iK719oAiIJBpNwoZvq7syiz9NchGNrFK+V+WqFLg6vHlc2246rlZ1mLDdTN7pcM2OfXW
         jCieyD17G3c2LxsjHAf1DmIzZbeMBJ2P/0yMB75AupdYl/0yhvB2MUPFVPG4QDA5D7JM
         h0QwkhR4BHuMuJ3F1wHyvAglBM7VG01j5N/ferbWsEp6Wx8fh7ZY7hEo7Bq96TXtFN7O
         a9Ew==
X-Gm-Message-State: AFuF++lguue+Wde3mCsrVjLw0joSF18JYneRoiw3nIJ7FDegLqQb103H
	Zt5vlQ+lYDx3GcTfULFcI85ZRtO9Hpn1v4ooJoANtQ58ivOioWSNTrwTqwavNRrBjrocA6yIMqQ
	rElrRisD4c+QO5nI0jlv3L+MtP0nNfKmuRyLWeCaCxM7PAQ+6Cyefn36v4XT8H8MWX8Gu
X-Gm-Gg: AYBFou2Z5DLugAuhOiKktkI2jlJf+7OU2RQVy05pcFiDa3LAb/T8CtH+31NdQYnXKpZ
	ywbWKi0fbFmwLbNWAQQS3bony5z4gE3e8zSzmRfLnUbMR3i6hK7yWNwQKI7Kb3LpghbbcOyqfd5
	o59WUBOuSmxq4V97IOaPuPjez7bNupjfHzJpBdXrnyRtDTOyBRkv+nlqGFaYdbnfSkoym8EmeGW
	TnOwB/oNkGeyU8NrDYJTO7piaXvHxaRhCRletbZSq3W0cdwKpjbrPg3fSzIZz3Z4dnAbTXt4rcC
	cUAL/hwyKMxiNJiI5j3QG3HXxQ/+5cjPARutnzfTWffuRNXRPa/B+u7uDe++x9BAo1s1ycZ3dmR
	BrLR7i9ubwrrSCS/7kPs0QjNaV82ogz7YwZQRMs2xxg9rtg==
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938345e9.1.1789491048790;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938035e9.1.1789491048354;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83f43ed9sm1438985e9.0.2026.09.15.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:50:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:50:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqlo-DLHC39UlmgE@sgarzare-redhat>
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
X-Mimecast-MFC-PROC-ID: N2tStfP_CG9c3CjZI5kbC4vF2MfQqGIBWuUf5ISfyMg_1789491049
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

CCing Bobby (and I guess you're missing several maintainers in CC)

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

A changelog after --- or a reply to v1 to explain why sending a v2, 
would be nice to have.

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

Better to move this before calling __vsock_net_mode_string(), no?

That said, __vsock_net_mode_string() needs some cleanup IMO but I guess 
something for net-next.

Thanks,
Stefano

>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

