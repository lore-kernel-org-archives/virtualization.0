Return-Path: <SRS0=wpUj=C7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B7BC4727C
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 06:08:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4EE23A9B
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 06:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuUH7P98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4EE23A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06CBA85AF1;
	Tue, 22 Sep 2020 06:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H48LyCYhUDlV; Tue, 22 Sep 2020 06:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA5C38577C;
	Tue, 22 Sep 2020 06:07:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8945C0859;
	Tue, 22 Sep 2020 06:07:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C62C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 110F8870C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2lUBuyF4Gzua
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5A46F8608F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:07:57 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id cv8so8893452qvb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YtWt5LT1rZHUieitxqoZL94pXE9Kni8HrVa9DLq6ra8=;
 b=iuUH7P98MAjsRlYJLK0TJlVvZeCzmYl9RV4YJokXxQqlQv7Wl7kR5ZHCp9MtlOlzKk
 /1RP01X5p+SM3kTFYgEvk62jz44d/piRqzh8EXdfCfQmyBgRRa3jZ0xJgGBfL2TYW6tn
 ede/YsJq2RHhP6OjTLHxVUg/RHQ1nexItE8RxNdloYtrMpaYRUzbXPWF7VnOLjpzZums
 CY/p2InTF6IIF4O6CRVc14nFUBzT4GmCjfKIYzruKsehGb+bT4uXZzhSESh7tX6yA1Cj
 L4hsw6xW7izWpTL7qRTsyjLb9Wnwa1exn47NZ3C9KFSk/ArtkDmN9SScS3ZUa1kEKfmM
 R/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YtWt5LT1rZHUieitxqoZL94pXE9Kni8HrVa9DLq6ra8=;
 b=qh4uU9jHZrvvPVvtfQr7JnAXSCwJ7qHDRwqp7UUOqJAEy8DeCwMskD0tZiHuuZ0/8H
 zxtDDxSqWO+dIkjekJLpum8gqtWHpVx6pNx+C+IjAYBSZPjlS0OeHnShUqB5aMQOKBM0
 Bn9kao6FARLUpw7Y/rafw9KGAfMjixhLxj3zHhsjPTPI0wXU3JM16ctyv0MgpRZFxC2/
 Ek0ZAT+iTfVPrXqethE5nmEQydXTUtFFDiafZfXIrj8lhettycmokd9r0XokyQFyisSo
 rO/sPlpECd7dWAoNDPoaXhXBUHxVTK35/ILATIRb+T48tFqEY8jPtk9wmyK8da9Lxjk3
 8hbg==
X-Gm-Message-State: AOAM533UhyTmW4Ggk7K1UAizlmsEkUfo8fajsRlKbiLUHPw3tMHuCzdN
 QVGd0AfUFpx3Dklb4e/tDxs=
X-Google-Smtp-Source: ABdhPJzYAkkRErXQKS5nPd9e9nFfwFnEtBGJUL1AQh/5PWzM/3iOlyBSVL9xx1MY6K5RCdOgRUtuYQ==
X-Received: by 2002:a0c:8b02:: with SMTP id q2mr4425388qva.48.1600754876169;
 Mon, 21 Sep 2020 23:07:56 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id x3sm12523533qta.53.2020.09.21.23.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 23:07:55 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: david@redhat.com
Subject: [PATCH] kernel/resource: Fix use of ternary condition in
 release_mem_region_adjustable
Date: Mon, 21 Sep 2020 23:07:48 -0700
Message-Id: <20200922060748.2452056-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911103459.10306-2-david@redhat.com>
References: <20200911103459.10306-2-david@redhat.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org, mhocko@suse.com,
 Nathan Chancellor <natechancellor@gmail.com>, keescook@chromium.org,
 bhe@redhat.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, ardb@kernel.org, linux-mm@kvack.org,
 jgg@ziepe.ca, clang-built-linux@googlegroups.com,
 richardw.yang@linux.intel.com, pankaj.gupta.linux@gmail.com,
 xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
 virtualization@lists.linux-foundation.org, dan.j.williams@intel.com
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

Clang warns:

kernel/resource.c:1281:53: warning: operator '?:' has lower precedence
than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
kernel/resource.c:1281:53: note: place parentheses around the '|'
expression to silence this warning
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
kernel/resource.c:1281:53: note: place parentheses around the '?:'
expression to evaluate it first
        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
                                                           ^
                                              (                              )
1 warning generated.

Add the parentheses as it was clearly intended for the ternary condition
to be evaluated first.

Fixes: 5fd23bd0d739 ("kernel/resource: make release_mem_region_adjustable() never fail")
Link: https://github.com/ClangBuiltLinux/linux/issues/1159
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Presumably, this will be squashed but I included a fixes tag
nonetheless. Apologies if this has already been noticed and fixed
already, I did not find anything on LKML.

 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca2a666e4317..3ae2f56cc79d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1278,7 +1278,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 	 * similarly).
 	 */
 retry:
-	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
+	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
 
 	p = &parent->child;
 	write_lock(&resource_lock);

base-commit: 40ee82f47bf297e31d0c47547cd8f24ede52415a
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
