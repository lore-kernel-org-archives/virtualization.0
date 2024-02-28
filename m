Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3D22F1E
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142824; cv=none; b=XTEGBvbhEuVBMYPkGjEV+Zjgm+bcfKy8kW5wHJrYBSyfD/z6W/Pqe3xVV22zEGhBTme07988XbFksJ+ww0rj0l/nWwUCtERpX4R+lsY2n6OurtbffYFH2C9i/oCuhBddbArCz6EKl2NKKly5BgEp9uT8i8l2/VvYF0m8rH95SVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142824; c=relaxed/simple;
	bh=LXfHA3dCGDNxmUPr2jMG1cF0psgm9mzwYPfFa63rcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUTYImEO0IxSll7e6m75uTEjMZDa3hhCPAeJpDWESgZWZGmJ4knFCsL7bG/CIPzMwGzlyqYg8HiCMwbNg++7wNY4r/x7T5zHPIAY/mA/bJbfwDfAWVE++a2V7D0nCjaq67NMPB7G5SOpLtyQPvyV5HxeO99CNXqzm1Ol6NciG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JabdvjqY; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JabdvjqY"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0c373ed3bso43eaf.2
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142821; x=1709747621; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTms7y6gBlfM5rqkqnuoQOJmNRtZZ8spMxgJ/p47Svk=;
        b=JabdvjqYxLq8cyTPmHria9AVzGTNkvjwrxWRf/JF1sHrA500e7YUK6NO2/ii5uRB7i
         M3wbUjnKWqjeG7CNeA6oOP4NP5M10pmU5NE+C1WaYgt0EfAdDnwK2quWnAN6s+DreZDq
         MB6zNd6gU9CLFNuasTPCYoKwyHSgRt0wVSxJrvFSI/fc5vcl3QdGldQz6UQORDxKTep3
         98VUKZZJDgM4F5XCTosHF3FOdjGm4WNRUlhAvXsiGRTvLFlC60ol14qhlBbvzfCEmodM
         iycjzTVRej4WYGrTRD4/r/jznL94am1tipJW2/eYMG1i6wHCCsfdUXvBvA82UqjGEtTP
         ECkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142821; x=1709747621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTms7y6gBlfM5rqkqnuoQOJmNRtZZ8spMxgJ/p47Svk=;
        b=eLlkjsxgMODIuCivAV7tkNeXKLPdLkCvGd2DMm8VjPqyhLuJutwgXjgbFTeFCBl9di
         CYbMeua4PMmAUQPGUwGjV6kNeTL/qaEVy4l2AnzuFRKI8dab33IWhNTsAMOndjyYXqda
         1SLVLHPEw2gKY8o7rPLn9jiwmV6wIvpfgEweDuIZmE4JfCNVYmvGxNSSOfXQgYrSPVko
         p6d0PRLbQ3qMDV/0yNtlxqTtVh7WRXqMFz32AzEbPrQpoN23cTfNYvmY7TA4w40tYYSm
         1l3jt7/Dwz7PCFcGPks9OcuTQoY6edLF6Ut/V8xZf8uwryOK2RqQsC9+ppQdMgh/yoUX
         +ZOA==
X-Forwarded-Encrypted: i=1; AJvYcCVuLy/cAJZJgfCQeoqVY0FCxV+xH8XGGz7lgXbcZx+6B22o+uju5s2/bebGFQT1g4Wm2Yq6pxCECmhy42FI8c8/XvjJw7lkSt6aeyfASrM=
X-Gm-Message-State: AOJu0YzW7A3hasmHJFLPN5y2DL2m+szbxMDOj/a+ZF122NGygU20Deg/
	35TmhVq0jFttLkRaYnfLXkaA99ClQHY7/TV8nWcGE6DZdcPYd5uGKFZKSFd7WPzWhLRVYIVs0nS
	1/2o2HQxfrZLKl3HBSfb+ekjplgE=
X-Google-Smtp-Source: AGHT+IHkShvoS3j34PpGZRdJpuildkNUMYe35bZWqGOxz31gFD0leWwH221mlvIRgK4ri/3cGJzWg3ZL+/JJmI+oCpE=
X-Received: by 2002:a05:6820:d8e:b0:5a0:e1c1:5014 with SMTP id
 ek14-20020a0568200d8e00b005a0e1c15014mr216278oob.0.1709142820730; Wed, 28 Feb
 2024 09:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
In-Reply-To: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 12:53:28 -0500
Message-ID: <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 12:44, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
>
> Add an array_index_nospec() as well to prevent speculation issues.
>
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: add array_index_nospec().

Did you forget to update the patch, I don't see array_index_nospec()?

>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>         if ((vma->vm_flags & VM_SHARED) == 0)
>                 return -EINVAL;
>
> -       if (index > dev->vq_num)
> +       if (index >= dev->vq_num)
>                 return -EINVAL;
>
>         vq = dev->vqs[index];
>         vaddr = vq->vdpa_reconnect_vaddr;
>         if (vaddr == 0)
> --
> 2.43.0
>
>
