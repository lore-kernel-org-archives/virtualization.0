Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB928C874
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736539; cv=none; b=B1oCvW31EzqNZYneWAZ3kGHkdqyDMaWLjgjJygTibgqJz9n+zhZAP71rLI5iMrf5CivUQsY4I+/QAVAS+oZuYZjQ6W13rv2+JckbwILyadPONjB1STq4wu71Cpa2Ev8txsnvCwF9feA9jJ6d/pCt4Hi2vPALvwFp1ixbIeEVvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736539; c=relaxed/simple;
	bh=9ksRgIEpFArrDBwuWTU+fH3xIEsF+1N4YpMi7lIilCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LjUW/8tPLpLm7e0L0VhcFjUBiRO+9h740E1QaGhfwpI3DeOqB5w2Y/obe9lBDlrnRm+Q9DybkFbKI/TB1qNlK2swMrJHv8o18GQbtJSeOp6Boww6kzlBVoOi1a+BiDEokOQobb44P59rcZQTgqsQZtCYnLcBuagWn2V6O1ME5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI+zDcBr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI+zDcBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
	b=gI+zDcBrL0BYvbgBdnXE2wtuC1JpyO3QSlCnPDf1PL/wVMloK1+WKiL6Ib0gI/dBvS3sMr
	wACfOlksVOwHXjzWhEN38/Njv7NO30PkGcASbxIMs1ZvVlIZ51BnfTIGcwjlOJ7Rrbc5TT
	BmYVNa5EJth1+Ny5w1Z9w7+YhvY+2d0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-PdXOAzVrMzO_NKuAddT2oQ-1; Fri, 21 Nov 2025 09:48:55 -0500
X-MC-Unique: PdXOAzVrMzO_NKuAddT2oQ-1
X-Mimecast-MFC-AGG-ID: PdXOAzVrMzO_NKuAddT2oQ_1763736534
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64160e4d78eso2056591a12.0
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 06:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736534; x=1764341334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
        b=IZhuCWVjjioZZGaoTxAlR4NaZIiooVblH0/ID7o/qGxa/qg58rfuXWPpw00yDKgkn+
         0De6ryQFUPh4KpfGqrpY5Cvn4PjFTW43gv+Y93XTB2/s+vXehRvGSoonl8kXVmKjaXbZ
         3/PUgCXLDPCndb1b7j58beQROlOJvly9E0CYpmNdrliafn3us72zrwJjMmriaxeHwtsu
         s3qEU5P7Pz+uQiTIzfwTjeGFsUDSbN1oXWRkfi7j8kUwnJBNcSGqlVJKd0f5b6R6covm
         +qkirJ5VRk7DlY37AxHiSJ6g9azk6qJ0ME8Dm7NXFmZRqW4GGUh//kgmS7S16WgHa2u/
         dOLg==
X-Forwarded-Encrypted: i=1; AJvYcCULjLQYSNVFejRjy6zJlLXeA0bYYiC7mQzNnA7RpSCRfdxJOyESCRlVYePRqE/R71bTyJCgIuaAoi+fgS2sFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrN1B1MB8zSbAy5+zGjPCBKTNfSxLi44Yi8xJyRXIoBmlnT58w
	NcSKdk6ms8G6UgQV5LeHiCA1vgqi/G5rWpLMCxXBC9qpsuCTltARpBebgaTnQ8rM3Dk5TnXtBI8
	jmVRdDx1nCST9R7jYPu24sj9x/g1ejZX/PenQPWQMewmZ2kEF6DgQazzJ2t8fNe1v84+4
X-Gm-Gg: ASbGncv9QDjRWDi6rX0btKegIaEucNxb9fWUVuZkv+0YPQan69PoidfftlCIKNGYeuA
	Kl0+rJSzog3z1IYu8ZUFxFJpA0G6E5A3vzIEqHrsLYfFstgvvz0cSW5PxXhR5WHq/ugLJTYKH82
	hU4kCTrXFIvNlullUEGYgXzCTPo/UlaGHsJeEioIz5B7M50eSfmuBUxzbfKag+ZFXMTvDhH1bUR
	FZayN/+W38mlxQmPnFphNT6HGOyLnhPauJuZnFlWC6k25EHNLOzQZCKycwf0MGeEr4db9AAzt+x
	lMWAp73UNkhjjRQDdY9ntWuhI0GxAXWnliLQbKigTY8A6D9w8qrYJK3lYoTt48bokEXIWTdxqvj
	BT5ttVm/+mSRh5naTbl1WuDU8IzmKK0vgWmuEHqSOgvfNcQ4MKjg9fq3Uz1I0hg==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541678a12.13.1763736534251;
        Fri, 21 Nov 2025 06:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYJ6NYmSLizuNfGJGB7tJ5ZuOQzhRvgxOwNrAKBcDD7p9ENJ1FC64SfddE4bzlIpGVmVbelg==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541631a12.13.1763736533716;
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm4585052a12.33.2025.11.21.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Date: Fri, 21 Nov 2025 15:48:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 11/13] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <zpfacrsl6dxmo3ltwiovrcj4rtbqgnms4z6rwnw7o2jncgjw5c@hrorb4elx6mm>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SDnbVMgwAvhoigeO25JcFe60FLcygbPciHAefzoFiPA_1763736534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 20, 2025 at 09:44:43PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to verify CID collision rules across different vsock namespace
>modes.
>
>1. Two VMs with the same CID cannot start in different global namespaces
>   (ns_global_same_cid_fails)
>2. Two VMs with the same CID can start in different local namespaces
>   (ns_local_same_cid_ok)
>3. VMs with the same CID can coexist when one is in a global namespace
>   and another is in a local namespace (ns_global_local_same_cid_ok and
>   ns_local_global_same_cid_ok)
>
>The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
>make sure that ordering does not matter.
>
>The tests use a shared helper function namespaces_can_boot_same_cid()
>that attempts to start two VMs with identical CIDs in the specified
>namespaces and verifies whether VM initialization failed or succeeded.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
>- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
>  local0 twice. This check should pass, ensuring local namespaces do not
>  collide (Stefano)
>---
> tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
> 1 file changed, 78 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2e077e8a1777..f84da1e8ad14 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -51,6 +51,10 @@ readonly TEST_NAMES=(
> 	ns_host_vsock_ns_mode_ok
> 	ns_host_vsock_ns_mode_write_once_ok
> 	ns_vm_local_mode_rejected
>+	ns_global_same_cid_fails
>+	ns_local_same_cid_ok
>+	ns_global_local_same_cid_ok
>+	ns_local_global_same_cid_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -70,6 +74,18 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
>+
>+	# ns_global_same_cid_fails
>+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
>+
>+	# ns_local_same_cid_ok
>+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
>+
>+	# ns_global_local_same_cid_ok
>+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
>+
>+	# ns_local_global_same_cid_ok
>+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
> )
>
> readonly USE_SHARED_VM=(
>@@ -581,6 +597,68 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+namespaces_can_boot_same_cid() {
>+	local ns0=$1
>+	local ns1=$2
>+	local pidfile1 pidfile2
>+	local rc
>+
>+	pidfile1="$(create_pidfile)"
>+
>+	# The first VM should be able to start. If it can't then we have
>+	# problems and need to return non-zero.
>+	if ! vm_start "${pidfile1}" "${ns0}"; then
>+		return 1
>+	fi
>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
>+	rc=$?
>+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_global_same_cid_fails() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "global1"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_local_global_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_global_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>

