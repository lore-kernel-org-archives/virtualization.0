Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C239E9AC;
	Sun,  4 Oct 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118547; cv=none; b=HIjbN7r9g4huOEAo1o68KyNU/n6MlJc1AH91jDotBAY/FRB9rlZPNVKwyUn9F3xqU3BZygQh7LlC5/5Am64haDLRRdF/leW77bbm0nMBEAPoHNylwFlmW+aUXkDxggVvOzhstKa0N1FTPcoIqZDjvUIDo+U9jSk8F9ENsKwf9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118547; c=relaxed/simple;
	bh=xg8YgNjj6PxAPhGgLkCHQIFG8rYJR9Jg/pZU2JYoDQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olbTfv/smZW5cYhE4NyHxZgo8bpzE0xi7u2Hz80Ggp0fY7/5iDnUQsmY9kDRRciysXjPkvJ+P0b4saepLADIWlHue6+ID9FxXjBmw8JPWn//HU7IT2jv1j5f3vNOg4WKDMWRY22+krA7mb9EjMm1nvKA7+Bh1eW6ziQ19FKaTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aERLBpOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aERLBpOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E461F000FF;
	Sun,  4 Oct 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791118545;
	bh=BFEKnbTLXmgagiAI1vAISoB39XR9rpuzExoAMyIR4EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aERLBpOKo546ecrYvslGXt2+L64I7saKpBBZo/78jcG9QBQQ56Y85Sl/RGtpV7seP
	 XOBJbNaaDi8fZzUeCfHesJynxW8KJT45Mg+nMIvhiAG4rA5aiyIPuGz41JibXOrGET
	 bxcZ96Asogt7es0SDzqcmigchDq4SxqO/9PWlntM=
Date: Sun, 4 Oct 2026 14:55:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: validate fixed-output response length
Message-ID: <2026100406-refocus-false-c5e8@gregkh>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004123405.586168-1-tjdqudcks0424@naver.com>

On Sun, Oct 04, 2026 at 09:34:05PM +0900, sungbyeongchan wrote:
> A short successful virtiofs response can leave the fixed-output
> portion of the request argument buffer unwritten. The completion path
> nevertheless copies the full declared output to the request destination,
> allowing stale allocator contents to reach callers such as
> fuse_statfs().
> 
> Require successful fixed-output responses to contain their complete
> declared output. Continue to permit a shorter final argument only for
> out_argvar requests, and do not copy output arguments from error
> replies.
> 
> A header-only FUSE_STATFS success returned stale fields in nine of
> nine calls across three boots. The patched kernel rejected the short
> response in three boots and preserved complete replies and existing
> error controls.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> ---
>  fs/fuse/virtio_fs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index f15e516ebcb5c..288848f23e7ec 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -730,6 +730,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
>  	unsigned int num_out;
>  	unsigned int i;
>  
> +	/* Error replies contain only the output header. */
> +	if (req->out.h.error)
> +		goto out;
> +
>  	remaining = req->out.h.len - sizeof(req->out.h);
>  	num_in = args->in_numargs - args->in_pages;
>  	num_out = args->out_numargs - args->out_pages;
> @@ -755,6 +759,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
>  	if (args->out_argvar)
>  		args->out_args[args->out_numargs - 1].size = remaining;
>  
> +out:
>  	kfree(req->argbuf);
>  	req->argbuf = NULL;
>  }
> @@ -762,7 +767,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
>  /* Verify that the server properly follows the FUSE protocol */
>  static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
>  {
> +	struct fuse_args *args = req->args;
>  	struct fuse_out_header *oh = &req->out.h;
> +	unsigned int expected;
>  
>  	if (len < sizeof(*oh)) {
>  		pr_warn("virtio-fs: response too short (%u)\n", len);
> @@ -777,6 +784,25 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
>  			oh->unique, req->in.h.unique);
>  		return false;
>  	}
> +
> +	if (oh->error) {
> +		if (len != sizeof(*oh)) {
> +			pr_warn("virtio-fs: error response too long (%u)\n", len);
> +			return false;
> +		}
> +		return true;
> +	}
> +
> +	expected = sizeof(*oh) +
> +		   fuse_len_args(args->out_numargs, args->out_args);
> +	if (len > expected ||
> +	    (len < expected &&
> +	     (!args->out_argvar ||
> +	      expected - len > args->out_args[args->out_numargs - 1].size))) {
> +		pr_warn("virtio-fs: invalid response length (%u, expected %u)\n",
> +			len, expected);

why let remote connections spam the kernel log?  And you don't need the
"prefix" of virtio-fs for pr_*() calls if it is working properly.

thanks,

greg k-h
