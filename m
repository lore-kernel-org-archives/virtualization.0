Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A82FB0B1
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476605; cv=none; b=lif0PFzIuGSttuRbzKcg542jEyd8e/OZ2KyqACYhi0wOpIqRBHWUjkDBA/gNjc8q37IrYpxFGDijcyZxV3U+G0F59JCP/JGIfGuONMqMX59P7N9UlNFpn3i/AffCDt/DwjxLYc0J5BtVZr2bTEX/ZDxal2at06r0nQuDC7Nvgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476605; c=relaxed/simple;
	bh=GxjWMLryYjjKJpr6TT3LeDbeqAWdzd/wbLS6W72CbIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dm0eklxXIVYnEKIcb61fw/aRhsCVGxc4KEXUYVizOqNsr2OVJDSIEvKiTJIFFgW8nsSH5esJ+PVKHm+b7Q58CSCrhgxoEMt9VCnrTYtz7r+tbJl29uSk8yLWFwuIjxad1OTJzWFyvLZAULzJW5vEUwpkk33TMozOLoXlUpjtFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naLROubu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naLROubu"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so306414b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=naLROubuDTe4NKyTBWodplcXDiCQ47f88f0BzMcTpxHB/7hSggWfG9z2D9Oj7FJbH1
         K5h5AxVCTXikpN5dg7rT00GsvHBVauIAEVvGmhHlxjsHrLHXDt6Cs742jRka3wUDprmU
         y/84tI/FN5KtMvAGXmjg5avurnO2aJ2JyZozd1CUiCASCaxrL4+A+0H/1Ef3RcEMTeWX
         vyYT517xv0DYa3jTFduH3bECJNLGYesZdTE4e533daDOQchZI7t5JZ81DtNpS2ZmoR1W
         EAguE2fTQu0QJtFjwBa7CzV9XB/SOWX8nc9QynkwS7q+3EvIN+zTK5gEB2zeUECzFMRC
         taNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=bjREww8bGAZKAsD1jEm5iYEex/8Dboin6n9T/NIXHN1yS3k09WKG8c7eixafPSnPqk
         bOACT72VxA5jHYeIofPnFNFFEe6d8ySkbtWPIcEsBNqKzucYHPg/rJS/M3Yt1YIRX3zT
         2hwJHZZmK5qEVkvmD97dYLh8VqdbHPRvidFKcOOeNhxjNBdHF6DwSYJdDFn1kJ5GpWnp
         HWwrPkuB2JA20VNBlq2bVzjauAM8cmRFx1kigu1R54ZAs/CcEwsZwvCys5YgHRHrF8r7
         7bB5lFg2OHbSpu5XMgIfnC9K2Wd/AZXvsLbY0LZ8gSTo2tuAD/z1YMB11ZPUli/60xFJ
         0ycQ==
X-Gm-Message-State: AOJu0Yyb2lLlSkstsiFAsjpm9l5FjoSj+gvSsMMnnylb5lfjiSXV2GUk
	g7hoFBvVQmEQCAvT+8ZNj2MSjUatebg4uYWHgmLiaSUYYBWJ/5pa5CQ6
X-Gm-Gg: ASbGncs4jKOrQ6gi5m4QvcKQbzCdrmGlJcfsTPWPS9Xxee13VIuzJs2LvGEtNeZPOdm
	eV0VQ5Eg6GUDOyhvqtPX54hOx/jxM8NQXhhLXoTM7Np9rjq8hyv4le+YJytdwLCOYOQpu37w5uI
	hDnoNVOLafIe7PH9RVSaXzAbonMszixgX/iNRgAbMCmNEFPU3WAyU8QczHqxdjYdlZuvecqcXN8
	wXZNObaYtvfn/wE5C6rIrPTzhmP7EjuuuoKq0htlPGjzjYdJKIDH1mXPbNVvh3gs4D8C0KfK5+s
	LH6EkGx7LM5G7sOKqfy5XNTOgXelErQ94DZ6dPxN3RDJASiji9pXXmpKzKg8sh8G+aZS8+vMxTV
	ZWbP/sqgvIlxhgdQqTXoPWOu4XiP/tt9FVnSd5x9ZAim2flCs7UQtIM5l+X6//xF7S/zn7cdP
X-Google-Smtp-Source: AGHT+IGEV5/i8frm9hdbKMaepp45D3BIIaGPeZxpCw61DZpaDradXH7/QyynY840Xwr3dtOtnTjxPg==
X-Received: by 2002:a17:903:943:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-297c0389dd7mr18651925ad.1.1762476601515;
        Thu, 06 Nov 2025 16:50:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm40921705ad.102.2025.11.06.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:54 -0800
Subject: [PATCH net-next v3 10/11] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-10-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a5c33b475a39..cde048bd7fe6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -463,6 +463,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3

