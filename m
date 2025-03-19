Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F61DE884
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405678; cv=none; b=nkO/qeq9hOZ9IEjRzNcR83NNQE+m8gLzm5JUazO13Qs5iqffw5qGCAIZgeF9IhZIT00xGkYBhAJNomJ+OKxPvNgf+bOBlj0aVqEdK8rqoOYqIyae4jFn3GyglTcv/MQbKzxgrrfOCzR7yhjwbi6GKvP+SbzjCyzWzUGv1BI74Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405678; c=relaxed/simple;
	bh=FfQKKaTnmq03z0gnWkqdm/YfkoeGGo1XLNenjo1HeLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzoSryp5GmiXRl26ZrpaiB8uyCVQAJ06bAl9V6DLfrV0L6E+teO7PYLvAat9CW9iQ1FhA1OVYE3p7Uoo5CoXNZziEcOESdOdy4P5OP18xmAoS36dmBeRV1JhvW3pzy8FldAPcT10CylTU9MpIWmNuJf12dCM3NiAA/NIDnvt2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2yJP3ce; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2yJP3ce"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3757622a12.0
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742405674; x=1743010474; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HICfp25x6A8uBlCw5p5+rBvNZqOl807JCLoXLGdju5w=;
        b=K2yJP3ceEs/vOj2Ejq6E/N2MuW66XzaZVEGjT3go8eNFny4VZ0i1GAg7UUxoDZQYXc
         yHfNZH15F8xIoggypQPPTt3Cck8miJ236Neo1dWRbM2bu2j2IH82SBSCNvTXI+M+p98i
         rlo4XV+IiigOj2mAV0Eo6Bv5BrBYOAA3I0zOGALeY1oL53Aj2o+aKeqYDgRORa5zhGh2
         j5zeqF4jxBxcbTKxdhH/i80lZffIwi1XMuDWu9TiDd04uQ2bY3i10MzpUOiQ8cNonXEa
         X4NH93wk9LphU4Q0pOlFeDZrS6E/9F1OgxM03pmjwIeZGiadIV9WVagNyfcMFwG29eEW
         salg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405674; x=1743010474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HICfp25x6A8uBlCw5p5+rBvNZqOl807JCLoXLGdju5w=;
        b=qnh3MviWDVxv9yBWdkiheg0VlJJA+wzdXG3IO1POkLLTXGP6BYXtItqHO0w0uKWpmo
         LnDJbAZxTaU/W/xzOzC2TQKNfUpQiw05eWlRwuRKWtzgeZRhT/uKJLKhO4za9FyrmlQz
         /ivITEN0tphcRPPwjvNEYcSj7R00yzUf92ZUru6dN9Cd6Fpm99+jc3h4v0F3KD/+q/bH
         0MYSA6p4FyW6q5kBpdvCE+tlqs2PHwcUFaOSMFXBWjGFKlpqUy6ALay2S/zVIB66LqOI
         Q0WMGnP9PfCq/OhYYpp3iMf00sLn33iml3iLUk82aJ1Ei5W6eFPfdS5s1C7EIOUfJFgY
         Ne/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM/iCRBEKjAmf/kq/aXocG6zl/4uLMijWXzuvVBMd3VVo3ntaV90qmMIPp8YxWYjJmniDWQB1BYu4rimIxJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBDypZQwFAJ3qEAinUrW2dWdSsukAL95WhlZikq5zGr5FbpDAN
	KsO14aKoO7grYOWoN3UmsGgohTj3tMUDzuViMMfvUUtxInxB2hRJT7uqhi0xhM/APSB6xGXJ7Xp
	yXZHWHoFKn9Z9X6ih98Y3UzZur7I=
X-Gm-Gg: ASbGncuALS3V5TW/8xtC3UePM+hc0xabAvLGAogPf+fM7VIWN+ppRTZA50w+vci1HBR
	POqqtL4++AZTZ7zvYsd2MtQvDS4DLqp/HXZ8xLI2RCgtqch4HuELp6U3X2MSlgFsSSJMcbRg9UM
	iAyBGNYMwcSZvkPHgs/2MAbRUhvos=
X-Google-Smtp-Source: AGHT+IHzu2e3XxsHC/7/u8CIt5MaZwZv1sD2yQijEy0cXRzLHdS5nTnlJJGE3hIhSh5QLgw2FNKxwlC7bngh5JrlEtw=
X-Received: by 2002:a05:6402:270b:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5eba02bbcd6mr112300a12.30.1742405673821; Wed, 19 Mar 2025
 10:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250314085858.39328-1-vignesh.raman@collabora.com>
 <20250314085858.39328-2-vignesh.raman@collabora.com> <CAPW4XYZ6+kc+Pj61_Kz8-CEy0Aed92XeXDnUiDAEGNBU+SPxAg@mail.gmail.com>
 <38315386-9975-4bbb-91e8-34b872487c26@collabora.com>
In-Reply-To: <38315386-9975-4bbb-91e8-34b872487c26@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Wed, 19 Mar 2025 14:34:22 -0300
X-Gm-Features: AQ5f1JoPUcAvMrjBsWoRX2_tKLW_5IVh6ZaI7nzG5lkIPL3lBFa4MqHpkPy7Ams
Message-ID: <CAPW4XYY8=CbhN8G7NFe+w9udsTxC=whtTUCzK9-43mvSk0zdDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org, 
	jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qua., 19 de mar. de 2025 =C3=A0s 10:24, Vignesh Raman
<vignesh.raman@collabora.com> escreveu:
>
> Hi Helen,
>
> On 19/03/25 00:22, Helen Mae Koike Fornazier wrote:
> > Em sex., 14 de mar. de 2025 =C3=A0s 05:59, Vignesh Raman
> > <vignesh.raman@collabora.com> escreveu:
> >>
> >> LAVA was recently patched [1] with a fix on how parameters are parsed =
in
> >> `lava-test-case`, so we don't need to repeat quotes to send the
> >> arguments properly to it. Uprev mesa to fix this issue.
> >>
> >> [1] https://gitlab.com/lava/lava/-/commit/18c9cf79
> >>
> >> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> >> ---
> >>   drivers/gpu/drm/ci/build.sh       | 16 ++++++++--------
> >>   drivers/gpu/drm/ci/build.yml      |  8 ++++++++
> >>   drivers/gpu/drm/ci/container.yml  | 24 +++++++++++++++++++++++
> >>   drivers/gpu/drm/ci/gitlab-ci.yml  | 32 +++++++++++++++++++++++++++++=
+-
> >>   drivers/gpu/drm/ci/image-tags.yml |  4 +++-
> >>   drivers/gpu/drm/ci/lava-submit.sh |  3 ++-
> >>   drivers/gpu/drm/ci/test.yml       |  2 +-
> >>   7 files changed, 77 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> >> index 19fe01257ab9..284873e94d8d 100644
> >> --- a/drivers/gpu/drm/ci/build.sh
> >> +++ b/drivers/gpu/drm/ci/build.sh
> >> @@ -98,14 +98,14 @@ done
> >>
> >>   make ${KERNEL_IMAGE_NAME}
> >>
> >> -mkdir -p /lava-files/
> >> +mkdir -p /kernel/
> >
> > the folder is not lava specific, correct?
>
> It is not lava specific. Only the directory name where the kernel image
> is copied is changed and the kernel image is uploaded to S3 for lava.
>
> This is based on,
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/5b65bbf72ce7024c5df2100=
ce4b12d59e8f3dd26

thanks for clarifying.

>
> >
> >>   for image in ${KERNEL_IMAGE_NAME}; do
> >> -    cp arch/${KERNEL_ARCH}/boot/${image} /lava-files/.
> >> +    cp arch/${KERNEL_ARCH}/boot/${image} /kernel/.
> >>   done
> >>
> >>   if [[ -n ${DEVICE_TREES} ]]; then
> >>       make dtbs
> >> -    cp ${DEVICE_TREES} /lava-files/.
> >> +    cp ${DEVICE_TREES} /kernel/.
> >>   fi
> >>
> >>   make modules
> >> @@ -121,11 +121,11 @@ if [[ ${DEBIAN_ARCH} =3D "arm64" ]]; then
> >>           -d arch/arm64/boot/Image.lzma \
> >>           -C lzma\
> >>           -b arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb \
> >> -        /lava-files/cheza-kernel
> >> +        /kernel/cheza-kernel
> >>       KERNEL_IMAGE_NAME+=3D" cheza-kernel"
> >>
> >>       # Make a gzipped copy of the Image for db410c.
> >> -    gzip -k /lava-files/Image
> >> +    gzip -k /kernel/Image
> >>       KERNEL_IMAGE_NAME+=3D" Image.gz"
> >>   fi
> >>
> >> @@ -139,7 +139,7 @@ cp -rfv drivers/gpu/drm/ci/* install/.
> >>   . .gitlab-ci/container/container_post_build.sh
> >>
> >>   if [[ "$UPLOAD_TO_MINIO" =3D "1" ]]; then
> >> -    xz -7 -c -T${FDO_CI_CONCURRENT:-4} vmlinux > /lava-files/vmlinux.=
xz
> >> +    xz -7 -c -T${FDO_CI_CONCURRENT:-4} vmlinux > /kernel/vmlinux.xz
> >>       FILES_TO_UPLOAD=3D"$KERNEL_IMAGE_NAME vmlinux.xz"
> >>
> >>       if [[ -n $DEVICE_TREES ]]; then
> >> @@ -148,7 +148,7 @@ if [[ "$UPLOAD_TO_MINIO" =3D "1" ]]; then
> >>
> >>       ls -l "${S3_JWT_FILE}"
> >>       for f in $FILES_TO_UPLOAD; do
> >> -        ci-fairy s3cp --token-file "${S3_JWT_FILE}" /lava-files/$f \
> >> +        ci-fairy s3cp --token-file "${S3_JWT_FILE}" /kernel/$f \
> >>                   https://${PIPELINE_ARTIFACTS_BASE}/${DEBIAN_ARCH}/$f
> >>       done
> >>
> >> @@ -165,7 +165,7 @@ ln -s common artifacts/install/ci-common
> >>   cp .config artifacts/${CI_JOB_NAME}_config
> >>
> >>   for image in ${KERNEL_IMAGE_NAME}; do
> >> -    cp /lava-files/$image artifacts/install/.
> >> +    cp /kernel/$image artifacts/install/.
> >>   done
> >>
> >>   tar -C artifacts -cf artifacts/install.tar install
> >> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.y=
ml
> >> index 6c0dc10b547c..8eb56ebcf4aa 100644
> >> --- a/drivers/gpu/drm/ci/build.yml
> >> +++ b/drivers/gpu/drm/ci/build.yml
> >> @@ -143,6 +143,10 @@ debian-arm64-release:
> >>     rules:
> >>       - when: never
> >>
> >> +debian-arm64-ubsan:
> >> +  rules:
> >> +    - when: never
> >> +
> >>   debian-build-testing:
> >>     rules:
> >>       - when: never
> >> @@ -183,6 +187,10 @@ debian-testing-msan:
> >>     rules:
> >>       - when: never
> >>
> >> +debian-testing-ubsan:
> >> +  rules:
> >> +    - when: never
> >> +
> >>   debian-vulkan:
> >>     rules:
> >>       - when: never
> >> diff --git a/drivers/gpu/drm/ci/container.yml b/drivers/gpu/drm/ci/con=
tainer.yml
> >> index 07dc13ff865d..56c95c2f91ae 100644
> >> --- a/drivers/gpu/drm/ci/container.yml
> >> +++ b/drivers/gpu/drm/ci/container.yml
> >> @@ -24,6 +24,18 @@ alpine/x86_64_build:
> >>     rules:
> >>       - when: never
> >>
> >> +debian/arm32_test-base:
> >> +  rules:
> >> +    - when: never
> >> +
> >> +debian/arm32_test-gl:
> >> +  rules:
> >> +    - when: never
> >> +
> >> +debian/arm32_test-vk:
> >> +  rules:
> >> +    - when: never
> >> +
> >>   debian/arm64_test-gl:
> >>     rules:
> >>       - when: never
> >> @@ -32,6 +44,10 @@ debian/arm64_test-vk:
> >>     rules:
> >>       - when: never
> >>
> >> +debian/baremetal_arm32_test:
> >> +  rules:
> >> +    - when: never
> >> +
> >>   debian/ppc64el_build:
> >>     rules:
> >>       - when: never
> >> @@ -40,6 +56,14 @@ debian/s390x_build:
> >>     rules:
> >>       - when: never
> >>
> >> +debian/x86_32_build:
> >> +  rules:
> >> +    - when: never
> >> +
> >> +debian/x86_64_test-android:
> >> +  rules:
> >> +    - when: never
> >> +
> >>   debian/x86_64_test-vk:
> >>     rules:
> >>       - when: never
> >> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/git=
lab-ci.yml
> >> index b06b9e7d3d09..55b540c4cf92 100644
> >> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> >> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> >> @@ -1,6 +1,6 @@
> >>   variables:
> >>     DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
> >> -  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 7d3062470f3ccc6cb40540e772e90=
2c7e2248024
> >> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 82ab58f6c6f94fa80ca7e1615146f=
08356e3ba69
> >>
> >>     UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
> >>     TARGET_BRANCH: drm-next
> >> @@ -187,6 +187,36 @@ stages:
> >>       - when: manual
> >>
> >>
> >> +# Repeat of the above but with `when: on_success` replaced with
> >> +# `when: delayed` + `start_in:`, for build-only jobs.
> >> +# Note: make sure the branches in this list are the same as in
> >> +# `.container+build-rules` above.
> >> +.build-only-delayed-rules:
> >> +  rules:
> >> +    - !reference [.common-rules, rules]
> >> +    # Run when re-enabling a disabled farm, but not when disabling it
> >> +    - !reference [.disable-farm-mr-rules, rules]
> >> +    # Never run immediately after merging, as we just ran everything
> >> +    - !reference [.never-post-merge-rules, rules]
> >> +    # Build everything in merge pipelines
> >> +    - if: *is-merge-attempt
> >> +      when: delayed
> >> +      start_in: &build-delay 5 minutes
> >> +    # Same as above, but for pre-merge pipelines
> >> +    - if: *is-pre-merge
> >> +      when: manual
> >> +    # Build everything after someone bypassed the CI
> >> +    - if: *is-direct-push
> >> +      when: manual
> >> +    # Build everything in scheduled pipelines
> >> +    - if: *is-scheduled-pipeline
> >> +      when: delayed
> >> +      start_in: *build-delay
> >> +    # Allow building everything in fork pipelines, but build nothing =
unless
> >> +    # manually triggered
> >> +    - when: manual
> >> +
> >
> > Do you think we could avoid repeating code by using anchor (&) and
> > reference (*) ?
> >
> > https://docs.gitlab.com/ci/yaml/yaml_optimization/#yaml-anchors-for-scr=
ipts
>
> We could create anchors for the repeated rules in .container+build-rules
> and .build-only-delayed-rules, but I would prefer to first do this in
> mesa and then adapt the same in drm-ci. Right now it is the same as
> mesa, so maybe fix this in the next mesa uprev. What do you suggest?

If we just herit from mesa, than sure, we can do this on mesa, but it
seems this could be made here.
But if you think it is better to fix there first than update here, I'm
fine with this too.

Acked-by: Helen Koike <helen.fornazier@gmail.com>

Thanks
Helen

>
> Regards,
> Vignesh
>
> >
> > Regards,
> > Helen
> >
> >> +
> >>   .ci-deqp-artifacts:
> >>     artifacts:
> >>       name: "${CI_PROJECT_NAME}_${CI_JOB_NAME}"
> >> diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/im=
age-tags.yml
> >> index 20049f3626b2..c04ba0e69935 100644
> >> --- a/drivers/gpu/drm/ci/image-tags.yml
> >> +++ b/drivers/gpu/drm/ci/image-tags.yml
> >> @@ -1,5 +1,5 @@
> >>   variables:
> >> -   CONTAINER_TAG: "20250204-mesa-uprev"
> >> +   CONTAINER_TAG: "20250307-mesa-uprev"
> >>      DEBIAN_X86_64_BUILD_BASE_IMAGE: "debian/x86_64_build-base"
> >>      DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
> >>
> >> @@ -20,3 +20,5 @@ variables:
> >>      DEBIAN_PYUTILS_TAG: "${CONTAINER_TAG}"
> >>
> >>      ALPINE_X86_64_LAVA_SSH_TAG: "${CONTAINER_TAG}"
> >> +
> >> +   CONDITIONAL_BUILD_ANGLE_TAG: fec96cc945650c5fe9f7188cabe80d8a
> >> diff --git a/drivers/gpu/drm/ci/lava-submit.sh b/drivers/gpu/drm/ci/la=
va-submit.sh
> >> index 6e5ac51e8c0a..f22720359b33 100755
> >> --- a/drivers/gpu/drm/ci/lava-submit.sh
> >> +++ b/drivers/gpu/drm/ci/lava-submit.sh
> >> @@ -48,7 +48,8 @@ ROOTFS_URL=3D"$(get_path_to_artifact lava-rootfs.tar=
.zst)"
> >>   rm -rf results
> >>   mkdir -p results/job-rootfs-overlay/
> >>
> >> -artifacts/ci-common/generate-env.sh > results/job-rootfs-overlay/set-=
job-env-vars.sh
> >> +artifacts/ci-common/export-gitlab-job-env-for-dut.sh \
> >> +    > results/job-rootfs-overlay/set-job-env-vars.sh
> >>   cp artifacts/ci-common/init-*.sh results/job-rootfs-overlay/
> >>   cp "$SCRIPTS_DIR"/setup-test-env.sh results/job-rootfs-overlay/
> >>
> >> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> >> index dbc4ff50d8ff..84a25f0e783b 100644
> >> --- a/drivers/gpu/drm/ci/test.yml
> >> +++ b/drivers/gpu/drm/ci/test.yml
> >> @@ -112,7 +112,7 @@
> >>       - kvm
> >>     script:
> >>       - ln -sf $CI_PROJECT_DIR/install /install
> >> -    - mv install/bzImage /lava-files/bzImage
> >> +    - mv install/bzImage /kernel/bzImage
> >>       - mkdir -p /lib/modules
> >>       - install/crosvm-runner.sh install/igt_runner.sh
> >>     needs:
> >> --
> >> 2.47.2
> >>
> >
> >
>


--=20
Helen Koike
