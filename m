Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437363D8918
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038890; cv=none; b=MEGxpRcvsWms+jRC1DOrbLrgH6/I7CUPrtGVS1E/xq4uJkix5lboLeTa39JjzqolOZ7C5CUXHqigKbaNq7NCNsLqjKw2Jmp0NTWfulpdHXGG8nxw46LqRpJ7LGkqaHXLHjXvpdI0/KeIaoCg1hVye+geekz8wYu23/nHY49yasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038890; c=relaxed/simple;
	bh=qB8dszQ4HH4b+qP7XqTBHavXYE8W9Ysyf9ZB4Cgze10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWANqkodZhAqlqaxV7D36PVL/o4nLTBykpiQ0/RI6fKbG+j8apzMdCvL4+8r0X+iHKKZ4jVKP3zilIx1sneBUnUqOlEZzm/lh2MVsVs1exnWtX4jEdOtoExAVogJCyBASA3ouzB361R2t0uvMrQ8+KqHUIuiIEhuzei0nmIGE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DYciowe3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j69bVXdH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DYciowe3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j69bVXdH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O9N9Ad518493
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TJmwWUrq3nEzizLuipOWwz7G
	EHQrlcpxHIz9pRnCFJU=; b=DYciowe3um4GgzRBExrFiCS+hJtY81U/QH8nHwZ/
	ji9ovfCTdvSwgeI3nHdi90qOSoVhU/Rh8lT4Tp28/JhmjWtpZZ0lCGo8Q0vyUZff
	/bliYQMM4L0w7RnjeFaDkA/vSlsApUFnRQFC2m7Cl11xkPHtnB81n/Z17WIKEzfT
	lTcQPd7Bn4pc9R59eO55n0qra0BipXyxrpzlDlg3pU5D0d32Lr/3q6d//XZPk7hJ
	hceVe1CU7OWhbj4840cJxKcc5UPq7RsH3G++nz9jpdmxqyU0KyMUbXZDaIqm3kDb
	7NFUs+yzb+fCPIfy0HB76Ih9UdsRcznfcPu8cq5QQXHAHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr0fnjg2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:54:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50f13da9684so67282111cf.3
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777038883; x=1777643683; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJmwWUrq3nEzizLuipOWwz7GEHQrlcpxHIz9pRnCFJU=;
        b=j69bVXdHI4GhuUEn0HzjMtxV93tgAnyXaYT7BOjkdILqNmc79iN00LUS+zE34j3FPp
         4OFLHGOaW2SQXgUn39SpFVcABiUVK99szi8oZsnc7YHAPdVD51Jbz0QgTO56QHSVJKzi
         iNIunCF5XMUTmdn/ihiEHkRkSgLHIw8fzXdr9MRgcFoeYSv9W7iMND1HNcwxgDYZgfQ2
         ffHD5YOt4vAyV3bpwQ/JZD/TIqKy8YU/aKO23+5lmFbJvUOcIkJt6iB6ezIOhOwXadaz
         zHpYBXvBawiqhZfSjYJmv5uhEyUwiNsYieGYzXinJ17UUo+JGiMJFlw50w85JDiX0C70
         GLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038883; x=1777643683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJmwWUrq3nEzizLuipOWwz7GEHQrlcpxHIz9pRnCFJU=;
        b=Si/CfyPRRkefX7aMA5v14rkqbyFTi60hRkmiHrUc+pjZCmtu8uWSBRSCNwru0vzJqI
         QHL/iJyPvRw49oob9dk2tys0foDg7veleu5pyQIHbGWSBmDj1qqwZ/IlvO1DKR36bsIs
         vCh0sfh0coOSWaEZOCPd+2BEVm4jMGKgJP8CwmL16zSujUSDnz8gbY4sHnA3ataQ2pvq
         v6nIIX2L/auKUtB6HoEYCZPR45oqSl5v1dKWRsOrnD5pIVik2vVp7iWtI42Ttu1ztsee
         CMWflZEL3DIPuxwQjimxsm7COK3s+/6C3dOl4AZ5OdlPCbDgssbMq2rlsdCH/cIgxZQe
         I8jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CL/7bm+Bt5M3onp0MU1OlqgCwl4F2uSkkVP8wVwVUhmxGIPG68fdOV1DdOoL/metULk1GS0KArDYwUeIX8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxShGsrl3e3UIBndGa5zfxXPDBNT/LBLFrag/wIgIDWJ47ER5m
	wKn2iqW3ObNytefB14Lp/KsnLDaLd+3mL+/rDAtI600txnszRpaELVqclec+r2xX+5lR0jSE6ur
	HhHWeQZzCOMnx5zADg2AK6Dzb6+CzPTCTyiJCbuBP3hHxh/egxpQ90VIKhbZTBufUnLcbLf3Igv
	S9gw==
X-Gm-Gg: AeBDieuhWUm0bxLNRmArOwxqgbb4bfy9hW15Bkj4wTvNthRbdSuITprX48aG2R+X4kM
	nuEBUWCqXOnWMYjQZuXDGjCx7qFddEjjtIE+mKIZiuDmr6KgVf7e59zYQ050+dAuhmPW+ivDOQ1
	pfC2hbqEau+yJFqEe1W+Qx2nwjdQkUqNysLjZ4opuBeH84x5cqz7D+kJZdzqQBNAFU6gpz7sAws
	NU6c7cHhhcNOZwsul6Y/pFiOjNAwxEmX2NumqPcgnKnKaNBj+4COYlCm1YOzsxQyDOqyqRSmj6c
	5gftjdlerfbAUeZ+DXSPJpIhtekJ1z2hVPDotkjFCEpX5LxNA+PtUeM+TqMd2yLYG58Ee2q3K0H
	+Btd7jh+/y20HupAOuuMWQ79d2938WyIojZHbl+z1G1N+v8TVoGAFuz4hV/yAdtp7uug=
X-Received: by 2002:a05:622a:261b:b0:4f1:ba0b:90 with SMTP id d75a77b69052e-50e367fe1c5mr463167691cf.8.1777038882904;
        Fri, 24 Apr 2026 06:54:42 -0700 (PDT)
X-Received: by 2002:a05:622a:261b:b0:4f1:ba0b:90 with SMTP id d75a77b69052e-50e367fe1c5mr463167211cf.8.1777038882399;
        Fri, 24 Apr 2026 06:54:42 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d50922sm4663799a12.21.2026.04.24.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:54:41 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:54:39 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: JiaJia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: rtc: tear down old virtqueues before restore
Message-ID: <d2gtdzjz3bfs47rmeslo46dkwmjqpv2qjcxmpgbkcbxjrqbf6m@bkeeynnavvy3>
References: <iwb4axxcxti6bpgpde5cv3n7y46xaopvkbdd2kug3qhn2ehfim@ny45mixj7ncn>
 <69eaeca0.050a0220.408e2.027b@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69eaeca0.050a0220.408e2.027b@mx.google.com>
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=69eb7624 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8GN21xCyV1WYvO84Ks8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEzMyBTYWx0ZWRfX3WN9Sd+iGmq2
 tYrvuo7nc9mk8n2+QqUXo9UapyY/zJZx1CrIBrphS0u019bxFYJvUt3OKrWEL00PNVihHH7eGGu
 o24tfGTjBAMr5Y0F6BlwX77A4s5yrzoYvRaObIq+YddH8oKr53gI9tYYglt4Z6s86zvepJ4nnIm
 Nh4OK1i+8w9C5gE0FC5LCiK/Ietu0KtkYFmoEW6OTP7qEH67B2g24Y45xEHXtTYfI+GP/6b3Atr
 2A2COmo6ij2EVdSWaN7Zv/+2azotrxV4C6dMj8krZX68cS5HTlquWuTDaA3llfVhEcKr9yjC1vg
 +sQ5s6IaJ9nSA77+8AlUbSmONVxXOS/SORONjiPf6abdsxP4s96VVsMTXlfeTFINEElO9PSpvuQ
 p7kK79+rJ1wkcqvUu8TrjreBt6xIdmrErcgC3bE665oowRZYDVm7ci9Hum3ZKDWGOmEnimj0t94
 LP8PHPPtG1I0EYOCzrg==
X-Proofpoint-ORIG-GUID: 8VXx77_rz2UuLCTO3KEw63aKgDVCojww
X-Proofpoint-GUID: 8VXx77_rz2UuLCTO3KEw63aKgDVCojww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240133

On Fri, Apr 24, 2026 at 11:14:53AM +0800, JiaJia wrote:
> virtio_device_restore() resets the device and restores the negotiated
> features before calling ->restore(). viortc_freeze() intentionally
> leaves the existing virtqueues in place so the alarm queue can still
> wake the system, but viortc_restore() immediately calls
> viortc_init_vqs() without first deleting those old queues.
> 
> If virtqueue reinitialization fails on virtio-pci, the transport error
> path can run vp_del_vqs() against a newly allocated vp_dev->vqs array
> while vdev->vqs still contains the old virtqueues. vp_del_vqs() then
> looks up queue state through the new array and can dereference a NULL
> info pointer in vp_del_vq(), crashing the guest kernel during restore.
> 
> Delete the stale virtqueues before rebuilding them. If restore fails
> before virtio_device_ready(), reuse the remove path to stop the device.
> Once the device is ready, return errors directly instead of deleting the
> virtqueues again.
> 
> Signed-off-by: JiaJia <physicalmtea@gmail.com>

Reviewed-by: Peter Hilber <peter.hilber@oss.qualcomm.com>

What should still be added is the Fixes tag:

	Fixes: 0623c7592768 ("virtio_rtc: Add module and driver core")

Maybe the commit message could also mention that this can happen during
a non-faulty reinitialization, when one of the vp_find_vqs_msix()
attempts is unsuccessful before a later attempt would succeed (as far as
I understand).

Thanks!

Peter
