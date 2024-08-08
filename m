Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0C18D651
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117069; cv=none; b=VswSKEJWBWJYstqa0o40Q0i9X/yRdZ5mkASZKx+9Wz+CitYhzgQpl6c96XXs34su0JTksVOhJo+9BvK78QjMs6LDQigG019awEY3d0V6w523okAm3nrTxNbGX/TyTCb2ZxfNavcTsBk8lGkCSr1KJG1PjuRiFljkLDIjB6YnlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117069; c=relaxed/simple;
	bh=PcDtehXPOnRp+0v2GaOgoZgVtGYtvFdOku2SbV4p6wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so0Nhx7ZGtLrlygutKRkXPzSZzITclo2d/inKh5aqxV5MSTFYAE4CBVb0DakilI7c6fQKH/pECf0wIz7ez2ilndXQHwqgOVXB0hkoWxLwMi8iHYwdCa36SrEvmy1UAAQc4JRNjX9V0m/6RfP/ZTBRoqAdILdayldssSvi+1kV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wGMGDW07; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wGMGDW07"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so6339305e9.2
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723117064; x=1723721864; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYjuaeJy2Pvg9rMTABhna8aZrftptocvWC4VLyaxXc4=;
        b=wGMGDW07otoRYUDo5TkfjvP21lt7y/1JlGsTZy9M1e2DfMw/QbcjYTkRyP7suH2QOz
         tTik6wHiCrzMPV8bTvYKaqgk7AzwiXy785ePdOQQ1v0ah3QSwdbSdFfZOD/hH15rM/Np
         Aq8inAJ873/b98lNzHQYJtkq15VS3TyEo8juVAzffDfkckHOYzcLTC4f/LmT50+rn2yM
         LQLMQAE7nO6HZckbxuYOd8p9PLKNfJuu5kX6xGd5jf8Jfb4lgaODl8bAFGAb4bc/aVW1
         z8lK7kIjKbrXLPwKG00Ri71t1VQ3piXDRt1KQcXI+h7rSzjlNg9/Txm6zd0TEHyuJuXX
         b50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117064; x=1723721864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYjuaeJy2Pvg9rMTABhna8aZrftptocvWC4VLyaxXc4=;
        b=l3pZVXCQeMIFszJkh4h8y/gf4+llz70PaWJLSnIb0eSaINYsWc6sXw6+1cfhnNKYXD
         HxQruPzbkAJ2KsnTxUINxG366cBYpVpS0rV3EvdgGV/BE/DDUKexfoycu31zn9OXIIfo
         RmpfiyxMW8WsF/5oljsjPY9/4pkMzCPy03JERaacmW2vSn0nYc0BXKTAJZPl68PekVPt
         5uSF0ToeuigggZHISbrBFt5oULC00yv7lwmR0qOK5QTB0kJykPe1uLpdL00SbsRcotTZ
         t6R7kMSDaPTQ+XHf6tkdrsfIXtB0slGMvVD7rw4UvBUyFBUCeSYBbDxTpXK1+m0T+Zmd
         S2QA==
X-Forwarded-Encrypted: i=1; AJvYcCV1uWxdsrNfJH+pqIFYi7blu/qa1fXW3cErBbkzevWRQxe2MMHb+VrcNd/0vkfl4SkMDZQD5uWzCFw6I4+pibj87CebPBqip4N1v2RmDZ0=
X-Gm-Message-State: AOJu0YyuVPiG66EA+JDmHpMphbKvyUXlofXW6fMtdQUHRmnZR5qEOr3f
	I+95RMre/VcqjdX4YyBvrQ9APC1PpqVIsw/PMTOD8TZ6XA1X2XvcGIz7vNgwGr0=
X-Google-Smtp-Source: AGHT+IGBaalm8I6v0NRwaz9hlc6hExrICBmkwG4RPAmXg++Ta5D8Vis1zmZkzdJ+0LOm4jWmhw0pRg==
X-Received: by 2002:a05:600c:1d10:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-4290aee068cmr16351235e9.7.1723117063943;
        Thu, 08 Aug 2024 04:37:43 -0700 (PDT)
Received: from localhost ([213.235.133.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d6d3sm18713035e9.6.2024.08.08.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:37:43 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:37:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <ZrSuBlWkE-USicQw@nanopsycho.orion>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>

Thu, Aug 08, 2024 at 09:51:41AM CEST, kirill.shutemov@linux.intel.com wrote:
>Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>accesses during the hang.
>
>	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>	...
>
>It was traced down to virtio-console. Kexec works fine if virtio-console
>is not in use.
>
>Looks like virtio-console continues to write to the MMIO even after
>underlying virtio-pci device is removed.
>
>The problem can be mitigated by removing all virtio devices on virtio
>bus shutdown.
>
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>

Could you provide a "Fixes:" tag pointing to the commit that introduced
the bug?



>---
> drivers/virtio/virtio.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index a9b93e99c23a..6c2f908eb22c 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> 	of_node_put(dev->dev.of_node);
> }
> 
>+static void virtio_dev_shutdown(struct device *_d)
>+{
>+	struct virtio_device *dev = dev_to_virtio(_d);
>+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>+
>+	if (drv && drv->remove)
>+		drv->remove(dev);
>+}
>+
> static const struct bus_type virtio_bus = {
> 	.name  = "virtio",
> 	.match = virtio_dev_match,
>@@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> 	.uevent = virtio_uevent,
> 	.probe = virtio_dev_probe,
> 	.remove = virtio_dev_remove,
>+	.shutdown = virtio_dev_shutdown,
> };
> 
> int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>-- 
>2.43.0
>
>
