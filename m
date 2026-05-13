Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E813B27CA
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709274; cv=pass; b=Zzl4C04nYie8FVzJxJW0T0XvEFJrM9et2UKh8RulOOZp9JBfyjVKL0CV9YSKAuzS+fWcrqxfc+NE1OPYnEzhKQpZBRpa+33fZyhEPM36yq2rT1FuKZcpic5kt7ZCKX9DZx7lng7iIlLJtwhtf7Xr49nnA4xafbz1P5TJS7cnVdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709274; c=relaxed/simple;
	bh=blRWwGF8HdShsCVV+9t1BLaFe9zKh1o7Gm3ha6WxFS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJVfrsi+IKLqn6OO02tb+4cdM06oppviHUe4eR9Z8aW5kdBeQy+9PNQsm7OWiWSfAtF++TR+FJdjGSlNj6VDsJ8V4Q4anLNZ0+O2b3y/hEClOrdlqH2c9Ste9n2F/+49THtBmiu/M9S6doscUP4JSLYm0e0WIas47+PKRzczJLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NDxen76W; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NDxen76W"
ARC-Seal: i=1; a=rsa-sha256; t=1778709265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aNSnV93oxeSja22MsEvLyWiZoJzMBmEm9eKTfBJB+egi4r7i7NU17+97eYEFpXwpxkmC+bbtDkAtpP06rkmqR4C3cqDB/g7W/BUjJiL+P00jUE53a8JCLrnmGZ4tXs880CDoMPgzL4DUpxz4r1h6cArJQ94Gn2ObhbbpKhoCDyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778709265; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qoFWKqXZsC4n+E9tB5UYBR7txBwkhdlz6HD0mf/7Ujs=; 
	b=TgHafZyLNtW/P0DrFaUXuKy7RifFIeFGtWisvx1CaERD/62Q2btiEByq66Wky+dcv2JEUIWh25octfizO24kg7ayJC98dScilyP8dmLUzN+Mrl+2y2PEWESQrjPrZftpBfZzm2qacUsyiXYkE5iN6Wub+P4BsX4YUziTVwXdTs8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778709264;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qoFWKqXZsC4n+E9tB5UYBR7txBwkhdlz6HD0mf/7Ujs=;
	b=NDxen76WjO/i53fhYdVeHIOY+3XGbaE2bAx8SB4IL/t442UPkwzOsb5ypcBHrr5B
	HICCJJ+bqxKqxmKsCB5cX2wMH6ObFZezA7i9LjSAOGfXL0kg+xH9IdmqhUWhhDVvlez
	vyCj5V0IEgt1QUOE+fUFEcy9RTbuACcQRbzHODZE=
Received: by mx.zohomail.com with SMTPS id 1778709263404877.5235059423231;
	Wed, 13 May 2026 14:54:23 -0700 (PDT)
Message-ID: <8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com>
Date: Thu, 14 May 2026 00:54:19 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
 <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
Content-Language: en-US
In-Reply-To: <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/14/26 00:40, Dmitry Osipenko wrote:
> Hi,
> 
> On 5/12/26 11:59, Ryosuke Yasuoka wrote:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>> wait_event() without timeout when waiting for virtqueue space. If the
>> host device stops processing commands, these waits block indefinitely.
>> Since callers may hold DRM locks, this can make the entire system
>> unresponsive.
>>
>> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
>> consistent with the existing timeout pattern in the driver. On timeout,
>> clean up and return -ENODEV, following the same error path as
>> drm_dev_enter() failure.
>>
>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> If host stops processing commands, this is a problem on host side. Isn't it?

It may be acceptable to have wait_event_timeout() in a loop, printing
warnings about unresponsive host.

Don't think we can assume that 5 seconds is enough to say that host is
busted, unless spec says so.

There could be a driver module parameter, specifying the timeoout. This
will be acceptable as user takes responsibility for the special timeout
behaviour.

-- 
Best regards,
Dmitry
