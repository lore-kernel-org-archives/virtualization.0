Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701442F2F
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362513; cv=none; b=n78DKVd/LtmJcjJshAsq0zI6J0tTI6u9NI8dHV/CnflCiO+Vje1MC6OaZOEarpdt3+RdbUf3SIKYHEemHhYqT+LU+aj2aKySYCGUgpn6PgOU74fy+Du/i7vEUXEox5pHqPcB+YHhjz+IreipCpYkxmjw9AJV0yJAJ98HbZSPaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362513; c=relaxed/simple;
	bh=9KMHWPkt/mzP2FxeLtx7HSsZuineo0SUwsWbbSwMoJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmOxPqaOIXHgHIGB6wy1oza29qab3TxtFoA2xoEDn/GlEPaInv7vFiv8FXWYcF7DxPTYTPdcNhNEy9tS0/tJEeubrCIuaOlOIN/pIRvfJ0wghTwXYfujoiFFtIiq9NfK2NyeVSZGWqcXZWwj9lqRjZDueLz2vtW4lUqIQ4COvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVwFPVFR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVwFPVFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JSF4EW8sAz0SacUsjOJsB92EZAvekc+D7nVVJHuZQ=;
	b=KVwFPVFRC+Ay7ZEGF5KKz8v6kNk/SHcpwmh4A3bnATDs+vAzdqeteaZl88MhUT1bAMj4wo
	dMMh8O5se386vNxaQBRLXAkwHrCJHG7rKP7XrWfph6Bn0TJRKDt6CO1oVDo5RPhsH3bB7M
	jpiahMKO/bwwijdgmdspn/M6YcVxiwQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-l-Y7hJSkMvmnNde-FqK7wA-1; Sun, 23 Feb 2025 21:01:49 -0500
X-MC-Unique: l-Y7hJSkMvmnNde-FqK7wA-1
X-Mimecast-MFC-AGG-ID: l-Y7hJSkMvmnNde-FqK7wA_1740362508
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so8324758a91.2
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 18:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362508; x=1740967308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/JSF4EW8sAz0SacUsjOJsB92EZAvekc+D7nVVJHuZQ=;
        b=hx8VdPQGaR5Pn97U030jVEDAnbP9+sfhfajh/QITaY9pj3ofLjegM8AEhk8/1ZfOn5
         7lD6J/ZoHKUkYI/aC27bi7OWKIp3Se8T2EtuWnLx1iD16g68ilVqkElMNgszSQpURw3B
         kBhJCZBqo2avY6H+ioiZEdyNpcCtJEYUAGyH46CRmCs4KpoQLJN5bA6Oah10KJ55VlmH
         ca+7g6y/OkTFTQt23e7OD6xIdctpYhBGuzlWYEewv1xYlt8SZcb0s3Wh88k+wrGOenQd
         eM8eZd+6ckQ5lkRX7FXe2lU3PPXAPUsxzFZtbELscwTu3llcrQF0tuSGZRpf7KYxL4ii
         bGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWFGIadGdcNHpSUB6W3pq14rprO8oJcdkBovbMAonWpSHMRT705jQB4gAUtrITUQ0kbsSbzews4AkCIg6Dh0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvObsYXCqEYVk4Xml8bDW8hfcioEEcf4D0CvCLqeedNfAWP2IF
	VX6JakqXZaHqemZXjVtHe8siXmQimN9w7LwLakhnMteZfbtmOOsqBRVRNi+gSg6uRR7VyfK0EUO
	JC1DJJ2BoKIQYyj1N5KlhK90/fg/mXJ3QeDwulH2p+O8UuGNkRiXJj4iGswKvAZhV45ULbx4OB6
	SPUZ4RsFlJNcgSoDMV3nUXCcDdQy4dmyMkiXYbvP4=
X-Gm-Gg: ASbGnctW7uZtErNnSCEVLh+u4QzS4QGzlDlO+4ndQlez1AyfkPgRquyxgC98Jk7qj6Z
	tyE1SKgxXrR1CE18l4fCyrEm+McjCqiTt5U7YsRE+FwVa7gKhPndfQZJFjZhh0J6nJz+ZFJ63QA
	==
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fce789e6acmr18362351a91.5.1740362507937;
        Sun, 23 Feb 2025 18:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3byH8eo8Yb3n98mptZs0KnZVtNYk3QfL7gWdOG/0QZCy+k/iRcwVcIGwP8Q5J+01dl8JyIjK7VJiXYwtLwks=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fce789e6acmr18362322a91.5.1740362507538; Sun, 23 Feb 2025
 18:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:01:36 +0800
X-Gm-Features: AWEUYZnr6SSmyz0c1upMGLe9FqKMYegAAGYeATevh8dBr6bWe1ZabFTLnQtaRl8
Message-ID: <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fXqO5VD1K8cjyoEc35z220QczcWZ9CBp8QM-DY5jvn0_1740362508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Disable notifications right before scheduling, instead of waiting until
> the work is running.
>
> After applying this patch, fio read test goes from 1191MiB/s to
> 1263.14Mib/s

Let's describe more about the testing. E.g FIO parameters, test setups.

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index e19c78f2480e..3d6981c0f3c3 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
>
>         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
>
> +       /* Shceduled, don't send more notifications */

Typo, and I think we can just drop this commnet.

> +       virtqueue_disable_cb(vq);

Do we need to tweak the virtio_fs_requests_done_work() as well?

>         schedule_work(&fsvq->done_work);
>  }

Thanks

>
> --
> 2.48.1
>

