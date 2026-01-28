Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF0342C9D
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638374; cv=none; b=sbIK/pu5NVcLxUuM5LF61Htt97X1akfyQ5jIg9fiLFWe28WD0LZWY/wb6glTHkpk53GMCVoBkiUqfTXwMtzavoP/UxuICYbrSQDV+RXU75J2NWzTvbOBajSA5cDOCIu9nEZyNALIcqKFbxtLDv+ZJtv2jihwMJyvJwkuX/C3InM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638374; c=relaxed/simple;
	bh=3/ZGvrOJ/EeebmY/pHR1o5er+CrVigjVSeIWhExIpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PopWnHRPwk4riCzLFmCuNZ/22q/UYiSlLkZhczw+gSP6+q/gJciKHTSyBhv9Ea5VnjFvGmN/d++J7TyEW0NPjS1TZVyeI+cz+wLaUlQzBm+9PSZiGFGi6QhxXEC39KVdoyGkjkHo5WX+lfOBz0Bb5k1cbXcubgeKka1i2R0hEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfOLogfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfOLogfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769638370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIT9CsTljwdnJ9erps7fcHJr49NIK4bTScEEBRZFMDU=;
	b=BfOLogfeJqxNbzxpCvjrhrXHICs+P+lxFSCA2oC76ChBfXCzbrH76LvGcYNO/V29w1/jFu
	5uLorL2Rajajc6NuZK+tO8NgWv+xaVeCRlTmAT4E6GGUWMrgYHHvJ/v4pOXpFabqhpRWYA
	BJwuqbq6zNuus1fLwtcgCqb0lsTJ7T0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-LubsrV5UMp2eMIc5F2hdOQ-1; Wed, 28 Jan 2026 17:12:49 -0500
X-MC-Unique: LubsrV5UMp2eMIc5F2hdOQ-1
X-Mimecast-MFC-AGG-ID: LubsrV5UMp2eMIc5F2hdOQ_1769638368
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so2835985e9.2
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 14:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769638368; x=1770243168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIT9CsTljwdnJ9erps7fcHJr49NIK4bTScEEBRZFMDU=;
        b=lB6LC1qGJW1qu221FjioqjsYqS/xYcWZqzyhT4J3Adi/65YAK+GEZK71vuzHGZ1Mwa
         npua55edHQvGV5dtT5fFwUkflsUiMY84b3+Ajj0TcZdbre+hn0YDG5wg3CQX+LxsVYmo
         KHG3mTuiEjMli76OBHMTvDkjn3o0rY7cNAttEdcWbsL0U7WXq+s1hAmG1vEFDLgqm93E
         NRh+dPbvLiZToLYoYpvRVzPZvMxqT93muyUXpYhbuKOTSFMxwfvFcEzwqZZvf7NA7Dfy
         PWkD2g4dyykXdwVvpo1TVew+XeTZFny/eFcXYAQFsoProkjI2Jbospgp7GtT2dxQsB8L
         CQrg==
X-Forwarded-Encrypted: i=1; AJvYcCWta6LjGHypybo3U30Ko3H46ujJys13HsP5QZH0GvvQqO+MC712t+GUvKogWyuLuDVXbM8pRBY4yE6gj18BRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDO6umHt7Bizj43ifSlutJCB2TTQRN0FsN0+H/oHO0cgpnrSlf
	4FEwuhQIAcuFObMLmPvTr6tydDLMFd348ooSiOk9MzpJytgAYBXLqoMapfLeFfxE15m+VtrwiBw
	0H8+ch507qG7uy1P/Ikt0tbQvB303u9aoEwVwpP+p/jxf64/mJXQory/noU7msmh8cN7c
X-Gm-Gg: AZuq6aLJ8iiZ9jwU94K50HhqWHqwtXV9jyNfGq/oJ5Ss3SK1Rx5+UmMVoRArer33Llq
	zih9Vx3zcoieIl/nxyIlqpSNxff1ah/awvRHj1aWjO3ObOGqueloLDeWKf+Qy40fraxdv02wP0C
	xIaSTn6r2tT2HdFKVVVlpYEdoB8BQ8YDFqA3Smj5gz1Id7Lj+Wz6Q5EXg4sbpnaFkh0H4XErOfz
	dtREoryoYHJdj4swoDTNgCD2DWuVW0Untr9deZA3IYHaMh/RbPATGX6S/7P5RNMhwAZ8JBQVhO9
	CclKLAX2OTheOtcn5SIidmvEsS7sSvGx1/8I1kymhJGsZXoG0HAyf7faRhQ55ty8R8h6lMZ+9en
	CiioV/8w4T3UzH71aAEWwXIInuBk/8b4tjg==
X-Received: by 2002:a5d:5f82:0:b0:431:1ae:a3ca with SMTP id ffacd0b85a97d-435dd02126fmr11202390f8f.11.1769638367671;
        Wed, 28 Jan 2026 14:12:47 -0800 (PST)
X-Received: by 2002:a5d:5f82:0:b0:431:1ae:a3ca with SMTP id ffacd0b85a97d-435dd02126fmr11202370f8f.11.1769638367159;
        Wed, 28 Jan 2026 14:12:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm9362320f8f.34.2026.01.28.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:12:46 -0800 (PST)
Date: Wed, 28 Jan 2026 17:12:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260128171144-mutt-send-email-mst@kernel.org>
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260128212031.1431746-3-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yHyZJOT135XBLRo5YCc7LslkgvcnC3_6u2glx7Q7Xf8_1769638368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 01:20:31PM -0800, Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..c2c8023d2b92 100755
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
> +require_command iperf3
> +
>  h1_create()
>  {
>  	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,73 @@ f_mac_test()
>  	log_test "$test_name"
>  }
>  
> +buffer_circulation_test()
> +{
> +	RET=0
> +	local test_name="buffer circulation"
> +	local tracefs="/sys/kernel/tracing"
> +
> +	setup_cleanup
> +	setup_prepare
> +
> +	ping -c 1 -I $h1 $H2_IPV4 >/dev/null
> +	if [ $? -ne 0 ]; then
> +		check_err 1 "Ping failed"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	local rx_start=$(cat /sys/class/net/$h2/statistics/rx_packets)
> +	local tx_start=$(cat /sys/class/net/$h1/statistics/tx_packets)
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo > "$tracefs/trace"
> +		echo 1 > "$tracefs/events/page_pool/enable"
> +	fi
> +
> +	iperf3 -s --bind-dev $h2 -p 5201 &>/dev/null &
> +	local server_pid=$!
> +	sleep 1
> +
> +	if ! kill -0 $server_pid 2>/dev/null; then
> +		if [ -d "$tracefs/events/page_pool" ]; then
> +			echo 0 > "$tracefs/events/page_pool/enable"
> +		fi
> +		check_err 1 "iperf3 server died"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	iperf3 -c $H2_IPV4 --bind-dev $h1 -p 5201 -t 5 >/dev/null 2>&1

is using hard coded ports like this fine?
running several in parallel will fail ...


> +	local iperf_ret=$?
> +
> +	kill $server_pid 2>/dev/null || true
> +	wait $server_pid 2>/dev/null || true
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo 0 > "$tracefs/events/page_pool/enable"
> +		local trace="$tracefs/trace"
> +		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
> +		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
> +		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
> +	fi
> +
> +	local rx_end=$(cat /sys/class/net/$h2/statistics/rx_packets)
> +	local tx_end=$(cat /sys/class/net/$h1/statistics/tx_packets)
> +	local rx_delta=$((rx_end - rx_start))
> +	local tx_delta=$((tx_end - tx_start))
> +
> +	log_info "Circulated TX:$tx_delta RX:$rx_delta"
> +
> +	if [ $iperf_ret -ne 0 ]; then
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
> -- 
> 2.47.3

