Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EE1B81D3;
	Mon, 19 Jan 2026 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863709; cv=none; b=gyqZtvvDWVbPkTM60VMG5LNRgsGPs5LZvpkSPbArC8L9fxTUixj6hNfo7gMMM8Z7An4VwSf0Lkm10eJqh53kyOuQgMsfbgCjaHBMX3KzeJKBTKtRDzF5Un1ExJ1iUxcsTfZUln/fef40bBZWuDFiQg0t+R1R4Z3vGzHCV8C3bA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863709; c=relaxed/simple;
	bh=luihl3MbyU6omYSiSWj4BOo3mmNqgAivFPTCpm64S5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q20iWzPgigxAbnQUfhymW4eY+7AM8nmvYTYPRyo3w+cnvUJMHMIkyI/qGOUtmyroKAA4lXc2y8Fr6zBkOlGh2hmnbJuewckaUuz6Kb+qZcqiEPf9zAKsRKBej1mZ08GCV8quY3bCIaAjtMM5uO/64ySQzeYFvQNzO0HPti8q4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty14IhFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty14IhFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E9C19423;
	Mon, 19 Jan 2026 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863709;
	bh=luihl3MbyU6omYSiSWj4BOo3mmNqgAivFPTCpm64S5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty14IhFYRg1l/2Ez+3EIhcGA92inZASN9By1yGWpfoCYQQoaXhF9GeSHpXh/4o7wh
	 rv2jd1KqUv7sxbQENf3+a93+kiHs6Pt5G9xfUtig2LlyAvg5fqgjrRlYOU451DxdQV
	 xFS/6MQL9QO4d/tcIUcQUVkk5Ga5MkYY1UtDOLULiGw7WY4N60Pad45nIyjD3Ohaa7
	 1u8b3HPjwXFqvexE1sUgx5Pa9UxBfNk4UNre7uxGAjjqz0uqzNWWM+n6+PIJW/KZC+
	 PdVBqArgnZb/xbX+khcmpQlrZp1iBBmSTeD10FX6KYq5s943DkILJgOIVYjGLYJiq6
	 qwGIPnllyT+GA==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
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
	Zi Yan <ziy@nvidia.com>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 01/24] vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
Date: Tue, 20 Jan 2026 00:01:09 +0100
Message-ID: <20260119230133.3551867-2-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119230133.3551867-1-david@kernel.org>
References: <20260119230133.3551867-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we're effectively deflating the balloon while migrating a page
because inflating the new page failed, we're not adjusting
BALLOON_DEFLATE.

Let's do that. This is a preparation for factoring out this handling to
the core code, making it work in a similar way first.

As this (deflating while migrating because of inflation error) is a
corner case that I don't really expect to happen in practice
and the stats are not that crucial, this likely doesn't classify as a fix.

Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
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
2.52.0

