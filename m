Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4443CE0A1;
	Fri,  5 Jun 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653919; cv=none; b=GDlKCtvBFZmVSdb0OucUdDWQ+1HTaT/TWOUHo1uCGLdzj4muqBio5SvUE8f7Yol7hyPoHQz8TE301utfNd5gH8C5LhiM8NK5zXTlDfvERkj5BzeFs+7h9lyiaXiRukDFdSFaHEN1peFtjPUIm/0gznDDPKuXo+hrBIls5LM1MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653919; c=relaxed/simple;
	bh=ZLyKVyu9Id3qdtZx4GzFgqhpDn+1yFHELWeHzCybey4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSU5fYC0buuLbQgQNoqpbUuGNL50rdjjOBe4cX68qpK04zpIPk0ZJ7bcpPOiFHtpp0sAr3AZRj5oB1SCl7tpGnWDPElFQqXgX6XyJ/mMfEVBap8RAtdsKe3F2xRE6YMLt/qdHx16NDVdiVMqlRg8iJqBiXa9/WC2qL3g2kVIHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nUbb0J/L; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nUbb0J/L"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4EB94ACE;
	Fri,  5 Jun 2026 03:05:11 -0700 (PDT)
Received: from [10.57.36.203] (unknown [10.57.36.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807553F632;
	Fri,  5 Jun 2026 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780653916; bh=ZLyKVyu9Id3qdtZx4GzFgqhpDn+1yFHELWeHzCybey4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nUbb0J/LJUyuOznqwks9Jj4LGzhKc5ydAz6psZwBgwho1urwhuocfZwv1mkBZcwgV
	 s1JoIOZ5YxC/Wnk8NFI07KPngvE6I1Cyzuvzq3F3cXtql+xAlUrMRtyvVLHuu9rWhn
	 8sYvdL7kiKrto7Gjg/0+zGL+7bmQ6VL+rLbgy6JU=
Message-ID: <3852f5fd-3e25-4ea1-b818-80d56a081eba@arm.com>
Date: Fri, 5 Jun 2026 11:05:09 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the
 loop in viommu_add_resv_mem()
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
 <20260604051816.2976221-3-maoyixie.tju@gmail.com>
 <20260604160449.GA1619938@myrica>
 <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-06-05 9:59 am, Maoyi Xie wrote:
> Hi Jean-Philippe,
> 
> On Fri, Jun 5, 2026 at 12:04 AM Jean-Philippe Brucker <jpb@kernel.org> wrote:
>> Thank you for removing this hack, though I don't find a contract in the
>> list_for_each_entry() doc, and the fix still accesses a cursor outside the
>> loop. Since you mentioned C11 UB in another email, do you have more info
>> on the precise operation which is undefined in the kernel (container_of
>> into an invalid object or the &next->list addition)?  Just so I can avoid
>> it in the future.
> 
>> Anyway, thanks for the patch. If this is just general cleanup that's fine
>> too.
> 
> Thanks for the review. You're right.
> 
> There is no such contract in the docs. I overstated it. And no undefined
> pointer arithmetic happens here either.
> 
> iommu_resv_region has list as its first member, so offsetof is 0. That
> makes container_of(&vdev->resv_regions, struct iommu_resv_region, list)
> just (char *)&vdev->resv_regions - 0, i.e. the head with a different
> type. &next->list is the head again. Nothing reads next as an
> iommu_resv_region, so no pointer leaves its object.
> 
> The container_of would be undefined only if list was not the first
> member. Then the subtraction lands before the real object (C11 6.5.6).
> That is not the case here.

If that were a real issue, then I think list_entry_is_head() in the 
list_for_each_entry() iteration itself would suffer from it too. It's 
probably safe to say that while the C language in general leaves this 
open, Linux relies on GCC using pointer representations where the 
arithmetic will always work out, same as we depend on two's complement 
representation of integers all over the place.

I believe the concern is more just that if the pattern of using a 
list_entry iterator variable outside the scope of the loop isn't 
discouraged, then it's all too easy for subsequent code to inadvertently 
dereference fields *other* than the list_head without checking that it 
is a valid entry, which definitely would then be the worst kind of UB.

Thanks,
Robin.

> So this is cleanup, not a UB fix. The typed cursor points at the head but
> reads like an entry. That becomes a real bug the day someone reorders the
> struct or touches another field. The new pos stays a struct list_head *,
> which is just the head, so it avoids all of that. I should have said that
> in the message.
> 
> If you or Joerg prefer, I can resend the series with the wording fixed.
> 
> Thanks,
> Maoyi

