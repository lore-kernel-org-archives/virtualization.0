Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF1381C2
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858590; cv=pass; b=CBiCkhwDWhA6vVGCufdkzA2z/8EE9USTAsRC01hCLb6IYRo/VG7nZf/BqvAL5eTo/97jC2ghOnA6nH+KNpDYz3Ak+vXSJi77bvqXLtYV6GkPAwErOAKvhdxZ3exm/clMSg19pxhpA3I37VNnuUouuzPHdp3nM8+LRScxEPwJdL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858590; c=relaxed/simple;
	bh=q0Ai9vwAVR2csqHYGXc0xFXCNpIIIBEFXwMrA/u2Zoo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uMAwtunlAdj2HhDxanmuiY+SQpcwPeFYTcnLJwBiDRNWJqLQA0J49eUv2qOmTTmc8Y+RJNlXn1zNPtxCIjwE/e095WTPUI0IoQooWyQi4lEWzrIVxwUEcTyJf1SEX341Ja8DlI7I6ptnCxtNJtNrk1v/2c9nmMrknanhXSEwu1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=Dzkh270i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="Dzkh270i"
ARC-Seal: i=1; a=rsa-sha256; t=1724858582; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n/0UeusnXOCvaEaJ1nhapBysPWJg8696ZD22LhKwNOjMIrmhYm6Hh/g1hJ2z3QffkO4VuqYZoxTZXKLyZ/VTyATeBFUvyW/ZTdjjq0xEj/BL5lEofKZ3SyCH2dTGpVenvq19l/KefQXVK3WIUe8zflbpzEzhS3fqEqfVoADkWcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724858582; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XCKdPShM2BSsjoKUXd5jLwgut9vQqNvq4fosnc20z7A=; 
	b=OP92ZjLenjEMMDFT+eHK7WNuPjfEm8fEPF52kLJYyZgF60nuoeQ6TmTaNF/rShu+hbGPRqPXTNzN3OP53bxDne9Uq8QHMJ9MK/q3vMknoCQWTbv1dUAWmiKyoRQ0RKe4AwCrlVwpwPxUnOKdJQQDDrK4d1klaeYMRNqMVbpR76U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724858582;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XCKdPShM2BSsjoKUXd5jLwgut9vQqNvq4fosnc20z7A=;
	b=Dzkh270iCgK9bLYwALngFlgSPGwMdPTS1B0v6XJC1P80G0jRtoqar0Eds6Zhlh12
	A6c93FpxNKjl5bogYxOE5VQ9ept63a2EgrUR6Vojrmsbfi6AhNbfmU3XHd//hy/UhZT
	8qK23+cNsxfQjZuN+ibJPBV//LGXRxKEljTN573A=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17248585802298.455583977077822; Wed, 28 Aug 2024 08:23:00 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:23:00 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Rob Clark" <robdclark@gmail.com>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"daniels" <daniels@collabora.com>, "airlied" <airlied@gmail.com>,
	"daniel" <daniel@ffwll.ch>,
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
Message-ID: <19199953cbf.ded17a68157355.1209172729493560159@collabora.com>
In-Reply-To: <CAF6AEGu-T4=3jPRcnq3BFBtfb_yhmWE2b8EgxgTm5Q0bqSv04Q@mail.gmail.com>
References: <20240820070818.1124403-1-vignesh.raman@collabora.com> <CAF6AEGu-T4=3jPRcnq3BFBtfb_yhmWE2b8EgxgTm5Q0bqSv04Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: increase timeout for all jobs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail





---- On Tue, 27 Aug 2024 19:04:42 -0300 Rob Clark  wrote ---

 > On Tue, Aug 20, 2024 at 12:09=E2=80=AFAM Vignesh Raman=20
 > vignesh.raman@collabora.com> wrote:=20
 > >=20
 > > Set the timeout of all drm-ci jobs to 1h30m since=20
 > > some jobs takes more than 1 hour to complete.=20
 > >=20
 > > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com>=20
 > =20
 > Acked-by: Rob Clark robdclark@gmail.com>=20

Applied to drm-misc-next.

Thanks
Helen

 > =20
 > > ---=20
 > >  drivers/gpu/drm/ci/test.yml | 5 ++++-=20
 > >  1 file changed, 4 insertions(+), 1 deletion(-)=20
 > >=20
 > > diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml=
=20
 > > index b6f428cdaf94..09d8447840e9 100644=20
 > > --- a/drivers/gpu/drm/ci/test.yml=20
 > > +++ b/drivers/gpu/drm/ci/test.yml=20
 > > @@ -10,6 +10,7 @@=20
 > >  .lava-test:=20
 > >    extends:=20
 > >      - .test-rules=20
 > > +  timeout: "1h30m"=20
 > >    script:=20
 > >      # Note: Build dir (and thus install) may be dirty due to GIT_STRA=
TEGY=20
 > >      - rm -rf install=20
 > > @@ -71,6 +72,7 @@=20
 > >      - .baremetal-test-arm64=20
 > >      - .use-debian/baremetal_arm64_test=20
 > >      - .test-rules=20
 > > +  timeout: "1h30m"=20
 > >    variables:=20
 > >      FDO_CI_CONCURRENT: 10=20
 > >      HWCI_TEST_SCRIPT: "/install/igt_runner.sh"=20
 > > @@ -215,7 +217,6 @@ panfrost:rk3399:=20
 > >    extends:=20
 > >      - .lava-igt:x86_64=20
 > >    stage: i915=20
 > > -  timeout: "1h30m"=20
 > >    variables:=20
 > >      DRIVER_NAME: i915=20
 > >      DTB: ""=20
 > > @@ -414,6 +415,7 @@ panfrost:g12b:=20
 > >=20
 > >  virtio_gpu:none:=20
 > >    stage: software-driver=20
 > > +  timeout: "1h30m"=20
 > >    variables:=20
 > >      CROSVM_GALLIUM_DRIVER: llvmpipe=20
 > >      DRIVER_NAME: virtio_gpu=20
 > > @@ -436,6 +438,7 @@ virtio_gpu:none:=20
 > >=20
 > >  vkms:none:=20
 > >    stage: software-driver=20
 > > +  timeout: "1h30m"=20
 > >    variables:=20
 > >      DRIVER_NAME: vkms=20
 > >      GPU_VERSION: none=20
 > > --=20
 > > 2.43.0=20
 > >=20
 >=20
