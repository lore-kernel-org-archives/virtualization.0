Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFF23D7CE;
	Mon, 19 Jan 2026 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863870; cv=none; b=mkX1YZxhNjtx4WMJ0beoA0wMpNsjhT1tMYhJFuh9m25ZQvuCigE0ebUnO/FCFXA+0C+KEKQJB7/QMm4eYria9FRLhGGvH6Dc/wupYu/BVa5ecNzyUUGZw/pJGUV7fgfdU+yYfxXt2xj1FEbvrWMDOnB6fsh29/5hVs/HMZkyM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863870; c=relaxed/simple;
	bh=S1lJXi3TslhD2DUEpYR7JuVS5MOqETlTcS4z0PNouhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A47aj4oJj90oVWUQV97tSkEj4czaZ1spuH4SJjfMiaUo6H+o7/VMAdHCEZMmGJ+ssTqqPg7eOBeKSDQtu8IqzIiKBE80IIt8ovmbDGZ/3DJeIECXn5QFGHwdjfioBrv2EWiySyyEHqfk2zwiNQuE6c+j3/Aw9WjOBIGgExEXXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JddkqrE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JddkqrE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A63EC116C6;
	Mon, 19 Jan 2026 23:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863868;
	bh=S1lJXi3TslhD2DUEpYR7JuVS5MOqETlTcS4z0PNouhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JddkqrE6RvS1AkcsaP0vtdPHirYtI6v+ox8YHuFnXoHZ6NJfOnr3M+yynoay6gTTs
	 2CSXcn90icHiGYaNfQcjwZ5gBkXXRJdWMqLpgNOW25skxtZ0cVYbGJUW8kM68yJjsF
	 xYxt39UFsY+/oOcthmFoy7p0q/3U5dWozuyWhB0B4IAEPbJwcOnI9Qv37JnTchNeIm
	 zer4O9EWA4zNWmtWZucviW7z2hJBTJJSFMqW2pjllnEM9ZoJQDnaoN+5yVxeyv0iPU
	 ley6W9IKnFUbeFASccnDtJvSJcW2dPCjakmFabdI4HFB4fknl1l42IDGOcMdpEVToz
	 T00lzVZ1LJSCA==
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
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 24/24] MAINTAINERS: move memory balloon infrastructure to "MEMORY MANAGEMENT - BALLOON"
Date: Tue, 20 Jan 2026 00:01:32 +0100
Message-ID: <20260119230133.3551867-25-david@kernel.org>
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

Nowadays, there is nothing virtio-balloon specific anymore about these
files, the basic infrastructure is used by multiple memory balloon
drivers.

For now we'll route it through Andrew's tree, maybe in some future it
makes sense to route this through a separate tree.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 MAINTAINERS | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de8f89ca1149f..11720728d92f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16454,6 +16454,17 @@ T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	mm/
 F:	tools/mm/
 
+MEMORY MANAGEMENT - BALLOON
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	David Hildenbrand <david@kernel.org>
+L:	linux-mm@kvack.org
+L:	virtualization@lists.linux.dev
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	include/linux/balloon.h
+F:	mm/balloon.c
+
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@kernel.org>
@@ -27536,9 +27547,7 @@ M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
-F:	include/linux/balloon.h
 F:	include/uapi/linux/virtio_balloon.h
-F:	mm/balloon.c
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.52.0

