Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF315199A
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990067; cv=pass; b=VIB5BWEcuWSa+7H4xcVVL068KZS1haq6Et78X9TiY1/RkSjzueraF+vrrs5012IcwpwGdLCere49QRe4w+gMDU71+QPBf5uR89fEpSV2l03mVF2SzmwTzlAFqpMeMPIVoiM+5ngcFhc/lUxkBFkWuJnQ7qohL+f5zyGUNJWJL4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990067; c=relaxed/simple;
	bh=91aatJCx7A3UddjmPQi5hOKRpkMLTvZBcFK3UPLoXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzjRThIgbFzj95/37Z9Rk08tASTXdxZyzM/D8BEmUn4IwavoA7rijIB7NhOgZZPaWen0WmCskCFRvRVrNqoCaL0uZ/8JZZyqMEJ0EKOXk2G7hH1wkGrm7TSPuD6sF2Oow7nW3zxbETJ5mockGd1BK/zA+Df+Gx7hQF9/tL6YYjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=C7b1qYoM; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="C7b1qYoM"
ARC-Seal: i=1; a=rsa-sha256; t=1742990047; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KgSFBxidFYS8wsR76dLRI60ogFkOoLXRtvh+dsrfbsEF1qylvk8qEbnn4h9ND+xDc9CrJNqCt1kp53XtvNvA6aS9mxwLvS4/KmW4iYwYf9XJ/DEM2la5Ipm3pXO7MKHN6LMDqZrjVEsY73hIcQ9bW0pCLJNKHO/L1LKWiGgvvIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742990047; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AceXwwk0dg/5R7XIw5oul2ygSeDFRaSA96BeLYqo5pM=; 
	b=njQiBcAByIRup3mqBmEQIqLkpwZmnRDCVo4N30weZFdIi5Ieqh3zyQa2cWcUFro3Kj9K3hKyVk7tPDUuTSlxMqKgmu50/W3nkj96wH+In2+HSkvSX4lj5gf2DbCXN2Wtr8kDnFs3XAnRrYnm0dQAQm6hMeGXu8ycCg3xkfpcdBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742990047;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AceXwwk0dg/5R7XIw5oul2ygSeDFRaSA96BeLYqo5pM=;
	b=C7b1qYoMraqTVE/p4+HACSFAM3pkzupchC001ua9JTLrVZEusvj/voC+NZOBFM/d
	MLoq4faBDdt5kVtuw3IMG2inJmIcwjhnaIImCkNwLx1nRz/VzSpaQ4BFw2rIEvkifNA
	19a7ZDWxA2HROxOg797hvpzBC6htiCp3FOi+fpBU=
Received: by mx.zohomail.com with SMTPS id 1742990044468581.4583932676458;
	Wed, 26 Mar 2025 04:54:04 -0700 (PDT)
Message-ID: <16a30d03-9c98-47a4-959f-8671f7cb7fab@collabora.com>
Date: Wed, 26 Mar 2025 14:54:00 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/virtio: Fix missed dmabuf unpinning in error
 path of prepare_fb()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <20250326014902.379339-1-dmitry.osipenko@collabora.com>
 <20250326014902.379339-2-dmitry.osipenko@collabora.com>
 <IA0PR11MB7185345D3DFA8C7900059144F8A62@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <IA0PR11MB7185345D3DFA8C7900059144F8A62@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/26/25 08:14, Kasireddy, Vivek wrote:
...
>>  static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
>>  				       struct drm_plane_state *new_state)
>>  {
>> @@ -376,23 +386,16 @@ static int virtio_gpu_plane_prepare_fb(struct
>> drm_plane *plane,
>>  		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
>>  						     vgdev->fence_drv.context,
>>  						     0);
>> -		if (!vgplane_st->fence)
>> +		if (!vgplane_st->fence) {
>> +			if (obj->import_attach)
>> +				virtio_gpu_cleanup_imported_obj(obj);
> I think checking for fence allocation failure before import would be much better.
> In other words, cleaning up the fence in case of any import errors would be
> much simpler IMO.
> 
> Regardless,
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com> 

Another question, why do we need this fencing for imported dmabuf?
Fencing isn't done host/guest blobs in this code, while dmabuf is
essentially a guest blob. Could you please clarify why this fence is
needed? Maybe we shouldn't allocate fence in the first place for the dmabuf.

-- 
Best regards,
Dmitry
