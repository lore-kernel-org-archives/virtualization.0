Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7B4A13A4
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712844; cv=none; b=kTMTf5thTVWr46rtmV87QlqaIoYyIzcsVRLFFuVCwHpgZI4pL6sFiuUJWtCymuQ3GRR9vTJQNhimoowR9Lx0Pq+QFKGi8xAx75blTxPcnziacbwk3MYvQkZjDAkTWpTcyX+m7nmYqoTjAbG+3J/soIyo+GYk/gyoxzulTjSIOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712844; c=relaxed/simple;
	bh=Q/VQLDYuv3Qa36N0Bsx4Z2oeix7QxD0WlUSTfViRmOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brm67hjt/sreHreN/LMA35BehJEJKTmEHGtxZ/OzUlLxlHzWY84pTfspVDW9WiqLW2pugA7FRBvPrtzYZyzGICNJyCbT/GC/n08dA8cHBBvY0q3IQXSeOANsnl/wmjjntBJTzoZ96fk2fGLZqAac5rXRdKB7Jyu+Fl+aOQSbN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QYVkPHAc; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QYVkPHAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781712803; x=1782317603; i=markus.elfring@web.de;
	bh=SE7ZEe6DsVeOYvkxzp1pJK9BKo3pmQnykg6xizDslEM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QYVkPHAcWNBuqCihma2VVcPzmwd30NK+Gl16DBkOlehLlDCk/qRDUSiMaeCXbPWW
	 uOClQSXkADUjHqFM9L5miriLNz639Or0QAs+C8QAfR5AiEacjSQ3UgmXk5W3lHU9n
	 JqVLIYbIBBctS3alQu65XBMM6zl/4uoBQtX2hfTcBY5TpPunR4eMP+EBVd9dmQxIV
	 R5PRFBdMaOBxxhaLILUcN/+JT+Cs78PSAfyFan0N1Q74OgmM0b0vl0TPU/GCreRI0
	 NMmLBABNgJzlbrXr4juZ0v896IcbN7Gn9n6ds/lCb1I40PmK6yKE5QyicgTW9J7cG
	 xwcG84ZoxamCz2cmew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1wZbdp3bpj-00AQ0Y; Wed, 17
 Jun 2026 18:13:22 +0200
Message-ID: <8e4ba35a-534d-4eaa-882d-4998b7371f2d@web.de>
Date: Wed, 17 Jun 2026 18:13:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Use common error handling code in two
 functions
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
 <54d6527d-30c2-4e73-846d-c0e5276c8f74@collabora.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54d6527d-30c2-4e73-846d-c0e5276c8f74@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HzJlt0BKkfCkBy/x3J8ajyYblJbRquVnm8XCyF3ffUBklBskKWL
 sGE+SlsxT3pIIE7O/J0WKk4ou5ZSjf9flzKTH1k4xWj79zNA+zwCQorrbJM0UIHcN8PA94c
 6xRsinwsiCuEgXG65j2Qiy5fvkwlufz77IOKysWSVWgALRRbdZTrX9IAAh1XWz6yiaokfkd
 LBG15GtVZR/NSZHHssTZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:taWZajQTDH0=;fIkqod6jpxdxJbjckRi0wXkK777
 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
 PWWZh3+JKRBO/l1Fow=

>> Use additional labels so that a bit of exception handling can be better
>> reused at the end of two function implementations.
=E2=80=A6
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
>> @@ -212,16 +212,12 @@ int virtio_gpu_vram_create(struct virtio_gpu_devi=
ce *vgdev,
>> =20
>>  	/* Create fake offset */
>>  	ret =3D drm_gem_create_mmap_offset(obj);
>> -	if (ret) {
>> -		kfree(vram);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto free_vram;
>> =20
>>  	ret =3D virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
>> -	if (ret) {
>> -		kfree(vram);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto free_vram;
>> =20
>>  	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
>>  					    0);
>> @@ -237,6 +233,10 @@ int virtio_gpu_vram_create(struct virtio_gpu_devic=
e *vgdev,
>> =20
>>  	*bo_ptr =3D &vram->base;
>>  	return 0;
>> +
>> +free_vram:
>> +	kfree(vram);
>> +	return ret;
>>  }
>> =20
>>  void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
>=20
> Please see [1], will be great if you could address the reported issues
> with this patch in v2

Do you indicate that you would prefer an other coding style for the applic=
ation
of goto chains?


>                       and add another patch fixing the
> virtio_gpu_resource_id_get() error handling.
>=20
> [1]
> https://sashiko.dev/#/patchset/b7440806-e9e8-4027-afe1-f6fe9297d8b2%40we=
b.de
Do you request to achieve corresponding resource cleanup after a failed
virtio_gpu_resource_id_get() call by any other function call instead of kf=
ree(vram)?

Regards,
Markus
