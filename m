Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61B37BE9C
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884129; cv=none; b=q9P2LfVKSagOtqfACVLPYas2BJAKBeAlBBkarNwWeE2/P/jpy1K9MmK1YAwiDHpQMgWrQOXWJOT6220wv11yj/f7Z3pbn3WuibAkpq3vyMsGR8kAlbE/YTYIEvQnjVcmb6xQnSylYo5YSMJtMErhFJ0Lmtwxk2kgATkINfCfhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884129; c=relaxed/simple;
	bh=3lnLwA6Kacwc5vQPhRVzE7e783OHkJzNW/An8cp43LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvImLwELIcfgUPegtdt49PL95S+lom7snHZ8lmDNktkE0/b87gKaxxzXHgVjIARv3TGq0ED/Pb9UE73M57m4lA489c34UueqNaNpSWYwK+ZbL/IKW0aIvCTsvhtf3KgyN/1JgHeUiXDJFzibqLGlvfLrUyscqvv4ubgtawl7MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TcSS57dc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TcSS57dc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kkP5CpymLzmaybT67yKfxuskN4Ws6gR75d5MFXrMNM=;
	b=TcSS57dcPTuzFiz0VQRxgsv8LpTZqaPz5GNHD5yzJmHEZqJrpClvUNfa5wLf2DrTtS5ho7
	9IhGWtcLrMn2sWEQQYMu5oETXwiD/pLzqIQV9eIZh4T5IMLTdY5bYdSIg9WWMLzxOSl+QN
	bS7yh0qUuflQ3sEPZhO/X/vJjmFI7Rc=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 13/62] drm/qxl: Fix a buffer leak in an error path
Date: Mon, 23 Feb 2026 14:00:13 -0800
Message-ID: <20260223220102.2158611-14-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

If qxl_bo_reserve() succeeds, call qxl_bo_unreserve() instead of
skipping that call.

This has been detected by the Clang thread-safety analyzer.
Compile-tested only.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 4ee2b5acf2e0..5617811f3c9b 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -323,7 +323,7 @@ int qxl_update_area_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 		qxl_ttm_placement_from_domain(qobj, qobj->type);
 		ret = ttm_bo_validate(&qobj->tbo, &qobj->placement, &ctx);
 		if (unlikely(ret))
-			goto out;
+			goto out2;
 	}
 
 	ret = qxl_bo_check_id(qdev, qobj);
