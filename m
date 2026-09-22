Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1B35DA40
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054235; cv=none; b=XqoLU/+v8oCXLGJsobrYvbFICTbu+mCO0MxBIncu51u2W4ffaalTjQvJnUDZBScun8VTW1TtfmpMA8HO0YaAYqVdncsV95XS8amkyy/t5fh32i/1VUGwq8gjdoMYoK6FmF+wmmgcO9IYVn7+u11hHhnl769sx/UHWvhZWijmC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054235; c=relaxed/simple;
	bh=cJ8LYFjzTM0muHUyVe+/MCjNYgwZO4f/9W0uzAKmrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Mhj04lTwzHk/XupyS95i2/u52cYeq1XkJuvTKrSR62E58GWzUw5WoNV13XiOoYMPGOCkrE6LpnUlu69+knDWkP7L/45ZCDSEcqKve5kK7Fw+ZonxhP6fQd1BRmKkjkKnY3ETmeXPU1kDeHlLrxxG9SyWpRifvjaDx2FyeSOPZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoNLgpnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoNLgpnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790054232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
	b=VoNLgpnW0iP+P6i+oUby4bEh7uDA0nzjUFsPeVMuA3JBw8KBCv0sBJCxXnV8YMKx5q1bne
	dzTrfVbTZrvKAmz4u8pqtPmW+91zMNblpiQq8WKdcnEleN0BjAnwGb2u86+1GZXVfngDMr
	hTd6kaE4sLtsHrEVwR+pXNf/+cq73s4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-nlNDjvtpPJWG_2jMlfwoLw-1; Tue, 22 Sep 2026 01:17:11 -0400
X-MC-Unique: nlNDjvtpPJWG_2jMlfwoLw-1
X-Mimecast-MFC-AGG-ID: nlNDjvtpPJWG_2jMlfwoLw_1790054230
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49953abe51fso22231585e9.1
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 22:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790054230; x=1790659030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
        b=DHbqBnb8AJvo3zHtrn7KXsNtogWIPXn9tf4eJX8hzgN3/DWJ0KBaAJQVClU4UNnj8B
         PWf62xNlh2QQItC3hAOodG9psuoRxqB7+LdgVYJibQiymGfg22QsdomiGfHNTKnvvK5C
         jgLfwyocUdb6Sq/v9EuLmC7RQjaJXuw3rJEGW6c4xE2E9omwtEttgYAoz1JnSVgpgPy0
         P3sl93bBWEDvGjBFBBDlmZE0GYemHKwdHbuxhYS0d9FwGbws9S2AX3z1s/xf1Oi/RTQc
         2E64kdUlARTqqXqTQB7N5CooLtcGAFNdgdenFX53GZ61YYE+KlVUAmRUuVlFQPhWSsnY
         To9A==
X-Forwarded-Encrypted: i=1; AKwUvByVIkzALKKjtQxKhY+MPIH4YUa7mD56maQwwjClrxy+1XUHYJpAv39dPbN1svTMysYU6VAL64AJnIj9jdmVFA==@lists.linux.dev
X-Gm-Message-State: AFuF++mF8j36ptoq0kDBOJhM8xfETScouRCAW3B5VPUWFuuy59eLGWpS
	alqqmF5BrLVIAjjnq/1SHt4LQKwWZYmjEBLE6an9bo5s0ZjGbqObsHqCP/BzY+FF6d7xH3BtW5r
	5OuCCxu+9Hp/A3ykdU/LSoLEypjxvBIY164Jvkzlj0r6tIOcC86E3+1EeoOCvVcpuUYIJ
X-Gm-Gg: AYBFou1/dj4t6m4SA+c7VIHvWbKgMifvryoSSWsp8GfEirSDabTdN50MNoPE7LGEr5Y
	K8udXxl5RWOTXimBjLyHAmbYEH3zKApEtIun20ZphyxjJmVgA/JL9utPZE5q0/b5ZwITTx8ZnUE
	2OCgdU9sZvnaIchyCNkYtnvJsSxCoolzepgPVod32gHXKAoLf3JtH3u+iSxZpuNXe30bQWGJ8Ua
	+0V0obBgKgIEi/N3aQn9nz7trnMyUQDAR98/ojMA9Ogdc4ImHqkp5p2YFfdpzfaq6LmmpllpHjX
	EBRV8AGYsbsCF0gjxBU91cIHSDCaNJPsnQ44A2A8HR2fV5zobjTn8jLaKdKhe6r7T6jlUcqz24L
	3Y24673QG6h7chJESb+4/fdY=
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430345e9.5.1790054230059;
        Mon, 21 Sep 2026 22:17:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430075e9.5.1790054229668;
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc05f9sm44650175e9.3.2026.09.21.22.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <20260922011619-mutt-send-email-mst@kernel.org>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260922050251.403857-1-oss.patchbox@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZ_FFnVTsYsjZ_IPET64MO9XoHIjY-uoEYOViMy5wW4_1790054230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 01:02:51AM -0400, Yuho Choi wrote:
> This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.
> 
> When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
> stops waiting for the remaining requests and virtio_i2c_xfer() frees the
> reqs array while the virtqueue descriptors are still in flight on the
> device.  The backend can then write into freed memory, and
> virtio_i2c_msg_done() calls complete() on already-freed requests.
> 
> Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
> exact same failure mode caused by timeouts, concluding there was no simple
> fix because the buffers must be held until the device returns them.  A hang
> due to an unresponsive backend is preferable to guest memory corruption.
> Restore the unconditional wait until request lifetime can be decoupled
> safely.
> 
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> A proper interruptible wait requires refcounting requests and bounce
> buffering to hold memory until the backend returns descriptors (similar
> to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
> stable, revert to uninterruptible wait first.

another way is ring or device reset, if that is acceptable.

>  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..581e55b5c65ba 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  	for (i = 0; i < num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
>  
> -		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> -		}
> +		wait_for_completion(&req->completion);
> +
> +		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> +			failed = true;
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +
> +		if (!failed)
> +			j++;
>  	}
>  
>  	return j;
> 
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> -- 
> 2.43.0

