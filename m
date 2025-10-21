Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66B341659
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058850; cv=none; b=UW6mgELz5TCAn6mAbRCqGQMD1HkHQEVYnV5TQ5LdUJLxJuBPSIyTb1BO9qhBF6DD8dsfsTHy6oDb90ubKIaz66m8zGhviGf7zF/kMWOU/R9vElbPi7P4Z6MMEX0n6wwtFdkEjOnD+Zu1pq/HYQepgUjGMjiheab0+3lrEWSzQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058850; c=relaxed/simple;
	bh=L7kBVIaKloL9qtKYYhf9Gn1Ws+54U3dYXmIRPOFuXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LyXzNAI7Y6pOKUMloTQl0UYvU4XG+TruUOPU1uzj+iHyK2Rv4mH+LnZmZEg3oryVzArvXz8QBFkkTortlF2ROf2n05UQMKSBKfWoOJ178iWDdtfdXN3zmmQiIOa86marGb9Nt3d4F3gld2lYicQ2VamgY/r1vyIEPPSMyNhWbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyGmGBJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyGmGBJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky9IQ4YAsBLfeIwBY21tvLCKpQrC6NzvR2EdWfDbaQg=;
	b=SyGmGBJ2Ix4W6W2fWue3yvoKNCxI9ITG43C0OVwTJH0AQBGlcR34vb4/3YeZWoV5F83wFq
	KOFRmXWaGVZz7K0XVv3nZ/ClEdsHQmwbIB4ph48MmDLwkN6oSqzJtO+2R/hbwT/P7TeoYT
	pEHu+oDrLZp3wzK37KYfl6tGlKZ0tlU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-xMrflAxBOsqO5OWU00vQ5w-1; Tue, 21 Oct 2025 11:00:47 -0400
X-MC-Unique: xMrflAxBOsqO5OWU00vQ5w-1
X-Mimecast-MFC-AGG-ID: xMrflAxBOsqO5OWU00vQ5w_1761058846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso30354745e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058846; x=1761663646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky9IQ4YAsBLfeIwBY21tvLCKpQrC6NzvR2EdWfDbaQg=;
        b=sY7aiOzFlLY/xu/B0dLlIssOQzmMIlAdD7+dIvy8U7cvo+TJAATudTusU0OA2vkaYe
         cNKRmDIkPxgChAq8KHAxbwkleteqxPZXgXDPKWswCzRKWpYJHWzpTPTd5heU9sT1A6of
         1I78OtQRL7rKBJ7/6CTAsCyoUtLWA130TKLcZiohMFg9Vpk1yJ/W9bYEV9q+eKOq4/yJ
         wKX5akgEDMCCI9++i/j7nLGUmp2IBHIuK679FVCHgJcr6c5+gLGHgc2U/aws02L/rpFt
         dhrLwrFR3DGkLGlh6E+PKFBXP8p36/MqF7u0yoI4WBS8cJuZ2kb5dPhd58xCBGXC02Hy
         HrKw==
X-Forwarded-Encrypted: i=1; AJvYcCWOHV0hI9oGfffjQAt3YqhzrYT0gIgJFDR7bWsdMDVRElb175scMZ7nC/xB5xub4U8BlYX9TrPJ7XHwG/Yxsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOnGA/V0ghS+IdPV16p337ahZDET23XRWI/N5r6FjZ8wtEG8EX
	bGJfgDlg8XaoW7HtkUWG8hRSXYo0Gi4deSS/7IxxMANTvpZaobE+NyhTgN0NNdcnUlNsbQKsq2P
	WLdOm1mvZW58RRZ2s8BcXVwyasfcgPOIbt47hUgm02ZUEcnLW3utEPylVr3PGNUk4RCPKcSO4LD
	BX
X-Gm-Gg: ASbGncv+YunOySSfEUxLvP0ZMW35mmyZl2vwoOPiBUCd3UI6JsNc28zHhAhGKnzl+T2
	mWZs2PcPh5Fg5Ub3yN16iYZ+K+EQc+DLLP7ZtXtcCjla7FbzowuDD8CN7faYnxwM+pjyjoig7BY
	DmK+EA+Vucp7O3o4+sSTmBo9RXAloM8ruaLJAHcmFwnAhgakOVo/kDypG+LPMSDCfsQLX9AA3WY
	YUgK6YjIPIFA5TnmH8IEI2gHKbqFNKjaOGHGOXvKDfcZ0Snn5drUc7VRLfhnAx/55DgR2epsp2Y
	WslpbrH8ngyHn0xqkI24vKod4Voc6kKuATz3hE+VmifT7XCf01zJcPm5lOHt4A8m0bYVOEASCP8
	Aqt7G6/roAmWoPZnV1urkAy35us4zV85X1LLWUKlGaT1RiGo2LSWlT0LIz7mL
X-Received: by 2002:a05:600c:4856:b0:46e:6a3f:6c6 with SMTP id 5b1f17b1804b1-475c3ea4513mr292435e9.6.1761058845735;
        Tue, 21 Oct 2025 08:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcCb5n53mP5PF5MfJ9HO5RP4uaN8pdS2o1XXt/OVHNFMEn6HOLQj1RdbKKLXflQ72jgla+hg==
X-Received: by 2002:a05:600c:4856:b0:46e:6a3f:6c6 with SMTP id 5b1f17b1804b1-475c3ea4513mr292005e9.6.1761058845283;
        Tue, 21 Oct 2025 08:00:45 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47152959b55sm204336915e9.6.2025.10.21.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:44 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 18/23] mm/vmscan: drop inclusion of balloon_compaction.h
Date: Tue, 21 Oct 2025 17:00:35 +0200
Message-ID: <20251021150040.498160-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wSiBQ5rEkcLUGFvu7N2daCHuV6baUggdAt28cO49aYM_1761058846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Before commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature"), the include was required because of isolated_balloon_page().

It's no longer required, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd4..b96448b562823 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,7 +63,6 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
-#include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
-- 
2.51.0

