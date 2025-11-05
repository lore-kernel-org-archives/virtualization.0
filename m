Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C9324B1D
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359398; cv=none; b=L2Pd+Of0ftdMw4TfqSivB9ojk155MxpLIBKPDs0sB+f7WDXVX1htKnpGcVmM49sdBLcuWMxJBvyNResXN2IntwPA+PcB6Zd0ZyOLUoBr2JBxN/RSWkt/2w+ywjxZnJg400YKemzgcz/0JAN5hiv3PKX7TiCX4Wq2l+liQMhJSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359398; c=relaxed/simple;
	bh=Z7eZPun2oefAkSM3+F0++XPUVNTkIWBrwjzNYiRkZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qxB/TbCdRkPwdywLEpmLMMYO0BZGEapHUouq4lOvgjieTq/RJl4D4KoiEALyFwp079rL3OhumNnxOLMNsmBlgAcYxmcCbyl5D31uBkgsHSaaJU2gnb3NdOSImtu0SJEGZ4/Jv+/b3lhlA77cdMGNWjOuMr7/JpN1d2xOTAnjjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGiEhwta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGiEhwta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
	b=OGiEhwta/SVUOFStPYurh0GkafrhS9FdNMbzoBBcD36fi8J/NDiHHc6VRGdygkd4lwwAIG
	IZMk2gRtolOwliCV8JE/1zTBjLTnwzxo/Wr4thnG71tEHK0r0DqkGqL7myB8ZfEpYisJ9a
	zFR44943wJdmW0Q+GuEGro88qE0qXlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Ed82v2xyMEuWJ8eYTYuHag-1; Wed, 05 Nov 2025 11:16:34 -0500
X-MC-Unique: Ed82v2xyMEuWJ8eYTYuHag-1
X-Mimecast-MFC-AGG-ID: Ed82v2xyMEuWJ8eYTYuHag_1762359393
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477212937eeso47252875e9.2
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 08:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359393; x=1762964193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
        b=PDwq5ETfdGenOOAWv4UftKQKhY8mIpsc5mZOAm7UZf+URG3WmWCGVX0HSa5HFqY8da
         /ONgjo83ZMOrVtJ6HpkPRK89cJYnPS/aIfflE/isSa+AW61dm+QiX3uM1Ew5ABKfBMUF
         n3EIF2mlJBwVhD6HwGKr+fcx3SNLfbA7W9oPBBoenlFgsM2UBx4RiqGLnRleY+Z9JydX
         LxA0ASo3ZM9m0GkWhBd+mIsTuvaLWszyWs2TmWNJKW5qYnLM+JedG4bUG1fmAjdAS8zz
         +2Hu4Y1fB8rupHezL2+t65hOGjW57befclVqYMjVE1MeNSDsdyhAQBB/DHmqnsk1VdCj
         rWaw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZ4DB/RPRAkcjgoWi/Eu3jibAU7pUAf/30tPtH5dHdDSqf+ofRZgox1uMV2KNj0R/VWJs/6XwhBvMhRklDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUabKHKhaiW0o8VxC7TqZweYq9diXSC3OPErDTCQDPd/QuM/E+
	5n4buggCGI+YlhVykFRjGjou2iIswlRZnqWOZobHp80L1uWaUTCH1Mlc1Mtl4uhogpfys49Gqs3
	BLwQERZ5toCB0nQGH6JopBMIryz8UvXaZ1U1ktaStUu6zRadHXLyLB2cDkOHca94zp2B8
X-Gm-Gg: ASbGnct6u3OHROey+1HA0KVJt/q6zkt7wn3zrp8VDZcKocaE0llBsHbisW3JKjrZGBM
	Qp0UV43rrSeJzNiI8ggUwghTQ7OGqJU3C1MkvGtq38OKIqH+CFUNDzoxoEK1vpuIKUr+h4gy5Iu
	pxJZVEJTmh/19JKajsx4iagODc3/MFjEy6Z0RFeLHIdPrX2fT2EdXjLRvFGsHV9+Z00dHauDvv+
	On4lS8VpqHgD1hcDsZ0QNFdYjVhxF75dRHTYP2hofD7iT2hqeUrAi7F7G9P0JFR9pTkMKxLgKoe
	6bbc9FH2SzlDLxORKrQ3xJ1HsCwSnV3VVs/UzZGKsoEQ+iBRF2rNFh6BYqxhyjkY52jYFFvr+/0
	F89c=
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30986255e9.28.1762359392870;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1zaF9xjh7lShdpMKxs0x1j37UBOgMCZm7D8elWZkrx4hb3LonHqe/99De4jJ82rRpyZFkSA==
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30985775e9.28.1762359392381;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
Received: from sgarzare-redhat ([78.209.227.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5af7sm12313106f8f.28.2025.11.05.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:16:31 -0800 (PST)
Date: Wed, 5 Nov 2025 17:16:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Message-ID: <5dkiqiatpxuq3wnizyq25c4hmiztglefh5icdcxpkvmej775nn@qw4gmh2bheyf>
References: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NuO-pCtzo8FNv_NCoWR3XvZ4OUIV3Sw36cNHJKCb_PE_1762359393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 05, 2025 at 07:59:19AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Sometimes VMs will have some intermittent dmesg warnings that are
>unrelated to vsock. Change the dmesg parsing to filter on strings
>containing 'vsock' to avoid false positive failures that are unrelated
>to vsock. The downside is that it is possible for some vsock related
>warnings to not contain the substring 'vsock', so those will be missed.
>
>Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Previously was part of the series:
>https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>---
>Changes in v2:
>- use consistent quoting for vsock string
>- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
>---
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..8ceeb8a7894f 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -389,9 +389,9 @@ run_test() {
> 	local rc
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -403,7 +403,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>

