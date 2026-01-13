Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA823939AA
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319088; cv=none; b=ZceDPkAwgVeTbfNEHMDTuI5IsK/BMn8OoQb7vq7+Ej/X/pO/J1BSGNVP9+pLQZM/tQYwJoee4N+Gk/xabUgxtEjSSNIlYfJrfD5q7g2JxQnVP55VbIomcJjgllRllgV5wlvQo4ICUSYc2Y+l+Yov9UfBMvXHjYa/XTCi+xW93SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319088; c=relaxed/simple;
	bh=JhyhgZnijw5QpfbaydtI94PP620au/36IgAqarY1YUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FnkK26PO2bIGyNY6nEC3dqRhk2d0lrDikM2n3oNnL67B2N+xAGTjYJEa1KObl3+5ay1R4gZ6clFseXcSRFqxXehJZqd8QlH/aobzpYeedvvnO8/SFei6PGs2kzICrbpwKv1y69LsfxbSULvm76uOmOTxHmjnvx/ax96VaniUiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pi+jrs1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi+jrs1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
	b=Pi+jrs1H4RlTLNUs+cAPK9t7UTPtvsz8vpUl3inQ2+HmlEcUtB8IG3wngQr2fcO81rFXnK
	/3XnhuUjxGhFgmtVWeodSIovjo7OjTD8481CLbfD99yu8RrM/CC85H7eNZkX6prBTTwcAY
	rTP0E7+Uh5AKlAXy0doP18oZclmh7aE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-mwAfcW6VOdKK3rrJHALohA-1; Tue, 13 Jan 2026 10:44:44 -0500
X-MC-Unique: mwAfcW6VOdKK3rrJHALohA-1
X-Mimecast-MFC-AGG-ID: mwAfcW6VOdKK3rrJHALohA_1768319084
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563e531cso53915895e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319083; x=1768923883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
        b=jnXsvMzBLG51ZgoqJ0ezmKY+LoLcZezBAqf9LFdvK8gljGY4ELAAHMW0DwoTpOIHZ1
         SFHN/fSTpxUgBu9BDAV7RlHjpiAeE7L5ELeDR8SdsyKHXEMdNmNNBzlHESufi49uQm7D
         okxydoYY/IsfnhQqkcj3vh4WYVdjDgOqeZX58XAXKJImt/v9eM+g1AXOZIFkwkbFHV91
         ttUtcs6xZh/HXMOMnqV3FxSA2Evq9Ub0+wUh02wdyaQsCdwO+WBPZfb+kam0iNI41VO4
         5ei6GukWIGVcrUiGFTSqlwpZns5/fa1Q8B3BYVYRkgGNmQS+QUqB/xbf//3cyY110cVX
         SKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWTTmkPHW5y+Fg5jTpr61ZINmj1HYZG7FXX2LIPd9FB1RgpG/vVTvtTGOsL12NNJ6ctk7nLCVtMP+1zLJM0cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykBM1aBX7xoQKwJf2CpF89+H9JF7/7QxbsrP13hrER6umm0fvb
	lEq0O0KOsIqVWNTOwxIHofQGPK1vRLN5YP4PBwF0sGZlRBTsMv61PuYT7YieTKT06FqS7JN1S2s
	uKbotLfIUz+saxWjsJcbA04rVX/UpXzZhChHKKwGCGntOovOjBGqTVsZMswjhca2sFW4g
X-Gm-Gg: AY/fxX6Yr/Cny3IjoL608FSINK5ldt+qesEtj61LTJgR9wQ8xyvGbFowQYa1LFJvrIu
	VCJHybCFSE81TUfeXXTpKblPsnwZ2ir1dnQuIl8+wg3SHhyNWjG1HANOmiZ2OD2oWlhAOrU+xhC
	7Q3Ep5441G0YnWUgXFhJh0+hGxeIB+ftMeEvcaw2hlBrKzKiU3XjsxQbFGbuwsjcsT1r3PLX7m5
	lBCaHTotuV5XdH9q1/yvXPEK7tVOp224VjQGZFVMni3HNlYgxXYn90qWPyiP+i2rUmImSjhEF/L
	eaAb7oFQMraJSbTDVPjvtzn0Hg9qwS/AruJu3X2Jlda3zivyXXkL9r5XeB/rvXfILxrqD3JIFjf
	gMrrLUfXsx/3mJOVp3EVdM1+E41jA6kdt4y9OkU6d0g2d+munfKy9F8Mdon9maQ==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251938175e9.11.1768319083569;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMqU/UT6yusYgmo7wLLK1QpcbQzRIghkGQravCSZ1TVNgzar9pv/6xyu/8mM8bGjn/QJ4Cg==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251937595e9.11.1768319083140;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm402645575e9.0.2026.01.13.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:44:42 -0800 (PST)
Date: Tue, 13 Jan 2026 16:44:39 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZoXUGyoMjKCm2u@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RQ-Q4JnM7H_fAXaGWoZuIdGG58L7m3QsMNzwTB6vow8_1768319084
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..c2bdc293b94c 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
> )
>
> readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>
>@@ -103,6 +104,36 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	local orig_mode
>+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+
>+	for mode in "${NS_MODES[@]}"; do
>+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+
>+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		# we need lo for qemu port forwarding
>+		ip netns exec "${mode}0" ip link set dev lo up
>+		ip netns exec "${mode}1" ip link set dev lo up
>+	done
>+}
>+
>+del_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns del "${mode}0" &>/dev/null
>+		ip netns del "${mode}1" &>/dev/null
>+		log_host "removed ns ${mode}0"
>+		log_host "removed ns ${mode}1"
>+	done
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +141,7 @@ vm_ssh() {
>
> cleanup() {
> 	terminate_pidfiles "${!PIDFILES[@]}"
>+	del_namespaces
> }
>
> check_args() {
>
>-- 
>2.47.3
>

