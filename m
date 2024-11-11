Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505714B962
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327517; cv=pass; b=gFpGUMcT7jCfjsqcW6204bRkN6a8e1Uk/qFRdw6REbBIye4BDoZQoxGVqA3bqHXHBjYNp0crzQGcEHl83sVtvGdHErCktqH+I6TWeJogL8/583IQE2G5FPg5E3zd9/Q6Cdj0+Lx1r2GHsvlQrqUlZc4/yvw2V6P+U6EUb3W9BXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327517; c=relaxed/simple;
	bh=4rzGbqBNpaeP73Dj14iZHeWJ0X5KI/kVdKi6xAoRiWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbXKNmKKG75JzmeRWIyT3l7VJDNz/yeZhlBeX6kb9UbG7rYjPvwauhbpyhpUL8L3+PfyBx/WjCDtSUgdrHLbqFi05AynR2L2P2xvK0iGtJLzkfdfGzqgX6EHR152713vU9Q6lzWavAuLxxcOfucuayRb2KFee5H4nUb5w+hd1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Tdk0hYFk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Tdk0hYFk"
ARC-Seal: i=1; a=rsa-sha256; t=1731327508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GtBLxRb0/a/pGnZBdkapmI8yoYQ6aIy0iSqSGE+OJbDvYmqNFq4BJV6uhJmF8O9Mwu9YeB0Itf7wfxpYzxjbW3GpHnuoU5BQXlGlb14STfS1QesEcGFTRU1NQJxgyJlSK32SFo0In10l9Vnmfcm5o0sGsyIBsYjJvFCgYUbKLN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731327508; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WmK2xlQ+zyobePquUkVhqfJy16+HvtgT370hP1XsPfo=; 
	b=fIVsWDdJsO7HkZtBDDPaD1ml90vOxjbbqwmc2fIEAFvcGijjN5ZOJhy/wkDCtKascZtTsLsNom9QxisZmW4x4z3lb7XTa2iVAMPXqOR/+C6qgIuHPgjfhyB01HHGV5EktDGel4hiXj5Q2Ma921NNeNIKnUH8NUBZHygG8Yy4Vs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731327508;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WmK2xlQ+zyobePquUkVhqfJy16+HvtgT370hP1XsPfo=;
	b=Tdk0hYFkM+heWlAhdQat/RUTeeOnYjfXp+GxYl0UBJFOcLFS9Ta8uvs50MjSWhRe
	EJxLrNFpfOKUyVEudlqbjPPVxaAkfePbGRFnjheySt9F1gjUA9BlTEG009FmWmHCdKd
	rXnmRUkNZ/fR7Z4jreUNEdVsRS0I0TVp48LOD3dE=
Received: by mx.zohomail.com with SMTPS id 1731327496153595.5978690443898;
	Mon, 11 Nov 2024 04:18:16 -0800 (PST)
Message-ID: <09d9815c-9d5b-464b-9362-5b8232d36de1@collabora.com>
Date: Mon, 11 Nov 2024 15:18:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/virtio: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241108032603.3164570-1-ryasuoka@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241108032603.3164570-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/8/24 06:26, Ryosuke Yasuoka wrote:
> +struct virtio_gpu_panic_object_array {
> +	struct ww_acquire_ctx ticket;
> +	struct list_head next;
> +	u32 nents, total;
> +	struct drm_gem_object *objs;
> +};
> +
> +static void *virtio_panic_buffer;

This won't work well if there is more than one virtio-gpu device in the
system. Please make it private to the virtio-gpu dev.

Otherwise looks okay. I've tested v3 on QEMU, panic screen works.
Looking forward to v4, thanks.

-- 
Best regards,
Dmitry

