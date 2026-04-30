Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261C2DA768
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777589384; cv=pass; b=shfV/Ysh0rXwLO6leauyycT34Z41SboZ2WZCMuBiLPLKYp+Vs1SgYqbQaAvgNF4mZK07XM/oOyc7k2UBS15qLZYQcn8O0v4ZRkhxXlbeICoC3utmQvGEVN1QWPWbdgKN5P9wHOwX4LPvXrKmBUF59j6HnwBDGdS3bYeIJHz4+Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777589384; c=relaxed/simple;
	bh=P4/EsWPXiMnJWB808Ki34Kr4J+2PXQy/pe1VQNdpUr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsNQ1U5YDaXgjoyQWDsXOzxDaQEBaaANC6rcjCDDes3/27z8l65nJr7J3Vz3qr2ucS3JIYAvCKCdOwTikmkf6jTVyZqObYX1eyc5iY0sBFPnvmJYmAmjfOgZ/Ia1DTgc6LU7zpruxq9vwliHE1YJc8hwZY/qX60OIp/8h3PnS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=LgOB2oQ3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="LgOB2oQ3"
ARC-Seal: i=1; a=rsa-sha256; t=1777589373; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ao51FAC8K72kOX0eU+98343y3kIElVEd6FVvxogQE8QgeYQudwpD7ktv9S+4oNLv0flgWwCqtyRs4zHsLPaTv0a7ZgR+SyLcPU/A+yiRawMEzSFeqo2ja0ZqhBW0+GW58/18pVkQzII3Ncnz6FHWdZJSuXuHaVD/0BCUCHci92c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777589373; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wtQedf8kA57FZT4+/T3ghPhkGmrJtXPf+PUEudB759E=; 
	b=idYrBxFKtploVdmOniCXLxfH5hobOTLGzwQPWoJFvFUZCJOJzZWcWM6EJwesrKWyXFgnJRins2QKZiIsFHdrX+tZnO6LIiom3qCrmsgehQkybB7NcVi3cek+bnJuNQ2TjmmbNwJhU1qXVf6A2LnQ1Z/SarxbaVOufbptlC8WubU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777589373;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wtQedf8kA57FZT4+/T3ghPhkGmrJtXPf+PUEudB759E=;
	b=LgOB2oQ3dXsZYg5sP0ePh17Oyqr4p+bSoIODW0TMmGOdB1UhF0kG421+MvewG3X1
	ttDAroACj9nmnPgYgS+RvPnzHjGXjjwGmLWisKARVZxl8zONm/k+y2rUyDjYrpvD9MK
	pGGZSNtrHSgljHEQgWeEPnlNfTkA3NmXgSdBajvA=
Received: by mx.zohomail.com with SMTPS id 1777589370669654.7406887211924;
	Thu, 30 Apr 2026 15:49:30 -0700 (PDT)
Message-ID: <adc4edee-bc5e-4a65-86d0-c20b47aaa3d9@collabora.com>
Date: Fri, 1 May 2026 01:49:25 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtgpu: Add PM support for suspend/resume
To: =?UTF-8?B?TW9ycmlzIFBhbiAo5r2Y5rOw54K6KQ==?= <Morris.Pan@mediatek.com>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "olvaffe@gmail.com" <olvaffe@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 Dongwon Kim <dongwon.kim@intel.com>
References: <20260401061050.1035881-1-morris.pan@mediatek.com>
 <2175a05a-d83f-4252-bbf8-581ae652a6b8@collabora.com>
 <26884a5a6043ce2d146456644cd7e37278b0edb0.camel@mediatek.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <26884a5a6043ce2d146456644cd7e37278b0edb0.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/17/26 12:40, Morris Pan (潘泰為) wrote:
> On Wed, 2026-04-08 at 15:59 +0300, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 4/1/26 09:10, Morris Pan wrote:
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> index a5ce96fb8a1d..fbca0a82958c 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> @@ -145,6 +145,40 @@ static void virtio_gpu_config_changed(struct
>>> virtio_device *vdev)
>>>  	schedule_work(&vgdev->config_changed_work);
>>>  }
>>>  
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int virtgpu_freeze(struct virtio_device *vdev)
>>> +{
>>> +	vdev->config->del_vqs(vdev);
>>> +	virtio_reset_device(vdev);
>>> +
>>> +	return 0;
>>> +}
>>
>> VirtIO-GPU shouldn't be reset freely. See [1] and follow previous
>> hibernation-support discussions on the ML.
>>
>> [1[
>> https://lore.kernel.org/dri-devel/20260107182745.229481-1-dongwon.kim@intel.com/
>>  
>>
> 
> Hi Dmitry,
> 
> Thank you for the guidance and for pointing me to that thread.
> 
> I have looked into the series you mentioned, specifically "PATCH v7
> 1/3: drm/virtio: Freeze and restore hooks to support suspend and
> resume" (link).
> I have verified that this change resolves the issue I was experiencing
> in my envirronment.
> 
> I will keep an eye on that series and follow its progress. Thank you
> for your time and help.

You're welcome. There is now v8 sent by Kim [2], feel free to test it
and reply with your review and/or tested-by on the patches.

[2]
https://lore.kernel.org/dri-devel/20260429204729.993669-1-dongwon.kim@intel.com/

-- 
Best regards,
Dmitry
