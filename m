Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECD3A8DE
	for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8Ytgko1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so1036035e9.3
        for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701111559; x=1701716359; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjiPRjZPiCmdU/duAiKaG+F7L9L8u8NYrRvuFjn8aG4=;
        b=a8Ytgko1CIIPXeGAloAxKDAexuIUXK7FKsZcXtZ4ljc5JLw9ghGjiP7N98qiK4yDUg
         LmmwNPuA32aO0Zmf4PRSMWlbN9I+FzgtqeJX7T8tccMxSbDK8zXVR1zibQ7bkeyz0/WX
         N+U67f624ETUGzX9cDfWTQBDHS6lYB/YZf0ZikxgZsmznHD28k2ZalNxSXXToAp9u46k
         mpGDHT7Gmx7aKsYAamDfjuL3LU205VIIb+LvpFTPMSOy9rbSskc3JzzyBUlfhs9zRodV
         cyaoPdCP/iCW0NZnJPWkhx1EQ+EdHUMsIqgt6NDzDh5AoeoacijH2THs1rXsGz8UNZCR
         hVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111559; x=1701716359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjiPRjZPiCmdU/duAiKaG+F7L9L8u8NYrRvuFjn8aG4=;
        b=gpLNjY9y8Vgr/AKNnfQqZMgoZxmtfsSSMDAoBBHBCkqA2tFMKvQMnXwb6RlVNwuf13
         SCSUkqWUj68S7Mq36cY638TfAcB2ZQT2D7UmQNGBd8qyecExTcYY0Ym5A3Jha+kWaOT5
         fufm3aD9LPluHHkbesZ2kVsc1sOos3P+4gfl7TzafpCaSRUBLS68IBWCYOrsQtDVO54B
         erFCZn0xcvrs/DlvQlbgIo3x4PQWEGo+MeuNiu3y8vfCWi3v330aJGpUDWM87oTvuTkg
         yetseIri1D98q2Qx8ivqDO6f9lh7Ho0FdWFgxdmCs4yTsc+O/dvhT91ne5jd4IOkMbX6
         7pvA==
X-Gm-Message-State: AOJu0YxfWGhOQtc1y9J87i0fZzjTqUfDVWTawzLhqFTyIEaJUue1VACB
	c5uiz+okAptCNeDxozU7Aok=
X-Google-Smtp-Source: AGHT+IFYgkKTxGMxfAVQ2TiCEt6no+2USkpLLKMpoenaxT5hDflerFFL3yg/x9yfMMXXyOIN1holhA==
X-Received: by 2002:a05:600c:3595:b0:409:7d0:d20b with SMTP id p21-20020a05600c359500b0040907d0d20bmr9631528wmq.24.1701111558608;
        Mon, 27 Nov 2023 10:59:18 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm15526135wms.0.2023.11.27.10.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:59:18 -0800 (PST)
Message-ID: <c3809a89-31bc-4e5e-b0bf-538845e37f57@gmail.com>
Date: Mon, 27 Nov 2023 19:59:16 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: use GTT only as fallback for VRAM|GTT
Content-Language: en-US
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "kherbst@redhat.com" <kherbst@redhat.com>, "dakr@redhat.com"
 <dakr@redhat.com>, "zackr@vmware.com" <zackr@vmware.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>,
 "linux-graphics-maintainer@vmware.com"
 <linux-graphics-maintainer@vmware.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20231127145437.15060-1-christian.koenig@amd.com>
 <20231127145437.15060-3-christian.koenig@amd.com>
 <a6e10770-32de-4235-a86f-02a90e93a0f4@amd.com>
 <DS7PR12MB59339B73B38A4EFDB2A67A9FFEBDA@DS7PR12MB5933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB59339B73B38A4EFDB2A67A9FFEBDA@DS7PR12MB5933.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.11.23 um 17:47 schrieb Bhardwaj, Rajneesh:
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hamza Mahfooz
> Sent: Monday, November 27, 2023 10:53 AM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; jani.nikula@linux.intel.com; kherbst@redhat.com; dakr@redhat.com; zackr@vmware.com; Olsak, Marek <Marek.Olsak@amd.com>; linux-graphics-maintainer@vmware.com; amd-gfx@lists.freedesktop.org; nouveau@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; virtualization@lists.linux.dev; spice-devel@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amdgpu: use GTT only as fallback for VRAM|GTT
>
> On 11/27/23 09:54, Christian König wrote:
>> Try to fill up VRAM as well by setting the busy flag on GTT allocations.
>>
>> This fixes the issue that when VRAM was evacuated for suspend it's
>> never filled up again unless the application is restarted.
> I found the subject description a bit misleading. Maybe use a Fixes tag describing it is a fix for suspend resume regression other than that, looks good to me.

Well exactly that's the problem, this isn't really a fix and we also 
don't want to backport it.

Basically the previous behavior was working as design, it's just that it 
was never intended to be used like this.

>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2893

Thanks,
Christian.

>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 ++++++
>>    1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index aa0dd6dad068..ddc8fb4db678 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -173,6 +173,12 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>                        abo->flags & AMDGPU_GEM_CREATE_PREEMPTIBLE ?
>>                        AMDGPU_PL_PREEMPT : TTM_PL_TT;
>>                places[c].flags = 0;
>> +             /*
>> +              * When GTT is just an alternative to VRAM make sure that we
>> +              * only use it as fallback and still try to fill up VRAM first.
>> +              */
>> +             if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>> +                     places[c].flags |= TTM_PL_FLAG_BUSY;
>>                c++;
>>        }
>>
> --
> Hamza
>

