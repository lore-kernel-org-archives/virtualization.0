Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91526F46E
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714034; cv=none; b=mdoBhC/SQUcWzzttBBsr0LPU80AFPlp5nLpQAm19p7wxB+mmDj3NpJuLk9UBhUASRempufkg4E8fY2sWOXE1AEEbT4XiWkoJ+ubLDlkwtdOTiXisHRvNQxtmUtGU74Du3+Mg9+Oy3WjM0pBvtxNHFLepmLgi0UMzDpukDz4PQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714034; c=relaxed/simple;
	bh=7YG192ZsD3WUn3drwZlMqsrENOopUzB5dGEgYOknoQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ObR1MCFJ36hiXN1dG9wB+/u66BeuXizLGOj6WA+67qO4OSP3e/tVZmEQ5TEDrt9VtLzP1G4ek98atp7yx8CwzOCCODjwS1DVKNOkep+vdPnXZS/yvkzf7fcwd9Hph8Fi710fn4WWWLPJfxOFBjGaN8Wl9WoFFZhzCK0Zdaheqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeQJFFjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeQJFFjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Egj0FQy/riyQmvL5sll8nVIB9OlbYijgnbiGu15AMX0=;
	b=KeQJFFjXqZ1nGR4AvbexKTV9YcFU+6tM1mCQmJ3RJpiGnCebF2JXugp51jrOr1LkPYhJpE
	uBP91ba9QS9BUDQh9G31LDRvYaEia2/6b29pDuLbkucp04WvstoCBXPhVpfLlqYOh4WQZy
	coBsuDnPbXSEp0c/3GQ815xF4+PefUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-cs1eNfunNEmWdtmvj_vRiA-1; Thu, 08 May 2025 10:20:30 -0400
X-MC-Unique: cs1eNfunNEmWdtmvj_vRiA-1
X-Mimecast-MFC-AGG-ID: cs1eNfunNEmWdtmvj_vRiA_1746714029
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac79e4764e5so83639766b.0
        for <virtualization@lists.linux.dev>; Thu, 08 May 2025 07:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714029; x=1747318829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Egj0FQy/riyQmvL5sll8nVIB9OlbYijgnbiGu15AMX0=;
        b=s6sUwqsrzWiLM/9v0zSLdJDMZoXuC2yLvnCGo9OT5w9nA3PbZH6u3NTto5oJldUHbk
         4bH2oWym/4yJaWCsTIvJfgjkfoSTQfNOiW7beCpIpla9AE5KdRfovN+bTCDiF18WOxXE
         DLOBIJRUU8eCFcIMDPUb05Y46ReE9AwCGPkh0vrUqvYQpDPmAmknsZB0OuV3NXyARw8D
         g6WNC3G2abYHkDOxmWyljb+nJpnrDvE4d1wegvPmJcLit1rPvMjsb2Oa92pa3ZEgsWuT
         WIMlwyvIX6PV2DcExjjDfW/6zAj+blmMdMCwAUD6No5KgYXrDZjQz90rMtNWQ+cvA/ko
         tpWw==
X-Forwarded-Encrypted: i=1; AJvYcCXy2C/YdLhWB4JcV5Fz27VJdFlcqi5/bmuYsuf0jva9qYCiN2/y2UuL65vAGg9c6h06wxyPOMUYiWIzxRrCOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUOBycLgYZ/Re6RPk0bD4r6B+R/pXqrAvZ1PqxoghN+d6ZkdVs
	Y6GPfaW8wUlNgjiWXAR+AiLWYuqcm3pH9MCErJ652AfR46fIEMVIYPhXlaQ4y64zqWH2LzHnHr3
	Nfc+rVHSvkBVki/a6K/gLC43cbz6zRr9Erw2nC1KK0SvDE6IRuIgG+xjNZLNqNPMT
X-Gm-Gg: ASbGncs6yPo2Z44zeK7PrpO0NlusoxMKA6rU4Go4on3Kyc0iEtYdvN3vrUYOwAPpbwX
	GPxpPc0Qin83YcVX/I/+ZTFvYw2qyeEMFj4IbNhk5ofPWXGzmscxefV294Of23L/7qeRQo2rFdP
	RAJHfQPZqmrlL07c0hFtQPnkqpgguToe0VmmVtBDgECOUZbw+H8JJYbs00e+lgm6RVU+87oZ/NA
	lUBeP4PG6pVOrOjmK47XGqQ9CXEXYvyiZFgyRfSi2v2FLz3wmXLvpda3PxKJyaEHTa/luyuhpuF
	fvVqIEm+0Lkfu9IARXyUxl0QsQ==
X-Received: by 2002:a17:906:f10a:b0:ad2:15c9:9c73 with SMTP id a640c23a62f3a-ad215c9ade0mr24419166b.34.1746714028970;
        Thu, 08 May 2025 07:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Oe8HK04stKuYdcastU9b8FffLyMB1PLqflqnugfQTg8McvY43KaFdQo960fI2h3cqw+r9g==
X-Received: by 2002:a17:906:f10a:b0:ad2:15c9:9c73 with SMTP id a640c23a62f3a-ad215c9ade0mr24416866b.34.1746714028437;
        Thu, 08 May 2025 07:20:28 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3f1asm1103005766b.64.2025.05.08.07.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:27 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 2/2] vsock/test: check also expected errno on sigpipe test
Date: Thu,  8 May 2025 16:20:05 +0200
Message-ID: <20250508142005.135857-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508142005.135857-1-sgarzare@redhat.com>
References: <20250508142005.135857-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jkJcLAef3ZHtOW-ExWaR5IxDXRQI3_vpAGteALMNaIY_1746714029
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

In the sigpipe test, we expect send() to fail, but we do not check if
send() fails with the errno we expect (EPIPE).

Add this check and repeat the send() in case of EINTR as we do in other
tests.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7de870dee1cf..533d9463a297 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1074,9 +1074,13 @@ static void test_stream_check_sigpipe(int fd)
 	do {
 		res = send(fd, "A", 1, 0);
 		timeout_check("send");
-	} while (res != -1);
+	} while (res != -1 && errno == EINTR);
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
 		exit(EXIT_FAILURE);
@@ -1088,9 +1092,13 @@ static void test_stream_check_sigpipe(int fd)
 	do {
 		res = send(fd, "A", 1, MSG_NOSIGNAL);
 		timeout_check("send");
-	} while (res != -1);
+	} while (res != -1 && errno == EINTR);
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
 		exit(EXIT_FAILURE);
-- 
2.49.0

