Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AF26D4C7
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946114; cv=none; b=Ke7MktChjY23M4XM96yeHWVO/o7pHDjkRvGlIgmEs565c+f/z83+8ghF8EsOOjI42/PboUKyOtRdz8VH1q0PAsE7NwpRQwQb0tCybfHTzS9TprUOOGX+ejHkUjb8bDRrZmK68wkrmkJbNYvHUy00sFh1w0HH4xulEYPh+DsgUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946114; c=relaxed/simple;
	bh=QJ7RsItWW94sQLYSWk24Ndul83P/s6M1Pj6x+zsl1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W29/eY9SnJqrM/Y8OVk95GUM9cpcaltiVTWr7mqxwSvhg52Nb0AwozlOwVZO8RzVXpekExHE/5IFes6KGWUPzjY5AFzS2Um7kTyOJiYamutibkkC7bWU+GXMmzpiVogSEawWD34+uJ+XrmPKDDyMu+CP3vyglxKdqjrnmg2S8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw/Ik6NT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw/Ik6NT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
	b=Rw/Ik6NTBCay3EpLKolrzqjaqodsp1xuD2dY792GGFLh1ejEHm/AxlZ2GIGjnE+DLaLh+k
	tTsvMH3PxBxwEUSmD+wcLrlYMhrk5NiaFaMA/zyME6HdNW7WQ6DuUjVT1RiccWRow4wube
	PcjE7Xs375AcFTcNT1z78EWSiRJGhxk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-pLtdw3CNN0y_1RI3DVsvzw-1; Wed, 12 Nov 2025 06:15:10 -0500
X-MC-Unique: pLtdw3CNN0y_1RI3DVsvzw-1
X-Mimecast-MFC-AGG-ID: pLtdw3CNN0y_1RI3DVsvzw_1762946110
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b17194d321so79361885a.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946110; x=1763550910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
        b=opGapxfzTJzrOKYkINs7GHUpIDR+QQRhGPAA/yma5L7qiLAp16GrydOnMsCb9v/eob
         XQwKkQiBriJWctS2R6kLL3/Iwust9+rga/C6f7txqt3UbLdGd6kqQYWBUyo1++3/yd7l
         4kWzm+oviZFgU2gPYM7E18QGq/3NJohupaP8SSj7gkZyD1v77lttc7BC1T0NaYa5mcKY
         R67Tqyk9rP35Ew0B4GgfzF/I+9uFZ/jARi6KRkN7fWtxSk9bLOT0dJY/koW5uVswTHIP
         oo6Gt9OxtAkLGOJvhz4O9kZOETqkUHauW0yJ2KTPqsFcm7kNoSiBAzbSbi+eea8GF6H+
         nLLg==
X-Forwarded-Encrypted: i=1; AJvYcCWURcP5dUG05mF3m/iTVmYSWQK2RhCHojv6hCXoAht5VsZM7T3P0SNZpk3rHqdT78GxcmaQA+xCu4BqalWDpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkgCHYoSDxPN1S2Q2CQfMTx2CV4LpzdfCC1cgrpS6UXOHZYYn0
	QltwPYh1Qh5fUPYd8srwscGpW7GGCRPn2P3GMpQ10dQmbKn4LEFlWDWVVwnRA4nlqzauwuNYCQ7
	82v5ScVX4HchUBxKYeygjRZyH8M85iEAM0kSaKx8nYmeV35pAsPaAJrJyncXJr1Oj+zrz
X-Gm-Gg: ASbGncvULEcDWxhTXulVvoUsHOi+ONO1OmbnuJl5M4y82tNoSmM90P74gFMdba5uGCa
	5HUO/9LyXkjGycQynbiq9I29dKE9rjfAjnAKZWx/L0MoM4ypHKGHO6zVMZK1z16/danxKLEkEIG
	8ZAPX7zU10yGBEAIFvGWrSU9XxciLkB2jTED6ZAOrBHwkZbO7F+x3ekm73U4qv4SPIOO4MP6Dcy
	10CRdUUOPDhUSh/GT5QUgek/2Ayy4Z5vj/NF2XAfwq0ANOyhqSgB22oyTB8vgZVEl+crSFzW/8c
	pb9O0H8wHN7iO99ZviWBK+yI5Wxz7IV0/Uqw5RqtG9tXA7QkhJa3AMsCHyW2EpFfqWluiu/5vI5
	TgL0T3w+ow90ib2KNcV8Hyn/cmryiafbkf3amHjm/WMdIqGv8RFw=
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307074185a.37.1762946109831;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtAKTvMbP3cFM+QNIMi0izCHSApoyYNJQFMwUCPX7a0E+uO7ILp2ns+ST+uoNT4M7IO7oCPw==
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307070285a.37.1762946109277;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa277ecsm170269385a.58.2025.11.12.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:08 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <kitbuqe5a2tyjbtjcyijcpqioidmrxa4b3iq7kulmbngofyt4l@d73gmgipbiid>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5YvvJ5RR5eSGZqJ-UnSQypELvzF1q5lBbF229D3OD20_1762946110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:52AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Improve usability of logging functions. Remove the test name prefix from
>logging functions so that logging calls can be made deeper into the call
>stack without passing down the test name or setting some global. Teach
>log function to accept a LOG_PREFIX variable to avoid unnecessary
>argument shifting.
>
>Remove log_setup() and instead use log_host(). The host/guest prefixes
>are useful to show whether a failure happened on the guest or host side,
>but "setup" doesn't really give additional useful information. Since all
>log_setup() calls happen on the host, lets just use log_host() instead.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- add quotes to "${redirect}" for consistency
>
>Changes in v2:
>- add quotes around $@ in log_{host,guest} (Simon)
>- remove unnecessary cat for piping into awk (Simon)
>
>Changes from previous series:
>- do not use log levels, keep as on/off switch, after revising the other
>  patch series the levels became unnecessary.
>---
> tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
> 1 file changed, 29 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 8ceeb8a7894f..bc16b13cdbe3 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -271,60 +271,51 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>-}
>-
>-__log_stdin() {
>-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>-}
>
>-__log_args() {
>-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> }
>
> log() {
>-	local prefix="$1"
>+	local redirect
>+	local prefix
>
>-	shift
>-	local redirect=
> 	if [[ ${VERBOSE} -eq 0 ]]; then
> 		redirect=/dev/null
> 	else
> 		redirect=/dev/stdout
> 	fi
>
>+	prefix="${LOG_PREFIX:-}"
>+
> 	if [[ "$#" -eq 0 ]]; then
>-		__log_stdin | tee -a "${LOG}" > ${redirect}
>+		if [[ -n "${prefix}" ]]; then
>+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
>+		else
>+			cat
>+		fi
> 	else
>-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>-	fi
>-}
>-
>-log_setup() {
>-	log "setup" "$@"
>+		if [[ -n "${prefix}" ]]; then
>+			echo "${prefix}: " "$@"
>+		else
>+			echo "$@"
>+		fi
>+	fi | tee -a "${LOG}" > "${redirect}"
> }
>
> log_host() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:host" "$@"
>+	LOG_PREFIX=host log "$@"
> }
>
> log_guest() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:guest" "$@"
>+	LOG_PREFIX=guest log "$@"
> }
>
> test_vm_server_host_client() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${TEST_GUEST_PORT}" \
> 		--peer-cid=2 \
>-		2>&1 | log_guest "${testname}" &
>+		2>&1 | log_guest &
>
> 	vm_wait_for_listener "${TEST_GUEST_PORT}"
>
>@@ -332,18 +323,17 @@ test_vm_server_host_client() {
> 		--mode=client \
> 		--control-host=127.0.0.1 \
> 		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
> 	return $?
> }
>
> test_vm_client_host_server() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	${VSOCK_TEST} \
> 		--mode "server" \
> 		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>
> 	host_wait_for_listener
>
>@@ -351,19 +341,18 @@ test_vm_client_host_server() {
> 		--mode=client \
> 		--control-host=10.0.2.2 \
> 		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>
> 	return $?
> }
>
> test_vm_loopback() {
>-	local testname="${FUNCNAME[0]#test_}"
> 	local port=60000 # non-forwarded local port
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}" &
>+		--peer-cid=1 2>&1 | log_guest &
>
> 	vm_wait_for_listener "${port}"
>
>@@ -371,7 +360,7 @@ test_vm_loopback() {
> 		--mode=client \
> 		--control-host="127.0.0.1" \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}"
>+		--peer-cid=1 2>&1 | log_guest
>
> 	return $?
> }
>@@ -399,25 +388,25 @@ run_test() {
>
> 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>@@ -452,10 +441,10 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_setup "Booting up VM"
>+log_host "Booting up VM"
> vm_start
> vm_wait_for_ssh
>-log_setup "VM booted up"
>+log_host "VM booted up"
>
> cnt_pass=0
> cnt_fail=0
>
>-- 
>2.47.3
>

