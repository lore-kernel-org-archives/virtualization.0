Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551461;
	b=epxxDryfz68U2EaEq1G0+09AW332bcs7bEL48MlMtqFY1VFOJIHddcq2SwCmv7o9c14S
	 8PPZW3KZGQ0NpEmEHyYbY2OMJkiOYDU4+fKKTzFUMJ1zj6jUxLIwT86zGGU8cDF7sFS1U
	 9xMXuIb6X2gvtBGoAQdTQUjqjsbrkPjDpinox0JCwM9BdKYpY8PK8/NhC0r95+3d4Ix0l
	 9LbP7s6GEhiHkv2xXt3NkAsQpfwbkBskb0eTO+iPgkTB9sWVtFyA2u+vT+oz2Eo6FAUO7
	 RTioZFbwDf0T6MD5zoSiOh1WGwMJRnpjpBKa6FOD1F4k+dlAgG0JBlJNk0Bk0S/Avcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7tEIWHNr59KovVpk7gJw0JqnDAdNK2se9vPrBzQVaug=;
	b=nuneSU6TurOVGcKDKXDksWtaWginkwGFzzfVrQdfyFlh2cAAoy9SBcoxiGewZNspUqjq
	 jlTxqGgvbNxPTu1TIJ3CJvhsZaGFg4tdPDMphk5iAKT1pRV9kK4KhLiD5R7WQYW2MilFb
	 AbE+trOmLbov3kp1qkhSFkrm421G5gRS8Y/WmmIgLHL6QYzrvHSGWqJNqFY78ELnMVPhd
	 XhwRsMOUQcfiiJmsQCld86ncIfXYWPwBrRb5gexdV4I1x64yDon9hkUq7Jb/z3DYcB9c8
	 hFUCNDrIh7Kpgm/GQmxbnrRWni3PkoJJ0II7UMmSUTCvDxocGofU4OFwMKhPhxnKn5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--pratmal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ap1Clq/f";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA48606A330
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 20:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA48606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pratmal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ap1Clq/f
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386177b0516so12843959eec.1
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795551460; x=1796156260; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7tEIWHNr59KovVpk7gJw0JqnDAdNK2se9vPrBzQVaug=;
        b=ap1Clq/fx+UlLwb+bqkF5T6saRHf3wORsrPtk9RbHmmgjFQp6rD+VKCVBAsaDaM6OR
         1P5GwsncLbSx6rDDA24ygnK1Y3h3z4Ge2JBxzT/FOb0DxKTm34k+QA6ANcrgBobQyilF
         Itw97ZnOzEu+dy2OtKrugE7vRfJIoWJ8384Le999k+TibXLdfx97tAs+Qr0noXvhoaGN
         L4WZJgURoW7g08kAzI7XCecg7vDQkddBhMo3goOuX/446fKzPytdoc785vbfNQTDMq/W
         3kYQ8UdY1mqJuEumy343e0jAszTA8wa1oJqNry/FyLaZN3nf/Qq9823m+xz8Z/js6iax
         JvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551460; x=1796156260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tEIWHNr59KovVpk7gJw0JqnDAdNK2se9vPrBzQVaug=;
        b=va4zDKqrTh13MjU1Ysrkv3zAeK0Rzwj/swcxjyklEePf/+ESNSYaWzQJgoSX4ghVO1
         9LEndv1OkeFqgFAM4wSaqflOfYQbWbrQQ0mNNbBICUovyw43xwSYNAEowlmDidP4o8o+
         JHgcA2iWs2NL9valLPQ2cHTs5DIs2mZDAU0/m9utb6R0vLDSQImcm65K9tuB2RvMftT7
         WLrh/lNZCh2a+PE/GYPtK0O+bQ6GrElTDqbzCgRa9XPR6LD59oZ9wAyIqwJEOW/ao6Xo
         DJ2O7s21NbYSxrevg7glZ2V/aIEdeN6TV+XJ/ctMKBAZX6p6luqQQPDYiMJIO86TUNfC
         602g==
X-Forwarded-Encrypted: i=1; AL+hErGiIOLV5RJ2EJBgE1YYtw3RRq1SQiJsfFvxJ4NxL6YkpbfeDkLz4IIs11MP3dS4BxdJNtEp3e63gfR7YlMR6A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Q1tjYPEpnSsE/EzwxgBT1xrH7F6qHFvgvBy4RsHg8ZlUYFGCM
	4B+iy0KTMXPfgeUTHz0jSGT2K0YmKLyXbq/KqHSdggfJ0Ez97PdCIK2p6VLdLa06C7A8h86kadu
	FQEmFFYWr0w==
X-Received: from dyblz33.prod.google.com ([2002:a05:7301:1621:b0:34c:9660:9612])
 (user=pratmal job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:20ce:20b0:37a:a9db:6bd2
 with SMTP id 5a478bee46e88-3856e63b064mr17431781eec.11.1795551459435; Tue, 24
 Nov 2026 12:17:39 -0800 (PST)
Date: Tue, 24 Nov 2026 20:17:35 +0000
In-Reply-To: <2d518dd7b8f7be147b9a957ad94f6c6641e4b5ef.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <2d518dd7b8f7be147b9a957ad94f6c6641e4b5ef.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261124201735.1311047-1-pratmal@google.com>
Subject: Re: [PATCH v11 7/7] mm: page_reporting: add flush parameter with page budget
From: Pratyush Mallick <pratmal@google.com>
To: mst@redhat.com
Cc: pratmal@google.com, aarcange@redhat.com, akpm@linux-foundation.org, 
	brendan.jackman@linux.dev, david@kernel.org, dev.jain@arm.com, 
	geert@linux-m68k.org, gerg@linux-m68k.org, gourry@gourry.net, 
	hannes@cmpxchg.org, jasowang@redhat.com, lance.yang@linux.dev, 
	linmag7@gmail.com, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com, surenb@google.com, 
	vbabka@kernel.org, virtualization@lists.linux.dev, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 19, 2026 at 07:03:00AM -0500, Michael S. Tsirkin wrote:
> Add a write-only module parameter "flush" that triggers immediate
> page reporting.  The value specifies approximately how many pages
> (at page_reporting_order) to report.  And I mean, very approximately.

[...]

> +	if (prdev) {
> +		while (budget) {
> +			budget -= min(budget, PAGE_REPORTING_CAPACITY);
> +			flush_delayed_work(&prdev->work);
> +			__page_reporting_request(prdev);
> +			flush_delayed_work(&prdev->work);
> +			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
> +				break;
> +			if (signal_pending(current))
> +				break;
> +		}
> +	}

I think the amount subtracted from budget here doesn't reflect how many
pages actually get reported in that iteration.

Each iteration runs at least one full page_reporting_process() pass,
which walks every zone, migrate type and every order from
page_reporting_order through MAX_PAGE_ORDER. How much a pass reports
depends on how much unreported free memory there is.
So even "echo 1 > flush" can report far more pages than requested.

Could we use this flush as a trigger to start free page reporting right
away rather than waiting for the delay, and flush whatever unreported
free memory is there?
