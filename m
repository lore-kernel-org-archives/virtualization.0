Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9D19E965;
	Thu,  9 Jan 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416837; cv=none; b=TbyPO6Q8UYvXLvr3negMrzzAz6Q3169bepecIWeb5H/+Xi041C94MnQZQWzMWZfykRTk2T4iVzJ+PDLBrsXUoDsvgcSYpUh7uZi9N5BrG1TROA+u1e+ZmBVz1sSG9zTbGCTZcgWObwNQ/+o2v4INFKuOfcZSCrmL2HIgZ6/nMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416837; c=relaxed/simple;
	bh=b/rYt0Z0ihUMkSLw4TZszASAPcnL7yCL+ei7qA8R0Pg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eatpeVnwqyB/JP4XYdsX3bob5cNJgKkdQz07tp4zccvnLjSdJZet2MDzdOMhR9lZNrFmk7ByLFHcTw3u3i5bCgBboNM5p2qnJud0tex/Drb0kLCMQBtfZ+EJpHAX/1B+Z5x9K8in2IfJ4P3h0nYJ9wt5+nTlbTWpVjZA0dnQxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usUzqOhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usUzqOhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AECEC4CED2;
	Thu,  9 Jan 2025 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736416837;
	bh=b/rYt0Z0ihUMkSLw4TZszASAPcnL7yCL+ei7qA8R0Pg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=usUzqOhsKz+DWvJrW5ueKeSsHHE2sqGgKn5zH7oKNLtHSBey7ORgohZu2kRDq8jL7
	 pBFsxDtAdfQa3ajmBfEvdBSHtNU1mOQ1Oe2dZoO5m65q058JQJDKhe0CiWrYGw480t
	 E0hJ2SPl/loDd5dTFCs1XBIex7U/36ySByzBILoEWpr0YmCwcBAYM1Cw0/YXIQ1WHE
	 yzrZk1aq6SWrV95/tM6VHy2hkJuwz5hHlRS/elUV8KC0bJB7/P/wKPWwbsZ0uU9yT5
	 cdPrZhzq9PgzWEM7kr3AOIWm/5lmEZIwhE5kk1YwqHl1YdwBE6Chs0v+J7/rrAvn33
	 WEdNPGBV7fcNg==
Message-ID: <71ebf77ed3f006e950a692368c87726c74e9063d.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Replace deprecated kmap_atomic with
 kmap_local_page
From: Amit Shah <amit@kernel.org>
To: David Reaver <me@davidreaver.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Ira Weiny
	 <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 09 Jan 2025 11:00:33 +0100
In-Reply-To: <20250109035904.168345-1-me@davidreaver.com>
References: <20250109035904.168345-1-me@davidreaver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2025-01-08 at 19:59 -0800, David Reaver wrote:
> kmap_atomic() is deprecated and should be replaced with
> kmap_local_page()
> [1][2]. kmap_local_page() is faster in kernels with HIGHMEM enabled,
> can
> take page faults, and allows preemption.
>=20
> According to [2], this replacement is safe as long as the code
> between
> kmap_atomic() and kunmap_atomic() does not implicitly depend on
> disabling
> page faults or preemption. In this patch, the only thing happening
> between
> mapping and unmapping the page is a memcpy, and I don't suspect it
> depends
> on disabling page faults or preemption.
>=20
> [1] https://lwn.net/Articles/836144/
> [2]
> https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings
>=20
> Signed-off-by: David Reaver <me@davidreaver.com>

Reviewed-by: Amit Shah <amit@kernel.org>

