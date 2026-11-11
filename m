Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364223;
	b=XPqVlT2oXGWo8yEujJQg0FWz+L2xUHNi27+ErgnlgYRrTiGuD3uc7mFcKVMd/oKeuqfj
	 YztXs3u/0DPA+U4vC4Ms1A3PNWCJorcejaDg+chA6MHhoBRHfeTAxeo/dNsueDwEh5Jyu
	 1HJ76dG7zHYnR7aVrUovutaZxG4isOz9BqGHBzv7vDxIosbJbwSBpn9kqkUu+dpG1zAHQ
	 fwNsYUVcGzyWL87Pu3dpGEc6JXg2UtGccdLhL4vLY2ZdCOZDMJqcPye+TJk2VeS1FhyXL
	 izl4wxV4Z8lCBLw8u5QVjw4yVwE0QKRRwKmSwKstoni//caGfIEXW3n3BBzn+cvmA5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364223;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lj8R5h31SmjZqTmZc6n5KHgrYv+EfODrdqeVn/tvRLA=;
	b=eLn9fHMd/CDhsC2o5N9HHLTCXdDcRIvwnd6mq6I5wPBaZVf2n8A1bf2mOhj0c07Ddhi0
	 BsiOqelIpjd/+IMMeGVHuZK1S1Qu78uY9cr0SfJJpQVtbDy4NWCbzucOl2qXLq5vzMcXy
	 NUt5mSxzq8ZnfJ28xO2/zhqMwtMIFD26CVMFw+Ia9hm773u81I2M6RiWqLaF48H1160bA
	 pLeuAi7U8LN2gktLsG5ll24urQUlB6QEGk+49LZmGS3Kmy38ydGVB1CDpPBKO2znEycIS
	 PCcEoxRBs/bpC7fJb0oFTIiDHU88Y1wSlT1QUY7NvC4ypA9IxLNYgQRFdf9fBDxRoLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2F606A321;
	Wed, 11 Nov 2026 02:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d47ea8acdd7711f19a56ed5b684f684d-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:598bc337-5a66-4b78-81e1-7bba62acc267,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:acae855ddf166885547dc21174e7b8c3,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:11|94|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d47ea8acdd7711f19a56ed5b684f684d-20261111
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1910389456; Wed, 11 Nov 2026 10:30:16 +0800
Message-ID: <934e7219-119c-4194-8829-fdef71d39650@kylinos.cn>
Date: Wed, 11 Nov 2026 10:30:13 +0800
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
Subject: Re: [PATCH 3/3] virtiofs: zero the reply region of the argument
 buffer
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 Sashiko <sashiko-bot@kernel.org>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-4-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261105150943.86650-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miklos,

On 05/11/2026 23:09, Miklos Szeredi wrote:
> copy_args_to_argbuf() allocates one buffer for the fixed in- and out-args
> and fills only the in-arg part.  The remainder is handed to the server as
> a device-writable buffer, and the server is under no obligation to write
> it: the used length it reports is its own claim and
> virtio_fs_verify_response() has nothing to cross-check it against.
> 
> A reply that declares its full length without filling the buffer makes
> copy_args_from_argbuf() copy the uninitialized remainder to the caller,
> so a server that fails partway through writing a reply returns stale heap
> contents from e.g. fuse_statfs() or fuse_getxattr() instead of an error.
> 
> Commit 5364d081125a ("virtiofs: validate fixed-output response length")
> covers the case where the declared length is short.  Zero the reply
> region so that the remaining case yields zeroes rather than whatever the
> allocator last held.  Only that region is zeroed; the in-arg part is
> overwritten by the copy below and the buffer can be as large as
> XATTR_SIZE_MAX.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-f0d6d4a3-f5df-4f72-ab09-802e5aab49a6
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index c824916f0a9b..cdd6f5c50d6d 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -701,15 +701,16 @@ static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
> ...
>  
> +	/*
> +	 * The server is not required to fill the reply region and the length
> +	 * it reports in the used ring cannot confirm that it did.  Zero the
> +	 * region so that an unwritten reply yields zeroes rather than stale
> +	 * heap contents.
> +	 */
> +	memset(req->argbuf + in_len, 0, out_len);
> +

For the virtiofs scenario, the server (i.e., host) is trusted. Ideally, the host 
should not write a size without completing the data—or at least not maliciously so 
(at most a bug, which should be fixed on the host side, whereas if it were malicious, 
we couldn't defend against it anyway). Since QEMU/virtiofsd can access all guest memory, 
a malicious host could always leak guest kernel memory contents through channels like 
fuse_statfs responses. Given this, I'm wondering if adding this memset is worthwhile.

Thanks,
Li Wang

