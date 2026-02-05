Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10C330D58
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272686; cv=none; b=ApSlKdh0+YWGJTblMpeiH+EOz6nQgjQpCKltdHBpMNeJVRdfk0IdFRvXhPfhoE7Gldr0t18kVWd/sXTfARxel/RsElwIOZJj/IyFrXTasYb9P3BamByWUZnjS+4qgZt63J031bQ0lACimVG1orrrEVw4TKZ51zbkfegDsOEIK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272686; c=relaxed/simple;
	bh=Mh730ABqeOHc+soxt/YN15a26Ao35FZi4KBbK5G8SHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LAWaSO6QTbjZ1Q92PQ2YMAPTCiv17pvY21gmqDdDZNRvC/uHh9E4RwnqIADkMHOaaZqzz3m7c0zZA3dpN87eg/XV8jIo/xlXlUGq1L+ER3OLAstPTgtRgEpWI0p3Q0w22qN6YCfP8BtnDDZsla9S9LdKroKZe0xJNJC4xm/l/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibrkM/IM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibrkM/IM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770272684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18afiwTs2Q1K1O6pkKB+aeDkBjoxoyzyrBart1C+0Rw=;
	b=ibrkM/IMY7f5gV7ftjT0mpVtgI5Nn9u21gayKf6HVwjrg+3WgfHxDI+uWTk9VCqG5g2CJ+
	OQYo3wNPvN7I7YOa+63xd9EF7rHqqdyjt3A0B05hMqzLvs2UEGRDEs0h7uxDxBpBTV/rHg
	/wvQagSD+IX2T21d/lpHanlpoza9jlU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-bbt7HNGwOS6RXBROX1MNaA-1; Thu, 05 Feb 2026 01:24:43 -0500
X-MC-Unique: bbt7HNGwOS6RXBROX1MNaA-1
X-Mimecast-MFC-AGG-ID: bbt7HNGwOS6RXBROX1MNaA_1770272682
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801d21c280so6460325e9.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 22:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770272682; x=1770877482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18afiwTs2Q1K1O6pkKB+aeDkBjoxoyzyrBart1C+0Rw=;
        b=g84GP+r0Tfjuz6emvaUqqAM/dA2KAjEvvp5/DBeJWwOfUTYxJQcZhkX+auVUv/bphr
         eMgNCBsQRBzkfg0pvsfOJ1x1cgDSa4YICeFKZx6wouYNLp0NHFYkdi3fCkZc4J6cWuaq
         BrdY46xQyizaeYbccnq/Zc3+3IyU2PTP+uJ6B78qSLAvCP+cWfj5a4K29jQ5XRJ/MmVt
         5zzlkaMFFJqF4BHWLg6ToTnjvD5g8e0W7BrH7VsUBfS7ArVYzKdHZ6c5Vc9/ZTBz3QXf
         TdHUjBN45WcZ0ft50DS/4KooL2WrszKcoV0tRH1LQpG71N4kL5UM7sR/7f5YoOx+pKp1
         YY8w==
X-Forwarded-Encrypted: i=1; AJvYcCUomPvsmJIWy4/IVV/LzraAZTnl0kMTP/9TCXFKBef4NhqOfCfj0ajmxwO6cLkbWWi5VT9Na2CFeC/SmM2GUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT7tpDL9uJKXXIYZdJybjmErFrZQNngWvxSGfYaS9nv+CO53g7
	5DWBJagI7WL4XxinWMqcpdmjZmO7Xoil2ThSA8qLE76hjPb54SO9J2wGbx9ExaNaxmQcSI93+eg
	fguIQ2ulmKitUaw2STWO6KgXTrdLynyZXl8J6txkEylJfwFSRKMM7lML9f1uM8VskitOh
X-Gm-Gg: AZuq6aJGqe8gIcH+dtusEFXElYUYBKtKIdA+F9Eqf52hBTF3Bhhu/2nv9AUqTVL1mlu
	2dtyij3NzBJc7uIQIsIM9bGhREuU3tRGyry+717isbEIgqqa6mAfIFKvZlt+ENGCv8LYmcUW628
	3N6OPThSIyu+St6mvQMlRxFYlZnxYQeXHGEmzOJrmFWgIiG77GCMTzTM4ev6DtJH11QEZjFt4Qk
	Qaep9ZZsf5+Jox56+EwdWhJVSG4Tp74hI3DV9w1EfrPtwjUU/brMhNcgrMiGptE+aWrHBlJwHI3
	UZHv8w1dgyt68Sz8OIDJtraPhtyd5ZZnX+0HxdcR7V5NU+Rjir9izB+dInZa86MTjjQhaGK50oy
	Tw7V8xhHnYlHQQdMj1wu07vWOKor0K6agmQ==
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr75710995e9.22.1770272682171;
        Wed, 04 Feb 2026 22:24:42 -0800 (PST)
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr75710645e9.22.1770272681559;
        Wed, 04 Feb 2026 22:24:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm31921785e9.2.2026.02.04.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:24:41 -0800 (PST)
Date: Thu, 5 Feb 2026 01:24:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260205012145-mutt-send-email-mst@kernel.org>
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ncAVbf_U2NJHXQMIqru_N6FH5TcVKfL7QHOEg3oeZzM_1770272682
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 11:36:17AM -0800, Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.

but it doesn't verify/validate them - it's just a generic throughput
test. so what is the value add here?


> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..fa98505c4674 100755
> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> @@ -6,6 +6,7 @@
>  ALL_TESTS="
>  	initial_ping_test
>  	f_mac_test
> +	buffer_circulation_test
>  "
>  
>  source virtio_net_common.sh
> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>  h1=${NETIFS[p1]}
>  h2=${NETIFS[p2]}
>  
> +IPERF_SERVER_PID=""
> +
>  h1_create()
>  {
>  	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,84 @@ f_mac_test()
>  	log_test "$test_name"
>  }
>  
> +buffer_circulation_test()
> +{
> +	RET=0
> +	local test_name="buffer circulation"
> +	local tracefs="/sys/kernel/tracing"
> +
> +	if ! check_command iperf3; then
> +		log_test_skip "$test_name" "iperf3 not installed"
> +		return 0
> +	fi
> +
> +	setup_cleanup
> +	setup_prepare
> +
> +	ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
> +	if [ $? -ne 0 ]; then
> +		check_err 1 "Ping failed"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	local rx_start=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
> +	local tx_start=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo > "$tracefs/trace"
> +		echo 1 > "$tracefs/events/page_pool/enable"
> +	fi
> +
> +	local port=$(shuf -i 49152-65535 -n 1)
> +
> +	iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
> +	IPERF_SERVER_PID=$!
> +	sleep 1
> +
> +	if ! kill -0 "$IPERF_SERVER_PID" 2>/dev/null; then
> +		IPERF_SERVER_PID=""
> +		if [ -d "$tracefs/events/page_pool" ]; then
> +			echo 0 > "$tracefs/events/page_pool/enable"
> +		fi
> +		check_err 1 "iperf3 server died"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	iperf3 -c "$H2_IPV4" --bind-dev "$h1" -p "$port" -t 5 >/dev/null 2>&1
> +	local iperf_ret=$?
> +
> +	if [ -n "$IPERF_SERVER_PID" ]; then
> +		kill "$IPERF_SERVER_PID" 2>/dev/null || true
> +		wait "$IPERF_SERVER_PID" 2>/dev/null || true
> +		IPERF_SERVER_PID=""
> +	fi
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo 0 > "$tracefs/events/page_pool/enable"
> +		local trace="$tracefs/trace"
> +		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
> +		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
> +		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
> +	fi
> +
> +	local rx_end=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
> +	local tx_end=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
> +	local rx_delta=$((rx_end - rx_start))
> +	local tx_delta=$((tx_end - tx_start))
> +
> +	log_info "Circulated TX:$tx_delta RX:$rx_delta"
> +
> +	if [ "$iperf_ret" -ne 0 ]; then
> +		check_err 1 "iperf3 failed"
> +	elif [ "$rx_delta" -lt 10000 ]; then
> +		check_err 1 "Too few packets: $rx_delta"
> +	fi
> +
> +	log_test "$test_name"
> +}
> +
>  setup_prepare()
>  {
>  	virtio_device_rebind $h1
> @@ -113,6 +194,11 @@ setup_cleanup()
>  
>  cleanup()
>  {
> +	if [ -n "$IPERF_SERVER_PID" ]; then
> +		kill "$IPERF_SERVER_PID" 2>/dev/null || true
> +		wait "$IPERF_SERVER_PID" 2>/dev/null || true
> +	fi
> +
>  	pre_cleanup
>  	setup_cleanup
>  }
> -- 
> 2.47.3

