Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7919E83C
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011073; cv=pass; b=RHiMgYYF+ypkfMzwP3zMf4HWi/1wobZNZHq2UkXzyfsy1AqpdstL3pSL4By1DvMvEbIi16gw6/aEWKnYdAq4moQ3jAJrvaYv0yem015Qz0l6xHz+s403fcAQgScG3Zlo6rV/jYO7Jg8Vv9heL7fkO1YApLdtMRmzKaBEZdu25cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011073; c=relaxed/simple;
	bh=iRrHJP1t10pZaXYtY7KirOgTjxwFtjN1FVfxN2uHumI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IFbcOK20b2SjcoUldXT04A1/8nZzKkNvoAgv5vAshSGIe1Ms82UpgpIvOBv8Nsg4XeXHc5QhUHdcKsVqs7csEbzcPrvRoVGC8fQ9iIDE5NfeG7LgHQBv/J1SMn9Oryf1BB3QBKZkhXqJCFpmvwsukxBl3nfmXT54uOA8NHZFb+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Amx68NIj; arc=pass smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Amx68NIj"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D33F4352E
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKekZiYq5Cfd for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Nov 2024 10:11:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.112; helo=sender4-pp-f112.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC7FC43530
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC7FC43530
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Amx68NIj
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC7FC43530
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1732011058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xjs2fNE2nDGWUloIZLZLpeaaIolIQ7blIJqNCpxcZu7Vm3eSxedZ6w3akJaowhJt96S3iRiT/362irc/uFGkBzwNcLapyx/y8EuAnpPl4P2zhY+VfHWLmG98xHzWlK+JuVDS1SI5JKPcbGoTI1a0mSy8MZYzSt3tpnM0TPW+ykI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732011058; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mjTMeSU3sTCJGKoxM7F867Kujv49vH3h9PnodMzQGU8=; 
	b=WV5Mo5Hj/dQQ7Xur3DItHiqOxUklzvgkKabC28YDQh+1+7pyU+E/TEdDcoKDkKnsM4wOD96Z2RdX2LlXtzAbOZ6KEW6mxuNTPxgITpqY8EBULc6WFEMGaYNlYBfZ40ZoDIvf5d4wYUx270JBWKfaAgW5QOHS2inVBHUSXscFRtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732011058;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mjTMeSU3sTCJGKoxM7F867Kujv49vH3h9PnodMzQGU8=;
	b=Amx68NIjFS7NTPccBsrF26kQLrkCHfikwwEm2NWy638tAVu1rOaHVSyCnewcIPZf
	mc32FvJ/m9eVe3KryuT4EGBsWqY1A2WluJVX71vM/OffmC4bkToFA/TtiC7ubnvREsd
	tkNGZW+gFbJh8qr7aLg7b9M5wv6nlY+xpbSG7y/k=
Received: by mx.zohomail.com with SMTPS id 1732011056423310.76166899225984;
	Tue, 19 Nov 2024 02:10:56 -0800 (PST)
Message-ID: <3f8c0fe3-6273-457b-a935-b93a3de5f695@collabora.com>
Date: Tue, 19 Nov 2024 13:10:52 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/virtio: Use drm_gem_plane_helper_prepare_fb()
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Kim Dongwon <dongwon.kim@intel.com>,
 Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/21/24 02:08, Dmitry Osipenko wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> Use drm_gem_plane_helper_prepare_fb() helper for explicit framebuffer
> synchronization. We need to wait for explicit fences in a case of
> Venus and native contexts when guest user space uses explicit fencing.
> 
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> [dmitry.osipenko@collabora.com>: Edit commit message]
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Applied patchset to misc-next

-- 
Best regards,
Dmitry

