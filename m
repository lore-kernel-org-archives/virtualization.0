Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E02116F6
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134145; cv=none; b=XRhmbUBVaW77UEBJ1aG87P1Zsj9jXwFKfLCmX/oHj9x/k19e7rMyDJof2RnXmP3u1V+WLWKT0OrCnb3TkLG1uCUleuzwf+GhNRFv/IFt2RociCuZ6QsHmdPHP8MLTRDYCROcA9GVCbyWLfd0oQrpk6SHO/c1bZ4fqPrvmwr/kNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134145; c=relaxed/simple;
	bh=viVgC9eKfZfPegm5V32POE92OvmFgYwi95g9Lg+B1fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dJiM9FLJ3heeFeBx/DteI6ojFzKKqB+2fwJeMMi2iYdhLM22e7ZpOXeXaiH5XVDRIQf3/cjjcj7WdcNPC7k8EK1rktdbP3raT5QVtGnpt0Eq82Y7WX4fzp4L0OLNR+FDscBtWpFNJLggAmHD+RXSsxOhvr9V5r9s/yz+798T738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM0x5MeM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM0x5MeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759134142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL/2dFIqy9o7LDqAQM77JNhA4n8xcsUmNbGqhHKd79E=;
	b=SM0x5MeM5LwNgOND16USaFEbI0iw1l1tofdD9vxydU23+vEzGgPT/WyMhfVI+V2lgfYxFu
	AA8zbOl3ZE6q/VDLjNcQA/25OnnPRh8y02PfRRvOtEYxAZ9s5Oj6FHhhXR2LStqnAl1YlH
	g7IRF5Dzh+wv1m2G4i0Cg3340HCekYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-19A0X3Y_OoasyVDAxtbE1A-1; Mon, 29 Sep 2025 04:22:20 -0400
X-MC-Unique: 19A0X3Y_OoasyVDAxtbE1A-1
X-Mimecast-MFC-AGG-ID: 19A0X3Y_OoasyVDAxtbE1A_1759134140
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso2648733f8f.2
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 01:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134139; x=1759738939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL/2dFIqy9o7LDqAQM77JNhA4n8xcsUmNbGqhHKd79E=;
        b=oed7bEaBSNkefjZIiidly7lIkSuxQB24k8bYwCrKCMDaPFYO1qYSxagRnANtL5ckYF
         7xcCMtcKDAPeBBtyDO2v3EfdFb/1WuywX+1AK0YSO6ZyUopXc3VMOyUwOo01bI7+65fI
         reYAu/Lun0TOBLdZAidQNtlByDhyGGY+WUNdAkvg4XLA0GU4OPei7fShuCUs4T1I92J7
         sfQRRgYfZlW/bsoLvpscWaPR8HrHsjbMRAZVQW8kF+SlCZU5gMyOPhRlDnKA9pJaifS4
         jdm0C+IJvsBDvunJVMecymQAuyz5nQ9w9csHXNDgk2I3CJEB8h6wnjNxpjbm8eSnvK86
         /4sw==
X-Forwarded-Encrypted: i=1; AJvYcCWfzu1paUW//Xbkab2z9BzbhexB+zU45te/1ZOScv6p/7VXJymVVrE4G35vbVD74F3Z+8GlyhY8b7YsrSuFSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhtIZ+hoGL+lRB05gZ81WzhJWY8Gu+YxQRyME6TlNnDk7+QQ7C
	3qEXQQI8USD2RwsSwCwwHFxmja505bCEzFNBPxS7xpoPWfVzUZ7WqxoiNArEsg6fcykcCRtlj3L
	Uw11jPT5oCTDsokOMrInyC31m9FiXIaGfNHX6eLRI5wf0siiXQzKGKpZxqyVeA9z2O8mc
X-Gm-Gg: ASbGncsrxNYrjuqHPk8NTTQc8jAhAE48inuLrjiXqGYRorXt9YyqYyzWDa3k9nJfhkg
	KIN/xS1v8LNVMpAkWNA+hoJHykdB5YLomJGyd/vouDyrmO7ngGJ+YSE5pCPd2a/pXujR8CrIsSK
	Qt8ric1mMxPIn9BLp1X4X0/Lg3TavX7q2Gf1BmC1HCQdKpXw3BYXPi2U97RwwBaBytfK3ogmXvi
	fxki8B8PUfXTA5eXbffwAoKhls0zMiN7TTzIOzEFJPWfUnBkE30KvtTgVJxcAp+n49CiapEzcqU
	1dQIjZ6q+YGXkzTUVs2yqHkiWExspolgGQ==
X-Received: by 2002:a05:6000:2512:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-40e4ece56f9mr15052542f8f.39.1759134139593;
        Mon, 29 Sep 2025 01:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUiQuaFrIDh0CTm/I8TXBLiYezuIZtt/OSkVDM7sUXPkUT1zKLp8GDaA3T7T36q3fGutodtg==
X-Received: by 2002:a05:6000:2512:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-40e4ece56f9mr15052510f8f.39.1759134139141;
        Mon, 29 Sep 2025 01:22:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f744b0sm3004985e9.17.2025.09.29.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:22:18 -0700 (PDT)
Date: Mon, 29 Sep 2025 04:22:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in
 virtqueue_poll_split()
Message-ID: <20250929041808-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-13-jasowang@redhat.com>
 <20250928192719.7ea3a825@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250928192719.7ea3a825@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t_9t5gzmfbZiBYapbzSpDbJ_2Lz5tRSbqGvNgm8qBqc_1759134140
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Sep 28, 2025 at 07:27:19PM +0100, David Laight wrote:
> On Thu, 25 Sep 2025 18:37:01 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> > spec.
> 
> If you care about performance you should pretty much never use 'u16' for
> function parameters, return values or any arithmetic.
> Just because the domain of the variable is [0..65535] doesn't mean that
> 'unsigned int' isn't the correct type.
> 
> > 
> > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>



I don't like this because it is inconsistent with virtqueue_poll.


If you are going to change this, change virtqueue_enable_cb_prepare_split
too.


But really there's no point.


> > ---
> >  drivers/virtio/virtio_ring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 58c03a8aab85..4679a027dc53 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  }
> >  
> >  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> > -				 unsigned int last_used_idx)
> > +				 u16 last_used_idx)
> >  {
> >  	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> 
> You can't want that (u16) cast now, I doubt it was ever needed.
> Note that the compiler promotes the value to 'signed int',
> so the LHS of the comparison is actually (int)(u16)last_used_idx.
> 
> 	David

It is not needed because the value is from
virtqueue_enable_cb_prepare_split:

static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);
        u16 last_used_idx;

        START_USE(vq);

        /* We optimistically turn back on interrupts, then check if there was
         * more to do. */
        /* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
         * either clear the flags bit or point the event index at the next
         * entry. Always do both to keep code simple. */
        if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
                vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
                if (!vq->event)
                        vq->split.vring.avail->flags =
                                cpu_to_virtio16(_vq->vdev,
                                                vq->split.avail_flags_shadow);
        }
        vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
                        last_used_idx = vq->last_used_idx);
        END_USE(vq);
        return last_used_idx;
}






> >  			vq->split.vring.used->idx);

