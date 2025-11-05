Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E63314CD
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353702; cv=none; b=WzQr+LcWNn4IK6Zm2h/J5msOJuMC1hHDhxl+ilcQD32qwra5PNRVXKIyuAfMegZOd17FsGTelwwIxuXXwX20t9IV6mVvpFPLecrv7ij/4csGrFHNoUahcWFVOkTiwOEq6uf5fdckjc8HyFE7m88G57lrDeN9aGu0w9rLlz61Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353702; c=relaxed/simple;
	bh=Un+S3Mc0QD8v6wfj3eL3xXYh+ndupS7pAvsfKuhFm4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RTO+gBOl3w+OdtjGKS7M3yvx5iX1fGKX9s7WvmGCkYGZSji2pxRy4P9/Et0ev23Sbkq5hJiLghLhprlgvd4k8O6QegY3ODW0tjtQa5apxGuIH7CdB8sqhRbFeXyPwp5TsBlFtCBIp/txYOXm6yzztst8CmB2p89LJUah0f1Wxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkPefxPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkPefxPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
	b=FkPefxPo1R3VY9Nr+VH69Xgp/pOzVQHgdF/xFpeyqQFDDI+III0k71FTVChB7nSjOgI+ZU
	peSZJ3fBUvb6+UFg4WKK4lSMeXISVTvSzj2lC8mf38wRDUtJkxmYlMLIARXWcieUUjPmrc
	pHOFvYYk7Aicm13nd6vMTLRzEZ6LlEA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-ppfLuz2uOgay-YJg4lAbxA-1; Wed, 05 Nov 2025 09:41:38 -0500
X-MC-Unique: ppfLuz2uOgay-YJg4lAbxA-1
X-Mimecast-MFC-AGG-ID: ppfLuz2uOgay-YJg4lAbxA_1762353696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4298da9fc21so3538207f8f.1
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353696; x=1762958496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
        b=lIeIFom580tlnSZKdbP3GUIOn23VxCqHkuvHbhIhm1o5rVof0yTqDCGzLljNVDRN2u
         5qhsMwenWNwXdS8G2iTnsQu5aye9OzeYiG+Hev9oQC3TuZ342oeXR96zYp/+G0CGt9LP
         W/HTzTnwD9bsd5e020IlVUHp7qL8Dr8OmCbx6vlprJC1A7DCQu/BhKcoefPmpMdEQKSJ
         du7SPNlDePpWen7dwIdzuoB3H+g7jjGUvoQr67km6h4Mt0iT6TfbBl/+orfEsAr1sble
         x70FNBexUiKlKcQLccaLsuFirLqXnKGJnYWH863qis7h4UB0RQ6Djrp7PXbqPJx42OFN
         h07g==
X-Forwarded-Encrypted: i=1; AJvYcCV6U4GZsJtUGUz1lB/VVt25dkw660vBnBxOG3lJpgegcXiFSO6PfeCSz5XsrV1syFwKZ7nlS/kwORWMOrKMKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdxY8WD8aLXVZtn2VwFgZkGEBcCZnnRBcs/H/w2JC3SyhsoQHI
	u/J+9LlET18bZdDe43+hGpdAnQt1z3AQpm/eNbt1145B5RopiOoLQ7Ioea05D7OFCsQqJMZz61y
	Dlh/fHuh+B/SHsFcqILSixycptfh4llrHcqIKI3jsB6U+4UPILuh/q6Q+MwrbND/Gd38H
X-Gm-Gg: ASbGncuc3ZCYG1BNB0MgBGdrwZ0TFF+lWO9tzFjLa0/XuEZPovCw7a9meK2EUg7Dvb6
	+S67yTVOopkaFKO5bXYkNxuoDOGZlyDzJQACWTQd0FfVhIBTtjS2HIUeIUIgiUgFsuKJcl2lhL8
	RUAOiVoYKoO4ZEENF7y0KW60DAyVby9KlJV8ZeVhFkfThsnN1TvheFcL0HvCQQ7VnZxb8VcR3N9
	X7L+nVrm818Rt+Ckz1k9TTKU4MoZSeUtnM3c5Ka396cVUWC70PeGKgRUpzaY7uJ/XYn/8TmDp70
	Iw5p07l8tmZFPxFGh7hmO9gikhr3wC5tSqR2Wllk7RnAq+JdCHaT2iEo6XM4ixjX0zkRhgbA0vY
	=
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305577f8f.3.1762353696181;
        Wed, 05 Nov 2025 06:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdNjVd77s4VsvkrZ4AU/ubU7KMUlzm/N0GSTkO1qZtkX4KqpOh8zmlKt0hs1ExVKOK4eMg2Q==
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305546f8f.3.1762353695682;
        Wed, 05 Nov 2025 06:41:35 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12058326f8f.3.2025.11.05.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:41:34 -0800 (PST)
Date: Wed, 5 Nov 2025 15:41:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <fodit6zue6iwtqgk54qy6fvmegklnsgh5437h6ofopzhc77i4q@u76zkisp4wie>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kh7wiMwj5fbwd-x0naWfVXFXKbxNO_sYjYc8FJQXJE0_1762353696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:38:57PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 940e1260de28..4ce93cef32e9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -78,6 +78,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc num
>+
>+	rc=$1
>+	num=$(( cnt_total + 1 ))

Can we just increment `cnt_total` here and avoid `num` at all?

>+
>+	if [[ ${rc} -eq $KSFT_PASS ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${num} ${arg}"

Where `${arg}` is assigned?

>+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${num} ${arg} # SKIP"
>+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${num} ${arg} # exit=$rc"
>+	fi
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} 
> 	localhost "$@"
> 	return $?
>@@ -510,17 +530,7 @@ cnt_total=0
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
>+	check_result ${rc}

Oh, so the arg is in this scope. mmm, can we pass it as parameter?

Stefano

> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>

