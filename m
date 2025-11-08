Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB32566E9
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617723; cv=none; b=fpzjxsiO2Y6aNpct2Ssm9E+onh6SEKzWErxrI9gff31GORPCS/fyPSrnQFqs+0uFvh89SKdCJHZuYkhitwOSxqWnPyJvCm2B6T6kiC6QBcOsvuFI1dlWyjafOf3Ad05IouWgw18occVUsLMVU6oQTCEpIpcbCXdKB4UcO3m9CNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617723; c=relaxed/simple;
	bh=w7gg8llTsk8i6LDemrCF1OsQjSqJGBnLeZ97AFtyVxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hezeGeA+KTUL0DW64aeRnoK0o+X/vr4dRPD1m6NmGj2cDbHjErYJ0WYdL7gN2EOKIPc9Lo8JucVKIvPfAztzxBKXIBNM5/rtFznJf4K0J07SlIs3DfSjuNSxz7ebEidE4DRBn2kWhDpxbYq/qPkFTZHmEdzjY5cawxnflRLsDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT5SWO7q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT5SWO7q"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29568d93e87so14791065ad.2
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617720; x=1763222520; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=mT5SWO7q8tw3KRVNoFPkYHS9NG2c8WjhK52q1Sx5cq/Yc3ixcjJqQ2Nk06NALpC6Sl
         lOZZu/E46K6B7lIrHtnOk1hAPaf7VE0nWJ5mdhsj7TTzonU1qRjjhU2zhnuQux4xoap6
         Kz0WiaLkfsvJDPRACErXuJMXmtShajNStmItgQZ1UPtF3gylV17bCKQjIQbkPUkrGD5/
         HmcozKswNtLspPusBrAF3sK6tsmd4Waf3o/mHX4UnWqc6Q5pefWi6asa3Fv7rWeiq7kL
         B/w/wY3tjcCQPppcdwaV3RgBOvmZoebzAPY409176rUnwfR9NmC8jhHHhUtA/X3nQcqR
         FcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617720; x=1763222520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=ZQpwXKYBIvpBZ4llfNO8kKZK5oqe3mEHHpwGTMo/Mehf4q24SoMXWHz9uIJws45cGZ
         JjzyWbe49drWCr74BSxPM39GnKTmDHeL6hL0t4cCAEvRoNoB7GMEhDdkSFvfVWC/dv/m
         TyfGMyYoxzgCOr7T+MYAefTJLaG7AAFa6baGAcxQfzEP+mKzaZxb3upJlUvScYsBu857
         mN44aAUCOGlHr2sO0p57p2EUbN4toXHefcFmxQxA5QOXr31tBy6b3684E564euDylnky
         Xz9RaSaaKDJyFmICGxk6Q0Mw/LvzMZR2GVsmR7oTovJo4y7oo/o9BqiSpSKVwUcFL16s
         tdcw==
X-Gm-Message-State: AOJu0YzhUlzvZC0ksRgBy8cyaOAYDO2QY2p0+aQuxOG4xgg0WbHP31gY
	OipSNq0jqqAu2YP2DF6WJROC23gr7l6xXoIVJpoz9Wwej+zNpyvAMoYJ
X-Gm-Gg: ASbGncskFcp6kW5yBp9OwIc/dJxMNR4auA4A1YM7bJ9ft0mBSVAHm2cufM0yN42Au4M
	NZytYz6FCiNhyb6rGewNYH33GpPCbtrm+FE2e/liJfDn6PjQds8+upXMfHmKTa6wfVBUje55qH2
	+cwTR7p0p0xSMJJdzV5TvtKsefYdLZ3O/hI1U9MU6wQT7gFv5RSHIEBhFJmQK9f4m21YQFs66Uf
	8Tmk7NcJLq/tUA1ArAnHxg6Z91HXZz0Lvdvc9902REN6tu23+ol165EaMY8UKTm+FbJ7KKHynf1
	3zcEeoxIuAoqSRXnrkNHLzV6n4a4fiwo1Lpr7VP73xgIO6ua40r3Ed2N0A1BynTDlAc3imyd7QE
	U7RP7vwKZsgIHqQNYsVE5RygeKCUmpPMrcCjptmuGqGRfRCIJcLArUl2LtTz0rkktF8/Kia4VZN
	SxkUVri+iV
X-Google-Smtp-Source: AGHT+IEsWYP5FLryBdHCq6QBhKzU01pCZcyukJfx4pdeg3dtTL07KkZygsC7aczWVHGVLKqYDFo3Gg==
X-Received: by 2002:a17:903:46c5:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-297e562489emr34699235ad.18.1762617720451;
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968602sm95152215ad.9.2025.11.08.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:01 -0800
Subject: [PATCH net-next v4 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-10-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e961b65b4c6e..b611172da09e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -156,7 +156,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3

