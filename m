Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50A2C15B0
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302528; cv=none; b=KfKDQQL0Uzv1+MUcF120AQcvbzXaXhbC0uLbixSd1ypmUz1aqzxQsDnCjo/mbiYj+KJem/3Ve+oIGD2FSuVv0PD0BY/moelhJKAzh6t1BT1r7YWJSXhZo8TVOJHR7FLm/ZK/Qbhy5d94xg3c8zyz47UZqjNcT3dHQMYhgEtOPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302528; c=relaxed/simple;
	bh=K0ibrbryHWA8nhR7V2WWbJtZNyh1iYz3h92NfYNz0iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TXJc7oj3odQa/0XcE58jujrVz2TFBT2mz7jr6CRZ8AUD3eyJdeGYe/q/cpeW5DkDuCWQ1CGDp97kzH4/L7H2L3RCQfsZWVcEF6ZuH7KATu7S7mu1Ubl9hM73SopBrweBMIvJM3hMqPVHNxMwLW6ngowltf+GrISgFvf8xqQf9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw5Z71X+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw5Z71X+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2276884418
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 17:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yA5ZOLVYNTsK for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 17:48:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EE907843F0
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE907843F0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hw5Z71X+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE907843F0
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765302522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wds+RnykkG8gXthSZ5oxSbSivYlkrug9sYVYpvvQME=;
	b=Hw5Z71X+u+yyi/BapdCia3xVzM0nJANBV5eOVM0NipwqkgZqHFcwT6LjffhMhyUgFljPVY
	374/E42JrKdFSXRwSaFduSs5aHk7xYzAg9Z+Wv3UNpYEJ1uI0uFddQgB7TH8zR6BpWueO0
	nIO8YTMDMJqH5GYx/mirODdT44PQyFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-Y7g92kRSPeaZ-n-TbJHSLQ-1; Tue, 09 Dec 2025 12:48:40 -0500
X-MC-Unique: Y7g92kRSPeaZ-n-TbJHSLQ-1
X-Mimecast-MFC-AGG-ID: Y7g92kRSPeaZ-n-TbJHSLQ_1765302519
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b5556d80bso4456952f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 09:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765302519; x=1765907319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wds+RnykkG8gXthSZ5oxSbSivYlkrug9sYVYpvvQME=;
        b=QPCvoqEDgfE22Y3gb4qNq/9lEXAA4OIVEJ9bNuYiaFYI8DaHEicPvm8+UKQb+97rcW
         Kl7+vP81xF9i7eDskl9keRU/H2g2tR3ik1RO4IJN1aj0kpzmyHUDIYhv1nLCwr84T3lx
         Hzs8sMcL67BobXQBwjedcd1cF036E9lfC0GQ7PB9PZnUwn9mevs1unMkx9A2a7FjktbC
         z055SFDuQ+B2zUShP7rIqUive+EUrA8f58EFshytdxwV7gRkRy2t7+vKzi9yVqGSygr7
         F85mHA0lVL2X2rCqataJXKLvpkt3w+Uhleiok5HdA0AyMZgRgn2bgrBPufJnTnzpeH4E
         lc3A==
X-Forwarded-Encrypted: i=1; AJvYcCUY7bFTQ+Jf/zLjIWZotITU/orFsuCjlqL5MVYFvL+JUPfb0shGVv///tfseB8rBVcKHqZfp7ckvqXSV9/tWA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7APDdtqrAzURm8VWrD58wl4B/cXJiuVnHjjBfeh9IwvUldc6J
	URvQgoihW8cWV8HhPYY3iepzfX8AkM594klBG0aXOatsIfbTPLw+aLFGUEGch5fFhd2V+T3Y7xx
	upZyVtUNFj++1oh0erbCMjjNJ1gb3yIF8ugpJacihCptIioqQdvSHfjlrsBconXDQ55PIMtYnL0
	M2BTHwoS8=
X-Gm-Gg: AY/fxX4GD1slJLuvcrGb+I7gjFbM6bybOm026vg138u8Gd/3OiEoqNM7b4A6hfwcLNq
	pJLxdxr1cM8KnbRGrkTkKDHIq/Tm8h26WFsUyJD54RhxEKomVookO/CNMCyJpXhrLHwqxWR21wi
	uehhrNeIEpfRvtXuW9oAzF2qcEA5XTPxVk6wD31F4dTPawLTIgtcjowu31c4QpLefPzvez0bXFL
	wDClac19wynVj1MGvfOCLvLqQQPEGoC4ConWKjD+IJMPRSom5gf60zbyPG8KTZ/56+EIxXgweq3
	Y5ypkdk3A41wBNhwKqyNS3UICSl8bbhTtYYbHMDEieYkbYeg7dJmOMFZuw+kX88xMDDTe9jTkWZ
	j
X-Received: by 2002:a05:6000:402a:b0:42c:a449:d6a5 with SMTP id ffacd0b85a97d-42f89f3d718mr11473080f8f.34.1765302519299;
        Tue, 09 Dec 2025 09:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNodAp4VRw+WDt0ClnkNSIgayKL8Y6tDD9ajoVtZAIm0NOGVQk4fbxwV5uQBvf9Fsn1fd/QA==
X-Received: by 2002:a05:6000:402a:b0:42c:a449:d6a5 with SMTP id ffacd0b85a97d-42f89f3d718mr11473038f8f.34.1765302518521;
        Tue, 09 Dec 2025 09:48:38 -0800 (PST)
Received: from redhat.com ([80.230.34.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331092sm33270787f8f.30.2025.12.09.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:48:37 -0800 (PST)
Date: Tue, 9 Dec 2025 12:48:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	oren@nvidia.com, aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio: add driver_override support
Message-ID: <20251209124819-mutt-send-email-mst@kernel.org>
References: <20251208220908.9250-1-mgurtovoy@nvidia.com>
 <20251209113306-mutt-send-email-mst@kernel.org>
 <49a3aabb-eb28-4149-b845-1bc5afffb985@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <49a3aabb-eb28-4149-b845-1bc5afffb985@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mRiMuGddKcr4zXjp3gS-bSjb5x76YZ6LxUs1rYw3pZg_1765302519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 09, 2025 at 07:45:19PM +0200, Max Gurtovoy wrote:
> 
> On 09/12/2025 18:34, Michael S. Tsirkin wrote:
> > On Tue, Dec 09, 2025 at 12:09:08AM +0200, Max Gurtovoy wrote:
> > > Add support for the 'driver_override' attribute to Virtio devices. This
> > > allows users to control which Virtio bus driver binds to a given Virtio
> > > device.
> > > 
> > > If 'driver_override' is not set, the existing behavior is preserved and
> > > devices will continue to auto-bind to the first matching Virtio bus
> > > driver.
> > oh, it's a device driver not the bus driver, actually.
> 
> Yes. I'll fix the commit message.
> 
> 
> > 
> > > Tested with virtio blk device (virtio core and pci drivers are loaded):
> > > 
> > >    $ modprobe my_virtio_blk
> > > 
> > >    # automatically unbind from virtio_blk driver and override + bind to
> > >    # my_virtio_blk driver.
> > >    $ driverctl -v -b virtio set-override virtio0 my_virtio_blk
> > > 
> > > In addition, driverctl saves the configuration persistently under
> > > /etc/driverctl.d/.
> > what is this "mydriver" though? what are valid examples that
> > we want to support?
> 
> This is an example for a custom virtio block driver.
> 
> It can be any custom virtio-XX driver (XX=FS/NET/..).

Is "custom" a way to say "out of tree"?

> > > Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > > 
> > > changes from v1:
> > >   - use !strcmp() to compare strings (MST)
> > >   - extend commit msg with example (MST)
> > > 
> > > ---
> > >   drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
> > >   include/linux/virtio.h  |  4 ++++
> > >   2 files changed, 38 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index a09eb4d62f82..993dc928be49 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -61,12 +61,41 @@ static ssize_t features_show(struct device *_d,
> > >   }
> > >   static DEVICE_ATTR_RO(features);
> > > +static ssize_t driver_override_store(struct device *_d,
> > > +				     struct device_attribute *attr,
> > > +				     const char *buf, size_t count)
> > > +{
> > > +	struct virtio_device *dev = dev_to_virtio(_d);
> > > +	int ret;
> > > +
> > > +	ret = driver_set_override(_d, &dev->driver_override, buf, count);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static ssize_t driver_override_show(struct device *_d,
> > > +				    struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct virtio_device *dev = dev_to_virtio(_d);
> > > +	ssize_t len;
> > > +
> > > +	device_lock(_d);
> > > +	len = sysfs_emit(buf, "%s\n", dev->driver_override);
> > > +	device_unlock(_d);
> > > +
> > > +	return len;
> > > +}
> > > +static DEVICE_ATTR_RW(driver_override);
> > > +
> > >   static struct attribute *virtio_dev_attrs[] = {
> > >   	&dev_attr_device.attr,
> > >   	&dev_attr_vendor.attr,
> > >   	&dev_attr_status.attr,
> > >   	&dev_attr_modalias.attr,
> > >   	&dev_attr_features.attr,
> > > +	&dev_attr_driver_override.attr,
> > >   	NULL,
> > >   };
> > >   ATTRIBUTE_GROUPS(virtio_dev);
> > > @@ -88,6 +117,10 @@ static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
> > >   	struct virtio_device *dev = dev_to_virtio(_dv);
> > >   	const struct virtio_device_id *ids;
> > > +	/* Check override first, and if set, only use the named driver */
> > > +	if (dev->driver_override)
> > > +		return !strcmp(dev->driver_override, _dr->name);
> > > +
> > >   	ids = drv_to_virtio(_dr)->id_table;
> > >   	for (i = 0; ids[i].device; i++)
> > >   		if (virtio_id_match(dev, &ids[i]))
> > > @@ -582,6 +615,7 @@ void unregister_virtio_device(struct virtio_device *dev)
> > >   {
> > >   	int index = dev->index; /* save for after device release */
> > > +	kfree(dev->driver_override);
> > >   	device_unregister(&dev->dev);
> > >   	virtio_debug_device_exit(dev);
> > >   	ida_free(&virtio_index_ida, index);
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index db31fc6f4f1f..418bb490bdc6 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -138,6 +138,9 @@ struct virtio_admin_cmd {
> > >    * @config_lock: protects configuration change reporting
> > >    * @vqs_list_lock: protects @vqs.
> > >    * @dev: underlying device.
> > > + * @driver_override: driver name to force a match; do not set directly,
> > > + *                   because core frees it; use driver_set_override() to
> > > + *                   set or clear it.
> > >    * @id: the device type identification (used to match it with a driver).
> > >    * @config: the configuration ops for this device.
> > >    * @vringh_config: configuration ops for host vrings.
> > > @@ -158,6 +161,7 @@ struct virtio_device {
> > >   	spinlock_t config_lock;
> > >   	spinlock_t vqs_list_lock;
> > >   	struct device dev;
> > > +	const char *driver_override;
> > >   	struct virtio_device_id id;
> > >   	const struct virtio_config_ops *config;
> > >   	const struct vringh_config_ops *vringh_config;
> > > -- 
> > > 2.18.1

