Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA531A6803;
	Sat,  9 May 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288851; cv=none; b=PwtWQPjeGGGpIWF6lmymuagpLNZP75YCn/T+JI688p3JDfyrDH+38iSrOZ+gvV4RsS+/GK3RbU4jSFMftjWDyk8yxVZt0bzBzT/5xksqog/Uudzra75ePnRZhdDb2FbTSqcS4iiDj+xcQ6c9hZCWu/rqRQA/qE8/7bjvQ8DmkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288851; c=relaxed/simple;
	bh=2we0wfmewVjEzY98udpopwqzsrMOslpQoy0p1QISyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyIcmxCfG7M6lj0jKMoARnzyxttYorBszuKJZ/YXGkKdWhTQ27Za2bd67nb9pwgPiTL2LKx404ECstfcpkbKENPSoJGuDJqrqY/j4uL3Xa+SFVktV+YiQ34DBeyP0CIPG6nwmemeQxjSEEP64N7JWniMdlH4HcGamlhJ9QxuQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krnqi5HC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krnqi5HC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1477C2BCB0;
	Sat,  9 May 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288850;
	bh=2we0wfmewVjEzY98udpopwqzsrMOslpQoy0p1QISyz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Krnqi5HCNZBb56s0oa3WMaF0sLWUatRFicFZm+7p8yQcexa7KnrCEdo5sBfihvj1f
	 bbH7Im33OvZeWPFw00zae6s5Flo5zL3wI17Xc+QachQtIsuOkGTSk03H7Ng5XAbCZg
	 OIEFvoLhHvdmA/X6hWef6g+yVxJDisLAamrJcmmOYPxALV3yWoG8cty3GEjvWzaE5V
	 Z6C4JmoAvkkLZsLgF4qj3DnPiHwaUkowoJZyI71UQo7xQBTgedPWHRrJRDX4f0Jnar
	 meObzWlSTQerIWjWXyelJsd1DlXmqsle/yPdehr/71kc3lCMQKFLfhaW99iM3Fizzg
	 q4s5Fk5OXpyLA==
From: SeongJae Park <sj@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/balloon: expose per-node balloon pages in node meminfo
Date: Fri,  8 May 2026 18:07:28 -0700
Message-ID: <20260509010728.84832-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508094736.142467-1-hao.ge@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  8 May 2026 17:47:36 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> Commit 835de37603ef ("meminfo: add a per node counter for balloon
> drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
> However, the per-node view at /sys/devices/system/node/nodeX/meminfo
> was not updated, even though the counter is already tracked per-node.
> 
> Add it to node_read_meminfo() so users can see balloon usage per
> NUMA node without having to parse the raw vmstat file.

Makes sense to me.

> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: SeongJae Park <sj@kernel.org>

> ---
> v2: Move Balloon field after Unaccepted to match /proc/meminfo ordering
>     (suggested by David Hildenbrand)

Adding a link to previous revision [1] would be nice.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
