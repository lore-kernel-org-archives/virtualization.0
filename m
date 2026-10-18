Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D64D9566
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792360690; cv=none; b=d0sbS17Vc0wXl1YPKmP9tQFqTI19f9kqkk7Z0C1A+EHuRbhS/SYvuxN+6EamxmDNhW86RKmqQtw6vj8FxBHGttwlY0Av2cX34/FPdapqxXHDQRRB60YYW8BbnA5Snu/F4ziycfisbNAMvsmuyS23NrHXXI6cAUBOy7Eyu+HEwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792360690; c=relaxed/simple;
	bh=zrU6pncxkNvGO8lsm0RmeCOS8yCv8qbs+XOEF524iU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tCOATO92usPiJJCpK2WTIQPTxc4g0SGvZp5niaxQVMm4b2iKkNGaT3lxuAxX85R/FszsICNB+7GfSNjclcDlC9OOobbLP1nW+hdFEkOSspHFglV5U8iRBDaPWvbu6xeLNOGg3WaUm8EuiK31cJnKpbwUbwGLdbPqF5MkGARD/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1xIg0eK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1xIg0eK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792360687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SW7smKPvwjLXka19f8Byx3O0NkEWaQaf/H2rebSp6ws=;
	b=S1xIg0eK0wZKTtBFVs6ZtiQdu0tVqu/OSZFbtaNDggw+aHX5MK8kABJFP9cCpLOqlRdzGh
	XUFZWnirjqwAqOo1eaM4T+tHe+UbnqRVfpH8z007qRQ0Dfwk6rGa8GV6kVOD5R7Fq9mcD1
	qbZvEYz9hfGxbaWrwuMMPhv83QVHxdY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ssnGbzHDM2q1yqo4Q-be7Q-1; Sun, 18 Oct 2026 21:58:04 +0000
X-MC-Unique: ssnGbzHDM2q1yqo4Q-be7Q-1
X-Mimecast-MFC-AGG-ID: ssnGbzHDM2q1yqo4Q-be7Q_1792360683
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48af4046a3bso1290073f8f.2
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360683; x=1792965483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW7smKPvwjLXka19f8Byx3O0NkEWaQaf/H2rebSp6ws=;
        b=XcTPATNUSPaFlzd9KFoeE6h38RIyYUjWULycZx2694XdjyikXe6VxNzb42PNDY0Vc2
         OuZPr5D2ltgVmQT6YNE/SboUzqVQruwaqMPUjr/zZFcmgBwBpuAv0jFZMWAVNTbSiPfX
         9idNASlLhd8bD+l4Pzn4jTQ56I14hdfJg2ziyXqvfcMuZPIl3z+EDY9j8GrB2zbiL1dQ
         9DAFSSQK+j0wD+QXqDgtu1Iv7UnUCFloau09oJh540FutpY9kVhQuYr+Vf4HX/kxreQn
         AOa/OOrh86UzO8GrXPcBrE7Y35+ORg4Fb0WvcGqJWygdhliEMsdP5T2jkFN/B+NEa0SB
         RkrA==
X-Forwarded-Encrypted: i=1; AKwUvByuIjDD7orPb+/gaZji5AeC+N6cV7QHDcFv2OdBggolAyFR+uu2tclcKTqfUKy5HeBD5Tzv7IcnrMts5mVkUw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIYttHEAYriiax8DUBONurH1s5AmO8wAOoCQ0o9i7/edca80ZVa
	ZVFKqc7iuAV6pfC9ZRxB1M9/uGHW1KCl/0fpD82XOF5upjZxWthdeK+5z4K9ZytRvIqcGc15SVO
	8/SoZzUXWinjVN3JKmfO2+FrTgKtza1CkBZNqMp7vTxVQt0Eq2VrLTPbqTBkVSzAna1Pp
X-Gm-Gg: AYBFou34MQrtfaNg2c0GTc9VW3f8fj0QfYEMKpIZGxjvLNnAiID6WZZRLql+4L8nb1o
	SUsoxaZ1fmuymCVgFsYE039u8rcpMds0IzyN1kLe960FhXynD/9jZ3/h6rHG8TENJh7moqgfl//
	HdR14ezCSiruSitcZjz1Da3rjjVJNels1LB5tB+Pp3QkDBLWR/g+aGSOsKH8lSjqAoHxZX34oEx
	MYUBFNGHymHyaYt0+5rl2XE6yl4j6Rwn+OsCWe7nuNsVi1NLWSaIPldTliFzwhTnnqFb/r20TD3
	g8slOsIfllbavD9zpFB5SMmOLaoIepjhx5pSa+uKsddiJHDif+GopK2XQGyBA13U034P/A==
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr11848842f8f.19.1792360683025;
        Sun, 18 Oct 2026 14:58:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr11848818f8f.19.1792360682562;
        Sun, 18 Oct 2026 14:58:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm18703089f8f.43.2026.10.18.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:58:01 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:57:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018175347-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261018204838.4080b238@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ckDprNl20cjqGCYj9Vv2Qu55wt_-ggChcQxJK1VsrWA_1792360683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2026 at 08:48:38PM +0100, David Laight wrote:
> On Sun, 18 Oct 2026 15:24:41 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > > against the 7.2.10 source tree. I have reproduced the leak on an
> > > unmodified 7.2.10 kernel.  
> > 
> > 
> > This should fix it I think? Can you confirm pls?
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/vringh.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..4b097170bd36 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >  		return ret;
> >  
> >  	if (vrh->use_va) {
> > -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __get_user(tmp, uaddr);
> 
> Can't that be a normal get_user() call?
> 
> David

Ugh, actually no. This is called under local_bh_disable.

get_user would splat on might_sleep.


> >  		if (ret)
> >  			return ret;
> >  	} else {
> > @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >  	tmp = cpu_to_vringh16(vrh, val);
> >  
> >  	if (vrh->use_va) {
> > -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __put_user(tmp, uaddr);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > 
> > 

