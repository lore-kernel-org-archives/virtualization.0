Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F93009D2
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946702; cv=none; b=tM8Nx6ZjmvDSUD1sP8LGxEf0VonY3jCmOibBAadp8MTyb6Xxq4zLADoXOjtk2Ty1kG8Jt2c7e/hGbv9a3waVwxOaCCRSEXVv1aAQFCHj/InD+Zl0WI4OGHhX//F6b2VnWixzH7IPOmBtI1Y3fjEvqdPZqhQdDzQCo1XKuILdVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946702; c=relaxed/simple;
	bh=7Pu0o2x/O51dsOpfT3kiDBb6OdNE43A6rRDatL6h080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tNkGuGJXu+x5App1b7sriS9EIjOyNh04b61tujDRAF9csX1ebRDTLPyoCf9UFuYCeK6WLKdt9cQARbH75bccQsoGX03Ld4hk1brgz0LAZbySeSuRNdOy4vaZYge8v1J3Lj1dTqXaMk4ikedlIBUxKNa4J6s3vaANCjoJEwyFM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic1Pjo9L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic1Pjo9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
	b=ic1Pjo9L3JFoaJs8/10KGQpDqw/H8OewVv93cdueooWGMuvqJ60VZyNFjXMVr8bnQqisPk
	y4o6dsyj/GAHObhbJJ3QzK9M341X0zq6KR7a6skhk86hCITho5I9g9MR6t/5eo1nq4t63D
	xOi6rFnGuRdsife97CbxxIAMxuTpMqo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-h2-5hiE6ObejnPyko6sJuA-1; Wed, 12 Nov 2025 06:24:59 -0500
X-MC-Unique: h2-5hiE6ObejnPyko6sJuA-1
X-Mimecast-MFC-AGG-ID: h2-5hiE6ObejnPyko6sJuA_1762946698
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-882485f2984so15221146d6.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946698; x=1763551498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=kxZBTcqCK7Nzmz7EqphN4wQ+jcgbYoDbVGoyCpdilgALLUx9Vzjr+5DFfJmVrwwUwm
         tl2pRv0a3A49gaRSr4YOnrA1S8hlkOP/6jm9veDv6Y5+9cC3OWCL1DSFc4IAlKyefAfX
         031T9ygLlYfJlo+WEu9ohal19412rp4Ske56Sdkhx+9nQAyMEVYVYn/BTmxndhf2StJU
         bM8z9J/YWElRmwJVixAduzFjLC94yaXZT3WIy0fgMUltfXaLRAp6KAPDcSE9JzgSWO4y
         OIk1hrjIWns+RJa5JvQzXxDLFoyV6YBC/zZzP+P/xrr/16dpwdx2uHfu8K1W4q5hEjna
         T5wA==
X-Forwarded-Encrypted: i=1; AJvYcCWafytxEUXP4k4/sefQgm9BI6oEGzF2ngwjDpRO0KNIYmZrKcfkjsIeLRstncTcm4wFgMtrL3xsgKyfyWI9bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm8F94Qrvusc4KnfOI8WTKT8MUcfffnXWoIlx+eW6UMVU+oFcl
	9lYGGC5UUgJa2LpK2pns2LOVBvxwQwZsD6mQWx3Wt5iQ0mb5s5S3iHjIe8QhxCwtEN57GzcKWNY
	uGsCMAgK8RTkIuEGeXckbpJxgrPHktUJh80ThSbcXhN74pU1qlIGMNJvFvvU23etsTJqT
X-Gm-Gg: ASbGnct0Rc+5PBNVKy0/qt28GUGKRivrd/XWRkA1GHx+pkCk1y/5lPo/ic/2XIFMonq
	TXNa0ePeluhar9WBX+kqXW/9uOO0lLFDDl8VKM/uWGQ9K0isGzVE2E1UsfoCl7mCffW58VpTRKN
	huppQyzVTR2orU59HXL9cqc5fr2KBFWfzlofNIe5oC99Hka0PlJFMfF18pC8g8yVKwOuCdEGYNA
	clE1kbdFRDEmTLM+o/4zNAKviXTkQ2xSgsGvLmHz7sibh+CPqX4EMVb6FDarXPu4LC9A97rLAgI
	oHIyytVycFIOjxgJew250GtD13HaOYSMJtpTw/bU88Th1eT4hIp2QOjqtlSNMkhXJ95WLHR3GCM
	rAXkS/SGG6cBLGIdX8QwxvDLDSqx2LcrR6IOSHpJwZLLLZ7e25KM=
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868276d6.53.1762946698660;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg23TSNoDmt+ZtfObVKbv3IEADZ/iTaXYGqZ7/Rp75tiUGAUlZRDyDCgloNS0C23doS3gbzg==
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868006d6.53.1762946698263;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm90041186d6.53.2025.11.12.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:57 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <2ujds4l5ji7pdm7lczttukisjdoo5z5ufufw4kd3qyls26o64o@43yt3nkohsm6>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JqslPpmo3X4RHwxCj8QnUXbGLxnDfkTs6iePp7x3AkA_1762946698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:58AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add check_result() function to reuse logic for incrementing the
>pass/fail counters. This function will get used by different callers as
>we add different types of tests in future patches (namely, namespace and
>non-namespace tests will be called at different places, and re-use this
>function).
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- fix botched rebase
>- use more consistent ${VAR} style
>
>Changes in v3:
>- increment cnt_total directly (no intermediary var) (Stefano)
>- pass arg to check_result() from caller, dont incidentally rely on
>  global (Stefano)
>- use new create_pidfile() introduce in v3 of earlier patch
>- continue with more disciplined variable quoting style
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bd231467c66b..2dd9bbb8c4a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -79,6 +79,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc arg
>+
>+	rc=$1
>+	arg=$2
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+
>+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${cnt_total} ${arg}"
>+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${cnt_total} ${arg} # SKIP"
>+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
>+	fi
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -530,17 +550,7 @@ cnt_total=0
> for arg in "${ARGS[@]}"; do
> 	run_test "${arg}"
> 	rc=$?
>-	if [[ ${rc} -eq $KSFT_PASS ]]; then
>-		cnt_pass=$(( cnt_pass + 1 ))
>-		echo "ok ${cnt_total} ${arg}"
>-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>-		cnt_skip=$(( cnt_skip + 1 ))
>-		echo "ok ${cnt_total} ${arg} # SKIP"
>-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>-		cnt_fail=$(( cnt_fail + 1 ))
>-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>-	fi
>-	cnt_total=$(( cnt_total + 1 ))
>+	check_result "${rc}" "${arg}"
> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>

