Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D66126BE1
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Nov 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838375; cv=pass; b=mYsV8f+RYaDbyY4y/uhJ/focWv+AobQN8uN11JPvzvvMgKtzkUovtLF5lmRs59PDRo6o46RMmhyJ9vN3OUhjV9uPGWmUxUdjPk7bfb2FpHrS/AFLCWpsA/F6z6LAkFZm3/ZEMOzdrrrRxCl7LIxHumlq/AIj+3P9ZQJh1pl93k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838375; c=relaxed/simple;
	bh=8rzFto3M+CsMfTL5bkLU52j5jCaXTYsiWHoZHEJIQTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XGLs+LYjWOqmWdOXym/oZ/ArbxFu1Jy2N0myD5PUA8KQPdEMF7SutqKsWJbH1JjRJ39tsGx+yMJuQZuIOK8z3cIW6kavvZPBLwCbm3YBzuCKM5z8QipB3mpuURRqd0osSXT3H8r2dDb7Ytpo8DJEZj8Hw/tGLSXebJ3DW6JyOEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=g+oUauBf; arc=pass smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="g+oUauBf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 233586069A
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Nov 2024 10:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tf25hvlH091Q for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Nov 2024 10:12:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.112; helo=sender4-pp-f112.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6074B6068B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6074B6068B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g+oUauBf
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6074B6068B
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Nov 2024 10:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1731838362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZyczvdXt27uh8PUxu6O8q1jXGx4ZLmNBfCAnmwpv4WUs5QX3I5CL4pkvnXM92pGZUWl7jyhaNMCvp7kHrxMgSyLbFYrUZp9H0uFtklUkiSPOgt6OsoD/Jugdgjsxu/f8UpBUd7eaOWRJHc0iERsbbQA4LHJBr+0PB50I4TsXyj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731838362; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NyxhRCsognRghJgqS/SCBGOjSPC/p2cFFkjhxwiJBwo=; 
	b=dDepkeOcFxx58tpeHhyY8wzyuuGFmWgZP4f40aFcxZSDeGJvSjrO/fPRbnGaLHwAeRDaOqxguXQ0EPXa6+n9q7RqUw+D/2CM+UXw+mYbYzWTJ6DGNLq6AWUuB6wKuhmd/7zMN8bu0i5u+ywzXKv8DZ327mcjCptPOt67lsEjUsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731838362;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NyxhRCsognRghJgqS/SCBGOjSPC/p2cFFkjhxwiJBwo=;
	b=g+oUauBfMxozbA15jbrurUOtFlfc9Q/FkLvfb2Nj8apqpjRnJz93RcKqzabAmZM6
	+hU31mb8FH1DTOgk6rkdmffbBm+ZPgflRUlRaDyRfkUK74UYhD2HAsmYGrK1DxHX9cX
	gQVM/ZoWcMqyPBqBh2yxiHecIOmiDqqfN/aXz/sA=
Received: by mx.zohomail.com with SMTPS id 173183836006315.941452786053674;
	Sun, 17 Nov 2024 02:12:40 -0800 (PST)
Message-ID: <f8f28746-bc6e-4c0f-a130-271e8535ae8f@collabora.com>
Date: Sun, 17 Nov 2024 13:12:35 +0300
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
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)

I'll apply this patchset tomorrow if nobody has more comments to add.

-- 
Best regards,
Dmitry
