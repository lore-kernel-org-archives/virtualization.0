Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A123EA92
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354148; cv=none; b=WHHutptEczH8dI4xsDHxP+Bw4Q2vLJCQNe3Mlzu3WZLeRkeTDyJm2P8aZlr4Wy1YzXq/8QvPK0NPyIYt9mtkjataORw7F6MshzOK4pmERpa51rS9v2BpbL7t7va5nH03+uWXsqNt7DFtO0xHVi0iAWxLWYPCIBPPX4z34z65XnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354148; c=relaxed/simple;
	bh=YfvMW72encoRkud0wVtm/A7j2WUacp04L3fsNBayHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XxP2rn6bDO0qab6TFRHO/V4vvxrexnBPMGqficuAImjafBeDW+DqC+q+abFyVM+ONXo+3C2PBOynDrlehrmRKL6JbQyMwowjDSJVu+s8JzqnZrS1Zr2fWDTL5zv0umzK8vOK+z6qzwRxyzdoWO8XH8/F0EmJuJQVxwVP/ivYnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXj03Umm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXj03Umm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
	b=KXj03Umm5zqC78KHtiI0lrsWdn1xNo2qS0DrCilMNvvmF6ZwBQzN8DzzIJbMkVC6pXGkiy
	d0GYO8T2HoCh4nvWFcgWJ1pNZZ5JsG4iKvVT/OuHwM0h7VRj+BVxZHzYejhkcCt+POyNVQ
	9ZAj5GcpKgBE0zZXy9zQrbrpKnFcpgQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-VgPYCn0cN8-RVE776I5P3A-1; Wed, 05 Nov 2025 09:49:04 -0500
X-MC-Unique: VgPYCn0cN8-RVE776I5P3A-1
X-Mimecast-MFC-AGG-ID: VgPYCn0cN8-RVE776I5P3A_1762354143
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4773e108333so31193315e9.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354143; x=1762958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=wf36P+DWHiYtMQ0Er4ayupLgMpNVWpYugBOwV8CMPR5h0N3/Tm9bnJ1tEuDFuSS4NQ
         gDhlGvh/a+2EUoWtjejUOmxsEAsQU7hfb1jZehj0qllEDtwj+F1ewuS28VeA54fc4rz+
         M1DuNYgbeMR7fXG2gKBshjyr07sTS2fzfsx3AKWs0nRjEGWI1Q1zvaZpUeY5F/8S+fly
         B41jFhDLp2zjhLtfH2wtH9XFeUFrMod1ftyuNXqpkL0G3JlwqiNPLOX0P/lKGpzl5Ix/
         hbTTh5AxRbbcS2U02+vSNEq4RtkbQzkx722Cpk5QxR8X6CwPqFYoAwkTZ1pRZkDSEG1l
         +ROg==
X-Forwarded-Encrypted: i=1; AJvYcCWmeN5qnb13PxKAbJamy5Zmk7rNoKwS40+z6UCLFbRqYtaSIa7+bXj6gAxE2EAahxUKHrHBDHEKfh25C7OJLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgKD9PA3b3Of2zPfbAVRbSn9zUXvncl7riELXG1y8xyVzMX9lG
	EgEkg/64WLbTKVlA1YV/sLjL1n3XLzAN+LhlCcCmnRh0odu6PTrdLFyYizH97t2UFnRefyRnonz
	B4G5aP6NcKEfPyEEAoFQqUG1hTpq6ahwNJnX12AM0GfnvVYqcO8Ijp3xmomJ+ZOpdpmb4
X-Gm-Gg: ASbGncv3KURS4pHoC+mz5BuVB9OezooCScPitfL1QSLJC/TmiuOid29mDzn736XDn9X
	jy3ufXBc76FaQVj7tPD6d2Swmf4+6Jcv/4wQW7v/pvcv16rJY8YrJ6TTpCao0s7yFyzk5kqpa1X
	I8geThLyFhhuqy294fLI7rlo48dtxTFKzB0MDNEhhUS4RYKGMhA/baminxl4dlreIY4UxwzUK8u
	9YfX7h1dmjmafiBeulw/OJEfN8MlT5iH41vnZGELE9DUqWGZzmz6zMGHitTSR5GvGbW3cFhNOXT
	Te9c3u5cmQ38uNUGYN2paCGNIeYd2496+UFeA0nrLpuisUrIJ5kU6Jj/bIgvKAZDyro5TfT47Qk
	=
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953945e9.6.1762354143247;
        Wed, 05 Nov 2025 06:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJCkXVCaYKB38WQ9mVlW2atyii43mXLtD2rPfe/M0bgqyi++PixdCT104cVwdbGCHZnaBsew==
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953665e9.6.1762354142802;
        Wed, 05 Nov 2025 06:49:02 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm10751085f8f.9.2025.11.05.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:49:01 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Message-ID: <ubfxj7koxuztrlrydfpjxenu7sdydq45rnhxkpmuurjfqvyh4j@mwzsqsioqzs5>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -H8XFwPPBDf18Nbb9jGUjE9NasdXTB_gNzGZPEu7EbU_1762354143
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:39:01PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add vsock_loopback module loading to the loopback test so that vmtest.sh
>can be used for kernels built with loopback as a module.
>
>This is not technically a fix as kselftest expects loopback to be
>built-in already (defined in selftests/vsock/config). This is useful
>only for using vmtest.sh outside of kselftest.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 0657973b5067..cfb6b589bcba 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -434,6 +434,8 @@ test_vm_client_host_server() {
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
>+
> 	if ! vm_vsock_test "server" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-- 
>2.47.3
>

