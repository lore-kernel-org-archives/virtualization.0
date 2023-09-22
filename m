Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3398CD4850
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 19:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89422404D8;
	Fri, 22 Sep 2023 19:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89422404D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VK9ia1C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtBfBwxBRb7J; Fri, 22 Sep 2023 19:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A6C340146;
	Fri, 22 Sep 2023 19:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A6C340146
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5CB1C0039;
	Fri, 22 Sep 2023 19:00:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54347C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 19:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C00E6110B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 19:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C00E6110B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VK9ia1C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SmXTtXQ9JfGg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 19:00:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 013D561108
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 19:00:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 013D561108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695409252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NE66f7DfP4/A2VOZXmvxuXHt1FmCuY2Q51yLIoHLwck=;
 b=VK9ia1C69p2AuLThkIIK0LKPkgnCxZHYupo7R9S74tkSAk8r6gwbVDQYYrsAM0Ip6iNFy9
 j4M8VDrWQznepxL1eNNSw8ofkdCPXkJuawhjH+UUt6dWoENcXeICIbyE5BfWbZ8nOwiciT
 z+uoTgfOxo+fBYy6496qiNDjRRGDQYM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-37N6bTagNhC9j8y8WGz_zg-1; Fri, 22 Sep 2023 15:00:51 -0400
X-MC-Unique: 37N6bTagNhC9j8y8WGz_zg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65af09eaa88so3936116d6.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695409250; x=1696014050;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llC9/wUzzd4JVzDSD0PHMCO4lX+W74lZOeDntPKMIjc=;
 b=Sip6+O4XXi+E+40rLPvSHf1Xz6vx7ygRS0FS7ox1p4zz9NMXaxEWxC+JPUkY54oz7u
 UIZpe2TbYPTfgCyCiW+vqQw9lpX0gwzoUg7H8ioyuDpaKppQCa+V9Z5JLGVtzcdpZo3v
 ZBUK3hE5pb5eqegBHCn7fu1J2QfBlXLb/KqhVjeFi2z6+PIuFIwCsX4Qi71L+LWYX+kj
 OdGKcf0LEipOGttRnMoR0D/eKf+JZoLfcgRq7fqLEceBOp4JHRK5h75SqJwwD7Tq56yK
 gowghE37oKPPsJtTcw82VQ1RkiLzUM7arju6D1RKcJOqKX9mxj4A5phCtkpko4REudTi
 xbKQ==
X-Gm-Message-State: AOJu0YyfzyOy/FC1orM84V59dW6Fio/ZR0rOeH2m/pnYtNv7OhU38jjw
 T+6t1bY1Mc4KS6iTZnoRkDoXc+saffRr7ArnjzDPinxE7Gbr1o58+ndPqrgcLjGrurhB4zVIFLn
 uZj0g1dmzjiBE3lm/bbSln+nrC5FD/C6D12fvBEEPxQ==
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id
 d5-20020a056214184500b00655d2c7a9d1mr187769qvy.14.1695409250677; 
 Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcAhYi3agHEIh1mExaRpOkIAUDfxEWkbuUfbk0Y5Ex6ReRQkYaRYp/G33/F11gHisOBD3h3Q==
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id
 d5-20020a056214184500b00655d2c7a9d1mr187719qvy.14.1695409250417; 
 Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a0ce106000000b0064f50e2c551sm1671895qvk.1.2023.09.22.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 12:00:49 -0700 (PDT)
Message-ID: <1fc22ed54041660dfff5b7f3cc69708fd4ac0472.camel@redhat.com>
Subject: Re: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with
 __counted_by
From: Lyude Paul <lyude@redhat.com>
To: Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
Date: Fri, 22 Sep 2023 15:00:47 -0400
In-Reply-To: <20230922173216.3823169-5-keescook@chromium.org>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-5-keescook@chromium.org>
Organization: Red Hat Inc.
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Emma Anholt <emma@anholt.net>,
 Neil Armstrong <neil.armstrong@linaro.org>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Tom Rix <trix@redhat.com>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@Intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Fri, 2023-09-22 at 10:32 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> index 6ae25d3e7f45..c011227f7052 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> @@ -82,7 +82,7 @@ struct nvkm_perfdom {
>  	u8  mode;
>  	u32 clk;
>  	u16 signal_nr;
> -	struct nvkm_perfsig signal[];
> +	struct nvkm_perfsig signal[] __counted_by(signal_nr);
>  };
>  
>  struct nvkm_funcdom {

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
