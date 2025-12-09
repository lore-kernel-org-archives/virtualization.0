Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDD3016F3
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304672; cv=none; b=AMpHW79s9+96JBGJLnAoNma+1//JjS9Will0rDVbhSBa6/6YqDcdvh88OwfSOzUx6FhYXmIzyXTNHNkt//rKjqEGzoG3h8dk1DYSe0RonXDMAYI9dMSbpgcmRJPRZYDQJIlwhXqRLUFv/9vzkLYqvF9iFV3ai+obUbolPJMNGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304672; c=relaxed/simple;
	bh=1VHf9csxRdUdp3601l4R7AIy9z/7AEjDyrvpyUT3F8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nFIoct8bBgXHLVgGKRvkQ0LQBcovDrU6uKKYjHusW6WtqA13i1Mg4Iaz1vwRdWwCM7cIZ08/fR1Smf0A7ZpHuM5BR+wodrIHtzGXHd5618hh/Y9CkduLMliAaiad09GQUu6JYrEE+05HxL7baIFR1QmSSd5qW3xF2w2A+i8dtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqOkfMNf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqOkfMNf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033FE80CFE
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 18:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhCcamo5R4jq for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 18:24:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EAC0580CC1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAC0580CC1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cqOkfMNf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EAC0580CC1
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765304667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USk9jSaWQvYUDmDx9daRJ6IHaYeMNOUxJLYi+6sv0Co=;
	b=cqOkfMNfiRZ3ovlHWb78Cd8CvAmQ+oaJjQRBDiulm+HYsY/Uf+vygFel/8v8zlHUDU6OHY
	nXOBXpG2oHu9kJkjkOCXbASbKOS0TZun4XIrURbfAwbbNkrcJKNdWHZKjWclxkv+gQlr92
	AQ+hjl4YubjlhA4lOeeTNF9+FyCBXds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-hEmaoTnRMVO07ePW64YLQQ-1; Tue, 09 Dec 2025 13:24:17 -0500
X-MC-Unique: hEmaoTnRMVO07ePW64YLQQ-1
X-Mimecast-MFC-AGG-ID: hEmaoTnRMVO07ePW64YLQQ_1765304656
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47777158a85so72333145e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 10:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765304656; x=1765909456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USk9jSaWQvYUDmDx9daRJ6IHaYeMNOUxJLYi+6sv0Co=;
        b=SOqm/skybzFYe8jvKEBD8NojpM5wqqbxIgGP72Cm+beAlqqqK6pQ3aw7CAblhqmsKv
         L7IQhxhCuw80d1iCBv1w76smInd6/YWO7dQ+Yp3c4xjWw6JoLs3+7BwSDhrfM5Cz2BEu
         EhoH8SfIYLhQ1PBJoEJDqNBlafDL3qmAZ2vSR2q23f82iv6biq8I0DWuexvTXABGRV3S
         p4u6F6hzb2Wd8itCeYCXVunTfzUNtG4ZiZqd8NrC5PdEkRz+7/7E4BvvIHd4NUp/iuwq
         az6pG8XykUbQVSqyJDtROMZz/u2PIIodScgQYQgF79PJAqJG1XMIzp4YnyjzHwP+RpgV
         /p2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9lSsMEXMrnSbbH/AJ12cE9F8u71pj5ljDQhgCvnh+VLMb6ANGPq/pYI2ab9s2iBlt6EZ9f8kezgwfQbBHsg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxzTOPM7HkWQlLJjR8zvfhC8lBRuxZg0y4qdUimdUShniAhbCpj
	qItAp0mnI9GRaI7z/lxo9LVYds8K0X49GO4Dpbb9kFCeEnFM55OOr7k4Kq0XJ/6gjtQ2HZHzvpz
	bVtlsthxVdm4+Oz0RRTeA7fa2RT38inuU5ggmcCIQ+yJzXMgPzB6QI1FM9ss2oGszxKr0i7S3WE
	PIfbcKQks=
X-Gm-Gg: ASbGncslhuXtylwPECXtV73zeLgCl4T8Xmb7eAk9yfMXcXfsn5PpL1pbvY0lMFAhe5i
	M87NQiJDMgjjsc0PJ2q7nEVcV5nwrLkDgBkPp3FBXVie6A7Z5j+JQH5OZ4FSsMUa1iauowQ+B0x
	NP7/TLWLJiZixwMexRkGz7nsi5DgXYYz4LPQWHrikvE2jU4NwQAYXeqbJNFqvhw3toZ3Jor7Gxk
	B7vONZcj36rOCOBhKa9vxO4lbchalB8CMUKmdqvDkVpTo9Q4/rZRKP8PBm+Bg3Zi6/vYUz+NrVy
	kcaOoFAMNLEqWj0MeUMqGwY4d6VUKgk+cstyApz2kudc/6nM00GRftUguq9Xq0xJ1WSPVvCse3v
	R
X-Received: by 2002:a05:600c:4f54:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47939e48e88mr105233275e9.32.1765304655663;
        Tue, 09 Dec 2025 10:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2N1U/qfn+cqUhT/IdKlmaO0Dfp9eCxkzBOQ6EPjCrkLOr7GnqGDK1Xhz5Rxxc3o/HgqTw+Q==
X-Received: by 2002:a05:600c:4f54:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47939e48e88mr105233085e9.32.1765304655197;
        Tue, 09 Dec 2025 10:24:15 -0800 (PST)
Received: from redhat.com ([80.230.34.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d910b2sm3071355e9.14.2025.12.09.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:24:14 -0800 (PST)
Date: Tue, 9 Dec 2025 13:24:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	oren@nvidia.com, aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio: add driver_override support
Message-ID: <20251209132326-mutt-send-email-mst@kernel.org>
References: <20251208220908.9250-1-mgurtovoy@nvidia.com>
 <20251209113306-mutt-send-email-mst@kernel.org>
 <49a3aabb-eb28-4149-b845-1bc5afffb985@nvidia.com>
 <20251209124819-mutt-send-email-mst@kernel.org>
 <df0d1e2e-a496-416a-8cfc-22d69ad4c37b@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <df0d1e2e-a496-416a-8cfc-22d69ad4c37b@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4QCoR3a9PPAaKhgZETYjCyU8wgQ7W8oGND13dCi_C8_1765304656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 09, 2025 at 08:20:45PM +0200, Max Gurtovoy wrote:
> 
> On 09/12/2025 19:48, Michael S. Tsirkin wrote:
> > On Tue, Dec 09, 2025 at 07:45:19PM +0200, Max Gurtovoy wrote:
> > > On 09/12/2025 18:34, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 09, 2025 at 12:09:08AM +0200, Max Gurtovoy wrote:
> > > > > Add support for the 'driver_override' attribute to Virtio devices. This
> > > > > allows users to control which Virtio bus driver binds to a given Virtio
> > > > > device.
> > > > > 
> > > > > If 'driver_override' is not set, the existing behavior is preserved and
> > > > > devices will continue to auto-bind to the first matching Virtio bus
> > > > > driver.
> > > > oh, it's a device driver not the bus driver, actually.
> > > Yes. I'll fix the commit message.
> > > 
> > > 
> > > > > Tested with virtio blk device (virtio core and pci drivers are loaded):
> > > > > 
> > > > >     $ modprobe my_virtio_blk
> > > > > 
> > > > >     # automatically unbind from virtio_blk driver and override + bind to
> > > > >     # my_virtio_blk driver.
> > > > >     $ driverctl -v -b virtio set-override virtio0 my_virtio_blk
> > > > > 
> > > > > In addition, driverctl saves the configuration persistently under
> > > > > /etc/driverctl.d/.
> > > > what is this "mydriver" though? what are valid examples that
> > > > we want to support?
> > > This is an example for a custom virtio block driver.
> > > 
> > > It can be any custom virtio-XX driver (XX=FS/NET/..).
> > Is "custom" a way to say "out of tree"?
> 
> The driver_override mechanism fits both in-tree/out-of-tree drivers.

good to know.  which in tree drivers can use it?
this is the part that's missing in the commit log.

thanks


> > 
> > > > > Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > > 
> > > > > changes from v1:
> > > > >    - use !strcmp() to compare strings (MST)
> > > > >    - extend commit msg with example (MST)
> > > > > 
> > > > > ---
> > > > >    drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >    include/linux/virtio.h  |  4 ++++
> > > > >    2 files changed, 38 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index a09eb4d62f82..993dc928be49 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -61,12 +61,41 @@ static ssize_t features_show(struct device *_d,
> > > > >    }
> > > > >    static DEVICE_ATTR_RO(features);
> > > > > +static ssize_t driver_override_store(struct device *_d,
> > > > > +				     struct device_attribute *attr,
> > > > > +				     const char *buf, size_t count)
> > > > > +{
> > > > > +	struct virtio_device *dev = dev_to_virtio(_d);
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = driver_set_override(_d, &dev->driver_override, buf, count);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return count;
> > > > > +}
> > > > > +
> > > > > +static ssize_t driver_override_show(struct device *_d,
> > > > > +				    struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	struct virtio_device *dev = dev_to_virtio(_d);
> > > > > +	ssize_t len;
> > > > > +
> > > > > +	device_lock(_d);
> > > > > +	len = sysfs_emit(buf, "%s\n", dev->driver_override);
> > > > > +	device_unlock(_d);
> > > > > +
> > > > > +	return len;
> > > > > +}
> > > > > +static DEVICE_ATTR_RW(driver_override);
> > > > > +
> > > > >    static struct attribute *virtio_dev_attrs[] = {
> > > > >    	&dev_attr_device.attr,
> > > > >    	&dev_attr_vendor.attr,
> > > > >    	&dev_attr_status.attr,
> > > > >    	&dev_attr_modalias.attr,
> > > > >    	&dev_attr_features.attr,
> > > > > +	&dev_attr_driver_override.attr,
> > > > >    	NULL,
> > > > >    };
> > > > >    ATTRIBUTE_GROUPS(virtio_dev);
> > > > > @@ -88,6 +117,10 @@ static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
> > > > >    	struct virtio_device *dev = dev_to_virtio(_dv);
> > > > >    	const struct virtio_device_id *ids;
> > > > > +	/* Check override first, and if set, only use the named driver */
> > > > > +	if (dev->driver_override)
> > > > > +		return !strcmp(dev->driver_override, _dr->name);
> > > > > +
> > > > >    	ids = drv_to_virtio(_dr)->id_table;
> > > > >    	for (i = 0; ids[i].device; i++)
> > > > >    		if (virtio_id_match(dev, &ids[i]))
> > > > > @@ -582,6 +615,7 @@ void unregister_virtio_device(struct virtio_device *dev)
> > > > >    {
> > > > >    	int index = dev->index; /* save for after device release */
> > > > > +	kfree(dev->driver_override);
> > > > >    	device_unregister(&dev->dev);
> > > > >    	virtio_debug_device_exit(dev);
> > > > >    	ida_free(&virtio_index_ida, index);
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index db31fc6f4f1f..418bb490bdc6 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -138,6 +138,9 @@ struct virtio_admin_cmd {
> > > > >     * @config_lock: protects configuration change reporting
> > > > >     * @vqs_list_lock: protects @vqs.
> > > > >     * @dev: underlying device.
> > > > > + * @driver_override: driver name to force a match; do not set directly,
> > > > > + *                   because core frees it; use driver_set_override() to
> > > > > + *                   set or clear it.
> > > > >     * @id: the device type identification (used to match it with a driver).
> > > > >     * @config: the configuration ops for this device.
> > > > >     * @vringh_config: configuration ops for host vrings.
> > > > > @@ -158,6 +161,7 @@ struct virtio_device {
> > > > >    	spinlock_t config_lock;
> > > > >    	spinlock_t vqs_list_lock;
> > > > >    	struct device dev;
> > > > > +	const char *driver_override;
> > > > >    	struct virtio_device_id id;
> > > > >    	const struct virtio_config_ops *config;
> > > > >    	const struct vringh_config_ops *vringh_config;
> > > > > -- 
> > > > > 2.18.1

