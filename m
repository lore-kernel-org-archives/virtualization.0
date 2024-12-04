Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18341BD51B
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316905; cv=none; b=lqRi4UAiqKJCkek0ZU9UZphA1i+V4E56O5LxtVHVHgZxTlgEtVFBiebC7JKwNX9Vd8m44CZNreb+OcGvC65nZo2WRhZnbOWHs80IJZuOeGnq4TCwDiLccU4CGnSRVnarKPyhRB8xl3SFq8SgTg/XTgzxpDL+dNSaUpBW57cDpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316905; c=relaxed/simple;
	bh=BgMJzD3uvTJhEKjQ1/IdIeY2entK2KsTWNxYBemJ1qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LIHBd2qsmFrKokyJXeKQFEQCmFQoH/4X5XR+3gBj51uJNfABn0r+PklU2b17aZNoqLpWhqEtFBIUTRtgxnukSrWpleCLjC/GyNTRVzno36OckyPGq4qzqs394X2cbiWIc7dEnPruC2D6bynRRxLRHzbdNpT4fO2Df8JqQc/GsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdSp76W2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdSp76W2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
	b=gdSp76W2fMZxWBw7IyXVva167tl5xVwilwJeCdz3Xpm3xFoa4T9RUV1ZjkKRye6UW5Oirs
	XqN09QK0AiM+jmrF7IUcewXOil4TcYu5AlHcHq6WHGiUCHWdxERJITBQzyLSDjuVc1AP3j
	Fj1duaBuMWbTU+ZDLsuqN4+jLpS8fB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-kWGshhfdOUadgLU9PIpAnw-1; Wed, 04 Dec 2024 07:55:01 -0500
X-MC-Unique: kWGshhfdOUadgLU9PIpAnw-1
X-Mimecast-MFC-AGG-ID: kWGshhfdOUadgLU9PIpAnw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43499c1342aso47971165e9.1
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316900; x=1733921700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
        b=Bn8sTtT9QciZjtMJWUk0woV5wax9fVgABq6oQezQ/+hmKJ/ip1DywWOSJ2bkeBZAoT
         iWNHmmEkPV5iWIWpCjZK0ZV8GIAL/F41nBHenp/QTbDXGzvalr6XFyJVPiEhaXo5RHGB
         YEjLEnnFCzNc3xMUAfbg3EzUqoy6KCHH6q0tl4EPqTheQKCy0WI+jQ6K0XieyXvwJ6iG
         XV20O86V76OGI2Rhe4dV57KEJ1ibuA93zp11uK/oglnaPzuL5kMTcA4hyHRWlq+cfU1Z
         930OZmYk67jJYJJ9UbjX+z0NXh5MmScFfsgUxDwKm9uYbTo6QvScQShW03nIYAYGc0U7
         oVUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqY40jFb8s5p5PC6jPzWIsLSGX5r/wsgjs2GH+XeznA5sclHkikFz8hf7iOXlNgj0E4btO1Z8kUcRumFqw1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc9CBIS5wTMM3lUitOr3qH6ETKolseZiq+wy5kRVG5qo7RlT2x
	N5J3+EchQpymPHEEK5DpGjW6Chxbl2BZMPSiPXwOgBmYlRsNY1wRjIuz1+mchuvsoAyQ13LBuEo
	GMXPs/+hhRZ9jaZHjPA9e6AcjjmUV5I1lw5SEQeWpI1nL2ZQmVl4MOBprEikQh+0V
X-Gm-Gg: ASbGncsBn5MwQyyHmv6/8O4F/Ra8GbDQM2Y0csRdEcfXF+73tALiGhrfqkPR2LGK1t0
	1t0ueP4kCu2ZGAXaU8juzc+2/vjOW+ESD6vwOwKnKH9jE181wKR8lUpghBClOC7ipA1vL58BokW
	2BHLmUdpeo+FgAjZDggpsk6LrSZTYX9eWec3OGoUcNJmdh5ZZf0GQCIACGFp6bHzKjPeSXbFmqn
	A3K/MU0zb5Dpfx1Z7qFIKqaxXEAI51EGdMbXR2YI68Ysv91NBpEO/fFl2duRbdhL8myeReGESDO
	q+EFVzYxqUppFvyZ3HrADmOf5K1YU4wEy4I=
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431760f8f.47.1733316900240;
        Wed, 04 Dec 2024 04:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkIZLfFS9dd4mzise8YhuqVkFTd47qC7aw9US3336mGUo5e0+UH/rIIT1Petk2to7fPbudFQ==
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431725f8f.47.1733316899810;
        Wed, 04 Dec 2024 04:54:59 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd2e1bdsm18785865f8f.9.2024.12.04.04.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:58 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 04/12] fs/proc/vmcore: prefix all pr_* with "vmcore:"
Date: Wed,  4 Dec 2024 13:54:35 +0100
Message-ID: <20241204125444.1734652-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KNiYsKPNLCzzsTVojGAWsXlLZMZ4fUGiAJASIscnBgk_1733316900
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's use "vmcore: " as a prefix, converting the single "Kdump:
vmcore not initialized" one to effectively be "vmcore: not initialized".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 16faabe5ea30..13dfc128d07e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define pr_fmt(fmt) "vmcore: " fmt
+
 #include <linux/mm.h>
 #include <linux/kcore.h>
 #include <linux/user.h>
@@ -1580,7 +1582,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		elfcorehdr_free(elfcorehdr_addr);
-		pr_warn("Kdump: vmcore not initialized\n");
+		pr_warn("not initialized\n");
 		return rc;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
-- 
2.47.1

