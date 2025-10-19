Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF931F875A
	for <virtualization@lists.linux.dev>; Sun, 19 Oct 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893843; cv=pass; b=bjb8qeZwOLq1vldqERb/cS++icoohb5UFrXA/EaKjn2ed6VmlJTed0if1EzQApzTTbuGMBlZNv6ytvIJQCGy8fxsgm9Hmmc/ryxi4lH7ewe7/MpCNDDs/8/IVZfFqSOqqk84ohcSnkcl3VlPTYbD7XW+EwcZfmjoGPib7jHm9hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893843; c=relaxed/simple;
	bh=TNld/pJCDCwvcj8B8XZI70E81Jn7j+sokVz3AKEwOAk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HLEOjEY6ewrUOitmlltaHZDRhNzSoICEWv4OM0JbFbQypdcDW53axsNracU5Cp8FsBzlucP1KHCOOJJaWL4579bYXW39SyBgp/RYi38JrjPuoDdPBcdhcqaGWuzApYtAKUSk8M7wr1BLcci6Jm4n4rBDh8TMG/8G3N9N32XcXPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=PhnJMMGh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PhnJMMGh"
ARC-Seal: i=1; a=rsa-sha256; t=1760893830; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZPA9Qsd/j+Gm7VyXWHRWnM01ELe8NUv93oBaXadOy0kofPbRs7SI/YvgnxjTUahJQPPJ+MMEvQWOV30O7EmKbn9NeRIzmmx7y/qLZDZEBqrwxLndz+9+J/JZ7tS7ruAxf3e2l12fpSJGHgMryLD7bwwX2H0iVUEI8poEN+l4z+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760893830; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hj8MRhMvdV36TLlnWRPsOcNpHfr2uM+65VDQlMiG0xo=; 
	b=Iwu9dhzGH7O+bF0JquPED2L2rXIakn/lmgZ3Xjl/xRRrvuqffPcjtw5nO1yLXF7hmi/U8kz0iWEuGHhx1FGeXZKNPoyWMMkNvQLCmCCnA5jgAu0zKCd1C0GdVkGQR7f2Cc1AxZei35a/3GFTUfY6SlyxQvMwGuEKTV5UJSZKfkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760893830;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hj8MRhMvdV36TLlnWRPsOcNpHfr2uM+65VDQlMiG0xo=;
	b=PhnJMMGhd2g9jNlCgB7wdEOB1D8NC3DW1BKPJBRXhyw3CGKQ2dTsfyEVou8BbnLV
	I652MHkzcIiqEfC62vlukz/oR643gPB5//3t9BDcCtbonM4bki/4PozgWx2Grph/IRe
	+Pq62TSGqO7A4crmMpnVmFyIQIfuMMX5Cn4zeGKw=
Received: by mx.zohomail.com with SMTPS id 1760893826818943.1538163687636;
	Sun, 19 Oct 2025 10:10:26 -0700 (PDT)
Message-ID: <a2afbc13-0be6-46ef-a6da-9461fd30376b@collabora.com>
Date: Sun, 19 Oct 2025 20:10:21 +0300
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
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20251016145230.79270-1-tzimmermann@suse.de>
 <IA0PR11MB7185A7BA7B8CEAC46CBC0922F8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <21851b98-06ee-4e2c-8570-70e8a4fe5d86@suse.de>
 <afc6ba14-cd95-49b9-89f5-e90fd19c8927@collabora.com>
Content-Language: en-US
In-Reply-To: <afc6ba14-cd95-49b9-89f5-e90fd19c8927@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/17/25 16:58, Dmitry Osipenko wrote:
> Hi,
> 
> On 10/17/25 10:38, Thomas Zimmermann wrote:
> ...
>> There's little difference between the current event handling and the one
>> where no vblanks have been set up. I suspect that the vblank timer
>> callback interferes with the locking in atomic_flush. That would also
>> explain why the fps drop at no clear pattern.
>>
>> Could you please test the attached patch? It enables/disables the vblank
>> timer depending on the buffer resources; as you suggested before.  Does
>> this make a difference?
> 
> The attached patch doesn't work, please see the trace below.
> 
> @Vivek Please clarify whether you only see frames drop with your
> multi-gpu guest-blob setup or with a usual virgl too. I haven't noticed
> problem with frames pacing for virgl and nctx modes yesterday, will
> check again.

On a second look, I now see that this RFC (not the attached) patch
doesn't work properly with host blobs.

I'm getting 100-150fps with this patch applied instead of expected
60fps. Without this RFC patch I'm getting constant 60fps with native
context displaying host blobs.

Not sure why guest blob would behave differently from the host blob.
Suspect something if off with the prime sharing that Vivek uses in the
vfio testing setup. I'd suggest to disable vblank timer only for guest
blobs if no quick solution will be found.

-- 
Best regards,
Dmitry
