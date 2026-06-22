Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCD2E54AA
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140371; cv=none; b=KoqzAxassR0WEQ3rgU63qpDvgHrpsRV/vWIi9fMULQB2yw+B3MKLiIRX/uXH+TYD/W8+CKJWKTkWvJXhEO+jvRfs0j9Q81Y/PI9gIIC2O8E9p6z9z+4XuFBqlVF9M/35GPTfPEpCssRly//sqf46PwsW5wUCyd+OK/GxK+yE0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140371; c=relaxed/simple;
	bh=x8scsJ8h9+Y2mMCa8zH4nxbUTE01RW8OACRJR3AcP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bp9xEoYOsZv08x3H9hVDXtjq2owsNk1P9P/I2+tjU2cTaK2GhohRmREDjGaQdJVt5MZ5vydJyG4DaL7VAq86Hej1rhCi9A69874MUnfnBBfm7mDmrJh+ZoFohOmXItUDuCZJ+ZfSttxRhRxkYXr9fRIay+sE0dOUko4s2R7w7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0RTDfZd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0RTDfZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782140369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/pjQ8vb9svPPFU7KuY+JwsGZZ/nfauUvUk0GUL7V9kc=;
	b=N0RTDfZdA5gFlWyIMYG5mteoFqRUwPA/jgn6m2C2UUgKA0ijfwrNOeSF4/1gI4+9xqgAwv
	LHJFxsri0w6o34OS4Bo0a9U6Aq0rsG6HhnsYMyWhheGVUzzgC/e3OhONu+t9+vEajpvHCw
	M6RfBlwhxHjTljOqAgdSkcOhaqC8/rU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-YMvPh-etP4iJKRswhQkxBg-1; Mon, 22 Jun 2026 10:59:27 -0400
X-MC-Unique: YMvPh-etP4iJKRswhQkxBg-1
X-Mimecast-MFC-AGG-ID: YMvPh-etP4iJKRswhQkxBg_1782140367
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef0af9517so4465120f8f.3
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 07:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140366; x=1782745166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pjQ8vb9svPPFU7KuY+JwsGZZ/nfauUvUk0GUL7V9kc=;
        b=Px/IbwN97l2QZIOmAR5CtB73Is/iVuWBk53jvIaSnvFXZxpj0At0EVS75qxhZr5weS
         Y6mJ2gGoSe8OW4Lwh69xQIAdNBAUcie+8+j2U+1/mR0eZHNqED6WkaBeRIiPM5k+BzRY
         +1lyyZz6csCzKD/g/HZp91qwXNRI6kNL9kxV4ODddIKqpI3L1e9bLSleVxZtUEauWIb1
         JIcHJaqLyC1MSGk9dnglhtsPDXvRoInwde4ZmcVY8+wc6+YFVbs2PNa+ouqm1nJD0EhL
         +oSIqmBJeaKqMjkV8H4uipQxVgnW2R3vk1ryf8Ytdpp39nfH8FHWFFx0eICoQzShdb7F
         4Plw==
X-Forwarded-Encrypted: i=1; AHgh+RpWu4JATey/mJN2gDI5UW3DZ53F00c3Mpqkb/+aSUhJFIlPnegtKlhbVRmJ3tM7scj0ryCf50xZ4d25IQXFJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytPiU7oqHmI3lZckjgYu2aA+LBzRQYiynOL5/YMgQRwBj23m5O
	heOcsOSr3NHuFDmPJmTGpaIA96sETmdZFJrtfO5kDEEk9mlfborPlJmGe53xgfbu6Alapznpc1U
	faDprujROKfsG/NiPhNqr6Tb+bYz9PApf0JXaWUNTRS0RNgyl7n8cjW7Lj+FCAJwtc7Hj
X-Gm-Gg: AfdE7cmIDHPq7c4eucKUHScqucG6MWRp9dPG16zNJQN6BljjGHXZNgFrJRIIVwgU+2h
	SCcV4KbOb+yCjjtBvxMG9er1Rm12nGtLplkMmB3qQX633ePo5t7C67wnQzxbdqGwixMbBQMhoSP
	/fT0tkY1Xq7vfgj9MxzCeb1xPrYur4kfQtTzGtySs895EXzodFyrtgARgQ5iWWtRkpOd3Gm5R2J
	2IMkdznuKVN+mMMtUpezGUbG4wnNcZxS0xLhgrrGpNzK0kY9YWLu9nDH0YpVSurq2EWo2szIlce
	uDMPXqGHtKrbhVqUXxgS3gTC7Ob/wMWzNkX6iYJooCyJkUH7I5rIxBXH0DWEnYh9MdEX/HXKnFG
	bp3HbIHMJ1ljBxWX0DYbKyQUul0/WQUE/
X-Received: by 2002:a05:6000:41cb:b0:46a:6474:83a8 with SMTP id ffacd0b85a97d-46a647488b9mr422310f8f.40.1782140366433;
        Mon, 22 Jun 2026 07:59:26 -0700 (PDT)
X-Received: by 2002:a05:6000:41cb:b0:46a:6474:83a8 with SMTP id ffacd0b85a97d-46a647488b9mr422210f8f.40.1782140365398;
        Mon, 22 Jun 2026 07:59:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm24534651f8f.3.2026.06.22.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:59:24 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:59:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_balloon: factor out virtballoon_quiesce()
Message-ID: <20260622105912-mutt-send-email-mst@kernel.org>
References: <20260622133715.3707707-1-den@openvz.org>
 <20260622133715.3707707-2-den@openvz.org>
 <79aa1649-acbb-4898-b533-4c991a6ca19b@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <79aa1649-acbb-4898-b533-4c991a6ca19b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lUtY0fysJ3EDK0p_vKXzGphoXbZ06BIomTBIb86yVaI_1782140367
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:46:48PM +0200, David Hildenbrand (Arm) wrote:
> On 6/22/26 15:37, Denis V. Lunev wrote:
> > virtballoon_remove() stops all of the balloon's asynchronous work (the
> > free page reporting worker, the inflate/deflate and stats workers, the
> > OOM notifier and the free page shrinker) before tearing the device
> > down. A following change needs the same teardown from a .shutdown
> > handler, so move it into a virtballoon_quiesce() helper.
> > 
> > No functional change.
> > 
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > ---
> >  drivers/virtio/virtio_balloon.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 088b3a0e6ce6..5b02d9191ac6 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1098,26 +1098,39 @@ static void remove_common(struct virtio_balloon *vb)
> >  	vb->vdev->config->del_vqs(vb->vdev);
> >  }
> >  
> > -static void virtballoon_remove(struct virtio_device *vdev)
> > +/*
> > + * Stop all asynchronous balloon work. The device must still be alive so that
> > + * in-flight requests can drain via the host before it is reset or freed.
> > + */
> > +static void virtballoon_quiesce(struct virtio_balloon *vb)
> >  {
> > -	struct virtio_balloon *vb = vdev->priv;
> > +	struct virtio_device *vdev = vb->vdev;
> >  
> > -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
> >  		page_reporting_unregister(&vb->pr_dev_info);
> 
> Most functions here grab mutexes and can sleep. I assume that's fine in shutdown
> context.
> 
> Nothing jumped at me
> 
> 
> Sashiko asks whether ->remove (hotunplug/driver-unloading) can follow a
> ->shutdown callback. I don't know, seems questionable if this could happen and
> should probably be handled by the core?
> 
> If it's possible you'd have to remember that stuff was already quiesce'ed. Maybe
> simply by checking early in virtballoon_quiesce() whether vb->stop_update ==
> true already.
> 
> -- 
> Cheers,
> 
> David

I don't think it can happen.

-- 
MST

