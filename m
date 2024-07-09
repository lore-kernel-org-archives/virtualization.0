Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBF1494C9
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510558; cv=none; b=Uje9XC2Vib7W0fqj4WifSqvE4oDUGCJNvbHXaJQdRMO9QbS12r6+cEQNw4EHR0Zeszn8W3nvQNPSXny1QaFAaESLA7qaY+jUIz3Y1bWAFKY56kdkdH7/yPCIB02x9WYL3Sy6/ERRgAiPDzijAYjCcOzziPQq96i708uZ8ILBAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510558; c=relaxed/simple;
	bh=bk6TipIY+YZoexVbFgevxA604DBUzZ7+Qxg6gsX5klE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNcbsx/QEQ/QceKEsxK2uaDPJ5hZ5WSv6yVJYJqat27fB2ku9pnC/bQh0dm/IoMCPTquLMcRBsp1V2+WJjuUBR0OyBYoLEATj45ETWTZaPx/nR6CPrSjknC4i3YoWU105vF+jLxyeF4nQAlxublbAeMV6wa29+e0uhUkDgxcpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6FVDQG4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6FVDQG4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7828160A8A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJT1KyNZaKWk for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 07:35:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AA86E607CE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA86E607CE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6FVDQG4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA86E607CE
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
	b=f6FVDQG4Tdmw3yxc3qENg+kLWXw5VkHRBO9O1prYG6NPOBB+q23N2AjUhV8fJtLDUAwD0h
	6RiRXU2RrdvnJMsWIuG+KzIj5ZG/9NFfGzEac/jN8P/EanI7hTM9Dmk3vLoGJQNuE0YVmW
	j/kbdaWC3wYb5L4R5tDPFlgfTlYW7jk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-iiezWBMXMQuUGIltbCcvZw-1; Tue, 09 Jul 2024 03:35:52 -0400
X-MC-Unique: iiezWBMXMQuUGIltbCcvZw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58b3fcf235dso3797834a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 00:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510551; x=1721115351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
        b=xShEDbw8Vl+dPKYUJqKsh51Rd9n246YBrIwjwJyuSI8R6rKkxKm/7BWgYkNW3p+5vO
         v+EsHLY6AktOi/T8KUwTGF4Yd05UgVOyuGemMCe3FrNyrXkP9LF8wiwZ8GFYEPBbUxZX
         GL0Ph+XEl7tNX+A3DH1bsMjDFvFQk3e8k6shP8Ihf4YYcJb75eXek7bPQcJqs71JPUbk
         tqAtJPAxovfqGtmBVlLuqhD7QaklOODwb6Ns0lgmK75LEy87P3hhX5he4JPuK3iHFRkv
         +1ChS7NApp+Zxja4R9LkZPWyD5BQjTDtAOz36Ps1ATKp+FVdn4fBQATigBaYiEeOqGjx
         cSYA==
X-Forwarded-Encrypted: i=1; AJvYcCXWz00e7cvpCuySHbbMRkP78exh+/HTOBSiCXFAGqi7Y3v79SeLJ4/hLycxKZwPLU718wsUtv9gZOA01/0ukx1mHNY+FJGi6B2mHFYPeUjPnBVFRwoq4y8ZxA==
X-Gm-Message-State: AOJu0YxstK6F11oJf1AgSFOZu+FC7tzriOYOHbuXx8+OIAYkKDpLoDu/
	UxOKsfnIsLs3dIPqtHTHJ3a3tJRchhJ+62s62ygVQAe0Gj34ACdNDDqJiC9KVOIvsFjhJD9KEJl
	YVofxVIQeVpNgP7A13MmWeoOzc/H+8GEtkIT5qT9deGSUFtQYk9XZfeDm4xAQN+A+WOLBBD3w3y
	NIoOgG/bvwnRHT+T8deMAPP9Y1DbZAgm64ChHUslxWfysPkmlwr6NM+g==
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id 4fb4d7f45d1cf-594bb67e9e9mr997094a12.24.1720510551377;
        Tue, 09 Jul 2024 00:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiWni+LJU+6yVhYpIE9XYIpyjrSEJCag4tVtoxMKRcXeymx8yfK8l7rFpFU9jUUkq9Rln8XyB6tiM44nsNR3c=
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-594bb67e9e9mr997083a12.24.1720510551112; Tue, 09 Jul 2024
 00:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709045609.GA3082655@maili.marvell.com>
In-Reply-To: <20240709045609.GA3082655@maili.marvell.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:35:13 +0800
Message-ID: <CACLfguUYny6-1cYABsGS+qtdzO+MKp3O09t_gt-bMM4JgdpZqA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 12:56, Ratheesh Kannoth <rkannoth@marvell.com> wrote:
>
> On 2024-07-08 at 12:25:49, Cindy Lu (lulu@redhat.com) wrote:
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> nit: reverse xmas tree; may be, split assigment and definition.
>
Thanks, Will change this
Thanks
cindy
> >
>

