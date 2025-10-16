Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320CE3451BE
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626359; cv=none; b=FBYoe+NP7zG/hebPVFMdheszyRGw1j+RCxSjEwqE66mTLqakhS8bRqAFxVJ3bU/CDjUS7QnuBhyUpOWPT75hpbhlkg/TJwUYvdVpkZXsGqh1yzQYNnggCPXlI2Y7p4V6MfE37fF7PKlt2tR5G8b6frxwWfPIxDdgHSh35ZEQH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626359; c=relaxed/simple;
	bh=bb2uPhrku27uZPv/Jf75e5nhpowUMYOiMnBB5KihFPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbhDiJDPI0f0uiXwxi+KMJ5J38b6C9mPXATj690MZ6VkoGETGToh3J5xE7gOvFPPKoM3m+u8po2a7dqIQFxhzjFUc4qW/WgEY+b38R7gSgpmBCouVOBRsjP+9NR1kyIan75fdVOvRRV+EKAODUPI4kvbjoq4ppAe9yGD3Mq8i1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oK0IvGUF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oK0IvGUF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDLVQO022777
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=jPmtY2bWstZxGYrHD2oLA4kDgMlBAGLM7cSsgPby8R8=; b=oK
	0IvGUFq5Jpvs+nDFM/Il2MpT/ilhF7MHPLO+EQjXbkTN5WAB2rI0VHOSOOV+Qzxv
	sRtsBKGetq9wWxLEcY2lXvRoMYL7LPpZ9pIVBfAimdy6R2mv9p6gAudwk8iSrs25
	65FvBqQsyi+Yt4UDL56r1HgrPj1Jwtkn5AOnrPf0622q69XSNno8TLBKC0CUEYol
	ixpON2jXbKn9SfLTwAQqtm6rDhMB2kh0BfyW/hagjxvIxYHeAEDIseAWzJedm9W+
	vK8BUcdjcOH0s4pKDHXdtZfLjAruVuPpD/VTQr//0Fa2Z6QX9Ou1aNUUAQRav4qz
	6q8Ce5vsU3zTX1Onw0lQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0r908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 14:52:36 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3c98354c16eso153115fac.2
        for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 07:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626355; x=1761231155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPmtY2bWstZxGYrHD2oLA4kDgMlBAGLM7cSsgPby8R8=;
        b=pz0vz8SuJS6eYZOuQb2eC80fekVp7bd94E/xhzCr3hkzmBuptHxKBc3blTtCMcqzXH
         L2ghwMQ7PQ3E7sCB5tBVUvJSHHKyZfdA2a6kqypk12deAEwjxEmhuJhpUAXg1XkurFXX
         FS+l4Ncxw5p4+pRBgYnhY4k5MbmNDx9vdPdXpvxOonc7Ifn1BPTpYkbO+vHDTzc90C4w
         f83L81bwVYPmqp5JNFWpNKEvo1WE6GWPxo8d44NlXb+L75vnRi3Dn2IDqH2nhAnT47al
         mWggnoUwLffFbDGpilsh/DJTwrRykMUw0KMkyVBn7XxnwCaM+SIHrF8x2KWOSDKZcyUG
         qrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3MPLLKP6gl0V8oJq6cSC82mWRkaDnJtX0XbCwXlfft0ChwN55fkoVeg6lq45r/0T3rJcb9AliL9qnoRN9xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpNGNLvsZfx79sOLUXnAzu0AOXBSjyrbiW5t2Q9Um+LMWq84IG
	bsjYHcJEp7yFkPATCkHfbr0v9LSvQl0gDrBZQSq3jjAK9+9qr8YlZOqQtyDi9He2xFq2Ah/AGrn
	FrHmQpN5Egg4N8BwiGHsaEMKEDJVVDXg1v/dxyjTYOYWXkHSnyJBoEeV5l905MRhNzuJhCezuVA
	l4aslHSnOx4sQq5nZ7ICaLYCKvYiBYDkrZQ+toLCMk+9V3
X-Gm-Gg: ASbGncvFxNbUEyYy2Z/N8SefdqmBUnOFLtCxk6bZUenQ8IRNUdwnPm/B590chztQs8s
	xnHSDX9/ONf/apaWIyRq2hYxHxwywmliJqlHgXFhj7qV+nto6L21KGeHoGo9+lDGSONaNZwmsgK
	o/bvtoj7gs7Tca51edzMRGwYpkDRNs8iEGLufgMXkaWvh0DYu3Ql4S5ro1S4CO3Sv+fmDUdP86T
	iKDzUtqINnMbUY=
X-Received: by 2002:a05:6871:2e88:b0:35d:a9e2:fbd1 with SMTP id 586e51a60fabf-3c98cfa8295mr10091fac.21.1760626355264;
        Thu, 16 Oct 2025 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF39ocujuIwT0Et62sHrBT+rRRN4wBRxOHxmKLmre65EnhOwqDPEsCuGBua+8VJiCAAa15gVkxk2D9mH6TwzQ8=
X-Received: by 2002:a05:6871:2e88:b0:35d:a9e2:fbd1 with SMTP id
 586e51a60fabf-3c98cfa8295mr10075fac.21.1760626354773; Thu, 16 Oct 2025
 07:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com> <20250718105407.32878-2-vignesh.raman@collabora.com>
In-Reply-To: <20250718105407.32878-2-vignesh.raman@collabora.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 07:52:23 -0700
X-Gm-Features: AS18NWBmqrEUHFQlSWdIGqm2-_tBPDNsmr766wJpJByzaFclGFLQ0RGnzuLEsPQ
Message-ID: <CACSVV029ueL_4Y5irmmOwy_9QDQGqDe_1wCGUe22FdefQiNjkw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] drm/ci: disable apq8016 and apq8096 bare-metal jobs
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
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
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f106b4 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=Gxbm4VOBLxWGKnsTXboA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: Lq1R_FNPRHcG6TqJTcY16AuuN9Qt1xOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX7zZWyQrGW4M5
 hKAxeVafiibfgzDYvaDlE1Ge4Mw1LwI54iHDvXmqHHJ2zqRwzY+fBU+SK1hfsBGENm0xVhSHfVo
 uv2MbMEqjfuCVLXrQOPQecSmYu5ZVVvgVW79Pzqa2ywf7eN063vS/WsdNtH+gB18wU/o1BqiUpM
 +TIYXGYlV8ofec44qRopR2llBkIT4VSFV4aLOxYj+/VCAA2omT/wDwNRqaR24IiSpsJNzXg8wm7
 /DKDiTY1F1XNfdiWKzNs7rnsZc2xsOfCX7GHtBTCPKh/rhFew5jnfniRuGm0Tdf7VgyvG8dq8rB
 drHNHtr2+doXsig1tEia7YFlsrZxZjVQWxoKzPIGyCWVbxox5zDrhDg4AvjBmbZePc65+1Mo9p8
 jnj+Pi4IQdv0SG+pa/jgl+rnlvrZmQ==
X-Proofpoint-ORIG-GUID: Lq1R_FNPRHcG6TqJTcY16AuuN9Qt1xOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

On Fri, Jul 18, 2025 at 3:54=E2=80=AFAM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> These devices are being moved to LAVA. The jobs will be enabled and the
> job definitions will be updated once the move is complete.

fwiw, the runners are up and running in LAVA now

BR,
-R

> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/test.yml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 81147e86bfd0..53d19ffaaf61 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -148,7 +148,9 @@ msm:sc7180-trogdor-kingoftown:
>      GPU_VERSION: ${DEVICE_TYPE}
>      RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-kingoftown
>
> -msm:apq8016:
> +# FIXME: Disable the bare-metal jobs. These devices are being moved to L=
AVA.
> +# Once the move is complete, update the job definitions accordingly.
> +.msm:apq8016:
>    extends:
>      - .baremetal-igt-arm64
>    stage: msm
> @@ -165,7 +167,7 @@ msm:apq8016:
>    script:
>      - ./install/bare-metal/fastboot.sh || exit $?
>
> -msm:apq8096:
> +.msm:apq8096:
>    extends:
>      - .baremetal-igt-arm64
>    stage: msm
> --
> 2.47.2
>
