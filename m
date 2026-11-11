Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400606;
	b=ZoDbn4XkpgmfRRBknpJTsq99LYjPgEBr+cgkP65nfFGdDjUEhh0/xntY8ajwXfnFpzvN
	 ET96UJZSLtuBsOv4Y8qnVgnLa8m84ppmxTOu83zpOloougy6qEq2+WJDfbZkQnYhsWcxp
	 ZdJce/3CCIRbTs2/lQWD+33LPklquLl8Nu1uXjkyTDuxqAumJy2TAz2Fe4In6Ufpx4kzW
	 qLoEc1Dl85Ndv6hqErt7NHqDvLUy3i+VosCfyNudvln51DDrFlWMQWv4klySqGVkaH6RC
	 T+JXn0xFJ7YtCb2MLviVhShrAQC0Ey7nAwXJrl5EdGEgaUqUEvFDeMOVldFN+a2UZKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NA3S0+TcajF90K5hGXvldMp+JqFlXBnQmtQs2Oovhrc=;
	b=VtCKViELcXU2I9OTdpwvzQ5v2aKf5PsWsd+d0u5vH14anhyJ/FE+rLBBctXGPqrKAz+N
	 tXPWthOZvHYw490LL6cMrUFihHD9hFBhsz267NuNSY7pId/gtAuj60p1/PPoCOIaDAovR
	 q5hoynHjS1AbKJUio++b1xB/tY0UtWPMlReIMEspLbM7KQdVldvHdjCg3kLKQmikuwH2u
	 wLst+STG3D8iszJceaDqmZByfRdqHxQarDgGU072507rUmjfa4jvI1ws+s7/UjeUpM3cC
	 TIp161rr9eKadbVyTLTp9S+aD2NVr0ClQY1AA587/s/woPaUknq0u0paXT+tsdSUSDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9+vLzd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873A606A326;
	Wed, 11 Nov 2026 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9+vLzd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB07A1F00A07;
	Wed, 11 Nov 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400606;
	bh=NA3S0+TcajF90K5hGXvldMp+JqFlXBnQmtQs2Oovhrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H9+vLzd2Lhu/eWWmeDsvRPseso8wUf+PyA2D4q8090P92qb4NNccLDohXyYUMEpnb
	 hf7xzk8PyBrRkszUciwVXEBszNLjVAruA91NZhWmmuH5klyj2fPK3lz/jjQ3qtjSJ5
	 QWvEGKlnB7uHH5OepDSKp0OOexS+hkY4/i5H8NWFyVE617U/vDgqHpECZ9GypiMXft
	 ZhndU/e1LMyGF1CC/qVU0NGj7ESGf5Won6mywMD0lED3dPbzw5yjdvNRqjQzl0N+6E
	 mPPllJ+h5ALbxOucIniGOXGpeJ6E92tSJu/75MFcA7ofbbBw23SCOC2LT23EMRNqKl
	 rxKTcpqwbMw0Q==
Date: Wed, 11 Nov 2026 13:36:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Message-ID: <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avNuQqLf9CG9dSsE@casper.infradead.org>

On Tue, Nov 10, 2026 at 07:19:30PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 10, 2026 at 02:52:36PM +0000, Kiryl Shutsemau (Meta) wrote:
> > +	src = kmap_local_page(buf->page);
> > +	memcpy(page_address(page) + offset, src + buf->offset, len);
> > +	kunmap_local(src);
>
> 	memcpy_from_page(page_address(page) + offset, buf->page, buf->offset,
> 			len);

I don't think that works. pipe_to_sg() only clamps len to the
destination page. A pipe buffer however can span multiple pages of a
compound page iircu. And buf->offset can point past the first one.

I found two exmples:

(1) skb_splice_bits() for AF_UNIX and TCP
(2) tracing_buffers_splice_read() with buffer_subbuf_size_kb > 4,

And virtio-trace splices that stuff.

Which means VM_BUG_ON() in memcpy_from_page() fires:

kernel BUG at include/linux/highmem.h:542!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
RIP: 0010:pipe_to_sg+0x130/0x150
Call Trace:
 <TASK>
 __splice_from_pipe+0x92/0x1e0
 port_fops_splice_write+0x13f/0x1a0
 do_splice+0x3b6/0x8e0
 __do_splice+0x20a/0x230
 __x64_sys_splice+0x97/0x130
 do_syscall_64+0xde/0x4b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fwiw, the open-coded copy is broken as well. Just on HIGHMEM...

Starting with b46e09667411 ("fuse: enable large folios")
fuse_dev_splice_read() hands out large page cache folios and
kmap_local_page() only maps the first page.

So a fuse server on a 32-bit HIGHMEM guest that splices a WRITE request
into a virtio port crashes mainline:

BUG: unable to handle page fault for address: fffab000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
EIP: pipe_to_sg+0x184/0x2b0
Call Trace:
 __splice_from_pipe+0xd6/0x1f0
 port_fops_splice_write+0xf9/0x170
 do_splice+0x2c1/0x810
 __ia32_sys_splice+0x2e7/0x310

So we need to copy per page which would fix both.
