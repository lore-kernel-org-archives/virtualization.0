Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4871E3DCD
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736202; cv=none; b=Y0sQeXe8RD6I6y89k0/PhrBrgQNJ4v2esJFgeneKptuWREd8uSjbMLh9MOck6xZA22oyImrrzRXPmWw/5DiRq7lswiVLGM5WGkvTyDJCF5c3csGNaFSyLGtJh0DeQLplUKORxRWd3f4YQSulgFZGsIqdKDcH7aSIV9ZlGS9UA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736202; c=relaxed/simple;
	bh=PszHgCmhtccWSqI0eShhC4jyc/2aRHcMziGgYPJttHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VUCJ4PhDKKOdWXdcqyQDa//q43qOfctXFu+Ga2I08WcwDNbhV7fAWbx09F/RzU143nGvriUpGFkGKjCHkw/nWjE3yMHAyvsezmj1W60E2E/Ml9Qrm5dtirxqSnrd2S450bMTliML2QRFgbAUmOJBOJ5dksCZdZS2/YDOoPMr2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia/ofJf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia/ofJf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBmGxeL2mYyQ8HpRUGAyaocZQhEEGSfR+zrR8FYGGGs=;
	b=Ia/ofJf8g4yc0r390iO+HrMUpLd+KbVDjEdgkfr+kch2VqZnZE14plJRGzeGKCjQ4GXv50
	njQo9Jn9TLR9KJfwuFrlBJ1QT/aA8TGv7cgpkKK9RbAhmaqUT8uJqIzZRdM/oAYfwNW06L
	T/E+QnKFO8qXM9zG1fJtRTozj+GxQkw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-DzzJJ95uPDqW0jTQwick6Q-1; Fri, 21 Nov 2025 09:43:16 -0500
X-MC-Unique: DzzJJ95uPDqW0jTQwick6Q-1
X-Mimecast-MFC-AGG-ID: DzzJJ95uPDqW0jTQwick6Q_1763736196
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3086a055so1879934f8f.3
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 06:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736195; x=1764340995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBmGxeL2mYyQ8HpRUGAyaocZQhEEGSfR+zrR8FYGGGs=;
        b=imCXKaWar/cYqqLCgOGhkWBt4yp7VQjgk56Z31VA7bnzwYvcMkaUnUhDVpUDkHytdg
         n9sl85Jpgl0zEQF3JOJf99oh3bNGEky84ng7g37dgbBnGPgP3vzD4t4jPd4KvbnWY2il
         D0//4uQTQ/BybObE5fIGCXjhgZMR/mEwc1z0pOMd3WzF4E5RwfwFaeY5UrhHg9xPBI99
         P64x9uOZfQ6wAR/Z8nfBzUKDE6AokKu8skGJf9zP1SoQRl1tCLURdwuxvmF+1da5GDHX
         cQAscn/GmS2MAumr98mJnUAfWmFIUrH+TmXxXW3MnZwAeFEYJ/ihw53H5Hk9nbu0iefS
         tusA==
X-Forwarded-Encrypted: i=1; AJvYcCXSMFk5WreMjQARe5gPmd61L/s01qRSDhPihYrhHYM5buqLrIU/de9ECrCHKuuuK6g1y84iRGhuOPcgKiNvPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAJnoibynh/bTXdL4i+34aZDcCitlUTIOXOylMgVY+uWDJplPm
	EV2IqM2JA+xn9KuiCjHj49VccqbS/FS9DhH+zRvdp3QmbertdqG3xkezDtpnvI5ssw+AK9ZHo96
	hUVh0rijeAOLJpBCZrfcikDm0U+VRqAHITsFuHJs14XzbVJqNy/TUnMrc/K2ZAnXip0mW
X-Gm-Gg: ASbGncuP2KF2YAYsDNUsZhs9XturGFyf0fima7uFtcfCCYHldVRKQPZG/ZrwZghqbvs
	yShpQlaOyee8Gi77Sas68mH5JcU+d6sC3+z/CCFvyXtodqokCpJ2JdlgwIVQl4XrQtpHgSxiqbL
	WKDYjfsp0V2F16rReg3i/JPMx+v63Dm0SfGrZrTGNRgdCqt07DtjGLlC+eLiWgn54MA7iyHhclm
	W5yEhblUu1rMb+wxxEbvAa/ektK9FyfcQyavrPFo35vIUT50xX27cvARplvYEIiItg6LKZ2RNMu
	fOz8qEjS6oYqXQBDet45K4bhMLAPbx8K+uSxhe+tLVAwlwYgXILaJL0G+8HHmhzxTTr3Q+nc5dE
	PUNsuaYftQPSFKY9S7S365vHhADscTNC8nNZgTbpSfORFeHLWWEQ4z0baZnSu8g==
X-Received: by 2002:a05:6000:2309:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42cc1ac93f4mr2817381f8f.3.1763736195510;
        Fri, 21 Nov 2025 06:43:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVXLVg+JpBLsM02kGG0z5u+UchXN/0lwnkDZob5QhAzEG71T30I0VsCqdgircvn6smhqXRBQ==
X-Received: by 2002:a05:6000:2309:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42cc1ac93f4mr2817326f8f.3.1763736194935;
        Fri, 21 Nov 2025 06:43:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm11445022f8f.15.2025.11.21.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:43:14 -0800 (PST)
Date: Fri, 21 Nov 2025 15:43:04 +0100
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
Subject: Re: [PATCH net-next v11 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Message-ID: <cmi23sbmgpmphjldjgsrronysce3r7zyptcrsqwqa6j5i26m4u@s5wscydfdgpo>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-9-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120-vsock-vmtest-v11-9-55cbc80249a7@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nf2CxgNL-d8M4mVI5INY1sw3Igb1r_C2eU_wqawmdgk_1763736196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 20, 2025 at 09:44:41PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Replace /proc/net parsing with ss(8) for detecting listening sockets in
>wait_for_listener() functions and add support for TCP, VSOCK, and Unix
>socket protocols.
>
>The previous implementation parsed /proc/net/tcp using awk to detect
>listening sockets, but this approach could not support vsock because
>vsock does not export socket information to /proc/net/.
>
>Instead, use ss so that we can detect listeners on tcp, vsock, and unix.
>
>The protocol parameter is now required for all wait_for_listener family
>functions (wait_for_listener, vm_wait_for_listener,
>host_wait_for_listener) to explicitly specify which socket type to wait
>for.
>
>ss is added to the dependency check in check_deps().
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
> 1 file changed, 30 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 1623e4da15e2..e32997db322d 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -191,7 +191,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh; do
>+	for dep in vng ${QEMU} busybox pkill ssh ss; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -346,21 +346,32 @@ wait_for_listener()
> 	local port=$1
> 	local interval=$2
> 	local max_intervals=$3
>-	local protocol=tcp
>-	local pattern
>+	local protocol=$4
> 	local i
>
>-	pattern=":$(printf "%04X" "${port}") "
>-
>-	# for tcp protocol additionally check the socket state
>-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>-
> 	for i in $(seq "${max_intervals}"); do
>-		if awk -v pattern="${pattern}" \
>-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
>-			/proc/net/"${protocol}"*; then
>+		case "${protocol}" in
>+		tcp)
>+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
>+				break
>+			fi
>+			;;
>+		vsock)
>+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
>+				break
>+			fi
>+			;;
>+		unix)
>+			# For unix sockets, port is actually the socket path
>+			if ss --listening --unix | grep -q "${port}"; then
>+				break
>+			fi
>+			;;
>+		*)
>+			echo "Unknown protocol: ${protocol}" >&2
> 			break
>-		fi
>+			;;
>+		esac
> 		sleep "${interval}"
> 	done
> }
>@@ -368,23 +379,25 @@ wait_for_listener()
> vm_wait_for_listener() {
> 	local ns=$1
> 	local port=$2
>+	local protocol=$3
>
> 	vm_ssh "${ns}" <<EOF
> $(declare -f wait_for_listener)
>-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
> EOF
> }
>
> host_wait_for_listener() {
> 	local ns=$1
> 	local port=$2
>+	local protocol=$3
>
> 	if [[ "${ns}" == "init_ns" ]]; then
>-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
> 	else
> 		ip netns exec "${ns}" bash <<-EOF
> 			$(declare -f wait_for_listener)
>-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
> 		EOF
> 	fi
> }
>@@ -431,7 +444,7 @@ vm_vsock_test() {
> 			return $rc
> 		fi
>
>-		vm_wait_for_listener "${ns}" "${port}"
>+		vm_wait_for_listener "${ns}" "${port}" "tcp"
> 		rc=$?
> 	fi
> 	set +o pipefail
>@@ -472,7 +485,7 @@ host_vsock_test() {
> 			return $rc
> 		fi
>
>-		host_wait_for_listener "${ns}" "${port}"
>+		host_wait_for_listener "${ns}" "${port}" "tcp"
> 		rc=$?
> 	fi
> 	set +o pipefail
>
>-- 
>2.47.3
>

