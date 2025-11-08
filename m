Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C3225397
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617715; cv=none; b=UApp6YA+qJtvO08OZV61sEaR36EJq1AVOKHaCRyNSpCzJmzOp63HIGcyeQbZ/KfAcjOxynpHN8jvZMkTwS+JhPJ5InoBs9XHEQyC88KF0dpLL6UewsshLee5ZBI7MVKtU4pp6KfiAJVP/M+Tbc1xJQsgDpBoTCNHLhcmN6tMKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617715; c=relaxed/simple;
	bh=km2A2/M2INKPEdopMbzPv/EYa58WkO98Q3inMzUAOZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDgBaDWAM9O52dWF0NT6LmH24zwhagaj2uyATL165C1DBIsXqb+2wDNMsHMWHXntL4mKOXx4fcpQmMaxYL91JmQMQFC3PyPdrhrVDR9Y5aSoipSk8sOuQTi0PB4dSFgerk3HnXE8ek+IsuhHD/EEaEMChIKULwHrqAfuyfIUnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmCsxO3t; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmCsxO3t"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1073178a12.2
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617713; x=1763222513; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=NmCsxO3t8bIAdEEINJwmHUMnuEKdKspT17SM3y6ghOMVfPbZme+4NRdjXWzn4SQgjz
         TFDkkGYHOTNzKOSeLo0DHYU8QcSQpKFFlCsO0IahxCeEyElfUqhysIDde3gk8tT45xSq
         IT+WxONeFL0vfWU4tsI19TDLjPt47u5tDiOWOZQeubX1MPwwnzqnvj+ZhhEFkUJTdQ5l
         GzAb9qmoRGS2mJSbjcTJgIowLxE12+n5wZ72g3GY4p2d+6BRmgXl1zWqNNhKc+GlQXi4
         QIf8Mdwp3I88r//NOOFdY87ybCp2KrggN2CVJFlXUKmQiCGAqtRpWyyKYRtUhycTRKhE
         fBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617713; x=1763222513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=HWx0RkfhyW330ZOWX+CTQXFtN0vBmmmqFg2auAggkKyAmT9CXjPj3P6hrAEQsb7gq0
         S2BOEuXaN4GJFhEO2IsbId9ymLv67j1nRv151VztlVSm4i5Y4ovX76gUOJeHMptT4vB0
         er4viM1pJXG0bn0PyBi1ELoRpmlGWAab9e3atsDeiuSoCwE7wQPp4Kj9fRL+Svx75OtQ
         KYJAXNLYGdTUP61V+8xqZv8GtiPIl8lVQ4GklSZAOTOjKqrbBNwsbHMgmUbntP1gij3U
         6wOELQU+q+qJxUEPCT9FnItpSaIOpu1QG3jRea4aEakpX/ZeqJhL/fIbBMQswYxcWZVu
         tWOg==
X-Gm-Message-State: AOJu0Yw5U+nSMq2VhbfhQ5bxEovk9Zvqp0LKrSnwJOW5YiBeBzobVTdG
	L03aKwJmWMG8kzUslxegFNUy1D117fEUXRYqxqEceq8CUR7NaoQZi7mK
X-Gm-Gg: ASbGncsIYZS8AR/yrOxmJzncEPtdzxLFA9dCewkg0fl40EV3c1WQrNol/fAYxmLiMCh
	mboTosId0e+scn9nSBFjAtY9snZpDhLg+pqmdJAWaQ14aBL5oDUHqPKyaR4lZEYEbInRYHgvJ/u
	QDMKbUSVWYSLMJgOZBhu8lFOWXjhOsCKT88cTb/IU9J03MA6L0SnnR1mXCYLEd92rEIE9c1Sz9g
	/34BcneDwsCNG5VcXxzt9SoBYUQgo6NmBCAXb637b1DDj/oqXHxpKwnK4PMULkf16ThG0r787eZ
	W75ErdqL7s18ovXP0vbmwQPzPkNKzFBZ5QAPUaUkwIZdEXPjsrJ0WzZQgMBpX1p0J1GYbobOWCx
	zNzo7imcJVVbo4lz3MECqMxw9+gesgW+YaSVPJGtvQdVPnAz2GqGw7EUEZuiGvP8GCXUSuPDS
X-Google-Smtp-Source: AGHT+IEXDETrGkQl7MwHVPnvPebwCXZubSUcSknCNmpO3Ei+QqK+KDEUJEIjXX7gb8KeZQyo0pNbCg==
X-Received: by 2002:a17:902:d507:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-297e571bce3mr36484105ad.56.1762617712966;
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f6cdsm95463135ad.71.2025.11.08.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:53 -0800
Subject: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exits, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bc16b13cdbe3..01ce16523afb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3

