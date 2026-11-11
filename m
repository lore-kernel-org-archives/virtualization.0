Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368226;
	b=nolFu60/Md21jm+mXjoGp1PgJoI3kyHpvDEcdbCeQr4KTRjoyLvME14PEnMU/b+LhAVW
	 GI9O8z4Ixrq9llZr+eDDnwUmgdlRoUju7dR9+g47M0giSyezYx2v3oFJlI925JDuT42SF
	 fUsEYrUk8HdbGEwODH9RiiPiFQN464p2JwXoWwNDl8AKLUDw6855IMdh54FrmoYN7SIr6
	 6Ch8n6uPkOmxItfinw99DK4npSkZj2aj1XMTuaMhJV7YCZay6gte7dMNmQWDNEpljfRaj
	 qbA0UoryiSY/KjHcyA7OqeC9AnDHgbCX+8nxDpDV9sLQ6NYDV27y5FcbSWg4AY3u0Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368226;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kc/j2C29W9wZFh23bSMMrtl5tf1xVPBktQg95tPCdGk=;
	b=cbQ+OToUFlrxinTi7rtSZ+yRXatGn0B6Gp4FG33Xler+FJbWNOrSU6VFHce9h9aGwY4c
	 I2XQHU4X4Slr4gmqyHdbCpgfQt/oERCev1n0JHknAWIn6TSo4S6JqE3jl3KEVfTOfTHdp
	 S7Kp6QeByWbKU/xiqWRTFFOsD1u+M3OFRQAnNCy5ZlhJp4OogLeESuNaEziyOMMJh9DWl
	 7X7eOeL7qJnsMdWKyMDSUkBMJl4CdwlRCLq5Lh89+TX/Thhmwoyw/9K7jhgNdDFpHynCd
	 W9z3h42h6yPoYaSzNeePFv/B0lFpHzDm7h7D2fLgq4bo1zrHSYrt36uClZVi8YVAO2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61E606A31C;
	Wed, 11 Nov 2026 03:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C61E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 235686e4dd8111f19a56ed5b684f684d-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5df9ad63-7e83-435f-a4fb-0a0413caffb9,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:505736c0ed68d747baa56c87cb93d0ac,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:11|94|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 235686e4dd8111f19a56ed5b684f684d-20261111
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1394808981; Wed, 11 Nov 2026 11:36:53 +0800
Message-ID: <16a0bf8f-8c30-415e-a35e-9551c78b8dcc@kylinos.cn>
Date: Wed, 11 Nov 2026 11:36:51 +0800
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
Subject: Re: [PATCH 2/3] virtiofs: disable request timeout
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 Sashiko <sashiko-bot@kernel.org>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-3-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261105150943.86650-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miklos,

On 05/11/2026 23:09, Miklos Szeredi wrote:
> The request timeout is implemented by aborting the connection:
> fuse_check_timeout() calls fuse_chan_abort(), which splices
> fpq->processing onto a local list and ends those requests.  Ending a
> request wakes the waiting caller, which then drops the last reference and
> frees it.
> 
> That is safe for /dev/fuse, where the request has already been copied out
> to userspace and nothing outside the kernel retains a pointer to it.  It
> is not safe for virtiofs.  virtio_fs_enqueue_req() passes the bare req as
> the virtqueue token, and the scatterlists point at req->in.h, req->out.h,
> req->argbuf and the request's folios; the device still owns all of that
> after the abort.  When the device eventually completes the request,
> virtio_fs_requests_done_work() gets the freed req back from
> virtqueue_get_buf() and passes it to virtio_fs_verify_response() and
> virtio_fs_request_complete(), which dereference req->args - the caller's
> stack frame, long gone - and kfree() whatever req->argbuf now reads as.
> The device may also have written the reply into the freed request or into
> folios that have since been reused.
> 
> This is precisely why virtio_fs_conn_destroy() drains all queues down to
> in_flight == 0 before calling fuse_conn_destroy(): once buffers are in a
> virtqueue, the only ways to reclaim them are to wait for completion or to
> reset the device.  virtiofs already disables the other two paths that
> could abort a live connection, via ctx->no_control and
> ctx->no_force_umount; the timeout is the one that was left.
> 
> Timeouts make little sense for virtiofs in the first place.  A timeout is
> a guest-side reaction to a wedged host, and the guest has no recourse: it
> can neither take the buffers back nor make the host answer.
> 
> So add fuse_conn::no_req_timeout for transports that cannot revoke a
> request once it has been handed to the server, set it from virtiofs, and
> use it to skip both fuse_init_server_timeout() and the
> FUSE_REQUEST_TIMEOUT negotiation flag.  Skipping the former matters on its
> own: without it the fs/fuse/default_request_timeout sysctl would arm the
> timer even though FUSE_REQUEST_TIMEOUT was never offered to the server.
> 
> Note that this is not a security issue.  virtiofs inverts the usual fuse
> trust relationship - the server is the privileged, trusted side and the
> guest kernel is the untrusted one - so a server intent on corrupting guest
> memory has far more direct means at its disposal.
> 
> Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-8171ebf0-ef01-4ccd-943e-8633a8d54239
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/fuse_i.h    | 10 ++++++++++
>  fs/fuse/inode.c     |  9 ++++++---
>  fs/fuse/virtio_fs.c |  7 +++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ec5ccdf18a25..a033b0bc4576 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -418,6 +418,7 @@ struct fuse_fs_context {
>  	bool destroy:1;
>  	bool no_control:1;
>  	bool no_force_umount:1;
> +	bool no_req_timeout:1;
>  	bool legacy_opts_show:1;
>  	bool syncfs_capable:1;
>  	enum fuse_vdax_mode vdax_mode;
> @@ -698,6 +699,15 @@ struct fuse_conn {
>  	/** @no_force_umount: Do not allow MNT_FORCE umount */
>  	unsigned int no_force_umount:1;
>  
> +	/**
> +	 * @no_req_timeout: Do not enforce a request timeout
> +	 *
> +	 * Set by transports that cannot revoke a request once it has been
> +	 * handed to the server, since the timeout is implemented by aborting
> +	 * the connection.
> +	 */
> +	unsigned int no_req_timeout:1;
> +

First, I'm wondering if we should also update the description of the FUSE timeout 
files in Documentation/admin-guide/sysctl/fs.rst.

Additionally, I have a further thought regarding the current virtiofs implementation: 
if the vhost-user backend (such as virtiofsd) hangs or exits unexpectedly, guest 
applications accessing virtiofs will hang indefinitely in the guest kernel. The dirty 
pages currently under writeback continue to hold the writeback state, preventing the 
filesystem from being unmounted. Furthermore, when writeback or page reclaim subsequently 
encounters these pages, the hang can propagate to other processes in the guest. Even restarting 
virtiofsd on the host does not resolve this, which can be quite unfriendly to users. Given this, 
I'm wondering if we should consider introducing a fallback or recovery mechanism for 
virtiofs—perhaps allowing a manual write to a file under /sys/fs/virtiofs/<device_id> or permitting 
a forced unmount to invoke virtio_reset_device() for cleanup. What are your thoughts on this?

Thanks,
Li Wang
