Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9E261393
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274585; cv=pass; b=LiZRUeFjge2oN2J243lBqPvRUAFyOy8W+LeyyUuvWi4g6p50QLkDDJgFPifCf61W82nhg1C3/A9uXTOjD3lanzVlKqbzizv78zVRsrSeCApKufDlhfa4JlwF4n9VbuK87d4TNjc6ijfCkPjnMTu9Ko3xAKhZvvjx0z6wtV9j8ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274585; c=relaxed/simple;
	bh=I1mQjMeK28JYucEOXoxHCd5EHqf6M7LfIK2vtDelMLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIsrvXLN3HtqJiNEErLyyudlIVuBe7eN97bMn75tozzCE06n7/SN6wQTmbhb7e1be+QNZrNrm1Ej/fy0qXqq3fD+gQf2VX2b9Di+RgHqJ+zMHOUEmUkEWL42yiJDmEUXOsHZhL4c0wnKMX+9Ig1IQtmhsgqiOjg7fgaUoSnNbrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=amI7bFHU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="amI7bFHU"
ARC-Seal: i=1; a=rsa-sha256; t=1761274566; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LJA2ABNV41zIY3utHxeq8c6PDeAXksAej7Mxxw2N+ycQpU6uQtaZntEDuBUgmClLmzBsxKDqKk16LXxqQXiHeamZ1pyaAWI0K1Ond+2Yt9IEH9U4REG5JNxSzS9NG4/Bu2K/jfYcYkLZ1VAmrRr0bKzFwiK4S9xs4LHO+XQZgPI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761274566; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/mv8dm4RzElIaT09+m1z1YwB5+HyUL5t0yLE2IDW2XI=; 
	b=leqjlDTdx0uKcdYzsAMonJsQjEFQE09fyKzgNFztJszE/hVLSOJhO4O9ZOgXXtEtplqVL5CC3RFr4QuahLniQ3oYS/ANZzyfKIcflSxHscNOKeFmZH8xT3A18wG9Jl4GPw5bmMca9ziUfTqFIGD0Gidxait6zpaEaCZOJtRbgdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761274566;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/mv8dm4RzElIaT09+m1z1YwB5+HyUL5t0yLE2IDW2XI=;
	b=amI7bFHUiidcuH2K/kW1JLwQ5dw0JcJv4WxT96f2Wj1SStyAzux6JUjmVfoTDrYQ
	eEiH3NaUNSXohedGShradk5r62FADbIVIsTtfeoibZbWpN8vtZ3j1jYgEEKe8YFL5RK
	Q60Bsl2Z8JJ+iID3x64VpW6qfRnR28GjN/SbJBzM=
Received: by mx.zohomail.com with SMTPS id 1761274563811118.4337829556714;
	Thu, 23 Oct 2025 19:56:03 -0700 (PDT)
Message-ID: <8ac5053a-5f76-4145-a2f6-6bdd8316163e@collabora.com>
Date: Fri, 24 Oct 2025 05:55:59 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] drm/virtgpu: Make vblank event dependent on the host
 resource
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20251016145230.79270-1-tzimmermann@suse.de>
 <IA0PR11MB7185A7BA7B8CEAC46CBC0922F8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <21851b98-06ee-4e2c-8570-70e8a4fe5d86@suse.de>
 <afc6ba14-cd95-49b9-89f5-e90fd19c8927@collabora.com>
 <a2afbc13-0be6-46ef-a6da-9461fd30376b@collabora.com>
 <126a0b10-a550-430c-a1b3-7e144461a0ff@suse.de>
 <IA0PR11MB71850CA585D6E42C1E7217DDF8F3A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c6b44524-4e44-46e8-89b4-8f90e074431b@collabora.com>
 <84de3c82-638a-412c-8e25-9ff507d59400@suse.de>
 <IA0PR11MB7185DCAF9132F2CD92E42620F8F0A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <IA0PR11MB7185DCAF9132F2CD92E42620F8F0A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/23/25 09:22, Kasireddy, Vivek wrote:
> Also, I think you might want to limit the plane sync to host mechanism to just guest
> blobs only because based on what Dmitry said the vblank timer helps in virgl/venus/
> native context use-cases. That is,
> @@ -138,7 +140,7 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
>         for (i = 0; i < new_plane_state->fb->format->num_planes; ++i) {
>                 struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(new_plane_state->fb->obj[i]);
> 
> -               if (bo->host3d_blob || bo->guest_blob) {
> +               if (bo->guest_blob && !vgdev->has_virgl_3d) {

Checking for obj->import_attach should be enough if it's only prime
sharing that doesn't work properly with vblank timer.

Please verify that only prime needs the workaround and send the updated
patch.

-- 
Best regards,
Dmitry
