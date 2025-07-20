Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105221B423D
	for <virtualization@lists.linux.dev>; Sun, 20 Jul 2025 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994377; cv=none; b=Ceni04K/1UD/0o+P9Sb00Ydwg8NwcpFoWIg18ctbEwDryKQWSocxOIVbctarVNbMi8qU5nJYgtowOy3BKXzhlA9UbhFavo66SMymd0yi4uHYqX4HT/SSG12FTWL+wZ0Zr2bXVUuyeQusX8JbwOO4uVG/MvBBRc9wK1gXXORWeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994377; c=relaxed/simple;
	bh=hbvAwknEuBZZy8wzM2rrw6C9ssd7Qd2r3sI2ZSM6FRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgg4kQ5KI7ZZv54UTufS9fX1kZ3JyQ1zDsGtjwxWQO3i7uPE4pMFL5DlEnqOh3xqanU5lk6VG8eRnqRUJUU0rt4K8N35AHNBT8QOmKwferMpgySZdnWPJo0bu+OR6KRYza3HfMOxAtUU86JonV/E3k0wbfR+QhBIOaTikDdbWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FktW2hKM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FktW2hKM"
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0e3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:51:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0e3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994285;
	bh=is1xGlkfyHt70hEGiHhmNMzkwdIVhZyUiA44BEc8nvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FktW2hKMjcrEahQ4BX+tnQYpnVrlQ0KHypZy5Z6dQU+OtvbravrDm40vu8FXR4g8H
	 xbCM/ysi7vqQh6gNwfRz4t52FBII1ke1vd0E83TOBa6FeyoVzvi4tuqeEbYhDHfsUq
	 tKZC4cywsDIyDVp8aHVNxDfNeooea1dYznAMQh8tZvGy1q1JAJCGRPVLWK7bYXu3Cl
	 19V6FZZCYpobZ4DD5XRnnV+JrEendA569OUpmtttbVpcCaqaelNI6vdaSzVH08LDUM
	 snW6ecw1wTrRCUnkpjzR8rw5F7Cf4oQToZgwDTuMRprULu9l1rp9zgbU46IPbH4Nim
	 lXHN2zQagbwqg==
From: "H. Peter Anvin" <hpa@zytor.com>
To: 
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
Subject: [PATCH v2 7/7] tools/virtio: replace "__auto_type" with "auto"
Date: Sat, 19 Jul 2025 23:50:44 -0700
Message-ID: <20250720065045.2859105-8-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720065045.2859105-1-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace one instance of "__auto_type" with "auto" in:

	tools/virtio/linux/compiler.h

This file *does* include <linux/compiler_types.h> directly, so there
is no need to duplicate the definition.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 tools/virtio/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..725b93bfeee1 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -31,7 +31,7 @@
  */
 #define data_race(expr)							\
 ({									\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);						\
 	__v;								\
 })
 
-- 
2.50.1

