Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113C1922FD
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315058; cv=none; b=HVSrZk6dNRJ3IcWolUeyYwYcvWt2a0Viyt48zE0KpPnEYAbfiOjvtZm8IfRMNbnGggpCCsRBn5paCSkhS8UE2huhYRaLCGejeFN5yFXrwKCfL+OU3RgOuRdcSR0OJlEM1VH+5HiJ2AImIF3Bo2sBGQsHj7pfzXGYJhDXbBKjL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315058; c=relaxed/simple;
	bh=5F6F7qba1uzyjFZMv+EeaWChEVyxbKI9bB3fX112gzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRGWBLFdWl9640f0H+x5T/7AtixQEH7AbK1g2cFRqef+eWk9Sho1c4bbDsIBwzidlwKtQBeNPzrgCMfXCYaYG+Hj/2qA3Q7h9SL7TWf0Z4CjrSE6HFZvEqrrqieKjyE6WSFQbXtt978whx4AiOLL0PHRGz0gCg3xyRb5pfrOWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XLLTWw8C; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XLLTWw8C"
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5F6F7qba1uzyjFZMv+EeaWChEVyxbKI9bB3fX112gzw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790315054; v=1; x=1790919854;
 b=XLLTWw8CMCBodxzboYQbeud9j4W5k097vZbJH7Fxa+WDrz+DxDXwi+Z69cKGi+kHHwLD1P4n
 VNAwZ8rjy3gz6oNIX+HER+c8pT/1TjW5bqSq8KjvUQe1bfM0+Wl9bWm6Ft4ZK5cvRmkFVexga8a
 KK6J7qRsLTrFw1A3HhqE4vNo=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 14310745666562df;
	Fri, 25 Sep 2026 05:44:13 +0000
X-Mizu-Trace-ID: 14310745666562df
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: sj@kernel.org,
	mst@redhat.com,
	david@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	ryncsn@gmail.com,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 13:44:08 +0800
Message-ID: <20260925054408.10431-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
and virtio-balloon:

With this kind of workload, an agent may read a file once and never touch
it again, while those pages remain in the guest page cache. Without memory
pressure in the guest, they can stay cached even though the host would
like that memory back ...

The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
cold file pages from the guest page cache; buddy gets a chance to coalesce
them into reportable blocks, and virtio-balloon passes those blocks to
Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.

And it worked: time-integrated host memory use fell by 21.2%, while peak
usage stayed about the same, with no significant CPU overhead. Pretty cool
to see these pieces show up in another real, large-scale system :)

Kernel work still changes the world. Cheers to that!

Anyhow, I still don't know DAMON and virtio-balloon as well as I should
(mostly I just know the people who built them) :P

[1] https://arxiv.org/html/2609.22978

Cheers, Lance
