Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9AC25F99F
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786375; cv=pass; b=LuttZYIfRiMVtOMyhLh0mGgpQfpXyfsLOrwRh6/iJISZzDWCHAT8C7qcSGiTtA0MT/aqRhD9FD5YtG9pXnxa0Zqbh3fenCmwheKTHtHWa+EAX95N/r9Ku8Kr0uYBecaSTeJy5UnMiS3OvD3qGWyUbVBWx9Ee/NozKlZmofX90AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786375; c=relaxed/simple;
	bh=fdZXnV9NA5IuEWqQSP2ZRTElxBLWK/zd9l2+t7svv+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJLfEBnfPthmkHCNAYDhRCVDQafa+NGh+9OXsp8Hx+QsDeTdejAV5FibRfHPfE9ngz1c2oqFtnklgKh9tB1OblcxVNUMUIhxlo42J2SEgNvHNrKJGpzP+UjMpzb+r1QYFqN3UCqGAzOT25OwgGdB0rdKaM8SmMNxXo46pv1ZyoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=L0QgZmHM; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="L0QgZmHM"
ARC-Seal: i=1; a=rsa-sha256; t=1788786358; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kMXbtxrRPaJ+E3qhYLoNEm2le+buDeOVUx7X76PuBvAW03+pMY2a66PLSguK7z3W5SXXfK2Xirkv8GAnpZKMcyhBvwD4f+y8Ye67YCEzVVQpgzeTbYPTl+i4HPPsgDswvnOrsnh5CP+ZloejpY+sqzW/4ZCoJZrbkb2jsO85cPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788786358; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=; 
	b=R/FHwu1RHXN279+TiOJtsYuWr36uyF3EOyacGEGIDaX011iSQDCNhZpbhBqG+PyuQ4ae4GTbL9OPEtdhZpfeNuSjnokGtVfESiRiCvwxGZsYRDjA8eyx4zfjSWZyeWYVgWCP1MxIbHiqpQ1QGMSMbMWGEMeqvDo7FrXE7cBayE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788786357;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=;
	b=L0QgZmHM3nOkKdD2ye4+33yWNIVb/yG0ENQNb169/2jnPHALzTEAqkvSNy29UfVh
	/upEar/QwWHOOC8aVuNkCxMGuETikiKJ1KiFcg12CWaCH6vomcrtXFkzQyU2BuPeyc7
	6IkcntT6ZoBDsc+SCRi0O6EOf+iVQduIu4CnG0Ww=
Received: by mx.zohomail.com with SMTPS id 1788786355604643.0054626038584;
	Mon, 7 Sep 2026 06:05:55 -0700 (PDT)
Message-ID: <fc5c5bc5-d3a5-47f4-8a86-bcd531f0803c@collabora.com>
Date: Mon, 7 Sep 2026 16:05:50 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: "Huang, Honglei" <honghuan@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/17/26 06:19, Huang, Honglei wrote:
> Hi Michael, Alex, Dmitry, Akihiko,
> 
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over
> virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm
> side has
> been supportted by ROCm offical.
> 
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.

The headless context type is totally fine with virtio-gpu. For example,
ChoromeOS wirh crosvm disables display entirely even on guest side by
building virtio-gpu kernel driver without KMS support. This is something
to improve in QEMU to make it work without GL context.

-- 
Best regards,
Dmitry
