Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170421494D6
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304313; cv=none; b=bJa8Rlk5JEVo1jkR93prtPMaFZFF9YVoqag9i7W3uucMOIWe8/mgXzeqT/ovLnzdB3AJD2GgpSLVg13UPsRbzFnOE52u4X/pKp7x+o5ov0FYi4EMc/YelC1GiTZIw9K2CUM1JRMTLFF9GU7VoGRHg/Tv9CZNCFgW6whin4nKAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304313; c=relaxed/simple;
	bh=4GQMcGauM1sM2qcIuTQSJ5+jNSGplBUnYe9YXxdjt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ROL9qWVjmij2HC/UTH27RDbN9FrCwN0IRuLVnnvyLagEW7QifLh66el8m9QVBoSqrjtD6QoRzukM/zmFFQPw96fPXbZ3sDb07Cwp7p/BWS0RGRG7pf5nVVZ6DgFRhJf2+OG0Y0u0Sxf8u65TIyGvI+t1I2RdS3TALxQkwiZO8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKdiiSNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKdiiSNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
	b=XKdiiSNo7G5HVhjmqeQlVEKMaYDVpA71Z5Gh6FMcH1ji1fzPi+oCjDIchvZ9VwnQCuz0cM
	PkpCKvOHCpUYJGtDInpWqUa9ptmez8rvJ5wH/XasMg2tpvNXXp+4nESuIr5EXLxyZXJx+F
	gXbQGlLlOsaf8bkvq4fNlW9oJAtD8WI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-wLexGDYdNw2XCt4f2cPnWQ-1; Tue, 25 Jun 2024 04:31:49 -0400
X-MC-Unique: wLexGDYdNw2XCt4f2cPnWQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fe721da43so94570066b.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304308; x=1719909108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
        b=NcIgGOIECL+JiJOHy/eJbMlgOW9mIHlSwJWQk8WSOh4JKL4z4PjJB8r24Kf09ZksOg
         JYUs7J6pMzbWtepvToimI5ltjpE15lrfdQX4GnJxs2NEYGaV1717LZuURK1wO1MUsm/O
         T0zyhptfwiIyRx/0fs9I6DLc3jTqyWmTE1Bja4+3Si9MQMeq4yuSLaQyNk4FONwWWtqh
         yqFrdcHiofbcKk4oZqi8f7fveN0KdXYbknID9s8ZTx3JqHgok5gNGnC7dr5818ukyTND
         T78bMJ7/Reg5RHDu8wHBbG4TiGXwn+6Z1HLzXkJFcaGUgk+GAztXNJcLmnbiC71u5Pgo
         dNnw==
X-Forwarded-Encrypted: i=1; AJvYcCW7njZZjpoev8x5hvndhwb2HrnFNkKNFDLMnn2i4AVmnGKpBZvBv4IOjoCJyl/mqaO7n3CHbshXUGWPumezKCsnFOVzuatMFBzvw0wXk0Y=
X-Gm-Message-State: AOJu0YzuaM0SDudlybqbFBxYrTDkQlPCnc6cGwdTgILJrj0lNzB8Fcyv
	/nllvqXQK5eekESKQoxv9JUJIvNN2PkbEnlnbY+HY4Xx10OZsOdSHrnIfwCfcFszNvRO/H3Awtv
	AfkofcWTCNGRDXnqVHLYxaiyO/gxV8xlf/iqL2PIoBx5Tsi+EHdV0gUyhEqERpbka
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403367a12.15.1719304308210;
        Tue, 25 Jun 2024 01:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxhsR1+izX70xNnvyhK6UwUVonlEeFQMV9kch7eEfTNcHpuqfZ/z/U8gcxRPMmp8lA3q60mQ==
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403333a12.15.1719304307535;
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535232sm5638857a12.72.2024.06.25.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240625043120-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
 <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org>
 <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
 <20240625035746-mutt-send-email-mst@kernel.org>
 <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 04:18:00PM +0800, Jason Wang wrote:
> > > >
> > > >
> > > >
> > > > But in conclusion ;) if you don't like my suggestion do something else
> > > > but make the APIs make sense,
> > >
> > > I don't say I don't like it:)
> > >
> > > Limiting it to virtio-net seems to be the most easy way. And if we
> > > want to do it in the core, I just want to make nesting to be supported
> > > which might not be necessary now.
> >
> > I feel limiting it to a single driver strikes the right balance ATM.
> 
> Just to make sure I understand here, should we go back to v1 or go
> with the config_driver_disabled?
> 
> Thanks


I still like config_driver_disabled.


> >
> > >
> > > > at least do better than +5
> > > > on Rusty's interface design scale.
> > > >
> > > > >
> > >
> > > Thanks
> > >
> > >
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > >               goto out_ida_remove;
> > > > > > >
> > > > > > >       spin_lock_init(&dev->config_lock);
> > > > > > > -     dev->config_enabled = false;
> > > > > > > +     dev->config_enabled = 0;
> > > > > > >       dev->config_change_pending = false;
> > > > > > >
> > > > > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > > index 96fea920873b..4496f9ba5d82 100644
> > > > > > > --- a/include/linux/virtio.h
> > > > > > > +++ b/include/linux/virtio.h
> > > > > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > > > > >  struct virtio_device {
> > > > > > >       int index;
> > > > > > >       bool failed;
> > > > > > > -     bool config_enabled;
> > > > > > > +     int config_enabled;
> > > > > > >       bool config_change_pending;
> > > > > > >       spinlock_t config_lock;
> > > > > > >       spinlock_t vqs_list_lock;
> > > > > > > --
> > > > > > > 2.31.1
> > > > > >
> > > >
> >

