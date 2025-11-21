Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B834CFC7
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736146; cv=none; b=AyzR/8SDfcUlLxPypf1FSZEkNN2c+u3lsdGflV2Tv+8yqIk7Q/vL+0IHFllXxU6IfIF/E6rZBeRN85pNXbC7iEu7ZVy7aOj5a/aLmi642vnWxnllVxixdmobyiRivzwpq0beSb1nNxgmyxEbOeFLuXBuRfT6zgK0xCaN6W175MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736146; c=relaxed/simple;
	bh=tL0PrPRXzvFMNUmQZS+jeR6hm5nHn34kXXtan4Z4rYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QwlnwfafbRFqLVXpFLTXvo84lBadgVx6jO/xQtUZno5yuw0bl+LsGKqiIJRzf1bLxW/tytvfHOxIvoHp1Ye+ws+eOf2MIJGygZkfDW2gRdIrgHjBdZft9vk2EdpgBOKYGTycxoRsukxeJyzwiFZ2BvyQL/PWObfGdKj5wJwEzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2gzx6bc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2gzx6bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ff3oUHYY/i63OgG2+W0AQ3qdCRaCGyr4AzC1ltc0qE=;
	b=X2gzx6bc16zSelkG1K/mhldK0obKazHJOWhlq34su6y/xZklYYr27k0QLxSgcfZE5x+Qx5
	jcQjdrFqfm0kpWxBhdu7K81BgGqH/JpmlUtciDSZKwf9AjPObaaPiQc3HIOR5zuERRpLfq
	/nByQC6UEHcwDczRTEA7h3knugMX/Po=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-nprg7K5dOoS7lJD-v95Vsw-1; Fri, 21 Nov 2025 09:42:22 -0500
X-MC-Unique: nprg7K5dOoS7lJD-v95Vsw-1
X-Mimecast-MFC-AGG-ID: nprg7K5dOoS7lJD-v95Vsw_1763736141
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b73599315adso165790366b.2
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 06:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736141; x=1764340941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ff3oUHYY/i63OgG2+W0AQ3qdCRaCGyr4AzC1ltc0qE=;
        b=hS+HctM4518sBC0BzA4vmaUbQRXRbdRcNHVGm62QabagDc9S8wO1gLUQtUbdPdVe3Y
         XRagj1KtiUAa3xFCiLPN+G9HcbPK0UTfYdXKoxwTXQOr4vLEFqRXCiJFvSbIcCjvyW5V
         qk/bphYPL6ISSwVoroa+3zTRd8CGjLcmeqCsHzUC+NBu5oKtL1LCAy9I2AajtFUG62yq
         UmqZd2h+5dW8EBc+xn5OrhbMxuXsg9iRLGZCNffRaI0edOGFpPnvPIk4doTsT//vSTTq
         SO7ryCMvd2cdghJSBPVcX6k7B6osgRJ0ZAYdgxb2k03aSsfqy4NcVU7h1u42a9SXF5sD
         XdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUah/nWWHQnZgH57EpoSXWuFcG9h/WLhn32HUgMERCbh6KtGDKBUhkARZWYqLfONUkRvE5Jx3h4xqV9Bypsxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFKasJ9nkbW4ZAWwxD2XfkWgDVgLtX6ZobDkErh33JaConf4oc
	MJ6cuonWvkWISc4JC9nB5vX7+yiI1mgQ1AHr2xxoMiF2gz0XdkFQoqbmkU/zYtOo1/U4H2i77N3
	kH7acO5inAjwp/4K1pJ27BZfy614A1ORy2XSWZvJi3L2d4iEEl0M16PosTNPOP7w00Ftc
X-Gm-Gg: ASbGncsR41VKJKTuleESTxUEClf0WGm4dO1v+wuVKy1R0Zvm8V2ltzGLGivYkyxxRNT
	M7AGgBaLl5XKHM4measuELxOPJfPT4JYvsh4OJodj9MWESVmxbSclAb0Bk2ujcDUAzmfw0YNIto
	nQI7RzvFq/hJgqjvhoW91qG6a8hkZm9VJ6FGh4qfwtoAMVts8ikZPQa4iXOM7Sn3Xwm34kiJGcV
	OLB4pJ8hj3WgDaTcLc0Fo17dRT4k0wZUcN7bI+pTp0uJDjAeXZPW3PgZAdyglBAAAaNdfYADn9F
	/n4M8IHqMWmtjaGHJP/bz6YfkgFELTY4K5aBJh0WO0GiOKUJDK07CXSmIMxfwdUC7ijUoxRqBb1
	r/wgXjq6KCnedFiCtkauousMvQFVbkExkEJrahvkqPv4bp1ZvP1v4CFdOZV9WUw==
X-Received: by 2002:a17:907:3e15:b0:b76:6c85:9b60 with SMTP id a640c23a62f3a-b767125f72amr248163066b.0.1763736141023;
        Fri, 21 Nov 2025 06:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpQh6yhHLGUKo/wsq6kHeGVp0vh9x4lS+/i68Gveg8Lfs4eInJ/Ie4BbRYyCHHJYP4NTl6tw==
X-Received: by 2002:a17:907:3e15:b0:b76:6c85:9b60 with SMTP id a640c23a62f3a-b767125f72amr248158866b.0.1763736140567;
        Fri, 21 Nov 2025 06:42:20 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550191c8sm460235266b.54.2025.11.21.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:42:19 -0800 (PST)
Date: Fri, 21 Nov 2025 15:42:16 +0100
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
Subject: Re: [PATCH net-next v11 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Message-ID: <xswlfomv65abcbcp6vcjzu5vr7hen4rvayviniyjynawvq5ghn@wmp224bnmpd4>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HDoPs6xYlof7D1ohmT3poJi22pwRIjmR3Ud0yVojVNs_1763736141
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 20, 2025 at 09:44:40PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>These functions are reused by the VM tests to collect and compare dmesg
>warnings and oops counts. The future VM-specific tests use them heavily.
>This patches relies on vm_ssh() already supporting namespaces.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- break these out into an earlier patch so that they can be used
>  directly in new patches (instead of causing churn by adding this
>  later)
>---
> tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 4da91828a6a0..1623e4da15e2 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -389,6 +389,17 @@ host_wait_for_listener() {
> 	fi
> }
>
>+vm_dmesg_oops_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
>+}
>+
>+vm_dmesg_warn_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
>+}
>
> vm_vsock_test() {
> 	local ns=$1
>@@ -596,8 +607,8 @@ run_shared_vm_test() {
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
>-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
>+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -615,13 +626,13 @@ run_shared_vm_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
> 		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
>
>-- 
>2.47.3
>

