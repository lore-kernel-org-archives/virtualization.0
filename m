Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E43D16F0;
	Wed,  8 Apr 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656195; cv=none; b=BYmBUWMtp9CYPb5L2adB/X4ca4kfTDxlquR4BmwljIJNIGcxgAlnmO4nHEpRbqCHuYBm0f7pYTzNihPkTDtQwzYshsbayizvIXW1GN2CJgv3S4dysOEY7IMaiF1xOS/PgIgenlpfhUf2IIaxZ09UsHNBJdyDGpCsWO2UQuHRz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656195; c=relaxed/simple;
	bh=AkaqZanasyw6+3Ot9d9earOaZwptTig0HHZPJjjxNz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6vumejOJmAOBD9FJbhaZ9IEF244iau0m2ld5OmA8UwDQiNHUbVg35mI+4PqC7SaXQd9087c31w/P+6+UDiMfl8K8zSbCTpClxERWxvnTXasl2EFD+9F9V45mgyQj5LwMdiizcLtwhANUwjYlQZMae7aJ/VcN2ow+ly16r2cXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8jokZQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8jokZQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05258C19421;
	Wed,  8 Apr 2026 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656194;
	bh=AkaqZanasyw6+3Ot9d9earOaZwptTig0HHZPJjjxNz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f8jokZQdo/YAbj2sX1qFtabEa94PpkJC5kckGukBJZDVJf1GgNmFyRqqLoj/To6z6
	 ilcuxiLLGOGKJvmesWvXIRJgEoO1OPQKdyu9vrZJ0FVj7d0BcvAuKtC+Tj2O8PeniX
	 ae4SeU4eREwt1rOtpzGC02HH+l6bjYC/inYGQZebY8sAfoyTRujjVO/vij++Iim4Hl
	 Bs24OnKkgOAsLapi4NLS6pVK0Zx0FTQM3tNDwdu0ZgPVD8+6WneILIFDJK2/628N5d
	 Ayuk1zjSaUiPObgKBaW4XUo4LR4zQGljJK6G6BOU7dzgOcqJ9P/urBfzE+YyF3+tq1
	 7zQc4uoFLRM6g==
Message-ID: <994cccff-ba44-41e1-b8ae-e2750455dbe0@kernel.org>
Date: Wed, 8 Apr 2026 15:49:51 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_mem: add bitmap_test_range_all_set/zero helpers
To: Luan Haickel Araujo <luanharaujo@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260405213210.108533-1-luanharaujo@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260405213210.108533-1-luanharaujo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/26 23:32, Luan Haickel Araujo wrote:
> Encapsulate find_next_bit and find_next_zero_bit calls into helpers
> to verify if a range of subblocks is entirely plugged or unplugged.
> 
> This improves readability as requested by the TODO comments in the
> source code.
> 
> Validation confirms the change is binary-neutral on ARM64, with the
> generated instructions remaining identical.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> Signed-off-by: Luan Haickel Araujo <luanharaujo@gmail.com>
> ---
> Hi David,
> 

Hi!

> This is my first patch contribution to the Linux kernel, following up on
> your TODO notes in virtio_mem.c.
> 
> As part of my learning process (LFX 103), I verified the change in a
> QEMU (KVM) environment with test_bitmap. I also compared the generated
> assembly on ARM64 and it remains identical, confirming the helpers are
> binary-neutral as expected.
> 
> I noticed these helpers could also be useful in include/linux/bitmap.h in
> the future. If you think it makes sense to move them there, I'd be happy
> to work on that in a next step.

Right, the TODO really indicated that core code should provide such
helpers, not virtio-mem itself. There is no real benefit in having these
local helpers.

> 
> Looking forward to your feedback.
> 
> Luan.
>  drivers/virtio/virtio_mem.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 48051e9e98ab..e94e30af3a5d 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -538,6 +538,22 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
>  	__bitmap_clear(vm->sbm.sb_states, bit, count);
>  }
>  
> +static inline bool bitmap_test_range_all_set(const unsigned long *map,
> +					     unsigned int start, unsigned int nbits)
> +{
> +	unsigned int next_zero_bit = find_next_zero_bit(map, start + nbits, start);
> +
> +	return next_zero_bit >= start + nbits;
> +}
> +
> +static inline bool bitmap_test_range_all_zero(const unsigned long *map,
> +					      unsigned int start, unsigned int nbits)
> +{
> +	unsigned int next_set_bit = find_next_bit(map, start + nbits, start);
> +
> +	return next_set_bit >= start + nbits;
> +}

If you look closely, fs/btrfs/misc.h provides these functions. So they
should probably be factored out into common code.

Then, virtio-mem could just naturally reuse them.

But, I wonder whether we want to call them

	bitmap_test_set()
	bitmap_test_clear()

Given that they have the exact same interface as
bitmap_set/bitmap_clear, consuming a range.

-- 
Cheers,

David
