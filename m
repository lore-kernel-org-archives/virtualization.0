Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010333EA9F
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UzZK/XYR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5767C400D9
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 16:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5767C400D9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UzZK/XYR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlkwmevHscRi
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 16:45:38 +0000 (UTC)
X-Greylist: delayed 57805 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 15 Dec 2023 16:45:38 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83FE5400C5
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83FE5400C5
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702658736;
	bh=vKEaU/E7paNN/LvyLgKhkKfx93q+/oWb8J2lSHxqsUc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UzZK/XYRFidF/ekISFPtWY7Z6uyyApqvRwKGwZ+P3q1qGcikasLQ/MyE2k8qnqjwi
	 3tXsQWZOHIZDQOuLXmOmUEPun+4VyZrd67Cp0cVUz7fFzm6iVFu7BfvX5jIaECEn1T
	 XZAox94eFhHv9CWaH3snbzyfc9Mu6SssR2+9rkW0EccjR8DdQ8qQi3/+JhO760Ki3Z
	 nRrnTn7jR/hwje1caiU79iIZj0qA1yQv5S2sWQqTUGbr7ysX8DYuxSZuieSj/G1GYa
	 t7jFhRWeABAwpr5naWBJ1kO31/A7H+ZQ5U2HfmAySIDUJp/PQyFns4u2pi0MQoDlgg
	 oEHGuTTr0odMQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B16BF3781F93;
	Fri, 15 Dec 2023 16:45:35 +0000 (UTC)
Message-ID: <b79dcf75-c9e8-490e-644f-3b97d95f7397@collabora.com>
Date: Fri, 15 Dec 2023 19:45:32 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/virtio: add definition for venus capset
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20230915105918.3763061-1-ray.huang@amd.com>
 <a7b783c8-b1c8-90e3-b6c7-7fa8c6d24d21@collabora.com>
 <68470997-bb4c-3c11-98b5-aa75c52cbaea@collabora.com>
In-Reply-To: <68470997-bb4c-3c11-98b5-aa75c52cbaea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/23 06:46, Dmitry Osipenko wrote:
> On 9/21/23 00:16, Dmitry Osipenko wrote:
>> On 9/15/23 13:59, Huang Rui wrote:
>>> This definition is used fro qemu, and qemu imports this marco in the
>>> headers to enable venus for virtio gpu. So it should add it even kernel
>>> doesn't use this.
>>>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> We would like to add a new definition for venus capset, it will be used for
>>> qemu. Please see details on below discussion:
>>>
>>> https://lore.kernel.org/qemu-devel/b82982aa-5b9e-481e-9491-b9313877bcaa@daynix.com/
>>>
>>> Thanks,
>>> Ray
>>>
>>>  include/uapi/linux/virtio_gpu.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
>>> index f556fde07b76..0e21f3998108 100644
>>> --- a/include/uapi/linux/virtio_gpu.h
>>> +++ b/include/uapi/linux/virtio_gpu.h
>>> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>>>  
>>>  #define VIRTIO_GPU_CAPSET_VIRGL 1
>>>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
>>> +/* 3 is reserved for gfxstream */
>>> +#define VIRTIO_GPU_CAPSET_VENUS 4
>>
>> Could you please add all other capsets, so we won't needed to do it
>> again in the future
> 
> I've opened request to update virtio-spec with the corrected/updated
> capsets https://github.com/oasis-tcs/virtio-spec/issues/182. I'm
> expecting that it will take some time until spec change will be merged
> and now leaning to apply this v1 patch to not hold the Venus work.
> 
> Gerd, do you have objections? R-b/ack?

Applied patch to misc-next with edited commit message. Updating spec
taking much time, not worth to hold this change longer. We'll add the
rest of capsets later on. Thanks, Rui!

-- 
Best regards,
Dmitry

