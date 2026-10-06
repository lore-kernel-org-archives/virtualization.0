Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50373DC4BC
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322062; cv=none; b=szgQvMAF0m3vjLmf9hbi4gp3ngp1HeFon+UYRI2CNPhyfwMknfkG36DnbdT+LnpbSP7cfVJMnwKgTnOkgV1R+t+Gzkvpkv8nIbG8o/f+jhXntnKQSukx3gfar6pSJyK0B4Cwo2L5cZVPZU7cDqV3vF+7vcyiHzjtUeNFryWyH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322062; c=relaxed/simple;
	bh=J518TeBei26VEQXbPGvt3y4HnC5DH/HWj48vtTb4u5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L/FT1DkBR0XdEq3FVsksaYsoJnQ9xxT4Ox5aGcPs6sEr0t3T/k7AoWimJDb8iYIGYaKWENo2HybETnKnKrRSS3FcCq4gZbW5eFUbFFDPni/6s58/vJenIFVhlEBhzXdnQ19lZDR3lfgRSGzCewP+hFNS5SOi9c3QmiGAnFB4r+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUSOZcIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUSOZcIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791322059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLYqLTXYL+33FHGPoAQIFrwweKpAyRzDOJvC/lVBZus=;
	b=MUSOZcIvkLTx7cW85sNFPq7rZUB1gLef1W9eMEidYhoRwl3QORZWzHKpTwJ62XEKY7m2eY
	Dv5ShUmbOMZAB1ZFFKJZOlZSShZL8i1JM1ioU/6mqu51f1LLkiY9e01Uk5G8ATjP2GKH+R
	Q4q1vWyENLB6Bz7K04UypsOcfREfb9U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-fr_0P0eBOfypUpMfudFNRA-1; Tue, 06 Oct 2026 17:27:36 -0400
X-MC-Unique: fr_0P0eBOfypUpMfudFNRA-1
X-Mimecast-MFC-AGG-ID: fr_0P0eBOfypUpMfudFNRA_1791322056
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a021b1b561so25527285e9.1
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 14:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791322055; x=1791926855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLYqLTXYL+33FHGPoAQIFrwweKpAyRzDOJvC/lVBZus=;
        b=cSfB7KmD2f2JzfuqrduAqfwR7ulJIWb7VKnphClhkXbQogRrbgnko8MGPN35aC4PXZ
         UBvyAn8YmY00cZRYuDnDY57oYNSk8VxpMdZ570oKDYXUMEA1S8hvFJkCu5jOfex7/iF+
         VgrjrXLBab+vZ2i1bqYOVB0Y1V0oICCzBNh4V9wgkK7GUbzwjYM8G+97Z3WE0MCHtb1o
         pVEgI9eJcs/OzTxiXZjLwq0PCphmDLQYr9uPgJW+p25J0Jhy1giVQnt5jFUcJhb4NyUU
         HjyAXH4v+OyiHnWQMKqSXKi4QlqPQx0YkEe1n9X3vB6C7O6bRNJtCRVxZRLxUx6fVAgZ
         vy3w==
X-Forwarded-Encrypted: i=1; AKwUvBz/HWmzObNxIJ44QqWYDyowWUcdAjR72zM+4khB2LQb6Gr3QVzGHaa5wtCYUoUr99Gxlt/bT56n6UG4lW4YEw==@lists.linux.dev
X-Gm-Message-State: AFuF++nLrC0KBFK2SPMGSQs5Ni/aCZvbm/f7NqZevkgIjx2oUay2d3jH
	TPTz1YL1j2B9yv3+fD46n9A60ZIWMIXJSd4KtLRuxsAZU9teKVNL653siRbAuu21ioUSKk1eExo
	nVPGnUQSWOum5bEE3LTdBi6mYh9UYwx4FTrLBkrZDFLrAvx7uvYzpuZpgLH14xz3RtX1V
X-Gm-Gg: AYBFou3SmlrGon9979n5V9RlifEzGH3MmOy8MBbd2D7f69WQUbX2PtLe3woIXQSLeP0
	f+j+oFFeuxOcNhmrG/FR3BfztfW8uc/NwUFoisA1ORmApspGbyNLWUUr1E5CGPYr9CfnfMbJ32k
	VDjOJOhc5Ri0V1oVAESln/+IxDUt4fWN6h35bsgdlpmzXJPkfEUf6YvNYasyqvb8wtwRYIf4quN
	2BCJ2dqyNa+LG1MS6mT58hDX2MAJbudUXcTaZl1+umJhvJxxAD6Vga/POGhoX7T+rBsq1w6AGXD
	wLMVR6c+dH8Y77/HEgo/GxNhqo1PuR1ioVTnfP/MYGX4pCYDJyFW9ODNpYt3CZewacwWtJw=
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a1806508edmr1608055e9.30.1791322055552;
        Tue, 06 Oct 2026 14:27:35 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a1806508edmr1607885e9.30.1791322055050;
        Tue, 06 Oct 2026 14:27:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f51beffsm14516105e9.2.2026.10.06.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:27:34 -0700 (PDT)
Date: Tue, 6 Oct 2026 17:27:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sungbyeongchan <tjdqudcks0424@naver.com>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] virtiofs: validate fixed-output response length
Message-ID: <20261006172721-mutt-send-email-mst@kernel.org>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
 <20261006182408.1301152-1-tjdqudcks0424@naver.com>
 <2026100633-roping-stardust-a6ab@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026100633-roping-stardust-a6ab@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kh93p74QjrBeIvjfNssbHI2kROr6dOZzRYZ2YmH8tc4_1791322056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2026 at 11:11:14PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 07, 2026 at 03:24:08AM +0900, sungbyeongchan wrote:
> > A short successful virtiofs response can leave the fixed-output
> > portion of the request argument buffer unwritten. The completion path
> > nevertheless copies the full declared output to the request destination,
> > allowing stale allocator contents to reach callers such as
> > fuse_statfs().
> > 
> > Require successful fixed-output responses to contain their complete
> > declared output. Continue to permit a shorter final argument only for
> > out_argvar requests. Reject positive and internal restart error values,
> > require valid error replies to be header-only, and do not copy output
> > arguments from error replies.
> > 
> > A header-only FUSE_STATFS success returned stale fields in nine of
> > nine calls across three boots. The fixed kernel rejected the short
> > response and preserved complete replies, valid error replies, and
> > variable-output controls.
> > 
> > Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> 
> Real name please.

a missing space I guess?

> > ---
> > Changes in v2:
> > - Reject positive and internal restart error values.
> > - Require error replies to be header-only.
> > - Rate-limit malformed-response warnings.
> > - Rely on the existing FUSE pr_fmt prefix.
> > - Add Cc: stable@vger.kernel.org.
> > - Use the reporter identity consistently.
> > 
> >  fs/fuse/virtio_fs.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index f15e516ebcb5c..fffbe08d9114a 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -4,6 +4,8 @@
> >   * Copyright (C) 2018 Red Hat, Inc.
> >   */
> >  
> > +#include "fuse_i.h"
> > +
> 
> Why is this moved?
> 
> 
> 
> >  #include <linux/fs.h>
> >  #include <linux/dax.h>
> >  #include <linux/pci.h>
> > @@ -20,7 +22,6 @@
> >  #include <linux/cleanup.h>
> >  #include <linux/uio.h>
> >  #include "dev.h"
> > -#include "fuse_i.h"
> >  #include "fuse_dev_i.h"
> >  
> >  /* Used to help calculate the FUSE connection's max_pages limit for a request's
> > @@ -730,6 +731,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
> >  	unsigned int num_out;
> >  	unsigned int i;
> >  
> > +	/* Error replies contain only the output header. */
> > +	if (req->out.h.error)
> > +		goto out;
> 
> But no error is returned?
> 
> >  	if (len < sizeof(*oh)) {
> > -		pr_warn("virtio-fs: response too short (%u)\n", len);
> > +		pr_warn_ratelimited("response too short (%u)\n", len);
> 
> Isn't these ratelimited() changes separate from the original issue here?
> That should be a separate patch.
> 
> thanks,
> 
> greg k-h

