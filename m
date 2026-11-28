Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795843031;
	b=OEGYxgHgcrgL8OLMpxMLPRFBt6N0dk7bwku1MisnrNeVV/B4w+Y9b08Tqj7MHBWVjW8R
	 KDBgmeelAGaknSmDeg4Mk0ZfZJ5z5MBWQIOMoU5NHCiib0olnXxaK0PlyM2ART3ySusXh
	 7/3UKmxJ/e+FOhwSgYZhO/diXGRZhjLIyRSNMdpy8PO2mqDzHvGKt3yc4no6R2UFeupip
	 RLqAKV/bwBu9n51JYp5dhNcEtnN5sJAGZhYGTlWPKcCb3s1xvIS+85JyBJISVUtQHeATu
	 E+6xyh9+IfC+/Sdt96s9hrq+jVAW++cSw9iP26bMcWW7ad3H5EzJj3fyPD1mW3GKu3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795843031;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SARcJ4OiEbkM6r9haDpTIZ07Si5ySupOLHDXUH9bBw0=;
	b=hPlsVpzvsI/zu9rn17sIRcYg7yq8B0BVLubG2FFR2Hq5xX8b91O7DunGVQTthUc4UR1V
	 OSiXK5P/nCQ0uB5uP9gOyJ3MMbV7jcR+hus6zZZ3DwsYhWGWuQa17dD4lEkYvO6xEJZEr
	 jE3TKqdgXGAy7kA7VitNNsILhth0km5dI1u0SVEYCAvt20l4DkZqfMpFdMfM+AHLiNSBY
	 U2nhY+wOPFJ3/AV+B2UeiPkTuAQNTEmUPMeR5Geg0/7O/XuGfW1V49NXye8GAwC6jvfi0
	 gtCiV1sZpSyW241xZkYWTZDnp8/oicTZpj+eqmkWcHuOCz4ZNIkfMtc/ccD0eulCqLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D6606A31C;
	Sat, 28 Nov 2026 05:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E5D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: efd334f8eaea11f19a56ed5b684f684d-20261128
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c5859302-451f-498d-9b52-5039b7b646be,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5efc92fc8fdee016395d3e281a84327a,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efd334f8eaea11f19a56ed5b684f684d-20261128
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 126678896; Sat, 28 Nov 2026 13:16:59 +0800
Message-ID: <00909830-f4ee-4573-97d2-792fce9fc74d@kylinos.cn>
Date: Sat, 28 Nov 2026 13:16:56 +0800
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
Subject: Re: [PATCH 1/5] virtiofs: fix DAX range leak on unmount
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261126144719.232329-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 26/11/2026 22:47, Miklos Szeredi wrote:
> generic_shutdown_super() clears SB_ACTIVE before calling evict_inodes(),
> so at unmount time fuse_evict_inode() skipped fuse_vdax_inode_cleanup()
> for every remaining inode.  The DAX ranges owned by those inodes stay on
> fc->vdax->busy_ranges instead of being returned to the free pool, and
> fuse_vdax_conn_free() only frees free_ranges before kfree()ing the
> connection, so the busy fuse_dax_mapping objects are leaked.  Nothing
> warns about it: fuse_free_inode() kfree()s fi->vdax without checking
> that the interval tree is empty.
> 
> Call fuse_vdax_inode_cleanup() regardless of SB_ACTIVE.  That is what
> virtio_fs_conn_destroy() has always assumed ("Soon evict_inodes() will
> be called which will free all memory ranges belonging to all inodes").
> Unlike the FORGET in the same block, which is pointless once DESTROY has
> been sent, the DAX cleanup is the only thing there that owns memory.
> 

Minor nit: should we consider adding 
"WARN_ON(!list_empty(&fc->vdax->busy_ranges));" 
in fuse_vdax_conn_free()? Since as you noted, 
fuse_vdax_conn_free() only frees free_ranges.

Reviewed-by: Li Wang <liwang@kylinos.cn>

Thanks,
Li Wang
