Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498B302CB6
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341449; cv=none; b=WlIY7VVdIjk44wjrMWwTFCSpywXmMIYDKscqhpyZz32Rb3ewZNk/ZXXhmMqL6unX4k2OLTutBPfSRyE9vV+b+x/ZwcAw+pNxjBVz8walHfc/3P5ATz5TLEYiLnq58ifn+e+RrvW2UWsRJ9nTyrBgpLQv2ugYySmpTKmU1eZivkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341449; c=relaxed/simple;
	bh=EIruf+q68s7Apk3JnbRaT8nDbQ4uqSCgVg4dKHFgp3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kt+yA+ErNvDH5Xt/6+n4GilSnPA+0PDkaiyMUK0//5EJxnRRC50i1QCSZOohWq5z0sVfEtAtui+c54yG6rb0ltF2HO4AZRTMZG/Ve7ZAzJThWYbyA1kvjwwSEIcolYS521kEACWDucuys0rCyHOZ2r8q1nDB3D686WkADWeay2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcvEiSmm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcvEiSmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762341446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
	b=BcvEiSmm3eNSzA1gQGm3+AyWvLhzGjG8y5ZJrNm0kD8NcFDmpKTn8bWiv0mbPR3gNtfX6v
	xFqaqyblKnk/1JptWw/VMnXaDPp7gNmMipqqLQHwH9DiDrBSEDnBHuaxA84+3A0K4u5PUa
	6DY8kBR6l/jaJuLXvWybvbEtr/EnTXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-hFFpQOabPAysTAakGM-QFw-1; Wed, 05 Nov 2025 06:17:25 -0500
X-MC-Unique: hFFpQOabPAysTAakGM-QFw-1
X-Mimecast-MFC-AGG-ID: hFFpQOabPAysTAakGM-QFw_1762341444
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so5111455e9.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 03:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341444; x=1762946244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
        b=NmtcTJExWtclmByYCoQNo0EhllB4EFbPAW55Hnm2QyQ1W4pV3LSD3IEvuey5PP5qgY
         GNU/unl40Q5J4ku8hVXu73EpPqVx5IoEC1tNgrLydIk/gRKHJEEz5OuVDQRU557fUSWA
         YxpwW8O/732MX98996BjhPRM+AINo637bX4uzGsMgmLt/wJRihM+RkmD544Ma+yY69WX
         EtoLx/T9/CDeOkhkifXRy2Cyv29NGsyvR7lwP6XLyVeuQTTl0n1KRXxbUgQk0IKPSFsK
         5S0MKw4+Qi16ufJYR6CL2h39G0aoNM5em7jgJMKSs4y8KLNI82N5Gag35SK9koWqCa4f
         pCxg==
X-Forwarded-Encrypted: i=1; AJvYcCUSNU/T1uLqDCsXIN/k1299ssViBu9+HYv+ZL/jwVpyKibrOZ+28bzNa7sgbGP+iVksqkaX+MLd9M99vulFVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRNdqblkxnpopHO1MDXr8S3kIhZTkB0OdHVrqECZRXlNgcCoFA
	IJpK0EwE1BtYKgEChWJSMlsm5IKSOrxw8x4N4F9kTruV7C6+hcd9E/h/6xibwauDM3rI2ZwPJbg
	uZtEg5OJaa5HNg+M6D1TQVj0d9gkbuXA1IHBCe27jL9dPoo8wydOeBbP+1I1g93SbIWEh
X-Gm-Gg: ASbGncv5fN9VB7TE8NeaxX7WX6zdYJKb0Y2aD9u4gZLpdkYWHPTLDtGDrEQ1uipkLkP
	fbxmF2aShHcc/nsfzBhdZh8a1YV7UqCq9ROtuRpY2PxfPY64MrRZsP7pzv/b/l8r0yaJpJF4kGf
	ip0ftYRsxskxNpHIXkGDAaWOcIkWZIRO8/Q/kJ+gToflmDSVdotUGe75+8L70E9e3siRoczoR1c
	d46sIauELGEsJGMeqWIUj+dd/nm0Y2fggNejFSbYFezxx4QjYPkfI2PmBf3SNJ7ABlXSXzcj4xl
	rW+qYdEJLS5rvW1z3Bx83BfyUae3jPnldQcLGLW6MvtS/RTSGqMbcwLx5JSd6CKRc7YShnLK6DT
	5Nypi
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35419355e9.35.1762341444083;
        Wed, 05 Nov 2025 03:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNzHvCUGAag3+wrnkfdKLHqAtmgiZqn0Kpfqlpb4QSMfUNSwUxHezyd0VrzCOLaf/mXC1/LA==
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35418935e9.35.1762341443637;
        Wed, 05 Nov 2025 03:17:23 -0800 (PST)
Received: from sgarzare-redhat ([78.211.197.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm42323005e9.5.2025.11.05.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:17:22 -0800 (PST)
Date: Wed, 5 Nov 2025 12:16:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dw7Lq5sH3zzRuXgIlZ60g9_7plZjy6XPW68o_CW3YZw_1762341444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..e1732f236d14 100755
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
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)

In the previous hunk we quoted 'vsock', but here and in the next we did
not. Can we be consistent at least in the same patch ?

The rest LGTM.

Stefano

> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>

