Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B033B6E7
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873990; cv=none; b=I9Xoo0g5kxLijkhTvBMT84XlLLS+SNTUphoof09iMCyHrHAs9Qzg5X9yldZZniblXGWlgT5jatX3AlMoueTkGqqnCiRpzaeIx04sD3233CbkUpdDPJyVAeARjk8fv1+fAPNjtpcz6axCdqWuZwcnOQL3KFvn1fI/haOeE5q5X+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873990; c=relaxed/simple;
	bh=ll/sxvvzc3XW4CmLB3HwF992o1GxD6WUnDKMX3Bix90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JHcnxp4ebKpzeWdIp1UR8SQEe6wP+m+PX3wVGusDggbSnwuvLNqIBvF5AsRkbrEzBBQlbhecd+22TDxAJMtHht5egRjrmlQySWBS33+0zainT1B30GYfNNzLrFAKsY/3NKHf4AkAwM5iwi/1NVHKeadTG+4FZhYXm784AYs7okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFz1RQqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFz1RQqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVw5dYteZUWTT3AJ1ycDooI045XqhugmJ7sLNTXFrBU=;
	b=WFz1RQqriELGd5lueYgE8j8i/fv0owv66qSOAuVe3sJdOZTV/uDj/OS1qU3LzqITayFeEh
	6V08wnzq6Uy3iSsfChrL+GD08whsfiYgviMqsw1hQwP6+HHrC0xVjvAyDVqvj2M9aLYASN
	8+eFbjVdO34Us1TKQT/7PTB0Hjql17c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-HvalmPo0PiKXxeyWLqxPAg-1; Thu, 04 Dec 2025 13:46:27 -0500
X-MC-Unique: HvalmPo0PiKXxeyWLqxPAg-1
X-Mimecast-MFC-AGG-ID: HvalmPo0PiKXxeyWLqxPAg_1764873986
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3ed2c3e3so919943f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873986; x=1765478786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVw5dYteZUWTT3AJ1ycDooI045XqhugmJ7sLNTXFrBU=;
        b=CPSi1oOdGNwJhWl0uO/IXNkUsNTRtFhQhE2iZEnQflza2oSwovO1fnLkqRHNVHOCT8
         ExkVARiLC6a44H6OsMEQ5e/hEgN0/1Ix0POMVYN+jH4tNPErqaAMyE4effkXCZy5T7ol
         kkhgajVbcmcxcyrsEttGDbA506dL4dIfsLxZm3wbqJ/bh6i7rJkhAFORIq9ACb0QsRLl
         b71qDmoVM/OBVyN7YafgyhNyU8wBGgsnuygcfOyLRpwXCnDf0aePuQliFIh1l/oNZvGu
         y2FbsT7oNWtrWl2L8sXD0PtdqzRbPUAmFFaya+y58hiDDrA8YqvWHaLEvHC8FPnnpPSt
         NhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuYZncT6+Vk3sDNyvBLIuc/bTa/CJiCvamWW95wkHdWgKksGgQgAQ7/cZJgpJYvaR4bZ+wAU3clvounaOynQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRh9EPag2ACYQyqTIrsvgE0p7mHLPWnfOWcaSTXJKihV2X8gQV
	o8BZd314NP2Kaq9cEPkOyoJLcDfOt/pbVKrncMyFCr8vgeaikf/DCMhijLqH5xcf/IUeiJlYqPD
	QOqo/UzFLg4pBY3/lCl7DappaVd/vSVhPZ5J8a7RZ1J9hDjNn5ynZHQD9a9X3JzIZUlE+
X-Gm-Gg: ASbGncsXxgu62uVzWJ9hj/sgy/P1yOQ3Tm9h3dAAxOYjrKIzY8q5K9CZrlSrwilwVRH
	5ZqgcTmKnPSVZt89c6JVNUj900QGXJgJEU8jxX1OWwxm3m0Ge1rSq5mH0rqk8a5f5r4PqZ/qOEy
	aW817UbjfUKnqJYA/aA6j1GilzAAbA6P5mM0fkNxyUoklcBwGs6peWYj+BwgHmWwkyYWVsXZZ7O
	dr1ISBA8c6oQbEi2uSNb+ZhTtXmuvl9vYuZG/Iyxc7de1QhjhzuAmP0SM/9peNlrAfD+XAWm5XP
	0Q0AZ/SUvAv+UviGQKllACgAo50g6HNrl/vAblJWzB6xUukQBiRR1F7/r2aKv6Y/lBxg22rtA78
	=
X-Received: by 2002:a05:600c:4f4a:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-4792aeebb79mr85646045e9.13.1764873985903;
        Thu, 04 Dec 2025 10:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVnZlUPVGwR42uNZ5MF++ugxWcelqzFWsr6Ll20O4Muqn6ej9BfWBGGv8F1+o4jnnv7STrOQ==
X-Received: by 2002:a05:600c:4f4a:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-4792aeebb79mr85645785e9.13.1764873985505;
        Thu, 04 Dec 2025 10:46:25 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310ca502sm45084615e9.7.2025.12.04.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:24 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 10/14] tools/virtio: stub might_sleep and synchronize_rcu
Message-ID: <5557e026335d808acd7b890693ee1382e73dd33a.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vW_9L7ZwmNRXGrcaeIdq4m5bKWtU3rlDx3TJkwnp7H0_1764873986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add might_sleep() and synchronize_rcu() stubs needed by virtio_config.h.

might_sleep() is a no-op, synchronize_rcu doesn't work but we don't
need it to.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index d7fc70b68a2b..416d02703f61 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -144,6 +144,13 @@ static inline bool is_vmalloc_addr(const void *x)
 	return false;
 }
 
+#define might_sleep() do { } while (0)
+
+static inline void synchronize_rcu(void)
+{
+	assert(0);
+}
+
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
-- 
MST

