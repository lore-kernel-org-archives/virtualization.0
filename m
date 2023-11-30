Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5747A67
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H58wh8CH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5DE2400CF
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5DE2400CF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H58wh8CH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s27Dt2XfuC0e
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 13:51:00 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41A3F40012
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:51:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41A3F40012
Received: from [100.124.219.30] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 037796607345;
	Thu, 30 Nov 2023 13:50:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701352258;
	bh=HGnD8bUQWOaK+6RFgKTsVFZmO6HTrfFGIJlJrDox4v8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H58wh8CHNeyKhFKLgOKBi4cHe/A5GWRrfro7BiyeAt4Jr5iSpHtao56/5Xpa0WFNt
	 iL9p94K8uIyTXndAwxXyrdNoIHY9sXoa5oBmnefTqKNP3R0jrZm8Swjg7huYA2KQi2
	 qA2dhqdwQ0MRA5G3Od4dScyaTjrYKG0aYkBzU0D3kIBfKadg5E9uG5RT6kHtSoFYVf
	 4V0V4odklj4B0h1o/kAGP/l1KaQWj1PwW92dO9KW8DxzbwFbO/+nUqH7C+XFTFeJ/d
	 058/Sgc7SGQkJBFyU3cqme3tnGtkMBUFdWLM7lBBh92rCW62iY4m/GSvtgeOyxYAOI
	 yAE7gIc4P+R8w==
Message-ID: <893192db-0431-4d1f-7281-952da9979345@collabora.com>
Date: Thu, 30 Nov 2023 19:20:50 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 06/10] drm: ci: mediatek: Set IGT_FORCE_DRIVER for
 mt8173
Content-Language: en-US
To: Daniel Stone <daniel@fooishbar.org>
Cc: helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 daniels@collabora.com, emma@anholt.net, gustavo.padovan@collabora.com,
 linux-arm-msm@vger.kernel.org, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
 <20231129121841.253223-7-vignesh.raman@collabora.com>
 <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 29/11/23 18:52, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Wed, 29 Nov 2023 at 12:19, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> Expected driver for mt8173 is "mediatek" and for mt8183
>> it is "panfrost". Set IGT_FORCE_DRIVER to 'mediatek' as
>> the expected driver for mt8173.
> 
> Actually, for mt8183 it's both. And for mt8173 it will probably be
> mediatek+pvr pretty soon. Each of these SoCs (like most Arm devices)
> have a separate display controller and GPU, with different drivers for
> each. They'll run different tests with different xfails. So we should
> figure out a way to support igt running for both devices on the one
> system.

Agree. Will work on separate patch to test both the drivers for these 
devices.

Regards,
Vignesh
