Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D433B8D75
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425130; cv=pass; b=ptDhQ00Di+V2jiX7ch+OPK4FRc4EkCUfyOZCWWUXCxh5llkrLf2lFLsRgduqfJBIkZHgFUqbFX2+9MP8XgcOmsdbzjTVQeQ/qpk6sVU9kJEhvo/4CgfXBpsSnVImZmC1l0MwKpN4TyfP7fSJvXt13sKrMvWAxhtcNq/uZDtsbQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425130; c=relaxed/simple;
	bh=Xv4VU25LdhjDzsAIlBYXJf0xcLBztQHk6wfa2qht3q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UETp2V/+/TcMAf657ayCDhlP8I4REZ8xp0k/sRAc3+epaUbw+if9vhyV+j2ByTrcnJtoAqAEIRN67UTscQbnL+E1kD0M+C01RPg/kBPDqH+QxHYBqFuElN7g27JgKNcSXiJK8UyajLUcWw3q3kPyWJ0QkqIScFUM+0Kj/VAokes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=j5KkXEJC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="j5KkXEJC"
ARC-Seal: i=1; a=rsa-sha256; t=1765425114; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UfXNDRKAolbhh/b/DQwWCj/W3uHl+ZofXxO093hhowcWPNDiAZrvIu7SADOxRELABI15fAa+1FjfqpYg+ITWkUwDNuiD0/581LsMLHV5aqMNg+JJA3gze0szerMzJwzzTLhWctu3EoI0xyuUetAs3YoHxia9RQHt891vA6ulMsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765425114; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bdvg75pe1XqkWjmd/gIJdQ0jjhqK3VCzZaGWpztaYyI=; 
	b=BEhf/9q0qN9YnoK6m9XgEdD8JboqSYD/YDuoSU7TxH7jmI6BlCwIWJjOI8F2UaKxchkt0xNv2WI9VA8XVrIODbrS1D59WymvU882gcmJwFAMchyEIksAtNdxVVA03NRrx5YISBGABuCww5UIDka9L0G/JjW/+QavOjERaJTjgVs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765425114;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bdvg75pe1XqkWjmd/gIJdQ0jjhqK3VCzZaGWpztaYyI=;
	b=j5KkXEJCgNqwK7wOt+FdQn5M62gsSfrmL54oaxm43bPmQmei6r9BhTAGjwdUFIJk
	2ZWwrIn0K+7hCJriOY865k4j0yQmb//PTl+XFxKXs3I11X10RKWabVWRJFL4gl6YU1P
	EOGQh1xm8kTCebFPws+HiTQt8U+KX3y5rLbPTozU=
Received: by mx.zohomail.com with SMTPS id 1765425111840134.7944186922607;
	Wed, 10 Dec 2025 19:51:51 -0800 (PST)
Message-ID: <5b0a15d1-6912-4a0b-acdc-ace4f7aa33e6@collabora.com>
Date: Thu, 11 Dec 2025 06:51:46 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Allow importing prime buffers when 3D is
 enabled
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251210154755.1119861-2-val@invisiblethingslab.com>
 <a8405071-8489-4965-9a59-fc58f78cb250@collabora.com>
 <1005ebfc-6f0e-477f-afae-2d42b44a5fa3@invisiblethingslab.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1005ebfc-6f0e-477f-afae-2d42b44a5fa3@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/11/25 01:11, Val Packett wrote:
> 
> On 12/10/25 1:51 PM, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 12/10/25 18:39, Val Packett wrote:
>>> This functionality was added for using a KMS-only virtgpu with a
>>> physical
>>> (or SR-IOV) headless GPU in passthrough, but it should not be restricted
>>> to KMS-only mode. It can be used with cross-domain to pass guest memfds
>>> to the host compositor with zero copies (using udmabuf on both sides).
>>>
>>> Drop the check for the absence of virgl_3d to allow for more use cases.
>>>
>>> Fixes: ca77f27a2665 ("drm/virtio: Import prime buffers from other
>>> devices as guest blobs")
>>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>>> ---
>>>
>>> Hi. I couldn't find any comments on that line in the reviews (on
>>> patchwork), so I assume
>>> there was never a specific technical reason for that check, just an
>>> abundance of caution?
>>>
>>> BTW, while here.. The drm_gem_prime_import "fallback" seems pretty
>>> much equivalent to
>>> `return (-ENODEV)`, as drm_gem_prime_import(_dev) just translates the
>>> call to
>>> gem_prime_import_sg_table which we don't use. Should it be replaced
>>> with `return (-ENODEV)`?
>> Returning -ENODEV should break dmabuf self-importing where virtio-gpu
>> driver export dmabuf and then imports to itself.
> 
> Hm, I don't think so because the self-import case (for when `buf->ops ==
> &virtgpu_dmabuf_ops`) is handled right here, right above this check.
> 
> drm_gem_prime_import would handle the self-import for `buf->ops ==
> &drm_gem_prime_dmabuf_ops` which shouldn't be the case since we have
> `virtgpu_dmabuf_ops`..

Indeed, then it should be redundant. Practically, there should be no
difference with removal of drm_gem_prime_import() and
virtgpu_gem_prime_import_sg_table() from the code. Not sure if changing
it will be worthwhile.

-- 
Best regards,
Dmitry
