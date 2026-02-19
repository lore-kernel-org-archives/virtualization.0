Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE33329C7B
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497329; cv=none; b=SxQNjsVB1iqbIOO5xubQyoXYhWRDtBScOoV8PE5YVrxqh2WPudp+1zhxrUt672UI5ZNLhNJy7O2+g284VPv8Zn1yo59CdhT4N4oGjcoDtp0XM9isLSH3pekU8s3MdkCj3W0sBPEkN1txYKJokUtdpM1SRS8a1uzHZdcDOrEcnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497329; c=relaxed/simple;
	bh=JzgTJfCZThD8ADnrrzOcTouopRq3PU+mfSlCjHNTIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JRakLHDcvAUPcwllG1uV7xMeX4FveL9GCulQ6h06Wuy/PuPzO9n/m9VD0WlHglJo36gZv/57KTnHmJMj9llsgZVYQ4p5z7/WbKJ5ONz1g+sK30fWA9Pz7fs7HKgb01Fx8c1j4nBoqHJiWk0vOKeqhw+p8wyeqDOLujBD4ard3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnG8/tQg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnG8/tQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771497326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3F3zYoVrT9qjM5rAq+b6pbd+/hnAt//GBzSEVJjvXTQ=;
	b=OnG8/tQggtNY3Lr8AVEqC7zh+Z9YSUah4pY0sWAoRIIuSTRkvgs6IF4gZ0p/eAp0HPkIJl
	AylTvKx/xPsLLPhd6v+kEDs83ueNQjuD48QiNLTnnCJ5RsSp1alM34hMg5nOA4tXb9SQ5D
	xXCtUegkUnaM24GQp9g9qfKoIwXmhYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-up0aySlzOZyjE0U2XchKDA-1; Thu, 19 Feb 2026 05:35:24 -0500
X-MC-Unique: up0aySlzOZyjE0U2XchKDA-1
X-Mimecast-MFC-AGG-ID: up0aySlzOZyjE0U2XchKDA_1771497324
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43635708e98so487624f8f.2
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 02:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497323; x=1772102123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F3zYoVrT9qjM5rAq+b6pbd+/hnAt//GBzSEVJjvXTQ=;
        b=XHazhLG7H02i/VX7btmAZCjz6FIJeGXgdwsbyeVMRfQPKBoeKw5Zo3Z0VmWyJvzhV0
         yMjKswHSoBd0HQXCNIGBtNqUkQvO9xLIXrsxFXT4ULeN+K1NsqcxootaNN/fcwRlHQhy
         1h3ikm19Oe/dotl5jVSDaOru7ZbJ1IQcenVlElSzgGn5suCi2GJqjMjmXxUPfDcNXkwa
         JjgvkZCEAxrU5iepw60MgYAjg+QJRtsCMw3teB45L9k3uyKpicP49sPgMO1FGoiWEftM
         oaHa3AZTHKbIm9l99M5fvJb8KqxKBVuB1EEtuz3zHNsShD+eZzV16c5YKXWDOEXw6rD1
         L5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXTW4DUkjJjMwGT+QOrk2QvRJ8aKk5y5V68Au7Ml6efOT4N+QPEvIQjBBeBgzqI0vo7d8MqMwoWglCYK+qQ8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjz4Kgte2JMeneIIURTHu9MYuqzCfogZ4Hvn5L9P//5hsqpPIa
	f7q3tpJaR5ckfa7QihSFxPDV0nFSY0W2ouMe68+owQGLJDZQ/820ZpOvcHYo12J3aHNNk37fONd
	WdWLa/Ri/F7/RkLwZsFv/Iu/V/JUQ+mVsff9gAddHQLkm8mumhkHu2FfosREcYx/ZNKfR
X-Gm-Gg: AZuq6aIIOmqAqm3zxFcxFzM6gJCK32DWq6xccGXK8SwbIxXvmBfP+eyc4v2FF1HfNFn
	EGOK+MS7Bkztkizy2z7oCNdSy95fk+5bjB+JN3TLUhh4wvxn0swJSgBNA5vKX4FY8gav908yOgX
	7L1Hgk/+WLjkSGzdhpRHC+1aPORJq6Lx2U13y71laHrIJpxU0I8awRGk/Fg3LVxjCbuDU/8S1fB
	ffnZ9mYaVKrNhu5FnrpRZPW8OejSSghfxVQHD9+ctSQjNcdHYwnxUdOfKU/rwk6vpBqCbaF5Kpi
	zYrhiqGJ/J9nBoiMdftroxDFbYBRPSLWQvdX7njHSJEG8D+ehTx6zpI2jmdWGrXDU/2J6eQrHGh
	KcigFOgdFg3F8k0vWPGQcGfzHOV9BnOH2LvcXO4xqOAhPQh6Lig3KUKR9SwVXhReFO53H4ns=
X-Received: by 2002:a05:600c:4eca:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-48379be60camr248733915e9.30.1771497323451;
        Thu, 19 Feb 2026 02:35:23 -0800 (PST)
X-Received: by 2002:a05:600c:4eca:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-48379be60camr248733415e9.30.1771497322976;
        Thu, 19 Feb 2026 02:35:22 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f96967bsm19658265e9.3.2026.02.19.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 02:35:21 -0800 (PST)
Date: Thu, 19 Feb 2026 11:35:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests/vsock: change tests to respect
 write-once child ns mode
Message-ID: <aZbNwPMSd6ridmBn@sgarzare-redhat>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-1-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260218-vsock-ns-write-once-v2-1-19e4c50d509a@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aPxVhnsBJTTwUZmkDKaasb5mJP4zVDFCmFT7Rys1SU0_1771497324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Feb 18, 2026 at 10:10:36AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>The child_ns_mode sysctl parameter becomes write-once in a future patch
>in this series, which breaks existing tests. This patch updates the
>tests to respect this new policy. No additional tests are added.
>
>Add "global-parent" and "local-parent" namespaces as intermediaries to
>spawn namespaces in the given modes. This avoids the need to change
>"child_ns_mode" in the init_ns. nsenter must be used because ip netns
>unshares the mount namespace so nested "ip netns add" breaks exec calls
>from the init ns. Adds nsenter to the deps check.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 35 +++++++++++++++------------------
> 1 file changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index dc8dbe74a6d0..e1e78b295e41 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -210,16 +210,17 @@ check_result() {
> }
>
> add_namespaces() {
>-	local orig_mode
>-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+	ip netns add "global-parent" 2>/dev/null
>+	echo "global" | ip netns exec "global-parent" \
>+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
>+	ip netns add "local-parent" 2>/dev/null
>+	echo "local" | ip netns exec "local-parent" \
>+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
>
>-	for mode in "${NS_MODES[@]}"; do
>-		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
>-		ip netns add "${mode}0" 2>/dev/null
>-		ip netns add "${mode}1" 2>/dev/null
>-	done
>-
>-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>+	nsenter --net=/var/run/netns/global-parent ip netns add "global0" 2>/dev/null
>+	nsenter --net=/var/run/netns/global-parent ip netns add "global1" 2>/dev/null
>+	nsenter --net=/var/run/netns/local-parent ip netns add "local0" 2>/dev/null
>+	nsenter --net=/var/run/netns/local-parent ip netns add "local1" 2>/dev/null
> }
>
> init_namespaces() {
>@@ -237,6 +238,8 @@ del_namespaces() {
> 		log_host "removed ns ${mode}0"
> 		log_host "removed ns ${mode}1"
> 	done
>+	ip netns del "global-parent" &>/dev/null
>+	ip netns del "local-parent" &>/dev/null
> }
>
> vm_ssh() {
>@@ -287,7 +290,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
>+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -1231,12 +1234,8 @@ test_ns_local_same_cid_ok() {
> }
>
> test_ns_host_vsock_child_ns_mode_ok() {
>-	local orig_mode
>-	local rc
>-
>-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+	local rc="${KSFT_PASS}"
>
>-	rc="${KSFT_PASS}"
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>@@ -1246,15 +1245,13 @@ test_ns_host_vsock_child_ns_mode_ok() {
> 			continue
> 		fi
>
>-		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
>-			log_host "child_ns_mode should be writable to ${mode}"
>+		if ! echo "${mode}" | ip netns exec "${ns}" \
>+			tee /proc/sys/net/vsock/child_ns_mode &>/dev/null; then
> 			rc="${KSFT_FAIL}"
> 			continue
> 		fi
> 	done
>
>-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>-
> 	return "${rc}"
> }
>
>
>-- 
>2.47.3
>

