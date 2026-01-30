Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACE3128A2
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758934; cv=none; b=RSDpmXqZ1mBwi6mW2ocyeHAbvSd+2+Cgf1YjlzJmyRC5BusVU8SGmqEQS3+YA86wAaixZCLvd/ntsntAme+4jERtIh5PTl82HWS2tgG6Jy8NR/ONRIzCIcdGz+uNGGQa4sRYHIAQbjrM1L0pAOg+8DdP368NqF50qG4c4waWZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758934; c=relaxed/simple;
	bh=UXTdlt1wI24qvqQsO+1DtbYd2cStysl45AaASSMaipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RDtV9Qy9d40AaSxa4E3THa6vSA6EJiI2Op/gqaZjrenMD0bKM85h0fQrKrpstj9ODWZV97FJZOUj/tVrYmZW7zN7jjoC3cU/heZqD01jCYr1PYCdCzrYT1AeSRJlMPN4mJpSrp0oA7ECtzW9VEeLE+F2rxjqp5XVLl71bpN+B6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1FZWVtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1FZWVtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769758932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l13seWwAdAZQPIaHiLynfs2twMZr5h3vDo6Uupa88F4=;
	b=O1FZWVtUN8jombTnihUA9mI9xT5bFfYWFz6HCPvHYeni0hp7eGkvjQ/G1Vv8UZ17U/BCtB
	+yCmkhJYwLbFXIAjNufPIbRrVyI7/QYhAb9ZoXYg0dbzM6CcDseJh1VG+UxiFr5QKrWzwT
	K9l+0grO/gdcbfKcqxjQ6vrOGBmqiyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jCmTyC80PwKo-VC08yksxA-1; Fri, 30 Jan 2026 02:42:10 -0500
X-MC-Unique: jCmTyC80PwKo-VC08yksxA-1
X-Mimecast-MFC-AGG-ID: jCmTyC80PwKo-VC08yksxA_1769758929
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d4029340aso33072055e9.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 23:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758929; x=1770363729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l13seWwAdAZQPIaHiLynfs2twMZr5h3vDo6Uupa88F4=;
        b=V48P/h32GpVOmdfyhbES3q594NCMCzzB66+ZudMPgYs2yffq+Hr1HLRoz4LMWUHvN/
         H2w6fmOtFoSmOMxkJUItYMfuhNG/zz+TBeOPdIbUEqN6vCebRPqP7pxeEFxt7QloV6dd
         sNAzmPjWSOnu+0sErAaB5EEXZ115i2hxokH9PACQIoMQerM9QGquS9t7C2YP/5Ms550S
         YD9WuP6QlENlL+//hcrAyiPTTUH+Ln1iDjCaTSgAVF5K+vUgNs6TXZ3NbdKodsxrgDdl
         lS63HCY7cgVFzL5KpZu20/WzrwadXtXiN9IniGeOB81Je1QaLdSWSOCAA3NK+icx9lef
         7ROg==
X-Forwarded-Encrypted: i=1; AJvYcCWVq5DYPAUl8wd1pgR++NSngj+2ryC3JJYABmvqti+yzHy29Lw1lCEfZp2G27yWpIxvrscOkoR2xyMc5FQn6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpcRkGBH6xQKrVNvhbCIRrXhh18LUBX8Up9/oBTG2LQzpS6SqQ
	SoRgvNZ7Wy6VNANMtBQANETkKsJ/kWLcvmpOuVF3f1bh2LtouWDbDDl6cSVQ5LKjv5ghbcH7NBJ
	ATf+8rPhYX1tIyao0qGeWBzj+UyDI0Xs7C6oF0rs8hD7QtQEEBndBkMkHLMt0W0n3YI4r
X-Gm-Gg: AZuq6aKEqF/qfLPkWaCkTJR9o4nqsCDx6/zIOLBZ7FaD6moMIqWUEdHqN/9Cgo/47FC
	lhiAqG8uTgZlPXU0ADIggAchKruFq9XmiUZLZXjtf3fGgTdkzEQq1s/0uBXNjmxpGTOfaD3Ec6E
	z9sX4DKzmuwpjG7AL1tEO1wQlzWaomiWAuyccxooCw0vXJBwZMHRKjfJLCqlUSMz4/oOKOO6Bwy
	SVTtrAX2CGDcD5+xlH/X0294EYzbtq56OFYPWRsWPlLBqKYz7NkpiDAdgGeEYeZt4dj56onPTdA
	YOhp91MY3wlkiDwdD4l5gw/04zzc7PVm/AgAH4Tc+J9Et9xtwGmKrESyBxeLl2JeBKPA95K7/vT
	JOLZX2vUgCb0aJgCT2qgOJ0NlJEmzLvji4g==
X-Received: by 2002:a05:600c:8b31:b0:480:1dc6:269c with SMTP id 5b1f17b1804b1-482db49e6demr18609845e9.37.1769758928929;
        Thu, 29 Jan 2026 23:42:08 -0800 (PST)
X-Received: by 2002:a05:600c:8b31:b0:480:1dc6:269c with SMTP id 5b1f17b1804b1-482db49e6demr18609505e9.37.1769758928331;
        Thu, 29 Jan 2026 23:42:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm260871765e9.9.2026.01.29.23.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:42:07 -0800 (PST)
Date: Fri, 30 Jan 2026 02:42:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Alexander Graf <graf@amazon.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260130024139-mutt-send-email-mst@kernel.org>
References: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
 <CACGkMEtqBJKaG0H6zcyr_RJZ3bZgdNvT1KX52fKHpA=bLsUuew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtqBJKaG0H6zcyr_RJZ3bZgdNvT1KX52fKHpA=bLsUuew@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8G9AUHK5V4dWOxoJ2s08iykdoU9NU-jouMM3AIS2dgI_1769758929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 30, 2026 at 10:03:23AM +0800, Jason Wang wrote:
> On Thu, Jan 29, 2026 at 8:16 PM Johannes Thumshirn
> <johannes.thumshirn@wdc.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > KCSAN reports data races when accessing virtio ring fields that are
> > concurrently written by the device (host). These are legitimate
> > concurrent accesses where the CPU reads fields that the device updates
> > via DMA-like mechanisms.
> 
> Technically, the device can write to the descriptor ring as well, do
> we need to care about this case or not?

Why would we?

> >
> > Add accessor functions that use READ_ONCE() to properly annotate these
> > device-writable fields and prevent compiler optimizations that could in
> > theory break the code. This also serves as documentation showing which
> > fields are shared with the device.
> >
> > The affected fields are:
> > - Split ring: used->idx, used->ring[].id, used->ring[].len
> > - Packed ring: desc[].flags, desc[].id, desc[].len
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> > Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
> 
> Thanks

