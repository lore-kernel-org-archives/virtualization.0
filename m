Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1A2DC78C
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090433; cv=none; b=ONYI1f2IrXimKxJ9PCYtjOoGlzBVIfWh25+qJa6Ic0EExqxl7IlBND6SEKyzB3ARJYW1J/dFigP6nZfKtcEVbqd7ppcKeU5QVaHRl11PvU7v+mdW9+cS53LO9csL6wwEwmT5L/w+F9qKGVwIiIAq/9R1gfxy7t8A1e+6pmIiGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090433; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbsF0+5dLaWbfBg8PlFcuBgtBZwPePpiEO2HpwCBmdYSDpGNXD+p8H0wUQCzYojKwA/HtGC66fMVC1+54Qy+NIhJ14KVCFBkcDRvW1+2T9VzWOOfjt0S+N/PkwLnkYMuzNEJ62D1knSFivY3+Fry8o0rc0B7J2hhbwR5YRu3HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la/qEZAs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la/qEZAs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-292fd52d527so7789455ad.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090428; x=1761695228; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=la/qEZAsZ5exeW8HeuSk48yHnTUuZdIsiYlJmkef2DiB/zoMg7ZZMWVkm3+BDxPqH0
         xunLMnZXgvCmbdQ7uozrZ+ueINkZ88EyhkQVi+0whsp8SEMJCjjpzhWI6m624TGGyEjQ
         TDVGx4bUo8Yl8UD9dhUBafWitGdPGfWUUzBhUHrXIjdbt+fCrPBjSAzQWM77f/KG4To1
         JqRmRmo320OLufm5pyl2bEjVU8qfxhvl5nTQ4mq5ABj0bWfMOLrKJA63iezGHdHpt+kl
         8eA+2ZDbdwzpeX6P2WuSCEC6s3JHd7WvPg+71G76Zc00G915U20hyQ9UtfMnNfNwoT8a
         mPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090428; x=1761695228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=n0t804dvyxbhHrJY+CFwOKOfWNahpfMEpX/MsaiYHLCga1s+EAzzXmAQuFFyDD2/LM
         0OyLVG0EKSPeZ1zFQ3J07pVTgISlRJGbLWLPyGyOYQW4Oba0bN2AIyw76bZpeYiEI31U
         yJ/HmQysG/bvET7J3ISz/n8x/sKnxpo2Le527ISg4mWTkd2jGHF7cRSC+ZZMXVxs22v6
         WF+zdK/qo/F/kuQ7HCr80VTZEUCKJUdvaz8Lhe7NPrjWnk/F9fnQkedcABcN1Hq3zmPF
         VAp0fx3ipjeXU6Uj+LWqf2tSTAEe51a7wd6rFa4DgymL9lDbLTax1uYP14/zfqe30noW
         fcyg==
X-Gm-Message-State: AOJu0Yz6M/izi4X+TceP811OQGbQWp0pj3H27avp/mMHvyuV7/n9kKwy
	jUIBQL+FT+BoknzKBLHRnJ0UFxLw5lkS2CTpNO2nxG53SBunbT+qzwF2
X-Gm-Gg: ASbGncvfKQQ7rQa6FzC1PDHNenrxv1RCBsoPz6Q9kKd0dfVe55FbIgn5XCksho50zgk
	6VclsHJsy1M5dSMqSjpdUghyzT8eX/hE49XYIocJ3l3Mewe88G2SR3QpOM5FiMzuLIMU7KvPi0s
	YiIfYssBS7MocmAyA77td6EWbBXGaNdpNadCC13YuYXfS1DsUsOxztIYmfH1bhdBVfHCapNgLR4
	uLu8FzGlSvUr4FvHpafDoQNbxR7bEmZYhEzb1dCRjLqlhkjnljotoMhw/bRvogfGCkNUzHQs0i3
	l34GOWJ19fCq655xN9/8Bf2iPleUIFVY/JNFig0yPIQ4Vz4MtfYP3js/nO8swDs3Fabuyc+MO9X
	UDtX7zqJU6ZbpncvUBgfuH47DLSAY7VUX08vKiIwQZp0m+qhfAaUvDFmrSNNI7BBWMjnTi4hXQA
	==
X-Google-Smtp-Source: AGHT+IGw80QlQNTM0vsCWt4Xrwj7+OMB8f2A+GUNehs8ToYoF6rhSNtapD7Jyv42u/TS1+BhlWruNw==
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id d9443c01a7336-290c9c897damr245660295ad.9.1761090427698;
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm120683495ad.115.2025.10.21.16.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:52 -0700
Subject: [PATCH net-next v7 09/26] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-9-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Save/restore pipefail to not mistakenly trip the if-condition
in wait_for_listener().

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used. This will enable pipefail usage, so that we can losing
failures when piping test output into log() functions.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 561600814bef..ec3ff443f49a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -243,6 +243,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -251,6 +252,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -258,6 +266,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {

-- 
2.47.3

