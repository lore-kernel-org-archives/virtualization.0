Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7B4749E8
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714817; cv=pass; b=V2icQppQurV6eNHthZeuj5Ud5/eX2W8ZnCFIvERbmiFWDy4GqWxAlKFvknRnGm7AVAc2Yl4Mk+2kh+knTcxTJxXObRa5INUMeETyFRiCr4QWjmNOvFNs1itqZvJCvLOicH/J2NrVa8z0UeaOEUC2QQ4wryqrG4KIQPjm7wrI98Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714817; c=relaxed/simple;
	bh=kthfPSltBwNPAHa6jkTpltq6ykPwuUg2l+yag4G1sdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kws7vE1OZFE74EO+lf+NmdUsWPjV/lQo2j0oZwMGlyE7uaRDZaQHDz0UVpy+9UdlOcVsJJlAXvdkEj9XPE86jQxzdtJi2sD2zssMjoYGAfqeZtO9DHY5S5+aRa72qjTX02pzV+PMwWljAROf+raGt6HHT3RJmG23g8KgERGDa0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=PBSnf7Rk; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PBSnf7Rk"
ARC-Seal: i=1; a=rsa-sha256; t=1786714796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NgavXlUADQDvZ2S6KKvBz56SL4m6B8hilrKppHyBmTXQm1dFyPQJOpbRj0TANr+EzXqKrZ3miWgouuW38zfDhERegW0tBT4p9rVrH8TDpUT0vUfT4AZguwZLp7kWxGehqt6iCca9lz7tkSltfvs4JPCNFnG1EP8d7jL6Zc/+lBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786714796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3qMZoNfekvYo/vzKa0VI3liKo/GCccBdJUHPkqufKcE=; 
	b=KbhG8w4XNgPUftNFrcrcDnRXxHrLLfSbDxqcVT13oH3mLJlGfPeXPpeCqi0cQfsDID9/fv+XRkOM18rY3QbnjbDEtzcMGkPhOR3RdoAeDdRgkwDWJdk031BitysfxzVpreArvcXivK8mwGt41gLdzMtZSIaMe2JSLfYK9OkQagw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786714796;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3qMZoNfekvYo/vzKa0VI3liKo/GCccBdJUHPkqufKcE=;
	b=PBSnf7Rk1OI3zqNlW0+W+GXpAhcUN7g92lT8+RQE+S5tgpyAr7gGZ8OkKRNvd6VQ
	Wn4SgdubS6zMNeouTHGoolEj4FjqxXKA5ANh/KLWYsn95/3U19Gd/UAElxNG6CqekyM
	GcNUWVP8k63yNJgtoCiByjCjErTrXKIvB6OliMYg=
Received: by mx.zohomail.com with SMTPS id 178671479401176.9931951513089;
	Fri, 14 Aug 2026 06:39:54 -0700 (PDT)
Message-ID: <17576d4c-32d1-470a-b158-6b98e2c16595@collabora.com>
Date: Fri, 14 Aug 2026 16:39:47 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: reclaim pending vbufs before tearing down
 vqs
To: bolewara@gmail.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com
References: <20260802-virtio-gpu-reclaim-vbufs-v2-1-5767fb860691@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260802-virtio-gpu-reclaim-vbufs-v2-1-5767fb860691@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/2/26 19:35, Anuj Bolewar via B4 Relay wrote:
> From: Anuj Bolewar <bolewara@gmail.com>
> 
> virtio_gpu_free_vbufs() destroys the vbufs kmem_cache after the virtqueues
> have already been released. Commands that were queued but never completed
> by the device leave their vbuffers stranded in the virtqueue, so the cache
> still holds live objects when virtio_gpu_deinit() tears everything down.
> This triggers a WARNING in virtio_gpu_free_vbufs:
> 
>     BUG virtio-gpu-vbufs (Not tainted): Objects remaining in cache
>     on __kmem_cache_shutdown()
> 
> Drain any buffers still sitting in the control and cursor virtqueues in
> virtio_gpu_deinit() after the device has been reset and before the
> virtqueues are deleted, following the same pattern used by virtio_console's
> remove_vqs(). Each reclaimed buffer is released with free_vbuf(), dropping
> the reference on any GEM objects it holds. Pending RESOURCE_UNREF
> commands are handled as well: their resp_cb_data still references a GEM
> object, so it is cleaned up with virtio_gpu_cleanup_object() to avoid
> leaking it on teardown.
> 
> Reported-by: syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=06f9b2a53ba4a5a47644
> Signed-off-by: Anuj Bolewar <bolewara@gmail.com>
> ---
> This series fixes a syzbot-triggered WARNING in virtio_gpu_free_vbufs
> (cache object: virtio-gpu-vbufs) seen on device removal. Commands that
> are queued but never complete leave vbuffers stranded in the control and
> cursor virtqueues. virtio_gpu_deinit() reset the device and deleted the
> virtqueues without draining them, so a later kmem_cache_destroy() in
> virtio_gpu_release() ran with live objects still allocated.
> 
> Patch 1 drains the queues in virtio_gpu_deinit(): after the device reset
> and before del_vqs(), virtio_gpu_reclaim_vbufs() detaches every unused
> buffer from both virtqueues, releases their object arrays, and runs the
> pending resource-unref cleanup so the referenced GEM objects are freed
> rather than leaked. This mirrors the drain pattern used by
> virtio_console's remove_vqs().
> 
> Link: https://syzkaller.appspot.com/bug?extid=06f9b2a53ba4a5a47644
> ---
> Changes in v2:
> - Also release the GEM object referenced by vbuf->resp_cb_data when
>   reclaiming stranded buffers, so pending RESOURCE_UNREF commands do not
>   leak their underlying objects on teardown.
> - Link to v1: https://patch.msgid.link/20260802-virtio-gpu-reclaim-vbufs-v1-1-9947f18b20e2@gmail.com
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>  drivers/gpu/drm/virtio/virtgpu_kms.c |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)

Applied to drm-misc-fixes, thanks!

-- 
Best regards,
Dmitry
