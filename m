Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415682;
	b=Ts+yqo0KbCRYvwEqEKysLhtGKEFIAsbcqx3WvtVr1isT192SyjxcQEj0XV6aD8xTkV0q
	 fcfEH/9n2kkeDU4xP6twaSITn8UgCqCKXK+feqB391kYMVLpetyolUUoLAcuURvIL/j3z
	 aQeMwBQ6QyNyuQvxcJdPZ1MVI2gtqHmtClZvzBlxxmD0P9yK8tm84LMkziKJgQf+AFcng
	 OduMuHeKEFG2RxdRLTiryFJAVBGGZJFbf2BmvNQZ5V4oqlW6oCw36wXA+KozEoiFeS8RH
	 1h/LZmwUBBRwJ5kxR8hDMy1jLS1nRywo7nPr6UKsyNZtJBKA3ksDoc3XQoUt37PXBFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415682;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dmlXveCSZnpBPgqF5aW5G0Y7xoxhrlf/pvo5jEKUvxU=;
	b=DmfhqybOXTRdalZZVF0HFQeKClraaReXCb3/0nFrptNm1DWIO02S0hCGj8qVYYBsBdNF
	 9ZMOeqvAAsuz6JtP+gLNCFf2eFYXrCrd3u1Jns93C97BCI9eGNycuBCCqaAaCepf4+5KZ
	 Tt8i+8QFVcVm4orkpR+ok4/ALuJWT/l9FYx7NayGPILjL35w5YT6/rQKIlI5WQ9DoukJg
	 2mujWodfgGSl8RKmZHm1adXj0fAiL/yA1SuRTPbTMOe+alk42gt0sQWT3m79YqQbbQv00
	 05fxZxqSxamAR8CRT4bsHOwTP22U+W1OsgM2boeCgZrbwnwm07istncD4gD1xo9xmnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dlBydcnf;
	arc=none smtp.remote-ip=95.215.58.216
Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE9606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 06:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74EE9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dlBydcnf
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dmlXveCSZnpBPgqF5aW5G0Y7xoxhrlf/pvo5jEKUvxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795415679; v=1; x=1796020479;
 b=dlBydcnfQX12oRR8uydjfFNalP6lYwPHDZCy6hmywmxHuo952ryyGAAepLiDfoCEtfpaRzzm
 wApFdueyiocb2Ktsgqp4hFv8Z/M5BEz+tDi72i1Lhg4EtB8Lc8iqQyvAaQDqYyA8VMdGE8L5Xs6
 Mm56EnvkWC59K4BDGst5DI58=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 0039204fecbaf92e;
	Mon, 23 Nov 2026 06:34:39 +0000
X-Mizu-Trace-ID: 0039204fecbaf92e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	nico.pache@linux.dev,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
Date: Mon, 23 Nov 2026 14:34:34 +0800
Message-ID: <20261123063434.99254-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
References: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Nov 20, 2026 at 11:34:43AM +0100, David Hildenbrand (Arm) wrote:
>vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
>using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
>for base pages.
>
>So far we didn't account 2 MiB pages under the "Balloon" counters, so
>/proc/meminfo etc. would not reflect them.
>
>Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
>these pages manually.
>
>This has low urgency.
>
>Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
