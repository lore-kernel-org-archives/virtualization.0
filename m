Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838250;
	b=H+lIc0SdzN3KmgmYVi6IBHunQyp0NSIAMGSVuKNX6CEJu0Gzp5RsffVIfs3WZAgyfuDK
	 KY3b5+fE5Bn69QvN2AvJD6FKAIm+pzDuXP+VZplsxDO+VkoZdX8zE3MouuQo9IY7dpj74
	 2HIaG+yStRuV4lgcdJBZTMcLJoWGXa4FsAcM9hwKHl6Ak+EQCvXeZFbuUNNzDsiqMsBI2
	 pnG4TiYpd0xXtUAI+EdhUnS+cNFTKx6rxgT7/Rk0BPnCG7iGsqZXI9dRAqHRLShjZaiQw
	 8KElHhMMx+pC3RRB29emUTmzV7hS954d4rTqz6U7A+J+P+J3DhOkLkS4q4AVT+r9sDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838250;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+tjbZ0Tt0mS++AXqyM3n2X9WGHosrOQfrSVYXA5YiWc=;
	b=dsFKL8SicUFBNM3H/npDab78s5muE57Jc8fx9xqDQV8YVi7TDP7Uziqwl6AJE9vvYZ0o
	 kRI2jDrx+Pd4oXs4xhTFSmyqPoGmjM/9n9jOhFuNtWrf1sJrf+/1Yb60JC0jPTN0weBfj
	 MsZHRZpJbapJ4x9EF+xP5KSd4SIlCWOhVwRJosbGNuhuBJa7mmkcMIXtbk7iKaTJKehbD
	 g9WxsZjGIDomgVTxAB7BJ8XE8VpmOl1q2V9u9WeKSs9bW6qmlthsmO6acEs6AZ8AOZiUg
	 91LVzry5GqYnrF72Avw0sXtC4cH06iGGQOa3dIIjhuVDBB0W8bz9jhgW/sPmBBrsIWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FF606A31C;
	Sat, 28 Nov 2026 03:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C09FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d0dacddceadf11f19a56ed5b684f684d-20261128
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3060b4d1-5f9c-4aa3-8977-fd3f71cc0855,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:cf68d98a61e0ee5d1a96911ae18466ab,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0dacddceadf11f19a56ed5b684f684d-20261128
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2017823991; Sat, 28 Nov 2026 11:57:22 +0800
Message-ID: <6a3d5a9d-9b38-4f6f-be4d-43515c72f8ac@kylinos.cn>
Date: Sat, 28 Nov 2026 11:57:20 +0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] virtiofs: abort the connection if the server fails to
 unmap a DAX range
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
 <20261126144719.232329-4-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261126144719.232329-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miklos,

On 26/11/2026 22:47, Miklos Szeredi wrote:
> If FUSE_REMOVEMAPPING fails, at least one range is still mapped on the
> server side.  Both callers return the ranges to the free pool regardless,
> so the next allocation can hand one to a different inode while the server
> still has it mapped, exposing one file's data in another.
> 
> The ranges cannot be reused, but they also cannot usefully be tracked.
> The requests are sent in batches and the first failure aborts the rest, so
> it is not known which of them the server did drop; and a server that
> refuses a request it is required to honour will keep refusing, so every
> range ends up retired one by one, with nothing to replenish the pool.
> __fuse_dax_fault() then waits uninterruptibly in wait_event() for a free
> range that can never arrive.  Quietly retiring ranges only delays the
> failure and makes it worse when it comes.
> 

As far as I understand it—please correct me if I'm wrong:
reclaim_one_dmap_locked() first calls dmap_writeback_invalidate() to write back 
and invalidate the pages in the file range corresponding to the DAX window on the 
old inode, tearing down any userspace page table entries pointing to this DAX window. 
Then interval_tree_remove() ensures the old inode can no longer look up this window. 
Both steps happen before dmap_removemapping_one().

The same applies to inode eviction: fuse_evict_inode() calls dax_break_layout_final() 
and fuse_vdax_inode_cleanup() before sending FUSE_REMOVEMAPPING.

Therefore, even if FUSE_REMOVEMAPPING is skipped or fails and a subsequent FUSE_SETUPMAPPING 
is issued for the same DAX window, the guest page tables of the old inode no longer 
point to it. When mapping that same DAX window to another inode via FUSE_SETUPMAPPING, 
the legacy implementation (the C version of virtiofsd and the out-of-tree DAX patches in QEMU) 
directly mmaps the new inode over the same virtual address range backing the DAX window, 
and guest virtiofs only inserts the DAX window into the new inode's interval tree after 
FUSE_SETUPMAPPING succeeds. Thus, stale data from the old file will not leak into the new file. 
As for the latest Rust virtiofsd implementation, it simply returns -ENOSYS for any 
FUSE_SETUPMAPPING / FUSE_REMOVEMAPPING requests from guest virtiofs.

Given this, I feel FUSE_REMOVEMAPPING can just be best-effort, without needing to abort 
the connection.

Thanks,
Li Wang
