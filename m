Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FB143C75
	for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711884708; cv=none; b=KSTe5dHsn1Q8iXPbYG2AL85nzFZYLR38sBNn6rZqlOqVu/1RnwYX260B6ZjsqqRJaUozms3KGG0OThj+DsxWr1F+h88lVOM0x5nk1hHtnlh5hByWovl1jDMJxMdUnjmDRsD+WXeFR1AZ0ve74evm2ckkdzSAsKhauHYpCG09bDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711884708; c=relaxed/simple;
	bh=yVNosw4u33TuyqESP5NBHn6SnAWhKrMkpduIk/OiD88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SoB8gQU7lf94EbbefJ0sZ6XOZgj4a2FjsX2BiEYLzPGCKHWJ4cz+ynttjU0VCBaZtNBB9RDxSZrxBkq/AaQn8MqkIJjEeEt6fAYeFnBgKSKagIFh5M+Rxuurmj/ondpeVGthSn60DGn5qeaLElLFkJKTbF2o+iynKxyVN+oI5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7vgq5MU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7vgq5MU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711884705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ei2NbWkgFtoq49j7dP3DKJIXWsHmyOvkmjAwAxfrPHE=;
	b=B7vgq5MU8auswsR689hPMaxDCH029oq6xJML/u6UWUQaHrXBi2DyoIBTILwlAOjNgnmCvt
	gcVDGAHckYBvHhlr5xVOrVcPmSWHFchWMhLWA7PZ9MVy1AP1bwTV70slySuQ+BkyOEHAfB
	IrmBbeOvFRKbUNVc3/lqTu5aKSa1e2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-_4NO-ZgxPES7fUUHgsNyiw-1; Sun, 31 Mar 2024 07:31:41 -0400
X-MC-Unique: _4NO-ZgxPES7fUUHgsNyiw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-414ae9b8c04so21115155e9.2
        for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 04:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711884700; x=1712489500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei2NbWkgFtoq49j7dP3DKJIXWsHmyOvkmjAwAxfrPHE=;
        b=gRsyZqSfn0fgtdOAtki/ZNmbOlCbZT3Z3B1TK0B9CFbWVpT4anJeaquESfg+U6GLgF
         7zDG2QhdPn8Hk6MJd0uTihaFb6ccZ4TqiKBURUaSJMD2hjTZwcG/UuOnDrbyYhZYxqPD
         rZW+9bq75xAQfpzWSc8o+4fW3wxi7BL3DKz11XD3whhRQBHnX/g8uFHzwiGCzcrYfZiJ
         50Pbl1lDBK/lrtxIQgnPT5NuaBxm3bxLgtMN+Gd5rFI2T8MgRTX7oRc2wMK/nYN74NOh
         dZ5GctDpGkwpoXqYr16o2nmUqLdkpTlYTVa1LNNhu6rbMFiJlH+r3BkHvBXZfo3rkQyC
         z4ag==
X-Forwarded-Encrypted: i=1; AJvYcCVnYd1hjQErRs37abTMChXcyNXl9YrjFJs4QlmWxLjt9xoL8oV6EZeBXoZZvw8qA3tJLP2rb8zXRtr+2i1sWzX/z8z8t2DhFNRP9jsiw9A=
X-Gm-Message-State: AOJu0YywmSxrwf1pNODRw/7D3h5HytizXyv1wPoBBY+ubMGC7TCy90XO
	4OJdEHqrLqM1X7DOAoRF5qNGHQQ14skLrRU3nh5wOFZlJt3xARXEkP1bzX7p8/NWAcM6zK/443n
	gvJ/3+J9ErJzHuckVqEY03dLVJEMoE/069ok6bhB11bSGIOHIoNYS1V7Hzg0GbrO/
X-Received: by 2002:a05:600c:3d93:b0:415:6451:3 with SMTP id bi19-20020a05600c3d9300b0041564510003mr321096wmb.9.1711884700275;
        Sun, 31 Mar 2024 04:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8E6C+YjWaMUhiEyz4RZj2cwG4ubALrs2NYj6SU2y/7f3QE+WDS/+es2ZEdArs0ZRBpV0JwA==
X-Received: by 2002:a05:600c:3d93:b0:415:6451:3 with SMTP id bi19-20020a05600c3d9300b0041564510003mr321080wmb.9.1711884699748;
        Sun, 31 Mar 2024 04:31:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:c52c:ce6f:ec9c:ca7c:7200])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041493b57976sm11386471wmn.18.2024.03.31.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 04:31:39 -0700 (PDT)
Date: Sun, 31 Mar 2024 07:31:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Message-ID: <20240331072925-mutt-send-email-mst@kernel.org>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2024 at 12:34:34PM +0000, Srujana Challa wrote:
> > > +static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, unsigned
> > int offset,
> > > +                                 const void *buf, unsigned int len)
> > > +{
> > > +       /* Not supported */
> > 
> > We probably need to filter out VIRTIO_NET_F_ANNOUNCE and other
> > features that depend on the config writing.
> As per modern virtio spec(v1.2), device config is read only for the driver.
> Still do we need to filter out these features?

Yes I didn't get this either. What is VIRTIO_NET_F_ANNOUNCE?
VIRTIO_NET_F_GUEST_ANNOUNCE? And how does it depend on config
writing?

-- 
MST

