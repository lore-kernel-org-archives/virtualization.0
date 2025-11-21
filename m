Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331262F39A2
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703903; cv=none; b=VccmeFhgL4oYk1Km8KwKhmMUtZxgzDvbk0vyip+1D3u+8/okymOru2ZMCyhUTwn2Bg2gV0VS39ZRaI/QFZOxpd3OMV9BVzp71onfjuzEA/XDJoNuc1iZOxkU2tExIp7tzbZIWCuQvUc5ry4MpjSFDzXJGOdJUwGZfQDfjN7+TPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703903; c=relaxed/simple;
	bh=nx6UHyycvOx0nOMJPrniexSgcT4f8Lew6DQLvX17eQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDKHeSCLX1tDy/je9WyJOXlufCgFv/dBvbQtvGn/nTmqVfue65KJNhzpNmnKME9YURDTf/2CO4zbrBm5p4AgiYMT4+f6soT+W7xZ9K5s8BOq+h8mmz8JedJSik/QWxqzYzx1ggfDiFqDBHU4QS/znEuyCzhf50m6/TTiNgb0xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd7Sdl2j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd7Sdl2j"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1847858b3a.3
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 21:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703899; x=1764308699; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=Gd7Sdl2jet14tF6huG5Avz8wCYih4R219zXvz/uZkISods/sGyJ6uZSJ8owqoJ+q5p
         e5S2fg677g9h+JSemox6PfkUpRYM3Hx7gJRJzACuSloEmccLuAX3uNshuxSHWYM7ccQA
         WK/NAeQLaSN7jicShhQQW5qMYLgKIINtgy3yI2qcI3/2EkGTwsBGY+CrjAMHvgeNf21T
         ag+ZpHr7NMyn453IltHlk1P8yGFfKLZ24F3N9H7gZHL9egaZS4nNog4N8BhXYP8bGFfD
         aj/QobBD46Vlp0AJYSGq0e6306W7ca6njzuZ5RbQioCM3N7NoxDqXvbg5HiUYpvHzG7w
         SLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703899; x=1764308699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=Ut0zzowFxQr9iDjb6iGGuHtkocDSRhbEglwEDRDA0IErqwLxFL3cGcC2iqrWoaVQx8
         rpZRq8BOSrzt/ddsxbtOau+5eQtH0VUcKNNl54A/DiGVfijTr9HbvQnCaAvJjclTNr9F
         xC3DMH8bhLahdeBM8e/UvzTYhyVr820lfpzvyFniFXgrg7hu8ZNX+s9e6OTKE3+5ilqI
         9onayfclGN7va989av2Ag9V7AcMcLVfKZJ5E8uYOnLlcWtaWlcsrspYeh2biNzbjGJ3m
         MBQ9Gf0MEbw2oH58YOHFYSNOwgbL6KKpyZNVbD7berWzOqLLEU9FxVcLt7DDJarIMuw4
         nnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBizbzA+RPMjF/dqKbOayJF5OvL10KotddjzrY7nhBIjDkRJzG38geI+OLKxyTRoKXWV6OMCgJEnk84J+yxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdKC8NUy/PzvuA9I13ZEPhtnJG3O0k1akp+1iWJ8iua2SkMzUm
	POke3Qh95+3HoxvXVHcUL8gY24GR/HC7WaqoKB5pkKZ5pJ6b5PZSF60a
X-Gm-Gg: ASbGncveZgLgXP0gr05clnbbmgEcQoEo7OL0WUUmmdiyIOa2jrwKi7ffxGWP00GrXbG
	VHS1GfMhMgFkNJIU4x00OFf8zTyB4yyxLu3+lsUGqSROSUDWg/TStTQRUTVdfj+yEynwx/rtR6H
	L23I/XEd+Ga6vOtKaJwSsmuYIYD0bhHAmpA+ChBALZWfAbkcC1JzJ4XfgQg8pC1pkaD+moNGuqC
	jegzdcyypcLfdE7Q04vSv+Xqz0p2BgFCrHsJ01UN5TaEFFkXmuhFC14UArCzxsySEMgtvDufuR5
	uKmgCHLoBo+imk+LSlwldh+Y539S/elpMeoZyoq4Nlc+QCuFrY5IFq7OJQf0fHSkzUYN4Fqj6VM
	eeDCRXOcONkyeoJoXVRbw+Bs7d+fjv4QAnUqp06oVhpi/hjnn2C8pcotJQy6ZENI+5eVem1Fw7v
	czmVV7kso31r1H8Cyah+brFy+P+zE4rLs=
X-Google-Smtp-Source: AGHT+IHqyE0w19zDPkaB/Ash2VMSaGraMj87gNleVuj/tN2LhZMjdzS2nkC0fyQfEaBt2i2bVW/KCA==
X-Received: by 2002:a05:6a00:1ad2:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7c58c4a4fe3mr1123886b3a.7.1763703898643;
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm4627465b3a.50.2025.11.20.21.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:40 -0800
Subject: [PATCH net-next v11 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4da91828a6a0..1623e4da15e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,6 +389,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -596,8 +607,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -615,13 +626,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

