Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4D3B3BE3
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812010; cv=none; b=ZRT3Lqn7Avne9h64t0OLjLh0Ar7/MU7Gh/noU9IgoNzNt4fJ26dGwsM6gOagyfzOLVijpME/EDyr5ekAhW++8cD9x0kOEM65E5ONFXw9D+TaqRoi4IWmjnPSmphsObVv9GyL6CuB/8qYRyJ0AuJLk9a5iTVHGUVRF8/LkQSag/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812010; c=relaxed/simple;
	bh=mkRB3+rS1m3805s8GQTj2HfkmQ2P2SWXAkPM7ASB7ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaUiLRIMWgobECBM9Ia3tcFLdfSEuzO/0lA0EM7gAuchnUgcr8tmc6xouboMoVcyDW/rGykWdzCdI9mhLEmLLUdd/z8xVzjcPSVvHSPFhb3hXZz20U8worHhLTtX9kHX50ziocPWMQpaZtT0IdpOWqHQWpWJ3ojL733LHGlxMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBK7lFu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBK7lFu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775812007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
	b=LBK7lFu2hAYD57dNrwiXfUCR91vVRYRAPCXLRLb+/lH+0TbCCEVnflGewXfjrGpkyA3tEB
	FIbmT++PY6WA1jleKSZ93V59/izmch5hfN+xwelf3v5NVO31mzYejU4dlUJOj2JJQZNllC
	BxibLHqM0lUNkpGRzYxyz4r4yofau14=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Tl3WvoCdPOCXRI8a4Sj2EA-1; Fri, 10 Apr 2026 05:06:46 -0400
X-MC-Unique: Tl3WvoCdPOCXRI8a4Sj2EA-1
X-Mimecast-MFC-AGG-ID: Tl3WvoCdPOCXRI8a4Sj2EA_1775812005
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2471321dcso44437355ad.1
        for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 02:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775812005; x=1776416805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
        b=k0i8Y6t9I5m0XC6QzxYXZhmemFdfH1otxNVIDmvY4C9h4aqy5LJySrH6X6AFbqEFH+
         dyJib0UxrQI69fDVal4ER8GL4T9W1TDMSgV97K30a8gG2qW3lR03xB4gZkoUfSRDjYXg
         CLhs/6k84aC+Jj4WaG19np8AAPq/cnOAAE8XWTiEHOvMJYp8IgKEzPcfUjl/AnikHxMT
         Et6WSIGQxSJT1PvLhxk/tvUYQl1ObWblf8FHr4MOnHNf01uRS2TbQqheCHtBlZQjQvH7
         6nr3vKSrB2sQkBeFuZDae9srN/Ig8Uy6mGwBq24nGvtBe6mNrdULFz/PeGgYDgCPOnTo
         IwXg==
X-Forwarded-Encrypted: i=1; AJvYcCVouwXwZ2jSk2UCFrcOKkwJh7lQ/gHkqUv2DzsQRdHk+jcWZbxl+LYhgyH+6GgU+0dyn9kSYKh3kDsqIW9k5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxehSQPaCtIaQ/3sUWOYu0Js2ag851jybxW9pVc+7FAYniFwBEc
	g851FP6poskn+1A9cvgbnKFtIyaWRwPKRE5E0PUUIN0XTO1Hw0PfD8gzcqASDm0Qig4xzvTFgU7
	Qc18DDmMYSQG+x33MD5yMkc+20q8XUWKPALPwHH18iN3fm2HFNk/tqA+g5shE2sI0x2IeiAuufg
	VUdEIu4TnhXFrHUOQ6IbpcRaPoC4J7+JTL2Qu/EbLO5Mk=
X-Gm-Gg: AeBDiev63MyxrW+AS6cVmBV5dNwEmpQOr5ycNsDOQ+GiG0w6Aza3RRu4+GClXr7FUsE
	vB0FMkwrGwyqTUk1hzWB/6k/NQVZTv841c+JITSAI5ZeKAfmr8ODTtYbGFA2K1klT/nOHNPIfa0
	q/F4QMnmnt3eJfg9M/Q3/Kzxu9VzPdmubYoPRxywWWOXOo3AvtjwXy2wYSHBwqRS2AHnQuOChQ5
	XgjKA==
X-Received: by 2002:a17:902:f0ce:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b2d5a3c39dmr14965835ad.23.1775812005211;
        Fri, 10 Apr 2026 02:06:45 -0700 (PDT)
X-Received: by 2002:a17:902:f0ce:b0:2b2:41a9:8e10 with SMTP id
 d9443c01a7336-2b2d5a3c39dmr14965435ad.23.1775812004685; Fri, 10 Apr 2026
 02:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260405195733.86043-1-create0818@163.com> <20260410035237.59644-1-create0818@163.com>
 <adi1X_3wVUsDhRmR@sgarzare-redhat>
In-Reply-To: <adi1X_3wVUsDhRmR@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 10 Apr 2026 11:06:33 +0200
X-Gm-Features: AQROBzDVhsz7kNUJ36YTaPNuvynQFY-Dt0FMLOERsUNJeRpJCN7EnVLjvVRFZ1o
Message-ID: <CAGxU2F4XpzQiKwboQt9UEpxY+Gzsq7qyR5CMLZO4F_hGqTpndA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket paths
To: Cao Ruichuang <create0818@163.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Cc: stefano.garzarella@gmail.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xVX6lid8QRvES06yeVghYlRQqbNQZgdD97YrziVmRAQ_1775812005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 10:33, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Apr 10, 2026 at 11:52:37AM +0800, Cao Ruichuang wrote:
>
> No patch description at all?

Also, maybe better to CC Bobby.

Stefano

>
> >Signed-off-by: Cao Ruichuang <create0818@163.com>
> >---
> >v2:
> >- retitle the patch to describe the race being fixed
> >- replace rm -rf with explicit rm and rmdir cleanup
> >
> > tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
> > 1 file changed, 12 insertions(+), 4 deletions(-)
> >
> >diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> >index 86e338886b3..c345fa539d3 100755
> >--- a/tools/testing/selftests/vsock/vmtest.sh
> >+++ b/tools/testing/selftests/vsock/vmtest.sh
> >@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >       local pids pid pidfile
> >       local ns0 ns1 port
> >       declare -a pids
> >+      local unixdir
> >       local unixfile
> >       ns0="global0"
> >       ns1="global1"
> >@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >       oops_before=$(vm_dmesg_oops_count "${ns0}")
> >       warn_before=$(vm_dmesg_warn_count "${ns0}")
> >
> >-      unixfile=$(mktemp -u /tmp/XXXX.sock)
> >+      unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
> >+      unixfile="${unixdir}/sock"
> >       ip netns exec "${ns1}" \
> >               socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
> >                       UNIX-CONNECT:"${unixfile}" &
> >@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >
> >       terminate_pids "${pids[@]}"
> >       terminate_pidfiles "${pidfile}"
> >+      rm "${unixfile}"
> >+      rmdir "${unixdir}"
> >
> >       if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> >               return "${KSFT_FAIL}"
> >@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >       local ns0="global0"
> >       local ns1="global1"
> >       local port=12345
> >+      local unixdir
> >       local unixfile
> >       local dmesg_rc
> >       local pidfile
> >@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >
> >       log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
> >
> >-      unixfile=$(mktemp -u /tmp/XXXX.sock)
> >+      unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
> >+      unixfile="${unixdir}/sock"
> >
> >       ip netns exec "${ns0}" \
> >               socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
> >@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >       if ! vm_start "${pidfile}" "${ns0}"; then
> >               log_host "failed to start vm (cid=${cid}, ns=${ns0})"
> >               terminate_pids "${pids[@]}"
> >-              rm -f "${unixfile}"
> >+              rm "${unixfile}"
> >+              rmdir "${unixdir}"
> >               return "${KSFT_FAIL}"
> >       fi
> >
> >@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >
> >       terminate_pidfiles "${pidfile}"
> >       terminate_pids "${pids[@]}"
> >-      rm -f "${unixfile}"
> >+      rm "${unixfile}"
> >+      rmdir "${unixdir}"
> >
> >       if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> >               return "${KSFT_FAIL}"
> >--
> >2.39.5 (Apple Git-154)
> >
> >

