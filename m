Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD61EB33
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM9kpBK+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D7F381220
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D7F381220
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MM9kpBK+
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iU3LJxEFqTy
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:36:31 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6607480E84
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:36:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6607480E84
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 42E20B83008;
	Fri, 24 Nov 2023 10:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4786EC433C7;
	Fri, 24 Nov 2023 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822187;
	bh=dwvET0tU2J4anZFCWNw+ZZdWZ1IJPa1GnEWhl08aDOY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=MM9kpBK+yisLDCYJftMOvpfpu6pOA725LB5EXxmwkvXFqByoAqaB5X89kowP4w0yj
	 zb681yXDg8hPDrvyYZXlz+nWipEQ6BGPdt591lhsL/JTR6pU7IR/QBTw4RlUo3UEPm
	 vC/kRYKYyX83Sxk689k6xefJdd68JBlWNtrjZSm0ry5RNYhbAkWK9NQxctEyrvjMr4
	 xbnGOxoOeDpcJBhVIHprlpn+i0ZjjweSibtSihYi81RQOfNUP9N4xSSsnH+q/ioJtn
	 8T5MLJWcclvP5CfJY/zAbPj04zqAUA2KCtIClU2XCyjdsjl0WzOhFsK6Bs5ZQJXnsu
	 xRJE8DkkXQncQ==
Message-ID: <f27d3ba73b506111583b2a4f2471dfc9.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:36:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 03/26] drm/shmem-helper: Make all exported symbols
 GPL
In-Reply-To: <20231029230205.93277-4-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-4-dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Chia-I Wu" <olvaffe@gmail.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Emma Anholt" <emma@anholt.net>, "Gerd
 Hoffmann" <kraxel@redhat.com>, "Gurchetan Singh" <gurchetansingh@chromium.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Melissa
 Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>, "Steven Price" <steven.price@arm.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 30 Oct 2023 02:01:42 +0300, Dmitry Osipenko wrote:
> Make all drm-shmem exported symbols GPL to make them consistent with
> the rest of drm-shmem symbols.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
