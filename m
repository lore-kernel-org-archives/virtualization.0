Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D7C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:35:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B06964E0B
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06964E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB23B86EE2;
	Wed, 10 Feb 2021 18:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JvC432CLpa3y; Wed, 10 Feb 2021 18:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E199686EBA;
	Wed, 10 Feb 2021 18:35:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B93B5C013A;
	Wed, 10 Feb 2021 18:35:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91947C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 80C278737C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sg82qGMIeGbC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 674958737E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:02 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602427560000>; Wed, 10 Feb 2021 10:35:02 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Wed, 10 Feb 2021 18:35:01 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next v5 4/5] utils: Add helper to map string to
 unsigned int
Date: Wed, 10 Feb 2021 20:34:44 +0200
Message-ID: <20210210183445.1009795-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210183445.1009795-1-parav@nvidia.com>
References: <20210210183445.1009795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612982102; bh=wb+dkpPaTiWpTz3BlBWkumEuJWVmUA/mgN3gQd43q88=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=iH7uuOwp92t21QGALRaCPgn4B9YX9YJY4k8FX1ddXR5pLn4GCUaBKPixY16c3jc2A
 Ivt4cW7UB9B+vbQVEhF25+a97OUzTxVFUXTcXCJWN77xI3qcSQ2797iH8MBjpB2C+Z
 0Wlj0LUOpOmNE47TMRBeTKbf3hK9je4MINy0PAQCE0PKgeRxjGw2VvqwX7zNgK0XWQ
 hulcfYbLtzU/G231hw+XCi7KMErBQseXCdCSh858v+CcaPK5SSt3dmQ7FnhJ4P6g33
 IM7x7QvcHPzi1VuW8oroZHTs0TWoEyHIqhpUSKogqFUJnw/fFei73ixGYdsxsrr2V4
 Lc48+wM5rdCrQ==
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In subsequent patch need to map a string to a unsigned int.
Hence, add an API to map a string to unsigned int.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
 - new patch to reuse string to unsigned int mapping
---
 include/utils.h |  4 +++-
 lib/utils.c     | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 9b76c92a..b29c3798 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -342,10 +342,12 @@ int parse_mapping(int *argcp, char ***argvp, bool allow_all,
 
 struct str_num_map {
 	const char *str;
-	int num;
+	unsigned int num;
 };
 
 int str_map_lookup_str(const struct str_num_map *map, const char *needle);
+const char *str_map_lookup_uint(const struct str_num_map *map,
+				unsigned int val);
 const char *str_map_lookup_u16(const struct str_num_map *map, uint16_t val);
 const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val);
 
diff --git a/lib/utils.c b/lib/utils.c
index cc6d0e34..633f6359 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1953,9 +1953,22 @@ int str_map_lookup_str(const struct str_num_map *map, const char *needle)
 	return -EINVAL;
 }
 
+const char *str_map_lookup_uint(const struct str_num_map *map, unsigned int val)
+{
+	unsigned int num = val;
+
+	while (map && map->str) {
+		if (num == map->num)
+			return map->str;
+
+		map++;
+	}
+	return NULL;
+}
+
 const char *str_map_lookup_u16(const struct str_num_map *map, uint16_t val)
 {
-	int num = val;
+	unsigned int num = val;
 
 	while (map && map->str) {
 		if (num == map->num)
@@ -1968,7 +1981,7 @@ const char *str_map_lookup_u16(const struct str_num_map *map, uint16_t val)
 
 const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val)
 {
-	int num = val;
+	unsigned int num = val;
 
 	while (map && map->str) {
 		if (num == map->num)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
