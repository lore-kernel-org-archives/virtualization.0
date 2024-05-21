Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821E4AED7
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275142; cv=none; b=V8oN+L43u5wfsQcaFl6kRyk0GN6GiYW78+pDX6KlJ7gMGvQbTEwTSv62/BoBmcnED14gycoEwjTHBFbmmxTAIZH+nE9COs/XFCJTcgWVCZuSe431CAgs4xj6xFg3PobH2FalB2yc8lMQphTjHweidjnoI9VFnv9svLAEKHewfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275142; c=relaxed/simple;
	bh=nS/Dr2W3vGanwW9ifFd+bOFrHEwvBrs3b1sW5lLV82U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uL27+QbaVrzFccKnSgG5m1bfLNqHfSnaGmuyDThfZ6YvGIyGkHZItzgHwszIGZUqcYbwmJkmvkvHXSqORruMwiKE9yw3pZMl9dV5CA+wDhuZ3rmNPXYoiMTpVvjWs2nebeCZsIgzpF64hjE2iYUtwxnXMjGFgPM9NR+Y4EKIVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qm0vO6hS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qm0vO6hS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56E8740BFF
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 07:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_YuFA0AXoIE for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 07:05:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.235.227.194; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D42C2400E4
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D42C2400E4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qm0vO6hS
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D42C2400E4
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 07:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716275137;
	bh=nS/Dr2W3vGanwW9ifFd+bOFrHEwvBrs3b1sW5lLV82U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qm0vO6hSCRlLszYJes6vtZsP0qVLDOWOlMVSXIEkovjNeL4Dq+Cc+8MXdXP7o9Ngt
	 dEgAlzV+KObOGcAdS/6I44aVkdi+dzENzBC+C8438w5ZDIY3qhWEdam1o+AodVwzjv
	 LXMakGJRGQchKxC8P/1xweTSAiUSv5m/wIebY9OQ7ZoehiIA9kMjvWzZlPc043uEtL
	 I9WPKXT+MUL2ESyAvmJo630D/7kottF1JQB7ihruCKvj6sjbQnA/ZmNcTgV2aj4M44
	 yBEOL1WXeyBsLFdR4/W1aZOQopqDRLXK/J8L1Xq3XC3FW2nsXiT1XtAj/HU/gghFaX
	 X7t22RCH7dZsQ==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E0B0A378202E;
	Tue, 21 May 2024 07:05:33 +0000 (UTC)
Message-ID: <9ab7eb04-d4c6-4a79-87cb-2d21e4bfa9c4@collabora.com>
Date: Tue, 21 May 2024 12:35:32 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] drm/ci: generate testlist from build
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 dmitry.baryshkov@linaro.org, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-3-vignesh.raman@collabora.com>
 <c7e0a8b1-5be6-460b-b489-2ab5a8248d32@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <c7e0a8b1-5be6-460b-b489-2ab5a8248d32@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 21/05/24 01:54, Helen Koike wrote:
> 
> 
> On 17/05/2024 06:24, Vignesh Raman wrote:
>> Stop vendoring the testlist into the kernel. Instead, use the
>> testlist from the IGT build to ensure we do not miss renamed
>> or newly added tests.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v2:
>>    - Fix testlist generation for arm and arm64 builds.
>>
>> ---
>>   drivers/gpu/drm/ci/build-igt.sh  |   34 +
>>   drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>>   drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>>   3 files changed, 39 insertions(+), 2765 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/ci/testlist.txt
>>
>> diff --git a/drivers/gpu/drm/ci/build-igt.sh 
>> b/drivers/gpu/drm/ci/build-igt.sh
>> index 7859554756c4..e62244728613 100644
>> --- a/drivers/gpu/drm/ci/build-igt.sh
>> +++ b/drivers/gpu/drm/ci/build-igt.sh
>> @@ -3,6 +3,30 @@
>>   set -ex
>> +function generate_testlist {
>> +    set +x
>> +    while read -r line; do
>> +        if [ "$line" = "TESTLIST" ] || [ "$line" = "END TESTLIST" ]; 
>> then
>> +            continue
>> +        fi
>> +
>> +        tests=$(echo "$line" | tr ' ' '\n')
>> +
>> +        for test in $tests; do
>> +            output=$(/igt/libexec/igt-gpu-tools/"$test" 
>> --list-subtests || true)
>> +
>> +            if [ -z "$output" ]; then
>> +                echo "$test"
>> +            else
>> +                echo "$output" | while read -r subtest; do
>> +                    echo "$test@$subtest"
>> +                done
>> +            fi
>> +        done
>> +    done < /igt/libexec/igt-gpu-tools/test-list.txt > 
>> /igt/libexec/igt-gpu-tools/testlist.txt
> 
> Just a nit, could you rename the file to ci-testlist.txt ? Since 
> test-list.txt and testlist.txt can be easily confused.

Sure, will rename it. I missed to add the generating testlist print also.

Regards,
Vignesh

> 
> Regards,
> Helen
> 
