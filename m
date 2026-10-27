Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113628;
	b=H/XfkaoQ+C042grNpxpe2RsQp9oYQiIMFdSfJaQMWgVJ9tzoOzyW+wM5mrfjpBen5m9+
	 o1FJcbdmwDWoHFO/RRHlhGkl/AacSZYhuSEzFxg2vO1dbDYROcJSGY3brRmuXJd5C65s/
	 ReKSDka2P/n3+KO5k01c7x3ME/voOBL3KMC3EbuUGWg+nc+qkRnnWeL9O5tJZq5bOMp7u
	 9Nf9wbw6X6lsnwE3jKcRUaCLl30wcZKbFm1Ss7Qv8Q+ra/Sln3jU6pgUPioBxN5wPK9u1
	 XzE9HguexHz3ezTYRZON8Sl9GaNHK+x6BDk6Nh+SiFZHQgMwhRVo2BU/vQkay4Dmflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113628;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wWb7DbFHMWNpVZOckBqEAJofYhxXz9iaHyVeX7ywDfI=;
	b=ygLyOd4dIiFffaRRqTwSGTMi//2EHZ0q43GhSAcJVu+xmbg6AdCjkjpUk/G15FTqDHBR
	 ViLlAiTAfk2ky39uKlalkhNghb+RugRiGRguin49HTI6+OT9ufxfRcSYNghgbawlSfV/0
	 O1nbmoOikCHPGulP5hU1cPnzH/L+jCqe8i+DjUMrXEBmK1YKT/Mw83OyGnmQPUy0o6Reg
	 xht27CkkeH0RdxVFOVg8ACCF4A/GWyOz8PyKn8C7qDAHdt6DKI1+4SR300fcDOdTnT6HA
	 3QRHDfyisRqvZP6dSwe4L5iPhm6BvUUtOcKIGFZgXF9Ob6GOdgX6tp8cV7FxBQGYuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B407606A321
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 15:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B407606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B075568BEB; Tue, 27 Oct 2026 16:06:55 +0100 (CET)
Date: Tue, 27 Oct 2026 16:06:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-ID: <20261027150654.GA14436@lst.de>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 26, 2026 at 07:55:19PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
> 
> Move the sector update into a helper and call it from both completion
> paths.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you add something to blktests to exercises this?

