Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11B2F6164;
	Mon, 24 Nov 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977328; cv=none; b=byh1Ugpebi4VI+1Xda5QFFIFEbG8h4id9YI5zZ9aaS0N8JfKfEYMPkHWZMBhzE8wx3YA2zKJjyjeNlZS0Sjy3NF8L8dgltF7fT9bDRD40qXqs08ONNvN2FL6h8Ox++tM9bIUCRmC2P3+z3GGBVdf7f6Lweio9KA4iUX88RIdKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977328; c=relaxed/simple;
	bh=YBD+HaeKCRIDVOelsiAOFOTg3fCCrhNd+F1aFDN1TkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR7x9qdAR7ABq3Axpn94bjVVIiBivdMsEjsW+roza6Xkld+PmZppMReEghfAcdeIUngg4x8JwyXMfo4gb+9tn0Y35d+QR6GWy7ztKyjtxuPRnIOO9ZHe6KeehOKRf+LlX4JUdAr9qsPJu0RcNVFIFS9x6t0Yr1enKbxfLp/MneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDqE4qLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDqE4qLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCDFC116D0;
	Mon, 24 Nov 2025 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977328;
	bh=YBD+HaeKCRIDVOelsiAOFOTg3fCCrhNd+F1aFDN1TkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDqE4qLlEEJfwj2eB5xxDoWZNSPxl/UP/kHFdSEJ6c4k0RmZTchPieQtUp+SL15IS
	 eSi4rb1fupB2Tn+AgGiNacSOXvv/t0Komk8PvTEHuJS6pjr7LNvDxP4oBA0EVw88Em
	 eX/MZUu5DFF7xcd8mb1f/mNMt9kXAMLEvNvacbsMG5GXAzytwy2FwHax4jdMltFBE5
	 RrDJ3mBrjQk/1fX4Mt+Q1H6MzGY1FiPCllEZi1MC59r2viwW1xp6SnijTup5/QdOiz
	 ubGuBmUTCzYJ01RwBLT3MK9tBxcgCIKtcwUN48ZBxFJofO9pqpNenIo8R7tuKQIqMR
	 9I4UU97RUdL8Q==
Message-ID: <fed22c6e-13db-4d11-b225-c9b4b91e7ce3@kernel.org>
Date: Mon, 24 Nov 2025 10:42:04 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add calls to mutex_destroy in virtio_balloon and
 virtio_mem
To: Maurice Hieronymus <mhi@mailbox.org>, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251123175750.445461-1-mhi@mailbox.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123175750.445461-1-mhi@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 18:57, Maurice Hieronymus wrote:
> In [1] it is pointed out that each mutex_init call should have a
> corresponding call to mutex_destroy; otherwise, it is considered a bug.

IIUC, mutex_destroy() only ever does something during with 
CONFIG_DEBUG_MUTEXES. And there, it performs mostly sanity checks (so 
it's not some missed memory freeing etc).

I wonder whether we should still ad Fixes tags.

-- 
Cheers

David
