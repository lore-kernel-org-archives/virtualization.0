Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630817B02F
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547816; cv=none; b=atrkmeqS1dpI9nj5c9+9944kCd0QN8UIikQ4gD8eTAR93NXl2BWhxhWnYM+37ZVa55khZQ7LwNuETVWds9ynhWYZsDfyafb4nxJ701DtJWrU+EHDJtY1VxyCk720LPASMst+hs0rBKfJkgjT8BDdIqYza1IoVbufqrTlsvP6J5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547816; c=relaxed/simple;
	bh=7ct6fmJRRthyBach+v0Gutk8b9CNRhWPhvYKKj1dkBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf2i4EE+JiIcWNOZX1+ODP+LKgfxMqBF8EUKWux8l/jWVRnBny+Q+CqNULbhNPqxaNa0xY/15/bmkkOjjk6WSa8bqCMOAELqoZHy8EGipeBK5DMsfkrmqSVPjt96o3ZnxQcET7JALvM6XVX+m6v+fYrP9afJF1S4CmOrxVLLd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=z83S4tIF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="z83S4tIF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a05c755477so40554285a.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720547814; x=1721152614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27GNx3rgssthvowIuYiHcRneaeD/UKbqkigSyCrQmiY=;
        b=z83S4tIFg2W/dRiSLCfKRMLzXgaZvLIe8Kg0Uwtq1ru04artO3XyhvD6sBspkWBwWm
         bsqQzbpTxxE7tDlBqsy6OYdKlFpIE4B1XJzHHZlyhlRimWbKhZ5BRBehjaDGw+SYjT9G
         zmLkiHNUxZq0tqF+PEF+Ft27NyRPcRSCdmx+RypURo92afTDRs8WJLu9UzE9lgmzzbk8
         un2tpktG9I0L27p/qYjC5xfIiwJenX1AegwIg5urJIZHICihJY8DyJGTkU2Kdzjf/6KR
         pjfAbXykwsLWoeoXygXZrcKeTk4dmKDfFNqtC+4GkAE3dJFUTYcqLYOQkbDlw3X1WebR
         b4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547814; x=1721152614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27GNx3rgssthvowIuYiHcRneaeD/UKbqkigSyCrQmiY=;
        b=esWuISDnvnloJgWyP+ddFCpAAm10OOPobrdofKgCrQeCoIpoQfXAN2UzUXoU7DJVjX
         Ut3PbDzlWBDRGU8BF4MG5JJIwHtv5offn6suJyK5np7wvP92awdcDEcpI+9mDbmETo4O
         1lKcG9O3590eJPFqHvA1P9GMcq5C8KYpmq7cEcEkAt8g327n9ReiRhrNr1xKmZ1d5RGh
         kaFC4oFcUyNVEYm20Nvb2JhlY6Bdhe9Eh4mnuGQzVI8hyjMjUR1/FgMB6tPLJam/wrcC
         nhAP789h7s1gGPGS5dkxeifgXHFagiFAxlzuDkd0SACJmQeruK3cJGMuejgZ/Q1jN4ai
         6lLg==
X-Forwarded-Encrypted: i=1; AJvYcCVZQKjNVb1/mxVFDgpUCFG6VJAv1yC3Lbdza6+vAMZUhQHZGx02MDAXKp+4J6YG9zqtduhrUlQI47h9qAHwS/u1N050ldB+xPZtRJGiFLU=
X-Gm-Message-State: AOJu0Yxp+HnV/8CZyT5+gvIpgbJVOYa5ieOdEa6+ZA7uN3Xr1UpGJU38
	bUNTayYAypf6Q7OhtAiTnho5UgYODExYnjHKukMFhZQGYTk32WQWQ/vS7K5nmuU=
X-Google-Smtp-Source: AGHT+IFhIi56Uc36YELLWajaoQqFRruybsE/k0kAjiGitoyDDRkMJoO4aEf3TSXtrlW0ke9B7QICQw==
X-Received: by 2002:a05:6214:240f:b0:6b5:e58a:6388 with SMTP id 6a1803df08f44-6b61c1c50f0mr41549816d6.46.1720547813948;
        Tue, 09 Jul 2024 10:56:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba047efsm10796556d6.58.2024.07.09.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:56:53 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:56:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
Message-ID: <20240709175652.GB1040492@perftesting>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>

On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
> Hi,
> 
> We want to be able to mount filesystems that just consist of one regular
> file via virtio-fs, i.e. no root directory, just a file as the root
> node.
> 
> While that is possible via FUSE itself (through the 'rootmode' mount
> option, which is automatically set by the fusermount help program to
> match the mount point's inode mode), there is no virtio-fs option yet
> that would allow changing the rootmode from S_IFDIR to S_IFREG.
> 
> To do that, this series introduces a new 'file' mount option that does
> precisely that.  Alternatively, we could provide the same 'rootmode'
> option that FUSE has, but as laid out in patch 1's commit description,
> that option is a bit cumbersome for virtio-fs (in a way that it is not
> for FUSE), and its usefulness as a more general option is limited.
> 

All this does is make file an alias for something a little easier for users to
read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
necessary to do this in the kernel.  Thanks,

Josef
