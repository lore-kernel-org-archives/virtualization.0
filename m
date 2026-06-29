Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB13382E1;
	Mon, 29 Jun 2026 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713904; cv=none; b=cecrf/zWFM3EGNJTChLUJ25seH6z7OGdmnfN0nXL+sYx0tAqDKvxD5FsKQ8QQq+0QI4Yp3547DNtmIElvC5QYfdM4VW+KUJ68CvOq3Z89HEotZkVofR+ogZd3x249DcG2R2F0qy2Rd2XZ+/JMZBIpFaO4mRkYut3U2Krnk12mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713904; c=relaxed/simple;
	bh=vApNqwkvQQpL4XpH6DZ3LaYV4Wz9r2wVqhLbY5fY9p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NVBTS6HpGFl/v/YKn9YRC1lyzA95gWvyc4me4MeZP9Psf6YZLVyzo+vIN6/eBvuhpklQfki2IEmOedYxe4hNp4IIVTC7RJCFjImE5ztrV8bqhv7k4akU7SA3Q+hx9s/USz33Rdv/WVsa9EXYPuECt8Gjf1r61wQvoymY+MUwrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFtSviu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFtSviu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402781F000E9;
	Mon, 29 Jun 2026 06:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782713903;
	bh=w0ovM7v4M4lPB1O8CvYfSspaqGe7fUKJGGFa//9xLpk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=fFtSviu6LRpTEy9B6NfICV5rQK12iBkG58BAGj5JfaKltTH0Hn1LF7FYzlThzEh7Q
	 b/zetp3T1W8RwED0JnEQCaCjRo1diBYDaCK/qQCyXFBU2PPkm9MoILmUa/mv8+utOO
	 yQtoKJJwd3w5DsTes7Gutl34DQvmONdZ5mvjXF437Qf7qEdRJUCemsrJxl2rhu0XVz
	 ZSYNN1kwPiIwytMtijgZAK8nCIGDAH5xpoDx+q2uPBO/f2kJBk34jSL0q5XU89nodl
	 d72AM3kK3IQLUJr/WKcDQ/xoo3FOmIkwytlyMYDVC3jBeXt8enNeSDjSacaXqRoCIm
	 44fynz2a2wDnQ==
Message-ID: <944c64d6-d6d2-4e63-907c-64ea115a3888@kernel.org>
Date: Mon, 29 Jun 2026 08:18:19 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_mem: fix hardcoded 'vm' variable in bbm iteration
 macros
To: lirongqing <lirongqing@baidu.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260629033738.2617-1-lirongqing@baidu.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260629033738.2617-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 05:37, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> virtio_mem_bbm_for_each_bb() and virtio_mem_bbm_for_each_bb_rev()
> accept a '_vm' parameter to allow callers to pass any variable name
> referring to the virtio_mem instance. However, the 'for' loop
> initializer and part of the loop condition use the bare name 'vm'
> instead of the macro parameter '_vm':

Right.

> 
> All current call sites happen to pass a variable named 'vm', so the
> bug is latent and does not cause a regression today.

Unlikely to happen, because no code that iterates memory blocks deals with two
virtio-mem devices at the same time.

> Nevertheless,
> the macros are formally broken: any future caller using a different
> variable name would silently capture the outer 'vm' from the
> enclosing scope, leading to incorrect iteration bounds.

Again, unlikely, but we should clean this up.

> 
> Fix by replacing all bare 'vm->' references inside the macros with
> the '_vm' parameter, and wrap in parentheses following kernel macro
> hygiene conventions.
> 
> Fixes: 4ba50cd3355d ("virtio-mem: Big Block Mode (BBM) memory hotplug")

There is no user-visible bug, so drop the Fixes: tag.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/virtio/virtio_mem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 11c4415..82a285c 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -423,14 +423,14 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
>  }
>  
>  #define virtio_mem_bbm_for_each_bb(_vm, _bb_id, _state) \
> -	for (_bb_id = vm->bbm.first_bb_id; \
> -	     _bb_id < vm->bbm.next_bb_id && _vm->bbm.bb_count[_state]; \
> +	for (_bb_id = (_vm)->bbm.first_bb_id; \
> +	     _bb_id < (_vm)->bbm.next_bb_id && (_vm)->bbm.bb_count[_state]; \
>  	     _bb_id++) \
>  		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
>  
>  #define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
> -	for (_bb_id = vm->bbm.next_bb_id - 1; \
> -	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
> +	for (_bb_id = (_vm)->bbm.next_bb_id - 1; \
> +	     _bb_id >= (_vm)->bbm.first_bb_id && (_vm)->bbm.bb_count[_state]; \
>  	     _bb_id--) \
>  		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
>  

Without the Fixes: tag

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!


-- 
Cheers,

David
