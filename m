Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23433FE12;
	Thu, 15 Jan 2026 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468831; cv=none; b=NSuEbgnlSCpUw2b2Qb4NGwm/LZl1kjGjGBmAY5i36CIaASv0iXGXwXh5brQsi2NMDhhcwZfZjyiiPM7Got/dBbqVDGZJZxyKFyDbQ7tOk+5PqHcSShGbk1aT89yQj48fvL6zY7fzMTuxL63Sylpspve4o5bDF7JHO9GklM0T4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468831; c=relaxed/simple;
	bh=Scv31UliB8apDlHu70nbhgpokthEcnnhLLec4iJu0Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2FhSbPFDfE62E9kRVsrFNO+62UmAZh8cQV7w2irNLQVqQVoVpjQoiaSkI0y9pHb2jsYtLmY4dvXRjOALSoJAJA3yHovpzZ8GX7dPtvemEY9UsxdDtT0gKrpvwnnX/5F6K6uCz7vOXiD5WvZ+Hs9/ySV02VCFy2z3T5mFLc3F6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYttf9RS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYttf9RS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4AC116D0;
	Thu, 15 Jan 2026 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468831;
	bh=Scv31UliB8apDlHu70nbhgpokthEcnnhLLec4iJu0Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYttf9RSd3DbdTaPTVk+zCGJKvc/Oez8ig0lU53ia9jJ6aGdraYIQwgrN8yJDx0Pr
	 5qlJKitoIajMNIWc7kDHGqVMM0UaKRvQAC7bbk7mgQkugqLRCBR8BUyRmOqRFH2N7Y
	 EJ2au93bd/o+ApHVyv0ol6BDQCWpCFNv1hC3BOgoWcmnv7HvfTvufkfjUo08S6jWy3
	 5opLIIVpz8SqHZkxP47qBlAAYzOLBQ5lRLzyIQQhvTJHLC1jIMu6+wxgilo4nYr7cJ
	 DeabCkk2c8fFv90mHyJ5RnYg2v4W7YzhuhYwVVVE1jXv557Xjjd9lvqckiUc5tazSb
	 PsIdQFPAUZZCA==
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
Subject: [PATCH v2 01/23] vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
Date: Thu, 15 Jan 2026 10:19:51 +0100
Message-ID: <20260115092015.3928975-2-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
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

