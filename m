Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8035FF55
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489667; cv=none; b=GC+wFDP9g2952ZRhoMwC7YPSGAGQ3bs1wv5Ab//AEGPkorTyOHnfJ/JxElIR+p2VBGT2q+Lhel2A8grp+wDmRzMiSfgvRlDBs17sUYoNXc3hGObqMUAUasUjHnKpWWPGc1aRcTnqrT28ugDPS7ts1SatYGNoBgqcmvus03kqERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489667; c=relaxed/simple;
	bh=93pZ6dl5lFQD43TapInbMA0s7FqryaSyeA9SjB2/Swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LVDi9AAKwCcCoXHdeg5FI5ouSZru3d8TaKXqyWqZPxEXh2d+H8QnKkpS4kdEuUySUiCof3i8jDbq1WMqBCArQ3BKF0dlAlBM2TLDtfR0jwr52bklqdxjOFKDFxlDHqqWOaS6I0SPzuEFD0jaQNNBl3On88ABh798rbof8zyw61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPXt3JgT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPXt3JgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
	b=YPXt3JgT3WfKGtMRiafhymWvX8w6wIvzrxJuitdlK/TIHSjkH6wys4F9KRzmeaZrgno7El
	gAnP12Ug5QNK+0tfAL1YzFHW6EdiSC3DCqw3z90hvl1uK1DV3YU+c17nEwEZFEpJ1XGYsF
	2q8Bwbxubvwr3EXG3WsBSsNS6lAOgPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Txgig66TMnWCjKaq2LmLhQ-1; Tue, 18 Nov 2025 13:14:22 -0500
X-MC-Unique: Txgig66TMnWCjKaq2LmLhQ-1
X-Mimecast-MFC-AGG-ID: Txgig66TMnWCjKaq2LmLhQ_1763489660
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso4712881f8f.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489660; x=1764094460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
        b=DVjUgnOm6sdJPD8IiJxNmavJOjZbO6tBVqfDKwMtOzj1H2Xbm2TZR0ynBXClZYQSsf
         162IfHiN3B+fVIFTO5LF/JeYi229LVPy+YlLjsnXfSOAXG5ExUcFtG4aLAtWPPTH+W8B
         8r93JQJgkHLYbKxrNwmvrWvbBf1QHEFQRNL8tSwNK40O1cHCBzvMb3UdB4hwgA4ibuGE
         E4vSPczcny0aqfMTwabOnzTfhTCeH9YFSgtsi4kBU/iJgySAXjTNKEm+yRIijHNiTaob
         TEU/OiuVwHEVjPJDqvnAJ9ZMr+6Eaw/CCFn9bhj4mJEND0WZVuoelSSRxizOX2zQIjla
         sKug==
X-Forwarded-Encrypted: i=1; AJvYcCX60oVncXgfbNSF/an9vzElyTSGGAomQ3sE9Ae+8KMvSHOeuUITcH3XCEd/bZ4jje3S5Y6He5BKUPhMPyIWAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYAYGSkV4PbUcjg+NfE37nk1tq/UVI5JZOWiUlyIxFkwV1mWA0
	srahAgWUIuLW1TaBXXa9bT+CtInqKeQq6RkFkS+cXiMk0VI35E9IvlA0bMIRU/ubFPmwwKAhX9T
	1oFX83W9mT2CC9heeres0Bqxqu9fUJjllB/FMULuEHR4jgev0ppoURopt81aDU9zCV0HD
X-Gm-Gg: ASbGncutIIsY8awU1GTFED4Z2xFAqFv4hLkdoGMqdru9axXry4CAaO13KLEcjq2FG64
	xJTChMeJiB0K69jyry6ZugYygoUUdSBz1nA73B/Xt+wuosjgm173BujzVQTr7tDb+OuxYqdMVpk
	AfZrsVv4o2lZ+aHNJ9oEM2QNAaQRwdN9GwgzFPqHk3lDqJ8tUyX9ef9nO3lW5cI/H/D7EBzdLeg
	h+ezbGnwyHSSrUd+Nq9GL8G/xG5SL3csaJPfI0rUR9cwyGV5w73ns74XuENhTsckPYc6vPSWxOM
	x19LsFZQFXD7aY2ArJ5XWiR9qfI6LhI1jn9V7pUZ6LpVbDgj8ToCE3Zv9VmlI2IuCr+iuP+hjTk
	m/ZvNkfGw0FwoGdST9gYBi8M6t9XRyoEEigvzagG5ihITDSxagai0yN+QE4Y=
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260486f8f.46.1763489660397;
        Tue, 18 Nov 2025 10:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS8o+OnlcCO7Yj6XaGWOD+hRu7PmlcNwfKGvJu2ycvTutZuUYYNXih4+y5NlFSoF//9qYsmQ==
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260434f8f.46.1763489659913;
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm33992549f8f.37.2025.11.18.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Date: Tue, 18 Nov 2025 19:14:10 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 09/11] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <iyn62b6uwxgoz5r3rk3huca3ehwvh6zv4rx37hliqrkh3bknkt@qfmfnrwdd3ks>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qIjPiRXO4kAuklEMgskc7rWuZjvIvpcOO6DnGyuyC4k_1763489660
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:32PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
> 1 file changed, 73 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 86483249f490..a8bf78a5075d 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
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
>@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
>@@ -553,6 +568,64 @@ test_ns_host_vsock_ns_mode_ok() {
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
>+	vm_start "${pidfile1}" "${ns0}"

Should we check also this return value or return an AND of both?

>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
>+
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

IIUC the naming convention, should this be with _fails() suffix?

Thanks,
Stefano

>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local0"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>

