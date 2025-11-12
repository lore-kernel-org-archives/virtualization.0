Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5926F467
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946842; cv=none; b=RMOrnFsre8hURxFyT4wHEm9NAwASJxcEvCAzExNV4rwhFUtyE5gfP8zMtZjMSLfbhmoRXDg62By4KkuV0KfG+Waik8dzHcG+Gb37+hCKwR4nl3ZdDc76sbWBcSQROCkaAo/V52cth1Obm+y5DatWqpXEOVkv2gix5ZksYULh6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946842; c=relaxed/simple;
	bh=4GFpYouVGxOOz3psCxGWSSpIfASjL19wnjG0Y6Ssa1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kXlbrKUAw62U8mabe9fJMlkTzAh9h90rbjQyWmM6O/tV/RJATKOjbh0lpo9sm2eaUUWSi2FG3+2rGr/6XsdVVkm/sqcCynvkUHFbidq8zB5QtNZyzKV1e+cxvtQpO75inUW3qqticnZpujrZOr51w8CVFVXhA4irhFsMjsQ2lqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAs6Fmxc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAs6Fmxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
	b=JAs6FmxczLOe9kGN/JS3KoHxZ3f59VGcHRYA6KFvO1zDf9+CXkjL40/1ueaehjmsgjM5Dr
	owTCm20AhsBDT/XplV5jpoImydfWz8TLceQyoHthjnNgEOLu7FGrdeVuetNxPQuqtlHRtw
	BVQMByBgrLpDkLeslQ0q7hqCAX8TpVA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-CysvumrIMZySuRKzygTEDQ-1; Wed, 12 Nov 2025 06:27:19 -0500
X-MC-Unique: CysvumrIMZySuRKzygTEDQ-1
X-Mimecast-MFC-AGG-ID: CysvumrIMZySuRKzygTEDQ_1762946838
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b23a64f334so217023885a.2
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946838; x=1763551638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=XKalN3wZCjSsFEz8ScCHBVTGvNLXONByrGx+G3ZkCful2bFsY55baohohUMVFe2Nsj
         h+VahehpGQLNRY2rqT76l8PDECE0rUmnRClBA/pRjE6mmOtHaKQIzGiXvpwpipU83vIB
         +lBdfNLPkQt4vnLygtW0jUirWyXfVbh0Q6Xthh/x9rGAlbboYqKiNfD+o4N9e6tK/K7j
         4qsuJ7NfGctJJERfET3M7qaXNN5rSUQ7Phkj7xbXr+ImoBOqA1F9Z8ua76rj+Y5iEhkm
         A6YCYm3SADSLL0eXelejWQsFcqyG2x4q6TprB/FI7UPKHWR6YBNNNpGGkcwRK3gCvfka
         9nGA==
X-Forwarded-Encrypted: i=1; AJvYcCUhuWvMoc4l+bYI/eJAeOc/oq2TIzvnBaTS+pvjaJf8xPf70LHkfa41Jy+BXvKKLnlHzGPAhpQmjtLnxQadxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZz3ItpY0MCS60Hku7CT/H/GsUJpCZRNNkadcD4wRrddqIfyFh
	Z1TDjjxPM8fFRGY7RQVuKcgLsgtziuGPXUQ4LEB0CNguKVhHuarmY+TYI8dkdRWhoh3owDT6yKy
	59liDN+c7nCtXqKzbWEtvivRJnimoq3iPmJ+WcTw/5aRy3WTwFYmXFJFZecT4QqTM4Tue
X-Gm-Gg: ASbGncuHKQQV7bR4c/ciTzwwy5COAcp2iCATxkgRkb/1Z37ukxyq2ol1CxE6i/bLaLg
	LrIgW31a+d5voEzGVOiDak16dsw3Lnz4GRYTYYntWpxhRCjk3YLcfcnClYJ1XoKHvmF2MraJ02m
	IStmYSGm9NZ7IaOage3UgDl56TsePDpj19ta2E1xNZ1WSPfFJiX5tc/LLDaFgmg4znewECSLNoj
	9zcJqzSCz7IsJf2wEez3+ELOHHkPiwIM4HfZO/ONboCiPHhVdqfQ0DoMc+amwyw66WFkGFmTeoh
	meea7XTDpstDArEsc0NeU6suZf7fp0mW+cGN0Ip+T2Eq6utzLe6x+zXhSd1azNIlq8K2bzI7ZEB
	l5FkRQeRQ6QJV4HrCVeHqGnkB16zmz3+KFYysQrgSdekfzxMLRYI=
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301639685a.49.1762946838667;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiq2o9VPSKEA3WnYmptOCbMHYXZ1Xc1tiIgbtvh2JnbBd2gww/tn2z5FSFACTcc8Z6rSWeNw==
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301636985a.49.1762946838217;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84b075sm176497985a.7.2025.11.12.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:17 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <z2lxg6zlt5l3f2fhx6lwfeiu2tclm4o4et5wykraonyfjlayos@oatpvj3hk6om>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dxjYfOQsdPY06WL6asLTCtVKJ86GvOpEENMdosEj7v4_1762946838
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:59AM -0800, Bobby Eshleman wrote:
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
>Changes in v4:
>- fix botched rebase
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2dd9bbb8c4a9..a1c2969c44b6 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -461,7 +463,44 @@ test_vm_loopback() {
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
>+		check_result "$?" "${arg}"
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -537,23 +576,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(create_pidfile)"
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
>-	check_result "${rc}" "${arg}"
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile="$(create_pidfile)"
>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi

I was expecting something in case the VM couldn't be shared, but I think 
we'll add that later. It's fine for now.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>

