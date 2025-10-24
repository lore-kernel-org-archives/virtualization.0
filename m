Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868326C3AC
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274659; cv=pass; b=XJk9W2AtHlYwOwREEj9dzliT8ayqoX3ZQfjPiPeQEt4q0HXHufax8BJWSW6oyNFEOLQ3MT3dhB/kFNnyIXX9IuaDPemCPqvh9dfskvcEj61DoWaiWSBhmFkQq8unpjGUTbUZf/yisH6Klq47F8a6hHBXk56xglUkls93DoJ6aOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274659; c=relaxed/simple;
	bh=g3f+ckbBZ/FiRylMYIqb6CBSo/xk+p6L58mgkeO+HdQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lI7S8kenJ/DtDLnvLan4OibDq6eW/MPYpicDOtre6mnU8PGSzIw3W3k74m6CkNr2yzwg+vphCfSj2Q2BSTFNiGgiktL25tVIzb5fPAUQKsJNmnhrtNUxLc9kIWFHpZK5e8DJn+g3Juarbek45rIx1CNDUFORXu/Bf9WEHv6623k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HPQa/byz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HPQa/byz"
ARC-Seal: i=1; a=rsa-sha256; t=1761274641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OHeDXFLQLd4ABZUaREQfv34vbwFlv/QoFL3vUjbJ1uuq1X4rNQqWl0DrW81+Vs71i+7opJQrNVPdPhf50KvzZp8wunsHpH6mrK59ZaQuNhO8Y6SoWgGC0cS3Nkw89ExuJbc3CxtjqRedTfJe3jmcCjVMpHlOH/HfX5ag4ulFC5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761274641; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RDwnsfjW/wgiael2ow2RghCG8kQBpH9fQNlJhjxCDh8=; 
	b=kdZV7SSy14xNM6dXs+K9Wstnn6fnseQOL03Dx/OHli5svnBE+VsFTSCkTX316w7nclhjwk99taANEvCfNoDtH7qAT7G61WUYqX7Rao6kLtt8oGzdCQQydSOzbOi1AC7kmFK0EiDLsJAvOaGaGHNKHFnARGRSe+VE+zRDIzD9AQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761274641;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RDwnsfjW/wgiael2ow2RghCG8kQBpH9fQNlJhjxCDh8=;
	b=HPQa/byzsHHFjn2EPp3hEvisHPnOr8HyvPz+17ExUCcORgF703hUIfVUAcD68+WU
	x7EFEEhRXSQisp+2g3MfwcZ/WxnIhloxoUQj8G50Zdlg0N3vpDd46L4JXpD0Hv7umys
	2jDOw6yv9lc2n9Y1mJ9PBqsykoZamnWY0jqexhFw=
Received: by mx.zohomail.com with SMTPS id 1761274639464460.8885606138539;
	Thu, 23 Oct 2025 19:57:19 -0700 (PDT)
Message-ID: <c5aa4544-9ff6-4669-b8d2-f8548c4c4eda@collabora.com>
Date: Fri, 24 Oct 2025 05:57:16 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] drm/virtgpu: Make vblank event dependent on the host
 resource
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
 <8ac5053a-5f76-4145-a2f6-6bdd8316163e@collabora.com>
Content-Language: en-US
In-Reply-To: <8ac5053a-5f76-4145-a2f6-6bdd8316163e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/24/25 05:55, Dmitry Osipenko wrote:
> On 10/23/25 09:22, Kasireddy, Vivek wrote:
>> Also, I think you might want to limit the plane sync to host mechanism to just guest
>> blobs only because based on what Dmitry said the vblank timer helps in virgl/venus/
>> native context use-cases. That is,
>> @@ -138,7 +140,7 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
>>         for (i = 0; i < new_plane_state->fb->format->num_planes; ++i) {
>>                 struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(new_plane_state->fb->obj[i]);
>>
>> -               if (bo->host3d_blob || bo->guest_blob) {
>> +               if (bo->guest_blob && !vgdev->has_virgl_3d) {
> 
> Checking for obj->import_attach should be enough if it's only prime
> sharing that doesn't work properly with vblank timer.
> 
> Please verify that only prime needs the workaround and send the updated
> patch.

Don't forget to add clarifying comment to the code explaining the
workaround.

-- 
Best regards,
Dmitry
