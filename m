Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FA2DA743
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111593; cv=none; b=Eu97QF19xix0gUID9BLRNGUlc+xwqUSGTryvyqQs49HRfTrQFkc+XEWQN4uuUQkCIoM6Z/zZF7I/jVaExBBuaTseSzTsXJoHpfndtXzHxNEkgCv9fF4ty6zWAuYsQhdvfvNfpSezfOtWi/dtzNruDms1mQ/NQR4a/hM9cTDNvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111593; c=relaxed/simple;
	bh=V2zOpe0W1PErgnFJB7s4XF1g/T4nndP6y9n3glr899Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbhMebSdX0erAZonep73iG7VBYCSSIPGfgLfXo9Dfw9ry+/yGVxeKR5aqUH2lrbipSe+QL+d17xdUMfGudzPPqLMivu2XqxO3AYBCo5XoPRjU5HyTzEpqLZXS880PBNn/BfqM/vGyX4YJ66cMadCAAytWs0mZNE6OUv4hLr/LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGkz1TGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGkz1TGc"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LABGr3031038
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 15:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=MnOD77sB2Ik3kJ7rDMTC033zhiY3x1p8B9vcyupzsb8=; b=BG
	kz1TGcI4MFfbOe5H/VgBz4u5HbpHgshH6Xl1II8hXJUKWkg8HPL9JYwqbx2neLEG
	ljnqf/ncKlo91sx1F74m4BqX/xfV1tDeVhB9CpttO0w1skrxPCoTRlkYij3WEpvn
	bnJ0ZuKiiHt6QSfoxIfml17kM8nKkQhyiagixzuZ1lf93nLPb7haKctryk4kfbyK
	15DboDxgowALoAWR3aPMDt2JL8rQj1+iDdDwdGKntmJdHp1H0jI/kUwq669Ldcfz
	/Ewm0bToxyO6SYurW+BdrDKtW1QOQthRkp9PWeJwGEvs4/CB1gS44/VtTpKhFiR+
	TJS7KfYYfiPU9zu1sUrg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tdtg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 15:26:29 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-41be154c1d6so3683595b6e.1
        for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 08:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111589; x=1753716389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnOD77sB2Ik3kJ7rDMTC033zhiY3x1p8B9vcyupzsb8=;
        b=gRXS3+SK1oFs0jUNdpTK+3k8uC9/4RDAI5zhZvGwSJxSOtCfSgIgfVDB4qK98fHSKc
         WruqIsdIPl0PpE/T3v9R1DKrYdqr0Rlpt5ww6ncW4N9xzShFmjMwlirPggfRKlZbeZlC
         ZDndQrpr03a2BRGNFjWN8DzhUN7b5IbGFPXad1hC2GuTc4D8kOQKzRzVQp9qELcrL7OV
         E90+a40n4v3hRpgvgWNmKxa9ypAmqrwrBw0l+fGEvp2nMizaMWxpD4qQoMQDUMKOmgY2
         UwpTSc82ODjVPtYNoALKjV8CvnTwhkSQGfgrngYu4HiSIsqRsB+I7ekbEqpM7Eja9Tdy
         oksw==
X-Forwarded-Encrypted: i=1; AJvYcCXsq4xtPz302KQ/07FCHqxXq/2RlnXa8hxsUGqklMgsbw4BTso0Ivm85W8siMzUg2jgHtKL72tKD6lal4zJLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv7l5anW1dg3cspXF0cQ12tam+/o/IkoU5rgzqcAWEOU5R1pa1
	3K2bP4IwLbl5+wczcC9nRyXKdHI9rbLn3UC5JmmiufZ/6K0YrHwkvUqZogmdxW2Kz5aIENt+6Z2
	yEWmaTOJQit4PS2M/jAkfj65PRZCMbqpWy71im+vR/F+pQjQh+wwK72f5Gyd9WrrEUE6gaY5sRj
	IvoDa74NKB2I55m29eL8CfID+LIlx3NJdHN+BtUAg0EK/R
X-Gm-Gg: ASbGncvMBIXtFCVJ1TMUMwWQK4whexEdL/vrbQDBJfb0mPD6aS2+TI6cwlWllrCoxbW
	jbk2yUyfR+5RH7IMUthP7KDEnLc7x4GNKO2tAAG9IqHVGNQwz6ykj4howI6QTW6sJQ7PgPHiaFP
	SI0rfZ1u7scA0JStjCPgVNuGosTMFrS0zuCS3XDC95ZRwUnp7t2iNZ
X-Received: by 2002:a05:6808:3a15:b0:40a:533c:c9cb with SMTP id 5614622812f47-41d05654bcdmr14287426b6e.38.1753111588596;
        Mon, 21 Jul 2025 08:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXFzYPkALClywTu5mOqRfeWp2m4fp272DjkezOJQOXBIAzqRGxPfJR9UxsN521B6259dXufoQBJ1qY0x7OZog=
X-Received: by 2002:a05:6808:3a15:b0:40a:533c:c9cb with SMTP id
 5614622812f47-41d05654bcdmr14287392b6e.38.1753111588114; Mon, 21 Jul 2025
 08:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
 <20250718105407.32878-6-vignesh.raman@collabora.com> <7c6suvc6quwwxni2nsos65btzim2lbv7f2u6mz5qbupzpmpzgb@g46wg63ubr6l>
In-Reply-To: <7c6suvc6quwwxni2nsos65btzim2lbv7f2u6mz5qbupzpmpzgb@g46wg63ubr6l>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 08:26:17 -0700
X-Gm-Features: Ac12FXw4vMk5Whh0pLXxQUQeTvmf5_E4on_jddtIDBax9_-2BPFjBHHhqwcfDPI
Message-ID: <CACSVV03x0DZLmoc_0GjiL+qhYH2ei8nKzuPRCTa+h6+j1pbhbQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] drm/ci: uprev IGT
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, daniels@collabora.com,
        helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
        robdclark@gmail.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
        lumag@kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfX3Z1xdi84BS9M
 wEJHbZrgq1tLtidLqTTBe+XPZe0xOqq71egIltrynZoJZ5kNNNlfjyrPwF/5ZmkU89BCZg2UZnK
 0h/I6moduyCNrgJ8mKmK0PRzEWveH/kbtS1EkKPbaPTLKpitxDmC2N3ltsW/tROA+WoI2z0huBT
 lahYtQJKBPcvye80PZlvnja74uJQOoXAcw4AB6uhwGXpdyDw/wTCJeR6rk+brxnPbweSARL48e3
 QTxV/9913fMOxPt7pEWdwbWk1QuDBqpVBSdqmh66z72r1jMpOeXVNDNT+Wxb93/DynKWOkrc3Ja
 KFNmWxybJpS9c7V3l9YQh9RwX3g9ANjl+bvDpLNMHI7oqWC8mpk0UW2XnDrgogtyjdYHq5aiWuY
 uEzIWmME8e9NpOrCX41L0PqBhwkzqNMnCqF8eauC0mLpcAuYXBmqwsIMIhRY1G138rx46VvN
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687e5c25 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=kxiJzIYbFHhRTRM7nIQA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: gw9tLW1XXWzVkn4XHnRVhJipkRE-2Rp_
X-Proofpoint-ORIG-GUID: gw9tLW1XXWzVkn4XHnRVhJipkRE-2Rp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210137

On Fri, Jul 18, 2025 at 5:54=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Jul 18, 2025 at 04:23:57PM +0530, Vignesh Raman wrote:
> > Uprev IGT to the latest version and update expectation files.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >  drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
> >  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   2 +
> >  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |   7 ++
> >  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  11 +-
> >  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   2 +
> >  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  29 +----
> >  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   7 ++
> >  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   8 +-
> >  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |  83 ++++++++++++
> >  drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt  |  10 +-
> >  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   3 +
> >  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   5 +-
> >  drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt |   6 +
> >  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   7 +-
> >  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   5 +-
> >  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  | 119 ++++++++++++++++++
> >  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   7 +-
> >  .../msm-sc7180-trogdor-kingoftown-fails.txt   |   1 +
> >  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   1 +
> >  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |   1 +
> >  .../drm/ci/xfails/msm-sm8350-hdk-skips.txt    |  73 +++++++++++
> >  .../drm/ci/xfails/panfrost-mt8183-fails.txt   |   1 +
> >  .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   1 +
> >  .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   1 +
> >  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  12 +-
> >  .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  21 ++++
> >  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   9 +-
> >  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  35 ++++++
> >  .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   4 +
> >  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   3 +
> >  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |   3 +
> >  31 files changed, 416 insertions(+), 63 deletions(-)
> >  create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
> >
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fa=
ils.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > index e4a8f8352cd6..9bf38c077f8e 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > @@ -15,3 +15,4 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> >  kms_plane_alpha_blend@alpha-7efc,Fail
> >  kms_plane_alpha_blend@coverage-7efc,Fail
> >  kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> > +core_setmaster@master-drop-set-user,Fail
>
> Could you please point out the issue / failure log?
>
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozee=
n-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-f=
ails.txt
> > index e4a8f8352cd6..7441b363efae 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails=
.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails=
.txt
> > @@ -1,3 +1,4 @@
> > +core_setmaster@master-drop-set-user,Fail
> >  kms_color@ctm-0-25,Fail
> >  kms_color@ctm-0-50,Fail
> >  kms_color@ctm-0-75,Fail
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt b/drive=
rs/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > index 8d26b23133aa..f387c73193c6 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > @@ -1,3 +1,4 @@
> > +core_setmaster@master-drop-set-user,Fail
> >  kms_3d,Fail
> >  kms_cursor_legacy@forked-bo,Fail
> >  kms_cursor_legacy@forked-move,Fail
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt b/drive=
rs/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > index 9450f2a002fd..84ffbe0981ea 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > @@ -210,3 +210,76 @@ msm/msm_mapping@ring
> >  # [  229.752499] CPU features: 0x18,00000017,00200928,4200720b
> >  # [  229.758095] Memory Limit: none
> >  # [  229.761291] ---[ end Kernel panic - not syncing: softlockup: hung=
 tasks ]---
> > +
> > +msm/msm_recovery@gpu-fault
>
> Hmm. I thought this should have been fixed...

There is another fix which came out of stress testing the kernel uprev
in mesa-ci:

https://lore.kernel.org/all/20250718-msm-gmu-fault-wait-v1-1-4dcadd3b0eb6@g=
mail.com/

BR,
-R

>
> > +# DEBUG - Begin test msm/msm_recovery@gpu-fault
> > +# [  153.288652] [IGT] msm_recovery: executing
> > +# [  153.295317] [IGT] msm_recovery: starting subtest gpu-fault
> > +# [  153.317588] adreno 3d00000.gpu: CP | opcode error | possible opco=
de=3D0xDEADDEAD
> > +# [  153.367412] adreno 3d00000.gpu: [drm:a6xx_irq] *ERROR* gpu fault =
ring 0 fence 814 status 00800005 rb 016b/0215 ib1 000000010000B000/0000 ib2=
 0000000000000000/0000
> > +# [  153.383449] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: hangcheck recover!
> > +# [  153.393296] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: offending task: msm_recovery (/igt/libexec/igt-gpu-too=
ls/msm/msm_recovery --run-subtest gpu-fault)
> > +# [  153.436085] revision: 660 (6.6.0.1)
> > +# [  153.439702] rb 0: fence:    2063/2068
> > +# [  153.443659] rptr:     360
> > +# [  153.446389] rb wptr:  533
> > +# [  153.449103] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
0: 0
> > +# [  153.455746] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
1: 0
> > +# [  153.462387] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
2: 2062
> > +# [  153.469293] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
3: 0
> > +# [  153.475680] adreno 3d00000.gpu: [drm:a6xx_irq] *ERROR* gpu fault =
ring 0 fence 814 status 00800005 rb 016b/0215 ib1 000000010000B000/0000 ib2=
 0000000000000000/0000
> > +# [  153.475919] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
4: 0
> > +# [  153.475925] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
5: 0
> > +# [  153.475928] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
6: 0
> > +# [  153.475930] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
7: 1
> > +# [  153.529587] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  153.539837] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: hangcheck recover!
> > +# [  153.549597] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: offending task: msm_recovery (/igt/libexec/igt-gpu-too=
ls/msm/msm_recovery --run-subtest gpu-fault)
> > +# [  153.566489] revision: 660 (6.6.0.1)
> > +# [  153.570099] rb 0: fence:    2064/2068
> > +# [  153.573878] rptr:     0
> > +# [  153.576411] rb wptr:  688
> > +# [  153.579134] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
0: 0
> > +# [  153.585775] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
1: 0
> > +# [  153.592410] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
2: 0
> > +# [  153.597308] [IGT] msm_recovery: finished subtest gpu-fault, FAIL
> > +# [  153.599039] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
3: 0
> > +# [  153.611856] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
4: 0
> > +# [  153.618498] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
5: 0
> > +# [  153.625132] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
6: 0
> > +# [  153.631766] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
7: 0
> > +# [  153.639162] *** gpu fault: ttbr0=3D00000001042fc000 iova=3D000000=
0000000000 dir=3DREAD type=3DTRANSLATION source=3DCP (0,0,0,0)
> > +# [  153.648502] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  153.650144] *** gpu fault: ttbr0=3D00000001042fc000 iova=3D000000=
0000000020 dir=3DREAD type=3DTRANSLATION source=3DCP (0,0,0,0)
> > +# [  153.650241] adreno 3d00000.gpu: CP illegal instruction error
> > +# [  153.671006] platform 3d6a000.gmu: [drm:a6xx_rpmh_start] *ERROR* U=
nable to power on the GPU RSC
> > +# [  153.687278] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  363.495437] INFO: task msm_recovery:876 blocked for more than 120=
 seconds.
> > +# [  363.503070]       Not tainted 6.16.0-rc2-g0594d0b01a7c #1
> > +# [  363.508838] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" di=
sables this message.
> > +# [  363.517142] task:msm_recovery    state:D stack:0     pid:876   tg=
id:876   ppid:274    task_flags:0x400100 flags:0x00000009
> > +# [  363.528876] Call trace:
> > +# [  363.531554]  __switch_to+0xf8/0x1a8 (T)
> > +# [  363.535703]  __schedule+0x418/0xee0
> > +# [  363.539486]  schedule+0x4c/0x164
> > +# [  363.542986]  schedule_timeout+0x11c/0x128
> > +# [  363.547281]  dma_fence_default_wait+0x13c/0x234
> > +# [  363.552123]  dma_fence_wait_timeout+0x160/0x45c
> > +# [  363.556947]  dma_resv_wait_timeout+0x70/0x11c
> > +# [  363.561582]  msm_gem_close+0xac/0xe4
> > +# [  363.565405]  drm_gem_handle_delete+0x74/0xe8
> > +# [  363.569951]  drm_gem_close_ioctl+0x38/0x44
> > +# [  363.574297]  drm_ioctl_kernel+0xc4/0x134
> > +# [  363.578442]  drm_ioctl+0x224/0x4f0
> > +# [  363.582050]  __arm64_sys_ioctl+0xac/0x104
> > +# [  363.586292]  invoke_syscall+0x48/0x110
> > +# [  363.590254]  el0_svc_common.constprop.0+0x40/0xe0
> > +# [  363.595197]  do_el0_svc+0x1c/0x28
> > +# [  363.598705]  el0_svc+0x4c/0x158
> > +# [  363.602035]  el0t_64_sync_handler+0x10c/0x138
> > +# [  363.606601]  el0t_64_sync+0x198/0x19c
> > +# [  363.610465] Showing all locks held in the system:
> > +# [  363.620406]  #0: ffff0000840200a0 (&tty->ldisc_sem){++++}-{0:0}, =
at: ldsem_down_read+0x18/0x24
> > +# [  363.629412]  #1: ffff800080d7c2f0 (&ldata->atomic_read_lock){+.+.=
}-{4:4}, at: n_tty_read+0x15c/0x57c
> > +# [  363.643169]  #0: ffffbd9c0475d920 (rcu_read_lock){....}-{1:3}, at=
: debug_show_all_locks+0x18/0x1c0
> > +# [  363.654158] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> --
> With best wishes
> Dmitry
