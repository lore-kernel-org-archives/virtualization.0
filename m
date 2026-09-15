Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9194B5CAE
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491458; cv=none; b=tW5HF6Zuqew9Rrl4XttvqpKbNqWKe/WtL7jHI9S06EIJUNQZAdhJw3hLibXGSR+joNrDps2ELLSzkE3o0mpFdYQocRenDFptVmWsBe2Wn+r5trGr24DMFL828cipSdHCnrdjG1EbSHvPzfliQq6E7HFk1wNY43j8hM12TW53kOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491458; c=relaxed/simple;
	bh=UGQOSKqIrs/SiqDtxOFHpCo7Bu74vgweEvsNVqBBjrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rj4rHf860k3Re7YxEoXV9zLguIl6l+NrxuKpCixnZkjI03h3b4Op0x+qNmeND8Cgt8yx5vPJmBBnfxsntUheZB0n3Q+2MQDU9FwdVSl5enxEW0ukVNF542Vb9rjM8gJg264zjmG7Pfq9gxkfJC4H2RTKvMQ6mYulOoHoc9CmhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FG/ABdZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FG/ABdZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789491447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVwyrtqiseLR+Flggta8C18yP1zmqacQADadqELow/g=;
	b=FG/ABdZ0UaqeD3ar0o9B16DYSUe/6H1nVrCTMrZrnFjDvxGDego189byOkHlFEPuWrXzFf
	VxCvVs424gMIXWnvxGZ+Lj0r29MmES+ikEEiSE0FRjMQ2y+Ya/aSvjpDtA1pRlOwOHRZX8
	GuIliePpP4lUh0Rjb15ioHjMVVFaTRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-MPiQFFA2OgmF2-q5_FLaGA-1; Tue, 15 Sep 2026 12:57:24 -0400
X-MC-Unique: MPiQFFA2OgmF2-q5_FLaGA-1
X-Mimecast-MFC-AGG-ID: MPiQFFA2OgmF2-q5_FLaGA_1789491442
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso24655175e9.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491442; x=1790096242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVwyrtqiseLR+Flggta8C18yP1zmqacQADadqELow/g=;
        b=J3PrIVnMSxMA4ONPPPqBVLzPMbOJmknIZqnx8POgxSvxMB5ksL04SgOlrvjW4AcWKK
         W6BshXLXenfjetOOxQ3nBljuC+xWQXLOXeOD/kyWIVlQFmSse5PeRAiANSKMOPX4x28h
         +FB9XC65k0n7GVySLgB0F6CyelRiOKoxDva5nWs4h4IZ3EdNb22OUpSB4XOrxwOVPn54
         RbFg/KirnIzS9jw+k31zetKRIOCNUN8rlPHdw5/NoLv9hDNB3oEAK2VPZEPBCD6hNEs0
         DS+JW3lBL0/k3JQtnvGJnhdnlTjfi1JU4r57xfNZgrA6gAcnaul+yd1Z8nXQqPr64K5+
         sT5g==
X-Forwarded-Encrypted: i=1; AKwUvByoYJbVCFDjhNzzF2G0q7XnOHi72yv9371QREZ80g5m432eqYFq+Y2sooCaBZzpOKD7nEn48p1MLU8iSEfpuw==@lists.linux.dev
X-Gm-Message-State: AFuF++lt9EIICAD4GuvScYIEdz+pqe/thiI+jjPQu+jwueKFFlp2ozcz
	PQ9E/FFr9m15nImQSVGui8xGPW5OVCu51zC679jyGsFeC5bUnlzNnPeMUMqcWZ4hzG6eIHE+R9N
	t/XkmQja2OpMM3TC2IvBu1pLMuM/mulHM2iCed5/NMJYS2VYfNTXwUr+P9dDo+QF2xNb0Xjc+Lj
	57
X-Gm-Gg: AYBFou1A7iksv8z6f6pJVw49YPPkq1R/0TMdpIU+hyYLn4Jjiqc4iWsEy0v0h/g87YX
	vOUrPIa36V/8aNg8sEejhLH9YMZqmWjxXtZREPTeu8D0m+ln+SL7D9L5APompdla8C0quViA3nN
	ISi8PpEcz5DDaReMX8gDHMyOuTwBTizx3O+jUG83iJ521U8XndkJnOp6GMp7/3E7Tz/dAycPJyP
	qmRJXJE9WMPVUKe4xt5db4tNU8VWpJ9jQ9rP8acg4C2VFe8w1g+geSY/v6JtBtpQGIfyMUATQDT
	8fpe2WAh39rFI1umcoFoQaLGRkdhxWnKRS/Cg1R9sm5pDN9W6M1i6+mMxQY/R9ib2b92jpAXlwQ
	0feVqzx6iVHFwKWDlD+brffHhe6n2ACU9neyqdBdAheJAzg==
X-Received: by 2002:a05:600c:4e47:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49e7a677cdbmr79242485e9.25.1789491441608;
        Tue, 15 Sep 2026 09:57:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49e7a677cdbmr79242155e9.25.1789491441110;
        Tue, 15 Sep 2026 09:57:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d9fae9sm3560385e9.6.2026.09.15.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:57:20 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:57:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aql3oxZkJIMT46hS@sgarzare-redhat>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <aqli0Mq_jv28h7eW@leonardi-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqli0Mq_jv28h7eW@leonardi-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0GNu-TWE1ZoxKVbcs6C9hMf35bj96C0kfwFvLmpHYxs_1789491442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 06:32:59PM +0200, Luigi Leonardi wrote:
>Hi Aldo,
>
>On Tue, Sep 15, 2026 at 11:15:47AM -0300, Aldo Ariel Panzardo wrote:
>>__vsock_net_mode_string() returns success without updating new_mode when
>>the transfer length is zero. Its caller then reads the uninitialized enum
>>and may permanently store a stack-derived value in the write-once child
>>mode.
>>
>>Return before inspecting or storing new_mode when no bytes were
>>transferred. This also prevents an empty write from locking the current
>>mode.
>>
>>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>>---
>>net/vmw_vsock/af_vsock.c | 2 ++
>>1 file changed, 2 insertions(+)
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 622dbd0467..816d25b314 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>>				      vsock_net_child_mode(net), &new_mode);
>>	if (ret)
>>		return ret;
>>+	if (!*lenp)
>>+		return 0;
>>
>>	if (write) {
>>		/* Prevent a "local" namespace from escalating to "global",
>>-- 
>>2.43.0
>>
>
>Code LGTM.
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>
>To reproduce it, I suppose we need a kernel that does not come with
>`CONFIG_INIT_STACK_ALL_ZERO` set.
>
>@Stefano do you think it's worth adding a test for this case?

Not a strong opinion on this on my side.

Thanks,
Stefano

>
>Just out of curiosity, how did you find this bug?
>
>Thanks,
>Luigi
>

