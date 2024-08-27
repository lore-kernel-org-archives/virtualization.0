Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A5186A
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790489; cv=pass; b=HcAdaHobXc9rB3vUQSfxO4doWc/zjRdtrvGPZ8r/b0tTIFMBQwHVZsFh4ZtL6vQ37IofAUbwSh/wdVswvqbeU5A78tTPHsOfqfITqxFJXfvbYUl2WPVYgqwzwL3jXrs/qSZBwj9XUp2hV8gOCyjpFCHhfqY2HybcYtlPYi79V58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790489; c=relaxed/simple;
	bh=F72uNt+lfxN7I+v+keVCkaoFUkqxTDR8fJX36yvMbxo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oxdtg0kVJ2qJKyj8sJY+w1vKLnHk8U5yFpFEnXFHFyOAxCaZWifGwDM+lPmpDH5WMOxyvcmnmvOMxemahGH6Fa9+tiYxuxFicUcQfkenKpFVgGI9+zJ75lXQem3POP/p/QOwatevo6GeQ91Rajc9HYaE2rFuhgOMD/Ei3xOxYd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=hI48h1WD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="hI48h1WD"
ARC-Seal: i=1; a=rsa-sha256; t=1724790480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Aya30ztD33wDitnB3E5Gn+IYVWfddnFNtZwWR4Z/GYc/NTc4LqyK/XEhTgm7ailY6rJKItNYBd/VB14kTXRNB5birLM3a7WFCPi5rZYvBpdJVssJwFlmyfJI9uQ7q/ztXjQwKCMFKKbSA0bxO7So7c6xWW07RuSK2A1R08jXkDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724790480; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vSjUVm1BVHx+k1tFoVAnnPQhkPlOOk9eSfEVMqyqIEY=; 
	b=Etx//QWRTu3HlBQryriesvrIEINJornZf9rpjNIxM3SwhFaOuf+jX95Yis3yJTCJU63WAKIyTX8pLw2oy9YGJrvoDytcl94RrdY4Ycb1kIthriVX2KmlipBO9sbxLaJxhL570HOW9lR/56evwrN7yFpc8LO2jWjrXcGe1BWGn0s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724790480;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vSjUVm1BVHx+k1tFoVAnnPQhkPlOOk9eSfEVMqyqIEY=;
	b=hI48h1WDy87pOMX099fASJTZhXMXCO9sEwV9KBM6EfWRIvETtevOgQMj6/okJmfE
	wXivfv2WtL0RIFAFVAtZ8qayYLD6kLZigOMut2jyKU4CPY+WcdBRNKSKftx+kUhhanY
	HUs/4BwTFTMWQg9V8bYsxQvUQP4+pIx5NxK33DVQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1724790478227916.9458842035166; Tue, 27 Aug 2024 13:27:58 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:27:58 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Vignesh Raman" <vignesh.raman@collabora.com>
Cc: "dri-devel" <dri-devel@lists.freedesktop.org>,
	"daniels" <daniels@collabora.com>, "airlied" <airlied@gmail.com>,
	"daniel" <daniel@ffwll.ch>, "robdclark" <robdclark@gmail.com>,
	"guilherme.gallo" <guilherme.gallo@collabora.com>,
	"sergi.blanch.torne" <sergi.blanch.torne@collabora.com>,
	"deborah.brouwer" <deborah.brouwer@collabora.com>,
	"linux-mediatek" <linux-mediatek@lists.infradead.org>,
	"linux-amlogic" <linux-amlogic@lists.infradead.org>,
	"linux-rockchip" <linux-rockchip@lists.infradead.org>,
	"amd-gfx" <amd-gfx@lists.freedesktop.org>,
	"linux-arm-msm" <linux-arm-msm@vger.kernel.org>,
	"intel-gfx" <intel-gfx@lists.freedesktop.org>,
	"virtualization" <virtualization@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1919586153a.1236d9a3a2810380.346109493548527669@collabora.com>
In-Reply-To: <20240820070818.1124403-1-vignesh.raman@collabora.com>
References: <20240820070818.1124403-1-vignesh.raman@collabora.com>
Subject: Re: [PATCH v1] drm/ci: increase timeout for all jobs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail





---- On Tue, 20 Aug 2024 04:08:16 -0300 Vignesh Raman  wrote ---

 > Set the timeout of all drm-ci jobs to 1h30m since 
 > some jobs takes more than 1 hour to complete. 
 >  
 > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com> 

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

 > --- 
 >  drivers/gpu/drm/ci/test.yml | 5 ++++- 
 >  1 file changed, 4 insertions(+), 1 deletion(-) 
 >  
 > diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml 
 > index b6f428cdaf94..09d8447840e9 100644 
 > --- a/drivers/gpu/drm/ci/test.yml 
 > +++ b/drivers/gpu/drm/ci/test.yml 
 > @@ -10,6 +10,7 @@ 
 >  .lava-test: 
 >  extends: 
 >  - .test-rules 
 > +  timeout: "1h30m" 
 >  script: 
 >  # Note: Build dir (and thus install) may be dirty due to GIT_STRATEGY 
 >  - rm -rf install 
 > @@ -71,6 +72,7 @@ 
 >  - .baremetal-test-arm64 
 >  - .use-debian/baremetal_arm64_test 
 >  - .test-rules 
 > +  timeout: "1h30m" 
 >  variables: 
 >  FDO_CI_CONCURRENT: 10 
 >  HWCI_TEST_SCRIPT: "/install/igt_runner.sh" 
 > @@ -215,7 +217,6 @@ panfrost:rk3399: 
 >  extends: 
 >  - .lava-igt:x86_64 
 >  stage: i915 
 > -  timeout: "1h30m" 
 >  variables: 
 >  DRIVER_NAME: i915 
 >  DTB: "" 
 > @@ -414,6 +415,7 @@ panfrost:g12b: 
 >  
 >  virtio_gpu:none: 
 >  stage: software-driver 
 > +  timeout: "1h30m" 
 >  variables: 
 >  CROSVM_GALLIUM_DRIVER: llvmpipe 
 >  DRIVER_NAME: virtio_gpu 
 > @@ -436,6 +438,7 @@ virtio_gpu:none: 
 >  
 >  vkms:none: 
 >  stage: software-driver 
 > +  timeout: "1h30m" 
 >  variables: 
 >  DRIVER_NAME: vkms 
 >  GPU_VERSION: none 
 > -- 
 > 2.43.0 
 >  
 > 
