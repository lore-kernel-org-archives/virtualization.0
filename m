Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D591553B8
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569855; cv=none; b=CruBELDXbnoc0LzWsNpvMvpgpNc/yvkQIxdbNHVi78xvUizJxaPHR/WBdFI0NLpjPdSdgGTuRnF03SCC8nXMdwfErkfe8PVJGJi4PKS5xQ8swMF00/uwWNHoMnmPxEIMVGXRSFopjHrSYxsPJqqgM1QX+vv2X048wH9hellaNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569855; c=relaxed/simple;
	bh=pgMb9uGoyAIyFbF9znVIz68QYrW0g+ex10ZFvjS1k8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NvkPy3Fnpmo3ophzqq8QaAWwUsHfS4oxFtQ2apzaE6kYu2ZwQxVw6/Fdb9TfSx1pywxwHbVooiqCjFdnYHlZZ6hYqoQ/qtrMMtmtPPz0DvX++s6ldT3sXjbdk0bse/V8vyuSN8geQY9sWEUlV/iSVlA0JL5TmOgzFUcQZ0MvGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vdm1l22S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vdm1l22S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711569852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pUwkeyxpCIgmMVeDahMru1IGnRUaXTuK4+0dNpSIAI=;
	b=Vdm1l22SfRW0BZ+Q20H3DIL2Z2Opag5Ti49Ke7Y3elqzzwSy2FFOlih+bSCiFdZpybSPjj
	oclCD1KJVsWL+RZvnUgrwCcqcQ6W8DoQpyQgC1umt/tWPUyL+j4ZMSCQ1W7j+O8eB4Fqd4
	8tjT9KucEeZrZ1TJsj/z8ArHKOSZaOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-VMkJ6EYMN3yO8kNxs2inug-1; Wed, 27 Mar 2024 16:04:09 -0400
X-MC-Unique: VMkJ6EYMN3yO8kNxs2inug-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ecf15c037so85914f8f.3
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569848; x=1712174648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pUwkeyxpCIgmMVeDahMru1IGnRUaXTuK4+0dNpSIAI=;
        b=Ja2TX9/z0OKj/CA7/JqDHtAZxBtW+B0nGIN6ai94ur5cS22mRuOPfUVgWO4HFKaDSe
         tN1X4tO1cPwfU1QRhJ8qxCw/lwMJ+eLf8/gBBb4jwgbuLyefb4Y7dwQYrgexCf54ieUm
         xq4qX3gMvdy4iBoW6c5VyFnVfvinoTqgt6SlUQJVEPI1KX11RKcKD/e33gwInzWrrEWJ
         0UOBpuPaD5aUlyNEoutsEkiopoOZgMCtPuOqliBNBjkjljnAwr1UMXcdvXVazAqTgKap
         98mt1yIIObfdNSuacovdJIAXR95zrYz6hJlJfcOiiYWQhmjd6ooLjV7nuZxJcNYt997v
         KNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBkzWN8A/alg7szaiGF/hckSDpCe25EWbBgAGOFOYMsBvFSJ9+FyvFzGMoTrDYg7XnBu4nzv/hAX4a8TVUD2TU1IfTKeUawVnRdTdeBWM=
X-Gm-Message-State: AOJu0Ywbkk+d5eic1CPcQHXYtiv04gOCJtcbA4rABF64guVOFFgM963g
	3FzkxMkTFEpHjpdk4zY1yO5gtUArC06bI8md/iTdGd3hJUkG7GwH0SS6DZOPe/N8zloFhirnrKb
	2C8AgOXjgB7KdQAFeH0VDZW47EuZBVQvapoOxy/YAkKsH8nUk/suXLDO/PyfNKho6
X-Received: by 2002:adf:a4d0:0:b0:33e:737f:2f2b with SMTP id h16-20020adfa4d0000000b0033e737f2f2bmr855574wrb.53.1711569847979;
        Wed, 27 Mar 2024 13:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTklukmtRKY9zEEGC4iwvdgrZ6nHRSYn8IS9kk7sn2RF5Cfz9P+w2Hhw3wmG5duVPhRlleig==
X-Received: by 2002:adf:a4d0:0:b0:33e:737f:2f2b with SMTP id h16-20020adfa4d0000000b0033e737f2f2bmr855554wrb.53.1711569847214;
        Wed, 27 Mar 2024 13:04:07 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b00341c6440c36sm11892032wrb.74.2024.03.27.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:04:06 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:04:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Gavin Shan <gshan@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH untested] vhost: order avail ring reads after index
 updates
Message-ID: <20240327155750-mutt-send-email-mst@kernel.org>
References: <f7be6f4ed4bc5405e9a6b848e5ac3dd1f9955c2a.1711560268.git.mst@redhat.com>
 <20240327195202.GB12000@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240327195202.GB12000@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 07:52:02PM +0000, Will Deacon wrote:
> On Wed, Mar 27, 2024 at 01:26:23PM -0400, Michael S. Tsirkin wrote:
> > vhost_get_vq_desc (correctly) uses smp_rmb to order
> > avail ring reads after index reads.
> > However, over time we added two more places that read the
> > index and do not bother with barriers.
> > Since vhost_get_vq_desc when it was written assumed it is the
> > only reader when it sees a new index value is cached
> > it does not bother with a barrier either, as a result,
> > on the nvidia-gracehopper platform (arm64) available ring
> > entry reads have been observed bypassing ring reads, causing
> > a ring corruption.
> > 
> > To fix, factor out the correct index access code from vhost_get_vq_desc.
> > As a side benefit, we also validate the index on all paths now, which
> > will hopefully help catch future errors earlier.
> > 
> > Note: current code is inconsistent in how it handles errors:
> > some places treat it as an empty ring, others - non empty.
> > This patch does not attempt to change the existing behaviour.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Gavin Shan <gshan@redhat.com>
> > Reported-by: Will Deacon <will@kernel.org>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Fixes: 275bf960ac69 ("vhost: better detection of available buffers")
> > Cc: "Jason Wang" <jasowang@redhat.com>
> > Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> > Cc: "Stefano Garzarella" <sgarzare@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > I think it's better to bite the bullet and clean up the code.
> > Note: this is still only built, not tested.
> > Gavin could you help test please?
> > Especially on the arm platform you have?
> > 
> > Will thanks so much for finding this race!
> 
> No problem, and I was also hoping that the smp_rmb() could be
> consolidated into a single helper like you've done here.
> 
> One minor comment below:
> 
> >  drivers/vhost/vhost.c | 80 +++++++++++++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 045f666b4f12..26b70b1fd9ff 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1290,10 +1290,38 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> >  		mutex_unlock(&d->vqs[i]->mutex);
> >  }
> >  
> > -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> > -				      __virtio16 *idx)
> > +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  {
> > -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> > +	__virtio16 idx;
> > +	u16 avail_idx;
> > +	int r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > +
> > +	if (unlikely(r < 0)) {
> > +		vq_err(vq, "Failed to access avail idx at %p: %d\n",
> > +		       &vq->avail->idx, r);
> > +		return -EFAULT;
> > +	}
> > +
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +
> > +	/* Check it isn't doing very strange things with descriptor numbers. */
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> > +		vq_err(vq, "Guest moved used index from %u to %u",
> > +		       vq->last_avail_idx, vq->avail_idx);
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* Nothing new? We are done. */
> > +	if (avail_idx == vq->avail_idx)
> > +		return 0;
> > +
> > +	vq->avail_idx = avail_idx;
> > +
> > +	/* We updated vq->avail_idx so we need a memory barrier between
> > +	 * the index read above and the caller reading avail ring entries.
> > +	 */
> > +	smp_rmb();
> 
> I think you could use smp_acquire__after_ctrl_dep() if you're feeling
> brave, but to be honest I'd prefer we went in the opposite direction
> and used READ/WRITE_ONCE + smp_load_acquire()/smp_store_release() across
> the board. It's just a thankless, error-prone task to get there :(

Let's just say that's a separate patch, I tried hard to make this one
a bugfix only, no other functional changes at all.

> So, for the patch as-is:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> (I've not tested it either though, so definitely wait for Gavin on that!)
> 
> Cheers,
> 
> Will

