Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FD34403C
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898423; cv=none; b=A1z7zC1LB4nivO0IIQCeP/e/xXq1se016STBnOmhJs2+o0TBurI7l7CWsarqQU4VlPSodnDL77/lKXVqdOKH6b+7zSuePdFm1DupnzrxPEH412G8GbUFP8enTeXcnRCdSfSfJKvU1TzfWIGAVI0VHp2+s4sFP3mLYHIf+yhHgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898423; c=relaxed/simple;
	bh=2h3WBnEQJKctPY2asYyEGA7td2QJtLLqP+/9R300ga8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBSYbAjqDMDFymdRnv7ISC1xeVNgTCGNYTnSNPl7bIXqBe0qpE4UNU5tU+YM3qQAYx+lPBNeejxZweLDWXJnskjEmFyMM7TWcRZbqwtD1/YF/Ar0WY71qMa3jwojx2+tgmb+fFJkbKyBEugIDCT8mIFfYbwoPXmtNipv+xS7E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwR11kC8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwR11kC8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a110548f10so4216365ad.1
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898421; x=1766503221; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um9j1NvhAvuOmXHqodLfor6UadH2pWBjGMeLJlrrYrA=;
        b=KwR11kC8X86+aZM9Kd0ubv0E+0bxoaFWDH+kOXnkjUGGDBtCKnLMhUGt3MAHCgl+Y5
         fVRhizMo5g5I2NREbLJIRpaFE/6rTz9M68hUM/K5AxRMMh2dPd3gRB1s29bEjOMwX0TN
         cSOfcYiLVkW5wUXk2GZKqvLdSsPWLwg1AyIcfBp75rj74gPfjY0p4JPDZjsgiNydBoRF
         pRa/8Egx+H4998fYhFvfuNjmAuyuwvBGQAe+ECDqA97zf5PD80333p+yiPyYY457K49T
         TDC3r2veoC8UdeKIh7liW4C3gPTI/Lie74eMgml2lC79J/4H0CV/HcMdesEI+7UVpkz+
         PCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898421; x=1766503221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Um9j1NvhAvuOmXHqodLfor6UadH2pWBjGMeLJlrrYrA=;
        b=f5XLjTsuyDqlxgHWkKwvYhbsdv1qEM/5HHEpeSIQrbA7du/IeRTCpTnxvbxl6y5BnT
         xjiF8GCrveaJajzEG7bXsAf364aM6iEDV49ii0Ij655IDLCfzjTqRHJ99uH7ENgb+v+a
         IeHtSMrZwC0+yCGLECEkl0ci/btesKrRMNkjc6GBkBJaEcp8cQP+f2mdi0ckRedPVP9V
         qqLKt/hU8U3AB0iWbRDTghS2dzD28Z0aLJCifFN4JO4dFVQ4YffFHgQcSkKSIa4+jKSw
         636xHyyobwtqV0iXxw8t+HVoCLpuMkORihM/9kkzUoIAVwFWrmb007mFW7h2UaOeQq2I
         43IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdbvK8Nt4fhanxK+FpXyaz30MYjfCOVqE4fBdhhumR2lnjmNl5Yu8OCvNBQufhOHrQP8e7YHd2pcggHWxg+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0dKNPa2t6dvcaEZhQ/0J8ytezptuVnFq9UEeI4NCD6inULr+E
	ALWshby+JdjIN3Mtn9rOyTtWEMaafAwDb1EeiaRdylp2Plyfzm7ttvI/P3qSUh1RHu96glnRpPj
	yuYvgNZZg+e4Lz0IoM1z7p8Pt5TTpWZA=
X-Gm-Gg: AY/fxX5eA0/WYVXlgJ9gx5k8xZhLS3HscrMjLI5lJsxYxMwBYzM6JNDQ24aTCj1rS94
	18wlmxEvm/ztcG9byoiuaNJ/tmurdvt0TB6jWyDlyGLjBsYrtqvHgxiprT7GQHjBf51cNJnoe4O
	NN3sl4tVmtCqsL/AjhMuty6Ld9FjuLxV9Q0Y9S1+h0dJXxQTqQj1UPHlwcNw4epX+XMTB6naiQ/
	2MEcb0yej/NOl3uv5qRoTijomJhi1BFxpQ8pmPM/D57p9lUyBnLnNCZaWzg88eNLrAqSbwLne4b
	mAQVMQg=
X-Google-Smtp-Source: AGHT+IGYJpLwVd3WmfTCVN6vD/x/9T3gUFCIaNjQX2AnDfzywCiHaDROcEgCyN90fYOeDZvtNwbDXrs4JcvDTNG1WwM=
X-Received: by 2002:a05:7022:3a0d:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-11f34c52cc5mr5906109c88.6.1765898419103; Tue, 16 Dec 2025
 07:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-11-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-11-bagasdotme@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:20:06 -0500
X-Gm-Features: AQt7F2ra4W4DJMCA0k4t80_q2saRqZRxc2HY97wTRTVoyOkAEkAv1EtqbtLiuMo
Message-ID: <CADnq5_P04522xETHty9hn5JO=mNbKSg3Pa68=u8cZ+JgNLt1Jg@mail.gmail.com>
Subject: Re: [PATCH 10/14] drm/amdgpu: Describe @AMD_IP_BLOCK_TYPE_RAS in
 amd_ip_block_type enum
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>, 
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, 
	Linux Virtualization <virtualization@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, 
	Linux Networking <netdev@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, 
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>, 
	"Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexey Skidanov <alexey.skidanov@intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, 
	Shaomin Deng <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, 
	Jilin Yuan <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	George Anthony Vernon <contact@gvernon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 6:48=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warning:
>
> WARNING: ./drivers/gpu/drm/amd/include/amd_shared.h:113 Enum value 'AMD_I=
P_BLOCK_TYPE_RAS' not described in enum 'amd_ip_block_type'
>
> Describe the value to fix it.
>
> Fixes: 7169e706c82d7b ("drm/amdgpu: Add ras module ip block to amdgpu dis=
covery")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index 17945094a13834..d8ed3799649172 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -89,6 +89,7 @@ enum amd_apu_flags {
>  * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
>  * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
>  * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
> +* @AMD_IP_BLOCK_TYPE_RAS: RAS

Reliability, Availability, Serviceability.  I've fixed this up locally
and applied the patch.

Thanks,

Alex

>  * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
>  */
>  enum amd_ip_block_type {
> --
> An old man doll... just what I always wanted! - Clara
>
