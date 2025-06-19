Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F72472A1
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315352; cv=none; b=mRSUoiKKH5yBc9+ep49FF9ld2v/flRpuP53d8NAmB3IMIgf7b1XYjHihBGmZ7wzdRBOLPHZjRiMmESzc5ufR2dnrUk4ksN0v57MdtFtNnnOOnhD/KVCEGmad3W4g6t20yyKIjCvkLDc5aMXE+d/T2p0kZKFNqVtw3wpKcfuo64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315352; c=relaxed/simple;
	bh=e7Ocn6zrexmd6c1PsvepJzsoju7cEdVlt06t113BlmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzpxXHbUN124guD2H3BMVuzqDo+pgiF093kX1nfJf1G7lh0SjGJu9V/iH2fkgzACzo7cTCWrUjXCodVQE901OF32uxqsBuX7n6bC1SJi1J8HuLOTAiiVwgVDTbBtEQCsPVWdp+7Vmy9nieYwu2WIsEEmbdA4jyer0gYdPQdX7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKOkjBP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKOkjBP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750315349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrAK3Pb88d2mMW8Ubsq+AvQbXCBrspP+wLLZy4buj1s=;
	b=MKOkjBP5BBW+kHJedBp8FUTk+i5OOL0XLvau4ZtTaHwHaJOj4az+uzwo8VCaRVsMEMf9xW
	1oXDpjk9Zw9UYj3DUUDLy8xcQptXalH7qCS/ONo8y79IHxG19jWCZGmJz02Z6kglF8kn+B
	y25Nb3lenfhy2aZGMID3LqBkOeyfi8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-OFHPdPjyO7u7fsKrfV4VLg-1; Thu, 19 Jun 2025 02:42:28 -0400
X-MC-Unique: OFHPdPjyO7u7fsKrfV4VLg-1
X-Mimecast-MFC-AGG-ID: OFHPdPjyO7u7fsKrfV4VLg_1750315347
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a578958000so137271f8f.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 23:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750315347; x=1750920147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrAK3Pb88d2mMW8Ubsq+AvQbXCBrspP+wLLZy4buj1s=;
        b=gxgW5Z7/u2xj89OEdfqFtZ0q30M9Vze4/EiXK4A5Hhc1VUOBaoOBgDiQ4qnmDJ1rWk
         opTAybbPoTLuL5QdbMomqmvL+1IwNmMkbVSaq4+vpYihyowrxtd+j/GqS0erEhi7iIiK
         w03pdUB8dFv78bH0s+cqiDZSP8FXOBYF9NwD3qA3HOVAAtRTA9jlj8A7hW4nf0sDw6sQ
         xwoeoEWtFaBDEIqS6SpkskmlYOYY114Eqvulou93/VTqDNnOHKajvpM89V970RjQ1Lhx
         Pl8qsqJ/rrA9TWQwk9VHw7sgffszikQVypFu6AGoamGSz2B+HGhoVL4PEW7y23E3uVpx
         O0UA==
X-Forwarded-Encrypted: i=1; AJvYcCWa3t2T9Qx5Klks7n1L1//o8z6f5p4SFjsGDy3CGmnK6eaKE84xlWyaAfdauEH2q0cj7pfohVAFrEu+3fmNTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAIrkfNhzhSwubLW/RyPfeDtZjY8A6gxWNzFQxqcb1PwTuojB+
	pZp25UHzkRvtv6nD/NN7GXWHmhvHbpcuBzdCBbxvq8hWOpIrd5h1UU6snCeYbzW3ocNlPacuXkt
	CVy7aXKNKMz6fUmXoGIYa+jiZ7igPQ/UHY0/3Wffsys4ylUVuzo+LKtfa32s6Vz783gbA
X-Gm-Gg: ASbGncuh+JSvzDfuggAIsEag22ZpyUNR9etolzvABCnrP+c8yO3kuNykuFo6S0yogiu
	BjOkrd1fdqN1DTGL4t/CwEkjCIoeCiCZJsKet58tMkPOUqbfn+Qj4WYcRwFDjtbyEtfJDxDw2xm
	Fd5AlrOpxOOdabPM9zyVGq1LkwjaIpTQXgdE5G4RgeQqDTuFzR2B4C5OVLiIX41GjHzWWM7ggRm
	Hw2/lHA1Q9430ZsoMN3AaNoCQDItyRmAe+CnahFuCHP90OxDC0bCYDR3Dn7Pi7vf0pGCueeYIrD
	LN54DkXettqs42KPJuVNj7j/8vLD
X-Received: by 2002:a5d:584d:0:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a5723990f6mr15208326f8f.12.1750315346748;
        Wed, 18 Jun 2025 23:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLtHsZYwk8UooadQvsmdpZxfBCgj7PE/RcSNtM8uxppV7BUokDO7d5f9znti0cXjt6rGs2Q==
X-Received: by 2002:a5d:584d:0:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a5723990f6mr15208307f8f.12.1750315346354;
        Wed, 18 Jun 2025 23:42:26 -0700 (PDT)
Received: from [192.168.190.158] ([37.167.112.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7e980sm18260812f8f.41.2025.06.18.23.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 23:42:25 -0700 (PDT)
Message-ID: <d8055c38-a802-4f9d-bc36-56f6c55099d7@redhat.com>
Date: Thu, 19 Jun 2025 08:42:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <30f0ea0c-d8fb-461e-86ab-6e7677beac3c@redhat.com>
 <CAHpthZqfzOXfxzv7OTaLK0x_qro1sHKOHqPeFxwNA4_5FYQrRw@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAHpthZqfzOXfxzv7OTaLK0x_qro1sHKOHqPeFxwNA4_5FYQrRw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xAKWt39NfkqsAKpgrw7V0UwCg4i7gAGGeR6glUETGU4_1750315347
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/06/2025 08:37, Ryosuke Yasuoka wrote:
> On Thu, Jun 19, 2025 at 3:12 PM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> On 13/06/2025 15:20, Ryosuke Yasuoka wrote:
>>> Add drm_panic moudle for bochs drm so that panic screen can be displayed
>>> on panic.
>>
>> Thanks for the patch, it's simple and looks good to me.
>>
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>>
>> If no objections, I will push it next Monday.
>>
>> Best regards,
>>
>> --
>>
>> Jocelyn
> 
> Thank you Jocelyn for reviewing my patch.
> Now I found a typo in the commit message; moudle -> module.

No need to send a v2 for that, I will fix it before pushing the patch.

Thanks,

-- 

Jocelyn

> 
> Let me fix it in v2.
> 
> Ryosuke
> 
>>>
>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>> ---
>>>    drivers/gpu/drm/tiny/bochs.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
>>> index 8706763af8fb..ed42ad5c4927 100644
>>> --- a/drivers/gpu/drm/tiny/bochs.c
>>> +++ b/drivers/gpu/drm/tiny/bochs.c
>>> @@ -19,6 +19,7 @@
>>>    #include <drm/drm_gem_shmem_helper.h>
>>>    #include <drm/drm_managed.h>
>>>    #include <drm/drm_module.h>
>>> +#include <drm/drm_panic.h>
>>>    #include <drm/drm_plane_helper.h>
>>>    #include <drm/drm_probe_helper.h>
>>>
>>> @@ -469,10 +470,28 @@ static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
>>>        bochs_hw_setformat(bochs, fb->format);
>>>    }
>>>
>>> +static int bochs_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
>>> +                                                       struct drm_scanout_buffer *sb)
>>> +{
>>> +     struct bochs_device *bochs = to_bochs_device(plane->dev);
>>> +     struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(bochs->fb_map);
>>> +
>>> +     if (plane->state && plane->state->fb) {
>>> +             sb->format = plane->state->fb->format;
>>> +             sb->width = plane->state->fb->width;
>>> +             sb->height = plane->state->fb->height;
>>> +             sb->pitch[0] = plane->state->fb->pitches[0];
>>> +             sb->map[0] = map;
>>> +             return 0;
>>> +     }
>>> +     return -ENODEV;
>>> +}
>>> +
>>>    static const struct drm_plane_helper_funcs bochs_primary_plane_helper_funcs = {
>>>        DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>>>        .atomic_check = bochs_primary_plane_helper_atomic_check,
>>>        .atomic_update = bochs_primary_plane_helper_atomic_update,
>>> +     .get_scanout_buffer = bochs_primary_plane_helper_get_scanout_buffer,
>>>    };
>>>
>>>    static const struct drm_plane_funcs bochs_primary_plane_funcs = {
>>>
>>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>>
> 

