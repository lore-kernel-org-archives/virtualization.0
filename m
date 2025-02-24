Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801F18B464
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383357; cv=none; b=BBzn3cxrp1N5v/j3HGkxBA+L5J7hVAIT69G59nGMiqwLOuE/9AEgesOBm8AHWAnU2lMnUu286H3JN5UfM7Yf0q45G0uHwjJixO2+1xkRM+DjpYmUozOu9PVJguKxweaiBK/QIJvpyWICk3aeWFni56sKBdSuWQwYEEMmjCuEBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383357; c=relaxed/simple;
	bh=xStK9CH4TU3I3+rtYUJpOH1tSFucpQmlqd3Apil2Wjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkVRT3MUgpBHcYGnjhuJz8fTxtZSxvLZ5Y16dsD48kEPdiv2Nl+Fjr/Xsel3zc4Wd3PQ+cOVL4f/b58Mo+Hh5sexOZDbATk0mVm2wf9lJH93CVpzTLrJU3hT9u6bcN/PeympPwil/t2mcnwF+VBjb3hyRq8ABDdXkpuo9KJTKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvg3BVkE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvg3BVkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740383354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E00VN6HxPgl9KvZBGjXBkxL6RT0gnJ7DSIyLW3UOh1w=;
	b=Tvg3BVkEF9U+5+aaMI5OjsxOWN/ViYl+KIDvtcOEZZI7NYY/OSRDdOFJEZ7WR6HXyS4OcF
	AxA3WPqb0p/8wXlTEAs2Fr6P9xXpgaCVzE/h/az26tPTZjwyC2Tzkx3eU/k4H4J1vclPKe
	FhFrZdsceSK6pJmrJgbamNgkbCtTIGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-GRWqBtpiO5O9PR0uw8Aq8A-1; Mon, 24 Feb 2025 02:49:12 -0500
X-MC-Unique: GRWqBtpiO5O9PR0uw8Aq8A-1
X-Mimecast-MFC-AGG-ID: GRWqBtpiO5O9PR0uw8Aq8A_1740383351
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399c5baac3so28989055e9.2
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 23:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740383351; x=1740988151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E00VN6HxPgl9KvZBGjXBkxL6RT0gnJ7DSIyLW3UOh1w=;
        b=JTosOznlF1feAAJT8NHsB1cxgFwERh30uDWi4+eXa8YyBtQ8WzX8g+a/Wm55IkK9hS
         DN3GC9cNTo5QPics6Vh55uVjFJe5bgUTh/nTP96RIhGLJntYTz6aQyZUVsV/VwXzMgIH
         z7hgfjf3JAtvnIl7LCG+PqNbqDJ7bzZX+4deKYQ4/pndgMF+sjsT4e5hBOflau9L8BDe
         rIftJ458ergY3r9LyctNWQ3GBii/Kpg5Ckl1HqnGgt8NNeBukVuSGovl2uAJmYs0c9Mi
         DAvv2pnGG05Ur3ovfcpZG6L0unGSPmwkxVVTT0bza8CKkvXWC/wHbgUS/gE/rDYn6Eum
         i0ag==
X-Forwarded-Encrypted: i=1; AJvYcCWGe2WVI+QkCIr9c9vX/G8Ps5MOAze38+U0CLKZkzmKAXzj2WZa5sKOY1wXWUYOQF0m+rx2h7XrD8MZ+zQzyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3AqdnVPqxo9Nc73p/mCo5DaGHKhmer4NEBv77MAg9GwpO+e1/
	1sAvfsII+fpQu4OYUkuAelvbq6Jd1tdnV1+T8Eh3slR+es1MkjX9gVGEhEevwyLisDJ/V3uhJRY
	TqypR1q5njn9tLgZfpH3qLrlCuYS1qoE06ADLEH9aWFkywtyGIzbifB/NC6cBk+Z7
X-Gm-Gg: ASbGncuuY8wKjbpcvIhELuH6D3whQOPbx/C4sOoqltZexDfwnUu0jviwv+2jRYXI9E4
	RLdzu+FQ59w2Wfhyyu0TiM3WhlJ5n6sPMz/rXH7T4UgMZIvPKvOAQujQYpZni9Lpfv0oIH6e1Zr
	4tf3hmluPUtmE2vjvmt/IqzXxnEDyvQoO9KeJVc7snK2NaofbGKey1T6vGb96LNj2DfUAI0QAWo
	wnQoMYOnjt57WUUmmznTTaLNwyVx52zX9JXsb+IJH4P10XDSgwiiJivQrCFJVg9sviAWliW/db+
	iqazeJM+IfinRZFd0p9+OJrWBJlssUTMYdEEVq+M3mBTkjMOla5Y4fLJlg==
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr79412475e9.21.1740383351205;
        Sun, 23 Feb 2025 23:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrYr6P7ROjGu/VT+mFoE6+CidQWRd3kw5YrS7WdRG0vovSVW/3wpDXzVzz04F1ymunuqV9nQ==
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr79412305e9.21.1740383350822;
        Sun, 23 Feb 2025 23:49:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030be6fsm97665715e9.31.2025.02.23.23.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 23:49:10 -0800 (PST)
Message-ID: <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
Date: Mon, 24 Feb 2025 08:49:09 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Hongyu Ning <hongyu.ning@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDyDGgug45HzZL0c9735QpPT9ODyRWAC-pAbJLTPNj8_1740383351
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 2/21/25 12:42 AM, Michael S. Tsirkin wrote:
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
> 
> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> 	...
> 
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.
> 
> The issue is that virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is reset.
> 
> Additionally, Eric noticed that IOMMUs are reset before devices, if
> devices are not reset on shutdown they continue to poke at guest memory
> and get errors from the IOMMU. Some devices get wedged then.
> 
> The problem can be solved by breaking all virtio devices on virtio
> bus shutdown, then resetting them.
> 
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c1cc1157b380..e5b29520d3b2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
>  	of_node_put(dev->dev.of_node);
>  }
>  
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	/*
> +	 * Stop accesses to or from the device.
> +	 * We only need to do it if there's a driver - no accesses otherwise.
> +	 */
> +	if (!drv)
> +		return;
> +
> +	/*
> +	 * Some devices get wedged if you kick them after they are
> +	 * reset. Mark all vqs as broken to make sure we don't.
> +	 */
> +	virtio_break_device(dev);
> +	/*
> +	 * The below virtio_synchronize_cbs() guarantees that any interrupt
> +	 * for this line arriving after virtio_synchronize_vqs() has completed
> +	 * is guaranteed to see vq->broken as true.
> +	 */
> +	virtio_synchronize_cbs(dev);
> +	/*
> +	 * As IOMMUs are reset on shutdown, this will block device access to memory.
> +	 * Some devices get wedged if this happens, so reset to make sure it does not.
> +	 */
> +	dev->config->reset(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.shutdown = virtio_dev_shutdown,
>  };
>  
>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)

