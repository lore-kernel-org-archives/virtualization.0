Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE115D52A
	for <virtualization@lists.linux.dev>; Sat, 18 May 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716017086; cv=none; b=nqUFm7KjybWJ8CKUBo5SGSRi1rrd13/OOMYzETNaOqT8Ixi7jQYdJtJemcgwnXo21nmE51tE404nnPrQEa1sek2RF8HNIiOQvI+8FiYo8bY0+uZwJpzfXnAcQH0Cjv1ki39GklN2VQ1XsDtX1Pf25XCkf9Rh8+cj+vUZEJmdFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716017086; c=relaxed/simple;
	bh=a3XvBXPOApY3RRFgdOHOwQDdLJuSEV/tLdbjK+TjgbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbA1cJ6l2xTWl3eYFFbGAOGNrkrnlc2ABLGW5SZsQ6dqFrzbJVqA/l6o3xZhsDLbAxMuwWoZJFRlgZY04ajmPjShoi084Cvjrkqyf7CmHZ0ZyICA5JMA0t4xfIGoOKJvqmo7cOrA9VaoELgSZGQb91ykyyoB+nsW7B40sjRU+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCrq8i7Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCrq8i7Z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-622ccd54631so123384647b3.0
        for <virtualization@lists.linux.dev>; Sat, 18 May 2024 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716017084; x=1716621884; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4IQYxb+uDF+mWfJsVcG+5UtKWGYyO2JjMy9dD17Z8=;
        b=oCrq8i7ZFCp1aPyWnalqgcSPLpk/PR3AB1un/bL69CmlOxLYdtqxtiLX+A6p6H1E+/
         l+D9BSeJKs2NfavgFsgxf0a3pPsX50Jfedns4Fm899R6OJ0xKihVISQpYMZz61Gizy2B
         X1tEdixAFWwS/S+way8Nka0Xu9eTSSlHL0h/Ip7+YnhGt/NwuhlwglqYw7rvbz68Wg05
         VdwmGW/FFx/dZ2zil0XHRpNJh8xiaMqOmX4iBaOVZlU3oJjojO3BEbCIJJlVbPxUzBEl
         yGWR3+zbiYHuHi9McnxPBWt6C7PdCKHuzWtUQO5M/opWZjRWOpTzCRaeIQuXFNuTI+iM
         FRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716017084; x=1716621884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4IQYxb+uDF+mWfJsVcG+5UtKWGYyO2JjMy9dD17Z8=;
        b=nIxf5pNjzTWEJQGAWWrrx2AL7lxRO1vNz8f+ARY4Ac2wsjQncm4QOFonTvO7HfKOUc
         DdSoxTlncnla9UCsT6uBJmR13mHIoIv3y/n9wa49R5s1i9vVvHJeKNn7gYStgp3sBkQx
         U+RzURXgHdezVfghNkKGftCgC/xT15gKpXytL98HBLx4qUrdoJM53KyMvjuubt01u/aC
         tFY4jDKx686AwcP3CLmt80Bwibwhz91zo6VbYHBSzXg3HrqFdgExg9abNyi5w/JGF3AI
         0U652xB+TZ8qDuq6/qMEG4MlVubTBFK8Sdz1/CE3OvqZ+Kave1xOBuz07JhZ4nuJMDqW
         2sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbmUqweQi/b0kzwcwZnJaP8LNyRgnxtOHHMq8yBUU9wHNvKwqWss4Ub+/w/rrLHilpGry65wwWFeHy6z61rA1jK1Tola3p/FzASF9Hyxc=
X-Gm-Message-State: AOJu0YwWG8HUkjsosKaROXSbbbBxuwBLbSY5nhruj6X5BlrcEgKhhS0C
	NgvsHeckcWqyWl2WsW8rb89wP0yqC0p0W41jQjhhTdUyXAul14lUd7YhVrPFSjfZWG9l6yST/L0
	4FPuMDg==
X-Google-Smtp-Source: AGHT+IE94WyeH6RLcAAIOJcTGdhrJI64gxY6uGfhyG5sUnknlOWcMCOVqt5FlhysOWO0+Z0nlFbjELjLHqB7
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:97d6:5b37:f65f:971e])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:1082:b0:de5:a1c9:7a7a with SMTP
 id 3f1490d57ef6-dee4f1903fdmr1751333276.4.1716017083829; Sat, 18 May 2024
 00:24:43 -0700 (PDT)
Date: Sat, 18 May 2024 00:24:22 -0700
In-Reply-To: <20240518072422.771698-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240518072422.771698-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240518072422.771698-2-yuanchu@google.com>
Subject: [PATCH v1 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org, 
	Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fdc3b09c171..fd77ce0c1328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18048,6 +18048,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

