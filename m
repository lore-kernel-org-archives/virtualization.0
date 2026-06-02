Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951C3D522C;
	Tue,  2 Jun 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397075; cv=none; b=sh0Sltk4ziex2oZ+NyjVPmvNtc1tEAHw9tyPP6RfiFMsRAlHeQIvUmD0C1J3yOE7dUMubh3gh6VKc5pMX0gB0RberT0V0FWX3s+CXUOXz3xfcLT1/808GE6gFB3jL9GXr7pGl1HwfLp80DLu6jJtBNiPMj2/VKriubAbQfd59D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397075; c=relaxed/simple;
	bh=MSt0dFIE3zZ+3m+M6rCatXZghC+L+yZ0BE65LAyDFgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3bHOKgTFEKgD9kI9pn1hnNM1KmtjDzjLa+Qc5rtY9ZfpLLjgNIS8K0eqsDMXiPFJ5Q0YqVCBeLfTcbRm8nwVPDiAqlMB7qyVRAzQEcloykUOzDvXaQqFhJ/v3hpCKaLa4GNEk0MTUS2Xh3ObzyzS9tSSW8d8cmaY4zOUfnyaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PWFVOqmz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PWFVOqmz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0FFD176C;
	Tue,  2 Jun 2026 03:44:28 -0700 (PDT)
Received: from [10.57.36.237] (unknown [10.57.36.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878DA3F632;
	Tue,  2 Jun 2026 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780397073; bh=MSt0dFIE3zZ+3m+M6rCatXZghC+L+yZ0BE65LAyDFgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWFVOqmzpNUzjPHytWy/+8xkfmCjfzHK73knjSv4qsGpRDCiFvUWPEt/JEDBMD2Vx
	 +oOR/xDP0IF8P0wQrY7cXOBNjMlvqWRbdiNJNYcfSQqo+mvb36geqM3+HK0kzY3bDQ
	 /lLrJnWB2D6iYLshuhwaLyjcBQnlaLdxR5FVjA5E=
Message-ID: <c23cc27e-80bc-4295-944b-4cdefd85b544@arm.com>
Date: Tue, 2 Jun 2026 11:44:24 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: iterator used after loop end in resv region insertion?
To: Will Deacon <will@kernel.org>, Maoyi Xie <maoyixie.tju@gmail.com>
Cc: joro@8bytes.org, jpb@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <ah6wYJM4g-GTBTCL@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ah6wYJM4g-GTBTCL@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-06-02 11:28 am, Will Deacon wrote:
> On Tue, May 19, 2026 at 02:49:58AM +0800, Maoyi Xie wrote:
>> Hi all,
>>
>> While reading drivers/iommu/ I noticed two places that look
>> like a past the end iterator pattern. I would appreciate it
>> if you could take a look and let me know whether these are
>> real issues and whether they are worth fixing.
>>
>> The first is iommu_insert_resv_region() in drivers/iommu/iommu.c
>> (linux-7.1-rc1, around line 873):
>>
>>      list_for_each_entry(iter, regions, list) {
>>              if (nr->start < iter->start ||
>>                  (nr->start == iter->start && nr->type <= iter->type))
>>                      break;
>>      }
>>      list_add_tail(&nr->list, &iter->list);
>>
>> The second is viommu_add_resv_mem() in drivers/iommu/virtio-iommu.c
>> (linux-7.1-rc1, around line 523):
>>
>>      list_for_each_entry(next, &vdev->resv_regions, list) {
>>              if (next->start > region->start)
>>                      break;
>>      }
>>      list_add_tail(&region->list, &next->list);
>>
>> In both cases, when the loop walks all entries without break,
>> the iterator has gone one step past the last entry. &iter->list
>> then aliases the list head via container_of offset cancellation,
>> so the insert lands at the list tail. That is the intended
>> behaviour, but the access is undefined per C11.
>>
>> Jakob Koschel cleaned up many such sites in 2022, for example
>> commits 99d8ae4ec8a (tracing: Remove usage of list iterator
>> variable after the loop), 2966a9918df (clockevents: Use dedicated
>> list iterator variable) and dc1acd5c946 (dlm: replace usage of
>> found with dedicated list iterator variable). These two sites
>> in drivers/iommu/ were not covered.
>>
>> A candidate fix would track an explicit insert_before pointer
>> initialised to the list head and overwritten to &iter->list
>> only when the loop breaks early. The observable behaviour is
>> unchanged.
>>
>> If this is intentional or already known, please disregard.
>> Otherwise, I am happy to send a [PATCH] or to leave the fix to
>> you. Thank you for your time, and sorry for the noise if this
>> is not actually worth fixing or has already been spotted.
> 
> Given that there's some precedent for "fixing" these type of things,
> it's probably best if you just send some patches for these new instances
> if you don't mind.

Agreed, given that the intent in both cases is only to find a list_head 
to use as an insertion point, rather than operate on the entries per se, 
for clarity I'd suggest changing the whole iteration to list_for_each(), 
and keeping the list_entry() dereference strictly inside the loop body.

Thanks,
Robin.
