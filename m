Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9E2F60D6;
	Mon, 24 Nov 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977441; cv=none; b=oLS+Zv3mRJrQbqXylKMFG386LiNeAEXBttPzkDCGjhRgKPjJuxWbfZYD9wGb0z1uTTKY9kTcIX7esx+RkaSyr/K1gSu9wYeHcOjz10hs2mIBwKNvi2jx5NkbXqD3lMo+s3Qb6On0EZCGHSDI2JPcxyHWYBiwEFYJYS2pHMHlrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977441; c=relaxed/simple;
	bh=MLCTPEg4vmtGY+Sq4byzvPjPdWyncwQ2nZmydawQjec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDuBA720QgfKrXomrz53R167amHbxsc724WnJZZMQKFRll4E3xDo/TWYEV9NHVQivIqwIR9QKICAZGaKRhomH15VjI/bdOFBwn+MZ5QxS2ULf6jYPkEum6m59PHpvtPSxz9e7IetpOAp+dS3Ym81NHFup6it2Eaj8Ctghf5Zuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6PU3Los; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6PU3Los"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E7CC4CEF1;
	Mon, 24 Nov 2025 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977441;
	bh=MLCTPEg4vmtGY+Sq4byzvPjPdWyncwQ2nZmydawQjec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K6PU3LosJXbYBSrNyMHzKb6nCxEvdimK+ijlIhuZjGfZXD6c7VhghTjT0478K/Hda
	 Q++urkPpQ0KSihmGDqgUkfTfAXzhxmcsKnaoSWS8sU0saxJBeah9T0rXL/TTYKfuOi
	 ndAExUxuidAkEpINYEXjiOQxQHqaSsturiCFuM1O7/fAliu181M/vnZktAhcb1Whh0
	 tz1BN0k60ym9M53LTgFxvvC8BKAOryxEoFcjvPrksvHFyEPD6Dj+3Gt+c6HXAA8skq
	 FACwBN7K/cDzYCtGSa0eYe8abirx5ZjDy93u1ZVWNTPhtsxvFbPunECPMA0ljzBQYC
	 Mh9AgGaLwA1Sw==
Message-ID: <daacc7bd-b477-4437-9035-1ecd41c02be5@kernel.org>
Date: Mon, 24 Nov 2025 10:43:57 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-mem: Destroy mutex before freeing virtio_mem
To: Maurice Hieronymus <mhi@mailbox.org>, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251123175750.445461-1-mhi@mailbox.org>
 <20251123175750.445461-3-mhi@mailbox.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123175750.445461-3-mhi@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 18:57, Maurice Hieronymus wrote:
> Add a call to mutex_destroy in the error code path as well as in the
> virtio_mem_remove code path.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
