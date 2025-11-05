Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594E22156A
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353919; cv=none; b=fkidNonSlsMBMqT1Gn4xZT2WJ8C3pa3LLBSHoBUF5YD45sr0/g/cQFdmBJhNty5ZQbBIibc7kKjh7faCPDMJH+6X3MLKEFfHwsPb3hCh4A/pNJO9PtEx9cwmsIVN7izWHx0E3ngz3t2NBxCoBYAyXis9w/Dv7btD7v4DW/EDEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353919; c=relaxed/simple;
	bh=P/3UCIyRDs5TY+J7sM5xjumdLDz5BUHqvdnv6ttKM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GKQDAzgmsYMR/1PDgXNzGCE6uZNq3l9As++95/iFeCbIOyCWMy0wEkwiZoUqrPvqR8tmN5LIAMQYN/x1sbuS2NtFcO0Q7tY4f6fEwui0FlXFXM7evx99B3Sxi3iLgkFlTcYfwufOLHJcoO8VfUGII5AkAkeeXEXgeoOaxzy/4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACDT4d4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACDT4d4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
	b=ACDT4d4ledwf0ZxxYQhngA8gWQ2voafg99rhm0Qp/j+jsRHW4j8/F6R82d1VNa7Bi8TvDe
	e6N2uxondiroZAspLplGm4VXQ01oRv4ATWdKOPcgFYoKNEN4G+92+krp62BzkIhs5P4WHQ
	HDqR2tuwt+QLHowQAH4o6Ob22FAccU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-xOL5MQ0lObqGsyOqNtD5UA-1; Wed, 05 Nov 2025 09:45:14 -0500
X-MC-Unique: xOL5MQ0lObqGsyOqNtD5UA-1
X-Mimecast-MFC-AGG-ID: xOL5MQ0lObqGsyOqNtD5UA_1762353913
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso756586f8f.1
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353913; x=1762958713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
        b=FPH7r1i7ytc9Hp4MlaqG+TsXgorZkpFAvRkRkhUjZqw5T8q9zzQ3eyp4Z6Ln8pV0gD
         8B+a+oS8yt0xkIg6fGOYbDdhNSkyXDfXkf+shQANh5d41QcOrNOIqWnRvhOIZgRHkqnv
         G2gjk1RsSX8zfD7J7+GbDrfzPBJJjiYKgRqvKtBDhNVb7sAFcy1cRVpIgEyIvbqxe0eC
         4dEzVbuJwv0TfbKZv3YYzxM0QFdgei2iLvXLKwp2CJftz6G9cr9S6/0NAwVwQLyghTQb
         wnKmxq2eB/EFf/HurzqIKX/2i/pqii+MSfaRw/c/btLhKmKiVILXSFXT6zuq+XWVERNe
         NalQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbCWSjjrevJ2zHRkrydFzKUtDWWoGtXlPLJVAURcohGeN4aRQgr1WgbV1N/K98agW6o29r7//m2EccrB7LmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9WsXODNPKx9O25u7i4/ipzYWbiwoe2pw7lIpIRQy7aZq0fOmH
	BYTryts4RxTfwbcSR9IQPikFpEk14uhu+Wb9v0IOTFmEtbwMTwcM8kpG7ZFR6gIkRRYBJzTkqZH
	50hoKWRIhtIP5YFjG8Udqlot1xrw9a1YFdTL7KY719RDMtxrHKhD6ZOAVo2vBp1LMcVVH
X-Gm-Gg: ASbGnctszQyKMFIrumRKJucMB6YsFI5SmI2YfND1r9sC95PCtQp1Pp6Tob74U1hn3ZM
	QwMMuQkdIMVCWH243GflwdFK/4swKQgDmgk9HJP5xazrm6Ew1V15NBELZAQSru/2KPu75aiaLky
	rxHVcwZG77Cev97K3UnoJOn5WcKzyBlmv8Io4EvshfFZ3icqgcQhHMXQJXtQRt0Ac0iXPIjAAwl
	M7aRP6Ta/gUVYHtBJ6JVW9eRVVaXOczqKaCBctGXwpyI1gTga3KBRwCT45uA0uYwrWYOtYioZiC
	Sb6c2K8J/gjOt5xQiLnuxVtfEsckAzhzOyAH6fdGmhZIbStr9gIq93d0aZP699LNdRz15AO6y9E
	=
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660622f8f.2.1762353912862;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5LAfcIKI+UGb+/zhR4tf/kpuE1QbENGNGMuBGWjUYd5tgElIuXzgUwRSVpo80Ale29EF9cg==
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660597f8f.2.1762353912389;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbd1csm10956989f8f.38.2025.11.05.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:45:09 -0800 (PST)
Date: Wed, 5 Nov 2025 15:45:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <ohe42glr4yn26ql5fdvrwrhawfqo2vy72i4zofjqwyqba7wwdj@5usmy5fczxhe>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X6hbSNXNKt6o8-Gh6h0QAm428jjvKIc5O8RY8KlucSI_1762353913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:38:58PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>In preparation for future patches that introduce tests that cannot
>re-use the same VM, add functions to identify those that *can* re-use a
>VM.
>
>By continuing to re-use the same VM for these tests we can save time by
>avoiding the delay of booting a VM for every test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 4ce93cef32e9..678c19e089a2 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -443,7 +445,44 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>-run_test() {
>+shared_vm_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_SHARED_VM[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+shared_vm_tests_requested() {
>+	for arg in "$@"; do
>+		if shared_vm_test "${arg}"; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+run_shared_vm_tests() {
>+	local arg
>+
>+	for arg in "$@"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		run_shared_vm_test "${arg}"
>+		check_result $?
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -517,23 +556,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"

Why here we used `mktemp -u` ...

>-vm_start "${pidfile}"
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
> cnt_pass=0
> cnt_fail=0
> cnt_skip=0
> cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	check_result ${rc}
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile=$(mktemp $PIDFILE_TEMPLATE)

... and here we are removing `-u` ?

If we don't need the dry-run, I'd suggest to remove it also from the
patch that introduced it in this series.

Also, maybe we need to quote $PIDFILE_TEMPLATE


Stefano

>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi
>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>

