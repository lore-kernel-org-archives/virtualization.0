Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D66D1AB
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410349; cv=none; b=Ludd0LpWRpXQ6Z7jWRqdF1An09MRyXqbbndsSRYM0UgLd2GAFpPvxC60ec3ny1WaQcozrFWNx43e3kn1fcMwxF/zmbko3PJanxePFHXxEtLwElWryUoQKOs6PE2Dxo8vFKOLc9m+rLOhoTUhcx8K72bRDdphEM17c0pyKhPJBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410349; c=relaxed/simple;
	bh=ExMN4fRP3peAG00SNEDYTXxXDdne2pybmXISai/Y8oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3xAN97quy1VpXzSvdyzUNOOhDkwJfunpwWSSS0in3Z+bFGhKanHCECrKOhVPezaNXCD3zXd8aEOaIRVMxzq6O6W0xVgp2y8Dgtd/cO9lMw/JsrXS/7HLYi2DhiZeRwSTNSP51MBayQ12VQs4ci1KYYOZMfaVpFOkTD9hGTVOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FoZuoeh+; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FoZuoeh+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710410347; x=1741946347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ExMN4fRP3peAG00SNEDYTXxXDdne2pybmXISai/Y8oM=;
  b=FoZuoeh+3eCw0mDcc88IcXl/Uuzn9UV4W+YlbzSubX77ATcNrNRDhVCf
   BDmhc66BQAM3n5sS9y5CUvD03AqgTAg3T0DGHOzRUxgZqJXX3VXX67ZAN
   5H1R9VmpJbUT3LUMT3951f4kUO8TGusTFyulAuQkKwidFSmEAapVfp1CE
   XztN9SWM/ZKip16WfAxFVtwmDD2i56UW6QydQqMQ/HqFLYX5XeeDvE4Hq
   XMiVuJPbhhlc6j8/acb5EvsMNZN5F28691yduEftxQan44U7jyHvzA4AZ
   bn/LYDqIurCswkhl2+qH+rgsQg+lpjzcNneGgnzccllqAIgnfTET0iYqK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152533592"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="152533592"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:59:03 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id ADCA2C21A0
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 18:59:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DE914D4C3B
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 18:59:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F65820093269
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 18:59:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BD71E1A006B;
	Thu, 14 Mar 2024 17:58:59 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] vdpa: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:58:53 +0800
Message-Id: <20240314095853.1326111-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--7.076400-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS7pujb8urdzZSuvtBzlaEqC99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+msxn4GpC3Y2sE5XPQnBzGXq8KsbROd9VSKW8
	BvXyLiE6ANl9QqNE6NhKK/bK+QypCR9GF2J2xqMxRFJJyf5BJeZVXUb4KTaXv6C0ePs7A07V9vM
	TaVNFNzVlNXZ4zxNCCPRPmWwzXHz5h70tmPyiUmkZR7Q/L+l1w=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: virtualization@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d0695680b282..7b82b9aa91e9 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -98,7 +98,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", vdev->driver_override);
 	device_unlock(dev);
 
 	return len;
-- 
2.29.2

