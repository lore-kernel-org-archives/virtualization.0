Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABD1F875A;
	Fri,  8 May 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265084; cv=none; b=XdO+mromiBObE8PBwprNKTi3rKxjkfHo3NmL3dhiW272S9JJuaTKw61YCSCsDT2PgkCusOj7/INQLANHkP7tHZkeL7Je1BGDFhI+dKFM/NBEGcizCpxgIPAGd2mgutwCrFUK9E3/GAKYgWfjfD9jx2Zwn6jnaNxqYDTW2hHglm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265084; c=relaxed/simple;
	bh=1THTx1MNdQbS8SAzVpR4M/ng9K2023DslkdCdS096cE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VkTfOjKYRAQxlQhm2OiNJMoVFv9/12ta+PJpJS0yuMPcq71nLQ/ynNLFx+PD+tUgt8yhEf+OXzyDUhk+u2PGCTcnoTpfBFRM0C5TQMcZ2fkHdBk8AgZLyLi5poDzxO3KfqFOeY95Vu34NikemZRYk5rP+wtW1vMUmP3Q9SgEm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xghED1y5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xghED1y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE4C2BCB0;
	Fri,  8 May 2026 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778265084;
	bh=1THTx1MNdQbS8SAzVpR4M/ng9K2023DslkdCdS096cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xghED1y5ak99PyTic9otbxraN/bOP99QbR1j9ocdEokqGW8e1yzqLofSWT9n1luPZ
	 ADFRaxjVnYoJcSeDECqjxYVhzSCsul5vgR+r31JIpVmxptrnkXCiSh9vBa9QDporFk
	 YcYmFhNn6Ejs1+IQZGK3SEkSzjSVaB4bMAkVbKoM=
Date: Fri, 8 May 2026 11:31:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/balloon: expose per-node balloon pages in node
 meminfo
Message-Id: <20260508113123.c8e653484d39e76cdd6e142e@linux-foundation.org>
In-Reply-To: <20260508094736.142467-1-hao.ge@linux.dev>
References: <20260508094736.142467-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 17:47:36 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> Commit 835de37603ef ("meminfo: add a per node counter for balloon
> drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
> However, the per-node view at /sys/devices/system/node/nodeX/meminfo
> was not updated, even though the counter is already tracked per-node.
> 
> Add it to node_read_meminfo() so users can see balloon usage per
> NUMA node without having to parse the raw vmstat file.
> 
> ...
>
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -523,6 +523,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  #ifdef CONFIG_UNACCEPTED_MEMORY
>  			     "Node %d Unaccepted:     %8lu kB\n"
>  #endif
> +			     "Node %d Balloon:        %8lu kB\n"
>  			     ,
>  			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
>  			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
> @@ -556,6 +557,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     ,
>  			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
>  #endif
> +			     ,
> +			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
>  			    );
>  	len += hugetlb_report_node_meminfo(buf, len, nid);
>  	return len;

This was prepared against a kernel whcih didn't have 2232ba9c7931 ("mm:
add gpu active/reclaim per-node stat counters (v2)").  Which was added
in February, btw.

Please check my fixings:

--- a/drivers/base/node.c~mm-balloon-expose-per-node-balloon-pages-in-node-meminfo
+++ a/drivers/base/node.c
@@ -525,6 +525,7 @@ static ssize_t node_read_meminfo(struct
 #endif
 			     "Node %d GPUActive:      %8lu kB\n"
 			     "Node %d GPUReclaim:     %8lu kB\n"
+			     "Node %d Balloon:        %8lu kB\n"
 			     ,
 			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
 			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
@@ -560,7 +561,8 @@ static ssize_t node_read_meminfo(struct
 #endif
 			     ,
 			     nid, K(node_page_state(pgdat, NR_GPU_ACTIVE)),
-			     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM))
+			     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM)),
+			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
 	return len;
_

