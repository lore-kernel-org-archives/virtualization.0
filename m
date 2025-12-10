Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1253288D2;
	Wed, 10 Dec 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354161; cv=none; b=ZQ61B1IT78BGqCrdhk7c/EIWk21CI8Kj/w1Jb01YIxd7TmcKd7w15uLWTkZDlZwSyoRGXIl8CXbw0r1hzYWggAKPz1ZdKhzjLqNqiBPZ7NKO1Joh8Hpfu8wAC8X6ARdizj//eooK0QjOWDk91v4PrmA4RII6Hzxi8eCvPbFwoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354161; c=relaxed/simple;
	bh=s8i6k/xrroKTTtWenfPpc2Fw+Z0jAYf9FzpixDvQZP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPKMAoSJT6m0WZlB82U46T8AQwnkseORUsXfOnz2IVfw6qP2fgme0AbxtMJGUzzFF8zaZh/G6LWoXt5tsqNNNMZYyAq34+uyKgD00CMMjaWzSK+5Hw9KyjQrol9rKzDSZ6pLPC2vfAVaoPVxWrS3yNDYQMjquwe5vUbLvaQAHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siPU6i+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siPU6i+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18078C4CEF1;
	Wed, 10 Dec 2025 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354161;
	bh=s8i6k/xrroKTTtWenfPpc2Fw+Z0jAYf9FzpixDvQZP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=siPU6i+88zh3eC0NXdDb47zfRQoMPBNnzhYa/vCq+0aKc3JI5NA1a1Z3f3r639d58
	 Bbm3c8VSgyUtWNMQ7AwtQlo6aMQjD/YryLD6DhLu/Vb9VoOnF4lvL27UG4itgIjD0w
	 7c5pzfJ2m+xlMnJW6t1DPdTVFZC7wFKCAWILbJrYQYbbFy46YhldYg69bcRbl6mcsR
	 nP+msDFULxfHtqJbNtwCCDeZ9gH0jkW8orDNvVVUXx3ZFK8sqvaNC1xPL54dDNMMIr
	 O0Sfd8oH97EFpbP71H+Xc6zkXccQYPrg55splWt5Qr1jYfG8xFe1iA9U+RGZ+gCup3
	 xo/W83+GyiAOw==
Message-ID: <0d9f302a-301c-4335-9c78-bcccab824a9f@kernel.org>
Date: Wed, 10 Dec 2025 09:09:18 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report
 unconditionally
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux.dev
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 linux-kernel@vger.kernel.org
References: <20251209212311.64885-1-dongli.zhang@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251209212311.64885-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/25 22:23, Dongli Zhang wrote:
> Do not set vb->pr_dev_info.report unconditionally if
> VIRTIO_BALLOON_F_REPORTING is not available.

Can you share with us why you think that should be done? Please document 
the "why" and not only the "what".

Without VIRTIO_BALLOON_F_REPORTING, we'll never call 
page_reporting_register(), so it will never be used.

But the compiler cannot optimize it out. It only happens during driver 
loading, so I am not sure it is worth the churn?

> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
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


-- 
Cheers

David
