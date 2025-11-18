Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A03074B3
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489596; cv=none; b=TRnWR36oe2X6WMU4TgYfhKbF8htIEkRnREYPWFRn6nZ1m2PoBZFrK+7Rl7Od0RzKrZt9asUeMSMVGbDace4sF4XayQLz6ZUEa8SjyFlDkhJb0cdVF3cQ/Ncv7628jEo7KNVVr9E4foBkTBcGkP3UpK12VS46GOf2a3z8dghlags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489596; c=relaxed/simple;
	bh=ESkljyOopVtU50//2SKEaLXXjPSw66upROeHtwZHBTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tu/cAj2DC7tQbDNzEu4eMu5N/HLErzG4CVf7dvPTQtcHKdr/MxNOyhP7Zj5ET0iac/bF5sBp+znwgQamxFK+vFomsRtGWtlNt04LAAGsnjyB6FnuDGUoL4wxt6PbwQu/dsDd3KvZTnxoU3CUDiTxEmlW4b6uYoAvSY7NyuBKs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHoRL0W9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHoRL0W9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
	b=LHoRL0W90uQfrkONRFJVVusN1nPdqkZL/rA18Q8YGdnESAm8eYezQcV0F7cFkAk08uiuG1
	bwpy4TKwIvGW4fgAz1WyykAGqUylyK0XeQNjJUdRHFCwClzBxO3hRvM0HWVKrElPVgTYg2
	z2pmi1vSD5iGtZF30laloS9gNVHbFzw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-_W2X6UbqM6K3seyAabmpjw-1; Tue, 18 Nov 2025 13:13:12 -0500
X-MC-Unique: _W2X6UbqM6K3seyAabmpjw-1
X-Mimecast-MFC-AGG-ID: _W2X6UbqM6K3seyAabmpjw_1763489591
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47788165c97so8637065e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489591; x=1764094391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
        b=EQKa7lAWd92NE3gCQXo0pRpkORx4oR2/oRuks43bdZmWJz+QRTdRIOpiaFh+tmqVq5
         m242Fs11KxOhvCzMjAnWQEyimJSLlpCsl7nX3ZaflFEPWu25Aiy1exyDajubzWwgPPmT
         JZ6XGQJ4mdoClkZQYAG8yhRC77g5Ge7yixcgZLgysmIa/10ON0sqvxh9XXWyfWSj6Dbb
         aP6PTA+szj/uOtUH44lMT3DRQ0DwKY2Lqh7tN+KBmxXPPk48yPQqSietuU0lzS2Qrgse
         M+euDvJ6GuaXt7IrrEw8H+FZpWJ3JlqaCxcgl+Eq485ZWHQEm+l5hAFVes7Ue99aBFGU
         zTPA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ye02ajtRUuZqAsx7KO0kor37UvWEaldLInbMKt0qLZQ7gr+fST4r37xYMboab+BKMFuRT0MJhXrjrJ8Sow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/WVERbffWdhs9jcPWHO1vl5Tt++MaZemXustzcRoS7Q3tUXV9
	g7JboUsIusbMO583i4/JG2P5vCoVUizY+u2OySd6ox8gMUiAdvn68bslTsuo5Qc6wNX1SCJPAps
	zk1SCLqzpY385SpitituDL7UMazhHWAm5bonWBu15eysA7pPmvscVLjZoqOaOiucGMGY9
X-Gm-Gg: ASbGncuZk6d+7RE2DvQES8Zz/f1HgJ0RpQ6fL1TK6fH39rr9OuOIWTeH1DY74RKoxnh
	nLTLxFhzGk6HHwvzeesd5XwACDHhFqiBXFDGEF7colfgimfqviLYEZ1DCLmTc5MAkAVPHGQxmJh
	4DDyb54WB2X2o5n+ByhPrOWkrhhHDjlghBKb0KdBQokqUGCXOVun3E3ANvxyfsGQ//ToYjXQDHU
	OdabMpFKchBe1FUEdYPBngD+c8K/VpyohuAqzG9I9NzI5a53R3joJXnTUBc1jOaOi0kxuguNT6u
	4/OBDozv+dozINCN/sn4LrFzSImi6QlqpzENmEGDMZ651+vsK/SvLfFkVCPKFkMjtvLvCPj9nyo
	3L7yOUykzPXsqkfBj+W3J/DthqXlou2QC9ST8GNjTkrEDWs4AA7/t6BL9Izk=
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147585965e9.21.1763489590804;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIT8ng0CUWbvzfqjNxNNDfLjFNDwG4+rLmN0Xj3SFNTvDx9hI+oXmEXYHOMQFCNSDvZBqLmQ==
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147585685e9.21.1763489590295;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm21423225e9.16.2025.11.18.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:09 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:58 +0100
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
Subject: Re: [PATCH net-next v10 06/11] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <643ayuucvcaet3v47uwh22mahncfbm3arjqf7szs4apa7gsklq@clggma36o37s>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hXW5iXp0TPb3q_5A8wgBKjqIRoehx4A0HTZm0K39XZc_1763489591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:29PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The init_namespaces() function initializes global0, local0, etc...  with
>their respective vsock NS mode. This function is separate so that tests
>that depend on this initialization can use it, while other tests that
>want to test the initialization interface itself can start with a clean
>slate by omitting this call.
>
>Remove namespaces upon exiting the program in cleanup().  This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test. In that case, this patch prevents the
>subsequent test run from finding stale namespaces with
>already-write-once-locked vsock ns modes.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..f78cc574c274 100755
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
>@@ -103,6 +104,45 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	# add namespaces local0, local1, global0, and global1
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ns_set_mode "${mode}0" "${mode}"
>+		ns_set_mode "${mode}1" "${mode}"
>+
>+		log_host "set ns ${mode}0 to mode ${mode}"
>+		log_host "set ns ${mode}1 to mode ${mode}"
>+
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
>+ns_set_mode() {
>+	local ns=$1
>+	local mode=$2
>+
>+	echo "${mode}" | ip netns exec "${ns}" \
>+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +150,7 @@ vm_ssh() {
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

