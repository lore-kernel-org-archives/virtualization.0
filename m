Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F78C01
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z9ihSIAd"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E73041903
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 07:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E73041903
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z9ihSIAd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fe2f3PRz0y_d
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 07:46:37 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3EB5418EE
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 07:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3EB5418EE
Received: from [100.124.219.30] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id CE18466022D8;
	Fri, 24 Nov 2023 07:46:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700811993;
	bh=8LvJc8DaAgHeIHvOQk6AYJxeRlrV3q4wIVakxhIdGb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z9ihSIAdqUhMuQz9cCS/bwAmg2YL6c12FYaZKZOE5E7g8/LQH3vK7Z5qQiqUpBp7C
	 H/E0LW/5bWnBo0sXZAYEL6+5JpXKxm0emC+OR/R2hQTJBn/6lU7fl4ile4YO3aSwT2
	 BuR3+9KMeMjwQL09nvKxfl/kjb1Kc9He7tUmzKnVqZxBWehMdO1nmbNcTBxWAMkU+D
	 /5UN0N8+uUwJf1DC8gzc/BSCwMTmK01P379ZRX77WH8aFX3f4Qt4NQm9DFRPAIVrFg
	 yF0tNZWvbSZ0b+JbadNjsRbBorMOmlwMqYiO7pqx99IHuoyyl7xhdPkJkUO0GOw4e1
	 vVXd1rSFeLQxw==
Message-ID: <92467afc-cd50-41aa-a3a5-481c9da30a4c@collabora.com>
Date: Fri, 24 Nov 2023 13:16:26 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 9/9] drm: ci: Update xfails
Content-Language: en-US
To: Daniel Stone <daniel@fooishbar.org>
Cc: helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 daniels@collabora.com, emma@anholt.net, gustavo.padovan@collabora.com,
 linux-arm-msm@vger.kernel.org, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org
References: <20231019070650.61159-1-vignesh.raman@collabora.com>
 <20231019070650.61159-10-vignesh.raman@collabora.com>
 <CAPj87rP=22Fw0h42U-p9fHd=6OHOu9Lj9kbpVMQVqL9U6BRE1A@mail.gmail.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rP=22Fw0h42U-p9fHd=6OHOu9Lj9kbpVMQVqL9U6BRE1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 19/10/23 13:55, Daniel Stone wrote:
> 
> By the time we get this error, it indicates that there was previously
> memory corruption, but it is only being noticed at a later point. The
> skip lists here are way too big - stuff like drm_read is common
> testing not affected by virtio at all - so we really need to isolate
> the test which is actually breaking things.
> 
> The way to do this would be to use valgrind to detect where the memory
> corruption is. VirtIO can be run locally so this is something you can
> do on your machine.

Thank you for the hints and suggestions. This is now fixed in 
igt-gpu-tools, and the patches are merged. I will uprev igt in drm-ci 
and rerun the tests.

Also will drop the tests from virtio_gpu-none-skips.txt and send an 
updated version.

Regards,
Vignesh

