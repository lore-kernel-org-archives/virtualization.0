Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C2470E96
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571622; cv=pass; b=nxvoHFKc+AugWrRxCZ+/hbw98nn/x2lWZoCc1oAyDdT6xrriYAZH1n26A4EHG/7L72EysXj6KLfYS5CM5j0SvKFDUkNbySx6B+jtJkW6VhCVezS4eBB2GbMXKQ2ztPi/mNHKGm5z7ARc460pkA5ClD03J+m6nArQ8bwU2ws2z7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571622; c=relaxed/simple;
	bh=+OhdLoeV7VemjSuPnl9qnv3JFlY77j8/3hG/kgAPlgI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sEs0lB5JvViJdomWJa0C7UZRynUBp/ZdNfX4nckYWipHtKgd2p3Esy02VaBWPywM1bX08VZIUbtm3Ux29y/Y2w9refq+1D+aRfckM3jKbn1rxZJFJ1++DoPGQy64jRxSixCZbyRFnu4zsa09/NbnIeiJxxt0LnGoisbNm+eTPYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=KOt+7J33; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="KOt+7J33"
ARC-Seal: i=1; a=rsa-sha256; t=1791571616; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bgSl2cLdivPj0FGLrRjRXccvLNkUXeT8tdAb122PXeae/keTuv4+QZSIIPKfHD1GvjehpWdNOI7G9QGhXDigTq6z4Bmp9dZsmgDgG5LGOQ/PyKjJzf3ngXFn5rVMMbTjevMjL2dyKBpoRHkYzDxvXtJetJuL5/NluyJIQHHNb2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791571616; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sNaQMcbvojwqaa6CpBCGayYt2Qv26FQpb2UDUBNOFG8=; 
	b=BfZyZ2/bM2OAAcoVcnOZ01Xq2K5WG7KIYNZ2ufp6e1A7/PbafYKNnDHCC05InIKai7f2WAaa6OsWH8zUqP7uYpqwasP1PEKlnVxuXLdK8ivxdZcKvK2+NyExpTukh0n+iNTfRBK1xEcdxYL2Elr2493sSsKhC8r0CDEP6NsNWGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791571616;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sNaQMcbvojwqaa6CpBCGayYt2Qv26FQpb2UDUBNOFG8=;
	b=KOt+7J3380H/WWmsyxhoxHbmGrc1pwnr9bBQgY9PXU4jnGjfRXCF+P1/eFRl1u3q
	Yey7EY0mfrjpjQbtBOYFKbCb43xufiJ18ZSu2sbUfynrVyPVHnuYzh77Orc+Z48dcja
	zUNaIOdIpl3PtfFtb6MePPhaKtWoguZm6nUBEJmw=
Received: by smtp.zohomail.com with SMTPS id 1791571615413714.4154527093252;
	Fri, 9 Oct 2026 11:46:55 -0700 (PDT)
Message-ID: <f0c5d61a-d4bd-4f92-aba9-50c67cef74c6@collabora.com>
Date: Fri, 9 Oct 2026 21:46:51 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Honglei Huang <honghuan@amd.com>, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
Content-Language: en-US
In-Reply-To: <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

09.10.2026 21:38, Dmitry Osipenko пишет:
> 24.09.2026 12:55, Honglei Huang пишет:
>> +	mm = current->mm;
>> +	mmgrab(mm);
>> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
>> +	if (new_pinned < 0 ||
>> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
>> +		atomic64_sub(userptr->npages, &mm->pinned_vm)
> 
> At a quick glance over other kernel code touching pinned_vm, nobody else
> check for new_pinned < 0 and then doing atomic64_sub() for the negative
> value will be incorrect.
Though no, negative will restore pinned_vm. Still neg looks confusing
and shouldn't be needed as such overflow shouldn't be possible.

-- 
Best regards,
Dmitry
