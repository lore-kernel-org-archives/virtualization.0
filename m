Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D84FECF6
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571100; cv=pass; b=P7G6yQVz7LlHjTjy1iudfQP/XbWW4iD0IoekJdxIvvJurFB4mOnIY0G9YCvfL2+tpLqRDABZqkFKRuNEtPJ3b1wmRK8yhPIwplTs/7tyAsUz9h8DnVuepNLUjPs2GHhcjBdRgofo0myE7yRTjFyLJRRTIhqKMS0FyZ/nsqzGHhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571100; c=relaxed/simple;
	bh=CU2QoJyOVBw2JEvh98F1xobFsw7cLUgvG+gOzoVrb0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/wCW1VIkwWUFEYSKnfCPq4jJgUlyuGqOn/R1suY+w79FFlArf3lBu5AoQWSHPAc35GwWHV7tKZjvv7pg99HfeD5BkmanCYyRk5LkAWNqmU+KV4WMV6Sf7hU+5OagqIE8+GoGF7m8m1Z8iLMuXpBnSKTl3BijqyUHFR1yImMRZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZnuaAN0r; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZnuaAN0r"
ARC-Seal: i=1; a=rsa-sha256; t=1791571092; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tr40Pw/N1/p1xdjaB+TrQFX+EkUgx+GJ16h7TdmRNNE8Njkhq9ZeJenec5nbW027f6NxNoUhX75LGM4FVqmVjW+Wnr+O9LeBYnculGRhTF5isE3m6mk5HaiG8v0Oge+CBZMEQEoGaC1tBVuvtJGkU7gBwD7pjPA+79QR0diNLOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791571092; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QuWSPsqQUuQxbHw42K0AOt4zUancOykowkLmXiRZhhY=; 
	b=VvWLyNYQsCC0VzKGn16+h8HnTrTjlVHWcAakb7vf45FFng6SRP4xTUFOKOQwOOok6S8UDd5bmzYohOz6PqBRhOp6wcfgSV7XzFJk+u8aMfXrfOhaQrKPTXHhU4BB9Kf+JDS4makQWzsdf4V8VJGb8LMBCM2j5vhBZOmfGB9PduY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791571092;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QuWSPsqQUuQxbHw42K0AOt4zUancOykowkLmXiRZhhY=;
	b=ZnuaAN0rNkLIPRCr8UKYQYCmsV8oYOzOf0c5beJJadzYmRxt6qXTWc5jURrg+RxN
	Tf+ZzuZZOZcHtpajF52Ehh6KjQJb7u2ftk2uwrefgR9x23MxdYT6SfU9w4hYoU8mfSj
	CQ8UPFlrFESOreca1+z0ZERA9ADYd9nC8HUW1nMA=
Received: by smtp.zohomail.com with SMTPS id 1791571090915569.1520305278708;
	Fri, 9 Oct 2026 11:38:10 -0700 (PDT)
Message-ID: <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
Date: Fri, 9 Oct 2026 21:38:07 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Honglei Huang <honghuan@amd.com>, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

24.09.2026 12:55, Honglei Huang пишет:
> +	mm = current->mm;
> +	mmgrab(mm);
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
> +	if (new_pinned < 0 ||
> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
> +		atomic64_sub(userptr->npages, &mm->pinned_vm)

At a quick glance over other kernel code touching pinned_vm, nobody else
check for new_pinned < 0 and then doing atomic64_sub() for the negative
value will be incorrect.

-- 
Best regards,
Dmitry
