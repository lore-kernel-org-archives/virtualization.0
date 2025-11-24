Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B72F617F;
	Mon, 24 Nov 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977391; cv=none; b=lhLEUNfHdf4ieTa7kD5fWLq/Xsw8qGwR0yATDi1KwrOdo4MPbW8yZBF2zL4uktlTT7F8v4w+vNwdXzVA8cmfEK+mvRQRSXU+SLccwRyEzrUbXdK7iJpIWr6H5HiNDX0h8MZc4XZYwirkAJRU1uPmnVks6EIIRrcmN0oThydXDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977391; c=relaxed/simple;
	bh=Jv1u0M1raS3QCnkleXbV9tzc9ruYUZwF2dknc/HRKRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNGLCqaZtndVljbYyQw269QgLCbcQafIsWlhjbC7cb+QRCxoHaSKq6IpsjkuYKuurnNvHtIrLlkMGExz+In5H7bi/Ae57mhcGZR63wHD5YKhskPy2B81MUmKxGYGagrYTgZGqQ4PdHREFt6UtillvvDXJiCrYAlwMdQNsi8IPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHG152uD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHG152uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A68FC4CEF1;
	Mon, 24 Nov 2025 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977391;
	bh=Jv1u0M1raS3QCnkleXbV9tzc9ruYUZwF2dknc/HRKRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OHG152uD9sdFVV1w5NgzBUAiAOWQQWxK51QXk+OBDxg5BWw0vISk/N8QRN7IHyzJ1
	 b7QI/5DGZ9l7nymS6pDGY4QKeotzNKKZE7WFUPWPOjWplfmLvW9IBBzTdNTuDRiIQF
	 sNczm1dASXuObAKsEV8+s2IZ6YzGW84UqgB/XI6zg4kYgP1Q5PCvpFF1uxrhXyVkib
	 YU4z3fwWgPp57jxbZlEArzF7hT6kRYtYBLJB4rhEHjtXN+xRkBGrVIUBWDfrEtL49Q
	 YS9vjA/YbIyUMTIpR9bCvciz0zdNkZDZimL18gVGaaCuOdcYfVch1L292Y6j0B2AAe
	 /du0r/5GB8Y1A==
Message-ID: <d33dca15-5e0d-4fd9-8378-dedd617a38e2@kernel.org>
Date: Mon, 24 Nov 2025 10:43:06 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-balloon: Destroy mutex before freeing
 virtio_balloon
To: Maurice Hieronymus <mhi@mailbox.org>, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251123175750.445461-1-mhi@mailbox.org>
 <20251123175750.445461-2-mhi@mailbox.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123175750.445461-2-mhi@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 18:57, Maurice Hieronymus wrote:
> Add a call to mutex_destroy in the error code path as well as in the
> virtballoon_remove code path.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
