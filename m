Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B373A9D83
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809994; cv=none; b=d/euUC6//tk7wt5OdzXA/i4sx+bf1xgQQLseptmjphHvkZFgLyKx9cC/QaKY0IdrlLC9APgXyybihv9Xcv9TU/iijdJwZILU9UhUUeCJDRukYOXf/0/obe+Kd7syPpCMPB/xy+0qJs3vyLkFbyHruG+uUDDolt62sNV639bFsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809994; c=relaxed/simple;
	bh=3P3Yp7kZAgzbJGxtHzxC2EX0OREVvZPZwUK5CbfY+SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OH4c+OowGbdc7R00q70LIdMoD0Q4Me6jfWfnoa/way/TH9SvPwtFJosKaCdIkrcR/pTf/ljKVFi2cQDtTDxBSI4VpRxgziEbg2wEGsS093cHlYSz3ogR4PgIy/DfMuhllS8uBHfBGtJNpubJIV07SwUNkoevKTGgFQq4So5ynFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqQjo4V/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqQjo4V/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775809991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbV+a2kN0fqhbaSyrzX6IchPn1p4RqFKSu0TwhqfCNk=;
	b=EqQjo4V/BMjG9wgzdaYDd/c9EiH0XhApdLGZke6CdJrHLAK9AZSSJxBPtuzU2wE5XvgTMY
	WSkZ7kRdDl9TUVVvPwya1WTYp0G+1iicGREu8KGFjlhD0Wu+y0d0wwftWLoEvx7X7eDQwh
	27r4LLxWloS/lgFR4qR0HPd7dVtfJlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PaK0V8D6ML27_ItWQsmVUw-1; Fri, 10 Apr 2026 04:33:10 -0400
X-MC-Unique: PaK0V8D6ML27_ItWQsmVUw-1
X-Mimecast-MFC-AGG-ID: PaK0V8D6ML27_ItWQsmVUw_1775809989
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so15290955e9.0
        for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 01:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775809988; x=1776414788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbV+a2kN0fqhbaSyrzX6IchPn1p4RqFKSu0TwhqfCNk=;
        b=SEUaZox4AhUdmWKQuYHeFP7GPTfERkk4axhSXnLaImYfkd3G8tq6+9AIL3rQOj9FjZ
         1JnJt0wc8HkF8hnP8s2oGzIZGJtRl/PxlCBHjPFASTooppzhPSJYngojpMWwqOt6H89n
         xaATlc0eI1CbMTr3cfq9O+aaf4W5Sb9ZnTTOq7LdNmO+GKXdoVZpZVxTRHuVQBBklNYf
         tx3fV1KFb6/W8Ka3gcs5QH+AfU1FC+ZH3AH3SprSHVyhDKI3sf/gCsr8LYo+8HG1p7w7
         Fq8JqASaHT8AXrhSp7UqBrDVxEGyTqIQPtAAXC1+SD1jZFrAyOyWdBQm/uU71bIC7Jj5
         efcw==
X-Forwarded-Encrypted: i=1; AJvYcCUgv9aa8Vr3GEAK1btXo5Wgs3yMzTL7D95vPjVpK/eOPjO4nPGVhZwOI25bG0AQ6NpwJZcD2DCrH8MKIXvcvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI2YH9seMtsh+dnPUFoygMpZ+uo9p7weWNpu8ervQbmTkIc31p
	0sAubwIfMjiOqT9Hu+UQr5Jo+2I3v5ZbHictc+Xzk7OGr9FWY3HW43Vi5AjLqqQP0yoweKboacv
	pOY25Gw3KsTgGjJkXe8fs6b2zi5llIuCs7G173Ck8rMys8iOptACKppQf01Oc8bYuLqjmdHRPu8
	yx
X-Gm-Gg: AeBDiev/a3t/y189nIGOPxn6s/6O1ZKn5WhBT8h4V0HeZt2f7NuczCMHDegxF8xI5+q
	1LyixP8K3cHURURlQVf8hAccrevM9IHA+OWc03AF6XGHPhflg6JLhdA6z/SPW9NC/fuDvW58c6D
	DDqGAdBRz9QRJnG50wS+u1ISMHhFatNlax52nMlECjHo4pYRZNyMfFLFsX54HzMN9FGWaZgZmnA
	iOmy/+SGDPPyMBPVOFADapc4UJSFM0foJePoRpugFNdk4OQ9qSl7bhEyV5qXhBfNSsDb3EcewxS
	AkYztZ9902zdsUM9d4tSINKH4990/S0K1cmZQ4Ix4jOkDgNA84BIJhRLdFX96/8Mjit9gcy9SjT
	CVVq370LrDAQ6eoH/GRFn6ORBQ1TfsbVtsjEER+gJNfsQeFcSj25ROSoAOkLAfXx7bLDPP4XdGA
	==
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr15409495e9.12.1775809988206;
        Fri, 10 Apr 2026 01:33:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr15409165e9.12.1775809987691;
        Fri, 10 Apr 2026 01:33:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3c597sm53013275e9.12.2026.04.10.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:33:07 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:33:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cao Ruichuang <create0818@163.com>
Cc: stefano.garzarella@gmail.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket
 paths
Message-ID: <adi1X_3wVUsDhRmR@sgarzare-redhat>
References: <20260405195733.86043-1-create0818@163.com>
 <20260410035237.59644-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260410035237.59644-1-create0818@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NVBvgT_ztqOBhsm2K-f3Hwmnvdtx7dnbsizlvZkLuM4_1775809989
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Apr 10, 2026 at 11:52:37AM +0800, Cao Ruichuang wrote:

No patch description at all?

>Signed-off-by: Cao Ruichuang <create0818@163.com>
>---
>v2:
>- retitle the patch to describe the race being fixed
>- replace rm -rf with explicit rm and rmdir cleanup
>
> tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 86e338886b3..c345fa539d3 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> 	local pids pid pidfile
> 	local ns0 ns1 port
> 	declare -a pids
>+	local unixdir
> 	local unixfile
> 	ns0="global0"
> 	ns1="global1"
>@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> 	oops_before=$(vm_dmesg_oops_count "${ns0}")
> 	warn_before=$(vm_dmesg_warn_count "${ns0}")
>
>-	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
>+	unixfile="${unixdir}/sock"
> 	ip netns exec "${ns1}" \
> 		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
> 			UNIX-CONNECT:"${unixfile}" &
>@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
>
> 	terminate_pids "${pids[@]}"
> 	terminate_pidfiles "${pidfile}"
>+	rm "${unixfile}"
>+	rmdir "${unixdir}"
>
> 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> 		return "${KSFT_FAIL}"
>@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> 	local ns0="global0"
> 	local ns1="global1"
> 	local port=12345
>+	local unixdir
> 	local unixfile
> 	local dmesg_rc
> 	local pidfile
>@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
>
> 	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
>
>-	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
>+	unixfile="${unixdir}/sock"
>
> 	ip netns exec "${ns0}" \
> 		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
>@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> 	if ! vm_start "${pidfile}" "${ns0}"; then
> 		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
> 		terminate_pids "${pids[@]}"
>-		rm -f "${unixfile}"
>+		rm "${unixfile}"
>+		rmdir "${unixdir}"
> 		return "${KSFT_FAIL}"
> 	fi
>
>@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
>
> 	terminate_pidfiles "${pidfile}"
> 	terminate_pids "${pids[@]}"
>-	rm -f "${unixfile}"
>+	rm "${unixfile}"
>+	rmdir "${unixdir}"
>
> 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> 		return "${KSFT_FAIL}"
>-- 
>2.39.5 (Apple Git-154)
>
>

