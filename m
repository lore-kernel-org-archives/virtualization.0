Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E91BD9FE
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011035; cv=pass; b=eBEjAYQM7cZFkYR2xen8gWwJCIShHoC+w7mbvTb7BHOFXhvkkNT9sOsiZxq59p5QbHo/mTdYc4vGR+C4khnq2PJ3peMfIe2ggw0FBXmQNrivzdmM0exCs0bwLbAz7DB2pdARWIZvHj9UPHbpSFZ+EhXrDhGBnsfo8lVMska/zMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011035; c=relaxed/simple;
	bh=i0HOapN3rTcgw4EcFbcQRZrtw0MRyS0bQk/ols/mr7Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AjyYqrBYJ0FmbLelarmM7l+Q6yBNEsjUKyfbe+S6HVIZZ2lv50xZjYYvwhgq29UmUeYpPlNlvxfOgqRSQu7BS9r8Qb3hr876v6FC6dsQ3IN813dSe1FBRp64Rofk+97N8bwC1reArCHdXrCWCLzeUDk0JN5LyqGLw1+ELrktLSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NB5vTJCj; arc=pass smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NB5vTJCj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45B156F5EE
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.789
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHn9jt-C26i4 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Nov 2024 10:10:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.112; helo=sender4-pp-f112.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F6416F5EA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F6416F5EA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NB5vTJCj
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F6416F5EA
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Nov 2024 10:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1732011022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QgPah7K7zl9Ui+n9l4278FXGNH/QF3ZF4pW4d90gxh1p5OsYYTIzM9eCgpdweH70zXRxGIC2lqWObcvkLpAvIsT6MioIY28rWR6p5CxmOzq56ajXlbIA90MLntkUY0T/M9stUHe/wHOk8M/gmopXjznav6U8nG4XBmtrcWy2XIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732011022; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k+g8j3F1tme4NsTxUII9r7aUoMjsICad4Xf/8UTilxg=; 
	b=NaaN0M9K4boonOB0pNZ1nDCIi99WnKkRlxlSwwPaBcTv3xR7Ubw/zdA+nolRspTnFpEt/mIUqAPoIYkx0MxTTMQLZVwVqkK9VCzunGRBU1I716EdCn3e5XatmH8GY5yb+7Msvf1NJJsAAEXbpf5CFszbznsJAtNau/Iw/H7HY5c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732011022;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=k+g8j3F1tme4NsTxUII9r7aUoMjsICad4Xf/8UTilxg=;
	b=NB5vTJCjNICX6Zr6b+KJwtUDlxov3AJDecviu21IuVOGxyf/Sj0CE64/THkPorjW
	IOmN4nUGZuz7m1BIDpgbtbgaeJYhb+2w6ka9sTpS2K+GpaMJE43SGUB5TVOMgLmtcOS
	nDQ14sU4m3PaZMh4NiHp8WaikVJnAbh2pIG9OaD0=
Received: by mx.zohomail.com with SMTPS id 1732011019170470.81764662086744;
	Tue, 19 Nov 2024 02:10:19 -0800 (PST)
Message-ID: <b3ac96de-8782-409b-8652-3415fa4c9f38@collabora.com>
Date: Tue, 19 Nov 2024 13:10:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Don't create a context with default param
 if context_init is supported
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/21/24 01:47, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Xorg context creation fails for native contexts that use
> VIRTGPU_CONTEXT_INIT because context is already initialized implicitly
> when dumb buffer is created. Fix it by not creating default vrend context
> if context_init is supported.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to misc-next

-- 
Best regards,
Dmitry

