Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE130C629
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831323; cv=none; b=iEzpOCRW7vJDA14MDm8NQCQs+eYqSPOAR1v1Rpx1qoFJzaedM2jsVh5LHnCtJ62nbMCo8iZTmz5ZVxfiGS9849IYQ8E30UtHZv9FAsPw2+5c/ggu0r7zdnFa31tTpogWE0OS3Ddf7A5S12GJlShGUea/Z0eOd25ZWgpF0XTde2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831323; c=relaxed/simple;
	bh=Tg2Hz5s/jJowltHvM8wwgjOW8nNKrG1QcZozg60XeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uNilYLj6qtCzCyxf+Kz4DarSO6JxscZW8zWlv2oIZNthEeexckrnwP65jFMrr2vBGb6gTic1uq+lKiaCXDAPxipQxlvmSJNOa7VNA1ean5gkHrMqRJS+QL0kcLA0KYqZeQTRAfUYsIcWYX0XhPP4Ca+b7FJYIirrawTZL319ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPh/oprn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPh/oprn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765831321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
	b=EPh/oprnsVUrz2G+idS1ZC2AM/rwA1+1CYkP4vO+y+Y9/Ks+UhZD8GQD8uiF7UNWRmm+Q8
	lYIJDilFvfrR2WTE+Al8Yo+CZTbbsG+JMUiIqor8rbyfp6JC2rk0SbDtLjgj40Qo1Qhd62
	7HXSH1GHpkG+G8IPBcGjz75EAvWohL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-FI5d4BO4PDygEP-UwgXWFw-1; Mon, 15 Dec 2025 15:41:59 -0500
X-MC-Unique: FI5d4BO4PDygEP-UwgXWFw-1
X-Mimecast-MFC-AGG-ID: FI5d4BO4PDygEP-UwgXWFw_1765831318
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so37539275e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 12:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765831318; x=1766436118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
        b=EBkuYLb33TeTWBAPRDorf8c/tgy2DMEIDr1TUW+jhN7KpEUoOdeCmlv4TBMiQVkzxj
         iar0KeB059Zi+X1raYwtyY0BFXfDAebZ+qwjTGJDNuLPiFzS3A2YJHHg3uJKR+58XUEp
         u74jdI5L0oIaVKYq+qefNq8/NiOFBJ5zSM50Nu2cSfQ/QPg+SnL7+VUdMYkPlohCt/Cl
         h4W3unYGARKGt9jwwHGFf2YSdP0mzLSxJM2CTkuJjsYSdT2cZZKG2uIDh1wMrbejRKKn
         f5POgFsMDHWgxp0i91eKBKF9kZ7/UIFU2/EDfcSyZ1CQx6D9ET/MnRplAuNk7KUWwLRV
         P6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVagYjsWuJZPGZIZwPVx0dAKqTQ3JtCwr4H0VJHiowEzPYjMYVUPKFndNxXf5IcCDozureej2SOvgbmkit6mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9Ctwhfk4ziy++ZEvUk3r8OGEBRuTPWYiZjxzs39imCH3Tk2vx
	d4rRat+hZsjToqk8UXiGtcuaMOOVSM/PVmdst/O039mhSJFyHD0Yk+Wpylkusiy9rtUhdOuy73P
	2DsZ+10HeU8AZeC82DVLOcG5SISkOG4yPD5h4+wAG761aYN0hBidsK8ioZSwi8O5uyKWP
X-Gm-Gg: AY/fxX6NEmeBYKOiWTmIi2U+SP7jt34UWTpYVpcPowoM3IjtTzDMNEM+g8nXKkF7OyC
	jqYh7MZS4TeNQ5P73tic/q+/XYGAKeUMvJasuIZPUjwwv9RvjHAfkMtGevUzYHXiArwqKxCX+mD
	mCC8Cc7E3THRj+B2F492J08s6HEDYMjgQEULSoUWNA3+YDNJOR8UIAyfTs7SPRmlIjEQr2GHHvR
	zyin2tddSNQ0YGlfNh766Q+c2o2SucO0hKyA3WBtd5sNi5qSJTl98gxmLxSxJ2t6gqrycTa8FRo
	bALaj8zAWEyzPs5MoVi3FBYv7I9835o9JJOxgX/7xS/95BgVsG/gI/uW0hsf9FXZzVOOlxSu7RH
	p9CatH3XTEQKRW91Gw2uGA4+VI/2QEZNCPw==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47a8f8cdfd1mr164694705e9.16.1765831318224;
        Mon, 15 Dec 2025 12:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvKxyv9KrTZN+I+gLKkWZxXPblkRG4VaB9KOKEG2SIjVVbTsH1HJ4pcy9Q9bDzIs00zZydQ==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47a8f8cdfd1mr164694005e9.16.1765831317597;
        Mon, 15 Dec 2025 12:41:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f26ebsm211656485e9.14.2025.12.15.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:41:56 -0800 (PST)
Date: Mon, 15 Dec 2025 15:41:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
Message-ID: <20251215154141-mutt-send-email-mst@kernel.org>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-7-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2d8hUhE4VPMv6tuwZDwr0DgW6K0laP5MQZgNSOr2fsc_1765831318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2025 at 06:38:54PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings:
> 
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'
> 
> Describe these members.
> 
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 132a474e59140a..68ead8fda9c921 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -150,11 +150,13 @@ struct virtio_admin_cmd {
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> + * @map: configuration ops for device's mapping buffer
>   * @vqs: the list of virtqueues for this device.
>   * @features: the 64 lower features supported by both driver and device.
>   * @features_array: the full features space supported by both driver and
>   *		    device.
>   * @priv: private pointer for the driver's use.
> + * @vmap: device virtual map
>   * @debugfs_dir: debugfs directory entry.
>   * @debugfs_filter_features: features to be filtered set by debugfs.
>   */
> -- 
> An old man doll... just what I always wanted! - Clara

