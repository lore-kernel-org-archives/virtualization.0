Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CB385510
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519955; cv=none; b=RmIIBqEs6nS4OzCrG+8h7BoZv2ncG+q0aVFN5WbLzY+crSvzWZxfHMGBxcKxMXv13OUxqXoFVdEY5r+Pzxb7AipJ2FXunSYY12rEhNLmqbupq64fEASRShsh/zSFWLaIvDKEKfKm6Qq/j1lAfq/UbNQomsSqj7X8BPDud9J2TOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519955; c=relaxed/simple;
	bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C438wRw0qbeuHBY8Ku8eWDdmj5n4EGNU/Fh6P+btIGvLq+lcc/cZYhmXDsiRIF3wbwCy1ZvsRyhoma7n+kGwPIa3mD4m4pw/2G8EhqukSn4ois1S7SPQjrw2FUCgQPd29Xn2sGH4cSpaMB4mty6jJi9RgJFabg/LHEiEL7Jcc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL+FSrUO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL+FSrUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772519952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
	b=NL+FSrUOAUs/ci/w68RmIwM3mMHIWKFLOOQ7F03yloahhgiXCGaxTFHJI/0pEVSpbFy2Aq
	dixZfxyzW5Al+QZ+yYvVozEQqkUsfzjTeLwsz4/nIr4a33PZbux+dk/K90xqu35X1qO8hT
	lhl9lrBzJqvFmKAmtKn/lQHEiS4mnsI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-YOqWjx3DOTOSs3HgxKoBrA-1; Tue, 03 Mar 2026 01:39:09 -0500
X-MC-Unique: YOqWjx3DOTOSs3HgxKoBrA-1
X-Mimecast-MFC-AGG-ID: YOqWjx3DOTOSs3HgxKoBrA_1772519948
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35842aa350fso25747372a91.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 22:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772519948; x=1773124748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
        b=I66oFeYw5/BVNWRBpEXRokCTen45cjk/1/i5qvT8vgzSk5w1oxBJ+9o9pBf6fJC5UX
         qIOXq+N/wsQ4gnJql20UiNxmLZxcAD6beHh97ly8vA3V+eXlSkGsxAfnQifLeEhem9tk
         QosJSDrAhrQA7vCbkJahe65geDVR+zUCJP6Upb9eM32T8UfKkBMhHuXpwMpgRdk6zogg
         05sq5xJFKD5X30/arDs+4nN7QMboJCJefz67b1flKefmwaIkTEBTvpIlVqA62LJWtnbj
         TGpH8/DsIPMWuz959VcHJybzcXTU50TJ2Mlsi+IdzQM/fKqQL6O0MInb29CNGhbrjAh/
         fnSA==
X-Forwarded-Encrypted: i=1; AJvYcCV1L7dcWK7x5ZlkFiaErcedRVg7lNmRsbWCtwHigZvYVZeTnMAU/UiGX9h08t4U/T4YGUbWi8YJwjaVRfItew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznffxo8fZ76wRafOQhVdUZMLozud1uwWfqpH/WOYvbNm0vSiQa
	Z2N9yefz7mA+D+wuHD+OX4+YH1v8YhC/qNjOz2O/Gwak38umjLjVpYUTGxwt/QeoAmboWVQla3U
	bna4gqCrTzH/0oKakKUBDYXXHUNmYyXw5wk4nK82RfO7LCpbspKL8hzuIgmQn6aaNmV/dnOYThI
	s+uQcxedtNf9+/NqyziGfE9nx3nryWWCl3iUCOwQAHOzE=
X-Gm-Gg: ATEYQzx31z+SqlaDSq1FyI70X68F56KG0SgJ3AZeHk8nHYAuowmkH+gfg2Pe9tUnpiO
	1BHcer/d8IXJ6imoi+0Nz8CNS07eQXdhZI0/XugVxUqmo+VBcniJNRXa35s6lP+uT15vUQt6aFT
	y14yhWiKMLlxDGrwaBBSC9dFUoicdhf8fp9HNfDj5Bp7fCyI/pO0XKlEmIDD9sgJbyf7bUPi4oS
	1lxEKUK
X-Received: by 2002:a17:90b:57cc:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-35965cc5651mr14849375a91.24.1772519948003;
        Mon, 02 Mar 2026 22:39:08 -0800 (PST)
X-Received: by 2002:a17:90b:57cc:b0:356:2872:9c5d with SMTP id
 98e67ed59e1d1-35965cc5651mr14849355a91.24.1772519947540; Mon, 02 Mar 2026
 22:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 14:38:56 +0800
X-Gm-Features: AaiRm53r9FNVJrff6gYF6SVhADQXXQkuO9R5pefHXa-qJopdw_5-5yvB1l-6tnI
Message-ID: <CACGkMEtWvsB0CcZCC9iB9GePROH37CuLFZMcdNs1DjXSx6uQiw@mail.gmail.com>
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>, 
	Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjgiBrRmXjmBYJRUHhaWl0wIhBxdOUrJc5SgvS-Lz9U_1772519948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> vhost_get_avail_idx is supposed to report whether it has updated
> vq->avail_idx. Instead, it returns whether all entries have been
> consumed, which is usually the same. But not always - in
> drivers/vhost/net.c and when mergeable buffers have been enabled, the
> driver checks whether the combined entries are big enough to store an
> incoming packet. If not, the driver re-enables notifications with
> available entries still in the ring. The incorrect return value from
> vhost_get_avail_idx propagates through vhost_enable_notify and causes
> the host to livelock if the guest is not making progress, as vhost will
> immediately disable notifications and retry using the available entries.
>
> The obvious fix is to make vhost_get_avail_idx do what the comment
> says it does and report whether new entries have been added.
>
> Reported-by: ShuangYu <shuangyu@yunyoo.cc>
> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

