Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8BEBA27
	for <virtualization@lists.linux.dev>; Mon,  4 Mar 2024 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531425; cv=none; b=c1fipOtcZfwo/1UP8rMlUVLYdvo6DWaTcsqOvZKS0IHqzyrmTeIcIzD+Vi/2iVdwMGjXLqxsyh6INnLag+F7wc/d5aJy+qNLH+5cvn4pDFWZOYXJouBlzFQuQZVmPAxKGaG1vxeP+bCGc7Db5j3dHeKNv/a+ZyLuiXAeANmTPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531425; c=relaxed/simple;
	bh=VvbSdOMNJSebGc+jMRFtjZVeWGkuAafHh9zPMv+XCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXRqtJnNKEsSmgvi6BlN2XK+8Qvt2Z3pyEGq8VgPLN9xGv9CJ2S1vUbPBTfRjOpQx74foHC043GYJN/kokmM7kIpEisQp/rj7nm74uQoJvUX17oRMMAUhCWwpcp3EHt3Ph3HR4aCrjYZZJ1B1y4pWGcZz74mdl2lAcRFmNgURxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyuZU0ja; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VyuZU0ja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709531424; x=1741067424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VvbSdOMNJSebGc+jMRFtjZVeWGkuAafHh9zPMv+XCbY=;
  b=VyuZU0jaIJU5VGNURjFr8sFlOHiGLa7IHCcqOn24/aVBVCENbTB5x/RN
   Vw+LzbGjjGt9nzg+LEjsbpPUKcti4xxQgP0J+KrZHzD6b4L/YRdu1DnPU
   C819YEqtN5d8MZoFWHz3qM0yngC3mCTP/hpa5dVpAGyiyjD/HNj/a9E7f
   rd3fd1omuIlEBGp/DRBeuNBESObZFtJfK1wrstEP/CTRq3pK0hXS8IMYR
   djdm+p7cQz11lAE0bqCzlPLvyBIEh+HDRA5IuoaF69Jfim1bw4BWhR1VZ
   7k0xKoJc64xNigfGiT1K6tK8QVBX02H/7A5bpu1mMeWZr1J6PGv1zWKhr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="6957611"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="6957611"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8756822"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.238.225.182]) ([10.238.225.182])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:50:22 -0800
Message-ID: <09fbc96c-9083-4280-b64e-e5159279b4ce@intel.com>
Date: Mon, 4 Mar 2024 13:50:18 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
Content-Language: en-US
To: jasowang@redhat.com, mst@redhat.com
Cc: virtualization@lists.linux.dev
References: <20240227144519.555554-1-lingshan.zhu@intel.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240227144519.555554-1-lingshan.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle Ping

Thanks
Zhu Lingshan

On 2/27/2024 10:45 PM, Zhu Lingshan wrote:
> This commit applies maintainer role of Intel vDPA
> driver for myself.
>
> I am the author of this driver and have been contributing to
> it for long time, I would like to help this solution evolve
> in future.
>
> This driver is still under virito maintenance.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..128ec843eb19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10365,8 +10365,10 @@ F:	include/net/nl802154.h
>   F:	net/ieee802154/
>   F:	net/mac802154/
>   
> -IFCVF VIRTIO DATA PATH ACCELERATOR
> -R:	Zhu Lingshan <lingshan.zhu@intel.com>
> +Intel VIRTIO DATA PATH ACCELERATOR
> +M:	Zhu Lingshan <lingshan.zhu@intel.com>
> +L:	virtualization@lists.linux.dev
> +S:	Supported
>   F:	drivers/vdpa/ifcvf/
>   
>   IFE PROTOCOL

