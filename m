Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59747781;
	Mon, 11 Dec 2023 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3HNWOl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCEEC433C7;
	Mon, 11 Dec 2023 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302779;
	bh=7nJudwtExTyLMiAH31qWZRIYlmBiq88S0FkovtP8cvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3HNWOl36yuVH6HPma8UvTdc+zl2hOxo9xxK+d2kW+oEwJR41RXX2mhmraLd6Mlf8
	 a2qCRJ+VaZ3vGua5zPD2QLOJDYQ8yL8TrvN1WNSmHDdLL4/g2/S2yLiDcQ02WDMODa
	 atN7iRkdWLBMiyCppkvhg3Aj21Uk02A76VIp4MxpxCRkztALMgofb7pP3fEgWQiv8T
	 7Iux+7uiMus++8pbYbopdsLs6ucK4ORV1w4J2zXpJMk0wrYwQYIVTsNHcUgRiYI18J
	 r28cxQ+7LTBzYXVLy2dtztOLhaEjo90+SeJsxnHzi6pt6yatIqhDG0p6hv+RvoHn+B
	 /PDgblsPyn0eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	kernel test robot <lkp@intel.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 24/47] pds_vdpa: fix up format-truncation complaint
Date: Mon, 11 Dec 2023 08:50:25 -0500
Message-ID: <20231211135147.380223-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 4f317d6529d7fc3ab7769ef89645d43fc7eec61b ]

Our friendly kernel test robot has recently been pointing out
some format-truncation issues.  Here's a fix for one of them.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@intel.com/
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20231110221802.46841-2-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/pds/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 9b04aad6ec35d..c328e694f6e7f 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -261,7 +261,7 @@ void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
 	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
 
 	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
-		char name[8];
+		char name[16];
 
 		snprintf(name, sizeof(name), "vq%02d", i);
 		debugfs_create_file(name, 0400, vdpa_aux->dentry,
-- 
2.42.0

