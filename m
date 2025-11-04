Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BB18FDDE
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230912; cv=none; b=Yk/MxJewaCyJlVrBUTJ4XbjHo1dqEGCXcDT01zw4+tiAoJCC7VVCZ1p0k3nrqxy8VZQKkVloT0f7lGUVLOBirXPp/7z7rYfN73Txv7dCUtJmsLoLzuqa/qpckfZ8qd/zpNn8weL5e60EhtvTckLzo82jYl3Cj5gaVtuiBLN8sGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230912; c=relaxed/simple;
	bh=pZ91m8+a/VCgZ6qu8Bmh/r7IDOJwtRB6INYfrPNEiRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHrfYyFuwXSmDC/9V4TOd7HsrxGa4tWtguG44lKh/FW7AQjn/DbCPfZEzStJbRqdbJo4JidQV+t7vJ+lzG7QKff/O2RgHeQ63HQJO4fXi7WEOc0pNmV3GBDWutWadJNAFwNHg1iQ7C+Qk2ee9eHVhsjF9cZLpU4InxQgJ7J2ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elpvN5aJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elpvN5aJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZmhQ+nL2DY+AZpXAeBqjbcazVO2nfP8+I3WpEAuJO0=;
	b=elpvN5aJi4Vkk4XT0K+OC0dYWSG5RrsCVz9gQ1xy8xcqOJcWxwyJoGSvbGcVBPDuBhR38m
	u0X6N2rrmD+KIki7VXRQUdci7Cd5PMBboo4jrYlEcv5GZabrJz0mT95Oj4G6ZLuUVhBGkf
	7QovPU2ogXDz1Nvi0iV5lwea151T7Uc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ZJ9sJUvEMmqC9CbSox7_SA-1; Mon, 03 Nov 2025 23:35:07 -0500
X-MC-Unique: ZJ9sJUvEMmqC9CbSox7_SA-1
X-Mimecast-MFC-AGG-ID: ZJ9sJUvEMmqC9CbSox7_SA_1762230906
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dbcb1740ccso1124333137.1
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 20:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230906; x=1762835706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZmhQ+nL2DY+AZpXAeBqjbcazVO2nfP8+I3WpEAuJO0=;
        b=Ex7WGX0h93qUiyknOAa28LL6lpEfutaPcBSEx9DLEg6/JQZLm/2n93AeTtbdj+a8I1
         3e+L4lOJ/9LnbqBKb4hjz1yYGtamWUVolickXBorSN5jDDMOBO5ElkDMBqtjnrgBq+iw
         E6B7jisizzVac/bmzZbwHIk+b4PjhJ5GUqV+nchg3nDT5DvzfOO2z6Y6YYk9Haey9DQL
         k3RNlJbVNaQvsagRCyjUCiW0TwQZJ2DJaGUih/lGPbZTXGvrCPP738giIAeZwOFReRwn
         OYM5dt/9LIU0nV+Wedakgp6wjAMPQ95fOfBpYVT0LIujdE4h+Wqvmd4XwHCdw/5nnw9q
         yEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEEYbgLpbNtld2JTnzMNqR0LIJNbUJCideH1++KKB/r56rjE7tJRbsgJMQaqky/GEofQnfXheSVHGFSFMNuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGXoZOX6MXS3L6aFjZTeguQAOXeEINomWYJwpI3J3ZNgUHDHZV
	gXLzDDrjlB80K0bXsvQcPQT3lnJWYh7i4PEMSL68YqLIO2behSjLQrLITdjC8t+EqUF24n36W50
	7iHtT+waXRgoOQqlH9n4AYgEo1wO2wCeOeYzWixY1uM0KfaQmpPNAQKiznK3qfkM5+HFcn0K1JQ
	kEdGZiNgWF8HiIPnAcs9joaAx+gXEOvSvR/aIpmNXlq1g=
X-Gm-Gg: ASbGnct6HqDmW2lR57MrHhq0eKgtXjAFxL84T/oVGyZ++Eq5/blmwr4RHMFPuCrnGTb
	Ju7UfWoUUxxsD1O1ymAvMGn5NLUbXWNegyucGLg3W9rvKFC/Fw826IHFri+K+PMoptIslRh5Bbk
	NqqyHZeVdPueORs6bHq4PB1+91anjwrYn6nn7XJL3EuBnZSWIPKbtEWgyo
X-Received: by 2002:a05:6102:1622:b0:5db:cc69:73a1 with SMTP id ada2fe7eead31-5dbcc69748cmr2217631137.42.1762230906327;
        Mon, 03 Nov 2025 20:35:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQRGGOR1eTK1zpBsstEHaXBd9jeWCUzZj8w151fHMOwtmeAK1RRNN0i+yG1hERYPNxEGz4nA8xUzhsJdQ1HFc=
X-Received: by 2002:a05:6102:1622:b0:5db:cc69:73a1 with SMTP id
 ada2fe7eead31-5dbcc69748cmr2217612137.42.1762230905823; Mon, 03 Nov 2025
 20:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-8-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-8-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:34:53 +0800
X-Gm-Features: AWmQ_bnmjGn9_5EGzpg2LqGHbd5YLW9AweuWJKWVAd0C5Mfyewv5Qlbi-E9D4lo
Message-ID: <CACGkMEumoo3J1LTKBJqLCWLAZ=DX1NeX8D_87HjJ_9hNkV0bZw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0_lhaYW6HQgpXE6zyAHuA2LZkt4ZgIuPZhU-NPfFOcc_1762230906
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
>
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capability. If partial matching is supported, the classifier mask for a
> particular field can be a subset of the mask for that field in the
> capability.
>
> The rule consists of a priority, an action and a key. The key is a byte
> array containing headers corresponding to the selectors in the
> classifier.
>
> This patch implements ethtool rules for ethernet headers.
>
> Example:
> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
> Added rule with ID 1
>
> The rule in the example directs received packets with the specified
> destination MAC address to rq 30.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed double free bug in error flows
>     - Build bug on for classifier struct ordering.
>     - (u8 *) to (void *) casting.
>     - Documentation in UAPI
>     - Answered questions about overflow with no changes.
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
> v7:
>     - Move for (int i -> for (i hunk from next patch. Paolo Abeni
> ---
>  drivers/net/virtio_net.c           | 462 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h |  50 ++++
>  2 files changed, 512 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 998f2b3080b5..032932e5d616 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -284,6 +284,11 @@ static const struct virtnet_stat_desc virtnet_stats_=
tx_speed_desc_qstat[] =3D {
>         VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_rat=
elimits),
>  };
>
> +struct virtnet_ethtool_ff {
> +       struct xarray rules;
> +       int    num_rules;
> +};
> +
>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>  #define VIRTNET_FF_MAX_GROUPS 1
>
> @@ -293,8 +298,16 @@ struct virtnet_ff {
>         struct virtio_net_ff_cap_data *ff_caps;
>         struct virtio_net_ff_cap_mask_data *ff_mask;
>         struct virtio_net_ff_actions *ff_actions;
> +       struct xarray classifiers;
> +       int num_classifiers;

This is unused.

Thanks

