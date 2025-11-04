Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821134886A
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295962; cv=none; b=lzbmh+0aFxzmD8/OzMl4Z7zhIpEuGslDGvN9Pi5HMUvgviQZGv3s0bioLM2qXmHX1SrXeNYdWsDnVocDESgq7twzY36O9x2/2OywDMWSJ+FlKbLFfsGFXOF3qwtPKeTxVK6sIgWOkrdubMb4uDbuK0ZVHGzzYnxssWImD5co5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295962; c=relaxed/simple;
	bh=u5DCKGRI4IXZokQzlkyrjLd6GRAOJx9KYjbavhXUqwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqeGSlUNJKXO4MGL/ZsDFfYOEuCGc9D2WSXIYYzeKkSDcmXQkt34psDXx0BLA1uJrWtUmuOqne4hD2U7xgWUsrwMP3adeTGyt1ZS9C18xBuZ0E76NefVKgkzGfmqAxe8KWYirRWXPFlk2FiCImJV6TNmFK2zQNj+FiIhjxmjFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciDwb0hl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciDwb0hl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b9ef786babcso1654370a12.1
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295959; x=1762900759; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=ciDwb0hldgE2JCSNyF4XYVVv9TTnZxrEFe7/s2ZvYRM8Y82maZldkJuUi4q0SOCI1H
         xeEY8I4JT6EhB3bP6ZaoQzV2Js2lcTCKn2nQqv/5S0Q+z5f7TBOgO0aMhZV2b25tYTqn
         /GcTWMOh+/UEpsfglUQovUrI8zhi3BPCkwl2ksMVJ6aWrNmXpqgNJFC131cH5vS12YN7
         z5kwXSBdCdVQgjIYt/9gll7YGVpQkpV4JqpDiYKFTK1LPmYG4mYhRZ2N+HeBZzC3xUBL
         XhLtd8DquDHdMjGOrNn3jLdkvREYI0ZWZqHyhtD7rR5gOOqJKdYA5MJGis1SXy1eM6dw
         Wugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295959; x=1762900759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=G8N1BEZh9Sm1thLajFMvPwM6oLHBxEAMRNhphxRFvRY8/ZMYszQA1m5tiGZ+KeQGrF
         JlJHh5fhWu45hK2/T+Dbgzj/ut9RULFAIYPWDEu/iTes/RJ7CDOWF+F/cKxfzzxkpFWm
         R6L+mch5MpLemzPfh4AJNsyw46n80rFeb/56XlNEOTariD+rDfRbZHXf2ZLetDS5P1kI
         k3l/e/r7N1FD+3HsDK2v3K/MkjUnbmzYug/3fAAHto23WZjIlQBkxCCimpk+ShqV2I5H
         D87ckVcorVTewLzxQoqVp6vesDUaMs+9UQj21gp18goIxWjiboe4IGl+SvI07D+pzEYj
         hlww==
X-Gm-Message-State: AOJu0YxvT1oOviDAy3V/XCp4aQgubsaTBEcdLJq3SImMpVHYeuHB679o
	RX4ZLUxZ+iDjN/QAQFwWILLMfVrWi8ldbm1fAOhK7uyRTTnjX3GgQLgt
X-Gm-Gg: ASbGncvctZUGBotD8V05NhFsORJuboCF3qYLp4M4eZmtcbngoYFLhWUiyZ8095n2NkL
	DuTSoAHKP60ZLIRUNMZpFRt3yHO14b+Ud6hHztg0vWbTF97v5dLbYd1zjNNTtxdZ8oa3Hw/aXKP
	m+obc4LdpNdt1xpYWtgdStU76OEgjRE6roClcly/d2iYUwhEVINKu/hCdpkPb7msqig/+BrO4kr
	PxbXesCGkXSDGsF63I0DP0MqOWh8z7t8n8FLaFOJ9PDsHwIBXNpgLlWtqK4dPj+6b+mk4S8OZHg
	oXE+ShaYGrFw46l3GktpR5515XTOr0XF8XSCsfg44mygqHhakSO97h+pll+H9Mnvo6UJOktWZ3P
	Tv/aP0V/82VWcQhnI3wYHuV56XIKm/XL/Ye6r+zYPhaGAhL2Xa5ShdEtReBikkL4Vj4VIUA==
X-Google-Smtp-Source: AGHT+IESw972+NQugcgnm78ZKTviYmRok4BWA0JCtmd+JQgIjTPldLbnjKbimXu6x1kSemHZnD8cAQ==
X-Received: by 2002:a05:6300:218c:b0:34e:63bd:81b6 with SMTP id adf61e73a8af0-34f865ff9f0mr1241428637.57.1762295959215;
        Tue, 04 Nov 2025 14:39:19 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd682163csm4050602b3a.61.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:01 -0800
Subject: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0657973b5067..cfb6b589bcba 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -434,6 +434,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3

