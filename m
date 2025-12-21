Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A803225779;
	Sun, 21 Dec 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315989; cv=none; b=tEb5D5kPktJuaBQbmuo2pm/dQTwP5v8VO9h0nFy/mPx/xrnsedLOXkTJa6IKwMVF+dlk9G5ZnqtF0FRkrGakDy4oVOpR+NMmiM6+tGodtsy3jqRbIlBrv6joGbFZ0o7Y2IbZJ5FSU+xQBduzO+Xfu3Du0+WlZsmBeNWXeRPb4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315989; c=relaxed/simple;
	bh=guuRGmw/hlIgWhXV4cHFQUC7aCkBU9AvPUtMQ9NJqc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiWP2Q+B1zFjFeGU3xrIuAeLHb88q5bV7/LYsrANrQx6WGGXHq4JYSQdQfDQDYoT1ThNUPzKlJuxB59vTJXxC4UG7DtNyZ16e4Si57A2DUE/MuB14VbxuGSgq8iesNmKSpmRU/B3QguzizhZJeuyNVQKaDaK1VjmzazI4n71eXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P72aupW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P72aupW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA97FC4CEFB;
	Sun, 21 Dec 2025 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315986;
	bh=guuRGmw/hlIgWhXV4cHFQUC7aCkBU9AvPUtMQ9NJqc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P72aupW4ZnLiVvqqxMX1TLHSk8A7nnL/JUBeB9MGV0zBn6ja163yqe1rBcuYTCgRO
	 kRgDc2Opt0bxd4804Qe3TSj2mb01vNN+njfCQahqbm2070r+Ics6s6enuFhwTzMQnr
	 6/sETcee67GrBMaL2t23G8Y6t+Ntq/48T1jMrF7CXJjlnL/X7zfoIHIRUqS5IO1hcq
	 truhGrlAkISUPGt/F6wrP3tFlbWe2qLNYbg/sJhBCQHT+ODnE0MoOMtUdcAbKSVVDO
	 D/j0gvTohS7bmDtaFVkvF4gHJTneBKGlpzEH2kAaC+5ScnqnLnOqqP3fCcLH+GACPr
	 6bvU81YLoMGKQ==
Message-ID: <9c83c2b2-7176-4a75-8bed-fe82691584a2@kernel.org>
Date: Sun, 21 Dec 2025 12:19:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio_balloon: pr_dev_info.report initialization
 cleanup
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux.dev
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 mhklinux@outlook.com, linux-kernel@vger.kernel.org
References: <20251220003012.78394-1-dongli.zhang@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251220003012.78394-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/25 01:30, Dongli Zhang wrote:
> The virtio_balloon vb->pr_dev_info is used as argument for
> page_reporting_register() only when the VIRTIO_BALLOON_F_REPORTING feature
> is available. There is no need to initialize vb->pr_dev_info.report if this
> feature is unavailable.
> 
> Similarly, the Hyper-V balloon driver sets dm_device.pr_dev_info.report
> only when the corresponding feature is present. If
> page_reporting_register() fails, it even resets pr_dev_info.report back to
> NULL.
> 
> No functional change. Only for cleanup.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>    - Add commit message to explain why we would want to do that.
> 
>   drivers/virtio/virtio_balloon.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 74fe59f5a78c..0c39f2415324 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1034,7 +1034,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   				 poison_val, &poison_val);
>   	}
>   
> -	vb->pr_dev_info.report = virtballoon_free_page_report;
>   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
>   		unsigned int capacity;
>   
> @@ -1044,6 +1043,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   			goto out_unregister_oom;
>   		}
>   
> +		vb->pr_dev_info.report = virtballoon_free_page_report;
> +
>   		/*
>   		 * The default page reporting order is @pageblock_order, which
>   		 * corresponds to 512MB in size on ARM64 when 64KB base page

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
