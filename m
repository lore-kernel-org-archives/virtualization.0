Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3692B9A8
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170957; cv=none; b=T9ToeikO+dkDBa19OgVroa+00Ub85Ddzf1NOQJidUDVuUXO/7hqvWJs/tAqGxk6Jtgl0W1z1jHkyOFXurfoqA+bAqVVDwVY7ZZ4jSn9k4Fwt1XL3NXK4ETP4WSbi++Cp0hL/FD/ZfJhLWR1JmDXgWDIZfvCmyHlshOzaZquzqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170957; c=relaxed/simple;
	bh=BVkGshfLZRo3RUtCtxfbGAEugaMtmSkFMan5nt8NqAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9OiQUPeNYrBsr7wn/2+6AcZitDr6P+9QrwkZj4wOnVd0FNmlNPBxaBsZrQJzqyZAnZnn0zBWM9DCpjNlWgV/UeXICeUJr5JjCQ2lv9h1ZGWqMuE0DW8eYE0gVxQloYoIwmSNuUlmzxGNacFOtWaUoL8lc8AQaB89jiLU53Sluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FEneRxwv; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FEneRxwv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730170951; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=d4++t/65zzCMffWMYZHpgypTFkZN5PDdFUUWnLn7QBk=;
	b=FEneRxwvfKmZB7mpjfKGaW0z4K6e9BzJkLzQxrPKk92m8AuelggKEHPHH1mZneyT56/LSx2JHRzXczzGoalO6zRRrgNgvLa/s1wvMhZr33SqV8A9mFaRj+P2FluyU9fW2UQMsCVtdTkKkD5GYlTNF33d0rcsPoGz9BIM8hiQfco=
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0WI8R.gg_1730170949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 11:02:29 +0800
Date: Tue, 29 Oct 2024 11:02:29 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH] virtio-pmem: reset device before delete vqs on device
 removal
Message-ID: <20241029030229.GC56926@e18g06458.et15sqa>
References: <20240920090649.42295-1-eguan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920090649.42295-1-eguan@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Sep 20, 2024 at 05:06:49PM +0800, Eryu Guan wrote:
> We should not update virtqueue status while device is in DRIVER_OK
> status, so reset device first then delete vqs.
> 
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>

Hi, any comments on this patch? It also followed what other virtio
devices do.

Thanks,
Eryu

> ---
>  drivers/nvdimm/virtio_pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index c9b97aeabf85..55ffb0e6976b 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -139,8 +139,8 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
>  	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
>  
>  	nvdimm_bus_unregister(nvdimm_bus);
> -	vdev->config->del_vqs(vdev);
>  	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
>  }
>  
>  static unsigned int features[] = {
> -- 
> 2.26.1.107.gefe3874
