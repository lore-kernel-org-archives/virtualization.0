Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574673321D7
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051579; cv=none; b=XdGLKh+VIQvrV1ZHD86HQeEZ6JejYAM213/uu/5WOuk7UeJFdEV57kteUF1P1/7CvmObg1cZ8ESxpOCZ6IMZPgjKX2Z7GDE1cSC1gwbITS4RSTzGYKqyfpzqojyNJD6HS5fFRGiPXrIdKVlBoeO4rRiE/ZEwHhuE83zo+lWZS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051579; c=relaxed/simple;
	bh=uLM2aZ8rWOYNYhXo8M9ClKVdKdX3HbPbC0z5JcD2olA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=M+86PWMr+JOr7FMc9JaJ2A/oA86RfUOraSVNqurrkZ9ADLj7R4873db+Uz8XbJ2pCQJt8YwSxgk2tm3nvPAw4IQZi/xd8AcsA9ZlnqvOXv1+4RU/kkpP+ml2a2bQM2NX+D28VrTybV/tyFCQDdb/7BHD/iNaEW+UOMK0ZNZaZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvCAyCu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvCAyCu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ8O3oI3PxPdSYdHMVP+xUJdXO9FbTcv+rg9gD/qHfE=;
	b=WvCAyCu2B1oAwKJ1eP6FVYWtHDeiVj7d+FCPG5MZDmyglZ1mVAxnJ+fZm2zTpg/opVLIHu
	/gw/4x43FTl0kCVC7ht5JVegOizAL1ZRH7VIfw4X4NHf97TaKuYHKkKfILK71biSO6Tl6G
	D6bOVso8PBOC6mjrdm4q8QKBGldBkBU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-x6QGbUQiNlutdLTA8UIahA-1; Tue, 21 Oct 2025 08:59:36 -0400
X-MC-Unique: x6QGbUQiNlutdLTA8UIahA-1
X-Mimecast-MFC-AGG-ID: x6QGbUQiNlutdLTA8UIahA_1761051575
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso3474050f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051575; x=1761656375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ8O3oI3PxPdSYdHMVP+xUJdXO9FbTcv+rg9gD/qHfE=;
        b=R+tOO6XVasgcCb3WIrM+ChMIVzIwEEo7ziYFJJmzKECfK5T8II+20XEG5tn8OBxSrW
         4AGd3SDgyI0k3KYxA5u91G+tJY6CtCp07hfe+5Y+x0gSGApjFdG6JF8TsEdzUAoF8YCN
         soeX7na9/y4N7XvSBezkORNDJLGFjEqplvTVE6UlS6ux7Ce7wQ4A/eENxm99+wfyek0j
         UXE152hj/FkQkRwzQ+PdqOg+leDqziKyHqZ6jpcg6h3+MCnifAaItDAU+WydcpcscVSA
         076M3a/+BYYAIIkYuF8gIszbr0Haqnzjeqtk/buoysY4SJLvibmLDoACLeS3h45De831
         wRlg==
X-Forwarded-Encrypted: i=1; AJvYcCV+2nkD2xbxAosPwe25O+b4/jtMSigG0xLs/+8PrCjHrl15n98qTtKjxBfIdA0aVwzbccw0mfidYCkgz9PIpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvdboWaFiBPbTEbh4Q8X2tbKPWUDWWH1aK/caBRhJsicH/rlsf
	4QuPvbV2JYmnlTvxBVCUkbl0iCt9dIUZjbDccu7pI+dD2dEEp1r94XWkCtzi+sYynfSVccI/8BM
	XcZhokbW/Yhomrjz2BnhimX9+4/gRxxvWxCDljQsXO9XDtAscIyE0UbxQ5ILvKGavQJ/k
X-Gm-Gg: ASbGncvbONdIYpS8UMeRRXPbu3Z8hLES/n4K8Gp80GDF5mMPzNzx8kkajnERlRY7Yzw
	VkfNrvM7VSQ5PWKrn3iL2i8mADZ2hMYPN9phcNaOXveW8YA7UYVYwVHT2ebtFyX+7ZgYW55GVA+
	h85vAkjH+kJEMK9ExC65GAUKninJL5QMIVbOQC1yN/5lqfurVnriqVuNg3nFXaIn28Fo3V7yjuI
	P00cKRi89IsxrhCQhHrEELx9UkI2t/0ZGKr/l9CZKg3EhSWPBbQQU8hx03nJZUzGBsWSNHa7a9S
	n3LKGhQslOo65YnThlxHiEop2t9DrrALfBcMW9GGICGJGe4hIohq+j9agBG+kyzWU6ddp7At2Jc
	j60gfnKpBwu4TXco+r9KCJhbwrupOZT7MB/2xhkhXbWTujwO59wWn6wWcDv8c
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42704a62705mr14069842f8f.0.1761051574803;
        Tue, 21 Oct 2025 05:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECa0A/SeCpIiHVmJluGV/YpnUcjGB4T+0tmg/6h2iDdcNEnR83hKR+rxH2jY97xv4J3P/Z8A==
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42704a62705mr14069824f8f.0.1761051574412;
        Tue, 21 Oct 2025 05:59:34 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ba01bsm19979250f8f.41.2025.10.21.05.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:33 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 01/23] vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
Date: Tue, 21 Oct 2025 14:59:06 +0200
Message-ID: <20251021125929.377194-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: toToxOKlp_IH0iYrav8PduVQwdNZ81Ikbl80jQB5iOA_1761051575
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When we're effectively deflating the balloon while migrating a page
because inflating the new page failed, we're not adjusting
BALLOON_DEFLATE.

Let's do that. This is a preparation for factoring out this handling to
the core code, making it work in a similar way first.

As this (deflating while migrating because of inflation error) is a
corner case that I don't really expect to happen in practice
and the stats are not that crucial, this likely doesn't classify as a fix.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index cc1d18b3df5ca..2cc34c4968fac 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1818,6 +1818,8 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	if (status == VMW_BALLOON_SUCCESS) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
+	} else {
+		__count_vm_event(BALLOON_DEFLATE);
 	}
 
 	/*
-- 
2.51.0

