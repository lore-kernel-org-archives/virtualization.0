Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4130EC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:11:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA25664E4A
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA25664E4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 84C532E142;
	Fri,  5 Feb 2021 18:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8T1DEnPzFLjr; Fri,  5 Feb 2021 18:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4F4722E135;
	Fri,  5 Feb 2021 18:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23507C0174;
	Fri,  5 Feb 2021 18:10:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8861DC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 77ACB87387
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdI3X19R4OF9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:10:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA3A58738D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:10:50 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601d8a2a0002>; Fri, 05 Feb 2021 10:10:50 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 5 Feb 2021 18:10:49 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next v4 2/5] utils: Add helper routines for indent
 handling
Date: Fri, 5 Feb 2021 20:10:26 +0200
Message-ID: <20210205181029.365461-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205181029.365461-1-parav@nvidia.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210205181029.365461-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612548650; bh=HDT133gXudxB52omx1TuwZ9j1XEiBgbv7aS9W5cuFWc=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=A37NgJPM6J5lnl9+8X715PpXm084B2FM9VGHuA2AzSFM3+4wRBcIPpsfsvaq9qSvd
 kFc+3zVtrCrjpVOdn0+H4y0862xzlPGQkJ5zQ69/duQYnocWjgmf7ZT5vPBYOx77Tz
 Vo4esNDQ6DnpPIMyYAnMMhxexYCK1j61rlmpVZAGkfVXKHQ0GvjA963+s0pzLDzyOu
 DRh+m9nKsfbCXeYvtWt0JUFs/tH/G6ihhkusfN1x8bQUqKaAezLBMVnC+856wsvpQP
 Wrs2b1Q9Tdlk+HttRX0mowTF60oSjme/OqgyEGNToystHXo5NPRsEsOhUauwW71018
 UR2g8pBJ4iUrg==
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

Subsequent patch needs to use 2 char indentation for nested objects.
Hence introduce a generic helpers to allocate, deallocate, increment,
decrement and to print indent block.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
 - patch split from vdpa tool patch
---
 include/utils.h | 16 ++++++++++++
 lib/utils.c     | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/utils.h b/include/utils.h
index e66090ae..9b76c92a 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -349,4 +349,20 @@ int str_map_lookup_str(const struct str_num_map *map, const char *needle);
 const char *str_map_lookup_u16(const struct str_num_map *map, uint16_t val);
 const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val);
 
+unsigned int get_str_char_count(const char *str, int match);
+int str_split_by_char(char *str, char **before, char **after, int match);
+
+#define INDENT_STR_MAXLEN 32
+
+struct indent_mem {
+	int indent_level;
+	char indent_str[INDENT_STR_MAXLEN + 1];
+};
+
+struct indent_mem *alloc_indent_mem(void);
+void free_indent_mem(struct indent_mem *mem);
+void inc_indent(struct indent_mem *mem);
+void dec_indent(struct indent_mem *mem);
+void print_indent(struct indent_mem *mem);
+
 #endif /* __UTILS_H__ */
diff --git a/lib/utils.c b/lib/utils.c
index af1b553c..cc6d0e34 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1978,3 +1978,69 @@ const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val)
 	}
 	return NULL;
 }
+
+unsigned int get_str_char_count(const char *str, int match)
+{
+	unsigned int count = 0;
+	const char *pos = str;
+
+	while ((pos = strchr(pos, match))) {
+		count++;
+		pos++;
+	}
+	return count;
+}
+
+int str_split_by_char(char *str, char **before, char **after, int match)
+{
+	char *slash;
+
+	slash = strrchr(str, match);
+	if (!slash)
+		return -EINVAL;
+	*slash = '\0';
+	*before = str;
+	*after = slash + 1;
+	return 0;
+}
+
+struct indent_mem *alloc_indent_mem(void)
+{
+	struct indent_mem *mem = malloc(sizeof(*mem));
+
+	if (!mem)
+		return NULL;
+	strcpy(mem->indent_str, "");
+	mem->indent_level = 0;
+	return mem;
+}
+
+void free_indent_mem(struct indent_mem *mem)
+{
+	free(mem);
+}
+
+#define INDENT_STR_STEP 2
+
+void inc_indent(struct indent_mem *mem)
+{
+	if (mem->indent_level + INDENT_STR_STEP > INDENT_STR_MAXLEN)
+		return;
+	mem->indent_level += INDENT_STR_STEP;
+	memset(mem->indent_str, ' ', sizeof(mem->indent_str));
+	mem->indent_str[mem->indent_level] = '\0';
+}
+
+void dec_indent(struct indent_mem *mem)
+{
+	if (mem->indent_level - INDENT_STR_STEP < 0)
+		return;
+	mem->indent_level -= INDENT_STR_STEP;
+	mem->indent_str[mem->indent_level] = '\0';
+}
+
+void print_indent(struct indent_mem *mem)
+{
+	if (mem->indent_level)
+		printf("%s", mem->indent_str);
+}
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
