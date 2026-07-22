Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF63515F4
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735291; cv=none; b=qj26A32VHtMTQuyOmXyyRAy6rTAo0LBg1tL8eVZuYRoTalH9G26bOgTh+RmzvtG1MZnKil8DgF3/RXvLNqqgoF/z2gPsnoV/RNqYxL60OnuAydZDnyT2V+9V1oa3NttMRIIFD0Ao6FOVyTfMvNr0Cvd4bGRVxGnrp+2JDDdhCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735291; c=relaxed/simple;
	bh=+Rvc1vJii0V7ir/NkGyyB5IORynfDUzGTfbHXnEy9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pewCO9ujOdDLtV1rCYVMN+ag2pqTQiG2H3ZgxdJn3iXvUMCqzUgfqIE3tpn74JTHIF79C/MmFwhPeOpBbHZTPIuZrNLlTm0AxzFuR7lKW6ibyWK7cwPJuUhDVOP8mJ8hzRdhjXs6tienb8MTZLsoruWsi1UTngJy/yTcdUcJPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oetnZ/K9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BphcFOaK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oetnZ/K9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BphcFOaK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXwf51176081
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 15:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Raz4alVB0GePm5R01e5NWC1k
	FuMU19+HyNsvRe8tJ+U=; b=oetnZ/K94qahcJtXJ8/l8ysg786JU6ndpLJBdVod
	jG6yA71Yv3e67iFO5EOPEDg8+M5iqZ+XVYYRN6G3BGyGr30g2aohFamuYCRolylg
	rhEK5FY+/WIU1T29tav6QKdAtPkbn3EljvQwfa4lZaoLyHJUlBGgNGdJl8McWzlv
	iiNCaogR707SwOQC7g2mB4oZHm3P/zCGYqL9GviRgsH132deOAC5sauPIkjgESvQ
	vHn3s3mH8SY8TfjKULv9JF3SehYtguzrxSjdctG/lkRVoNqxfwnZfd0T9B0iBok9
	pC0U0agCXlLRXI9g1OxVBatQmT1iKvcWxWW6YASd+emejg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm10nvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 15:48:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-522de3c645dso117696701cf.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784735288; x=1785340088; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Raz4alVB0GePm5R01e5NWC1kFuMU19+HyNsvRe8tJ+U=;
        b=BphcFOaKt8TDneDdURvdaq+tol5TtHiC3JES/whzVFqBRhVo/Pp1o30uhkKDlcUPDt
         XX77RX2mlVus2yMtjmOtjaEHTQsbncLNJpMVI8tHScvczDy+AK7ud7DFV/6GPDf9S0mq
         mn4uDfbiBJqZZtTPJswu1BORJZ/VGS7pJ377LwwZcQZtIUwMIwyTdABpjyE0D94cRPlH
         Ayw0UTa4xJWMFgW2f5fher62pV45fJy6Yf4hokebSunNuzXWc+fY0Lvmcs6e3ILlR8FP
         osIdpCcY/ooCriVrnTFG0YA67vZ1hTe4WdocT80gaSKOXeUBvnMWcXoIlfoG/iV8cp+r
         nJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735288; x=1785340088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Raz4alVB0GePm5R01e5NWC1kFuMU19+HyNsvRe8tJ+U=;
        b=bGAWE8Gextf+u7l4EETSQX1xtoVIVisxaYT6vtyGw1LP8tTsphu+FjTj9SATVoZ6xI
         dNopJC+k6HHuHs5NrvmbqgebvcDHWx9wiByH8dNp0CJala0TtiVtZFFNJKq03KIX5n2Y
         ip+Ul3CkvOyX/9PWfNg9l8EV7UREzrqC1wyp7uDdR8yjM1E+0/L1/o7VJk0OsnB1rMLt
         bpDMkkcK95lUJR3OoKgvb5DsaWiX5sUE/1xMtG/3PI3gBYXRkJ4xNHJaV35cipUcQ+9I
         7CGwWVLsJwR6etuBJP529Bro788FytOsfETDWYVTAHv3utnTk8k2dpTh5KtDEFH+3pFw
         gcxg==
X-Forwarded-Encrypted: i=1; AHgh+RoE7N+75ELCw1oXddiLkQ/VH20Qz3xdMiCP57Erj37YMyEqrBfpNeO6B4P0G0BiPLNY3B6AeqbY0kKfUd2MOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxat4kZWLjj+IJ2wy30X1OdO2zt8zVL71Yl94T1fIj8LY9AUl7w
	KHpKFiKtgiPQuw8rCZHKYmzgrCou3Ntj7GAR0fzq5Rww83uw7hwU97xlie1QY12cXnYTvNKkRXR
	O5LaCM7DpKbzMEKEN7FRTk7HNf5hLSnUJIm9YyiHV6TsitjMfkQwrVNgkvVZrSa0eRHpqlg==
X-Gm-Gg: AR+sD13JgeEBm+t/23kQl7r66SOFNUbvmrxIuuWfWAUs2wsIPvXyndj+KZIVq49xy6o
	bGfliN1KoEfQre7pxc5v+64pwREDiSTxLbN7XOkHtuGpXVkZRSE59RGjXTZkmT5kKxbKgvnmP07
	ypMTBHdmEGOkcgkpSApZ4X2xqkj6wQC3waLdJeSGaw6//T1oB3Lf8GOD/ZiCg++uqEUfgXIiRJu
	U8MHtHjOkyvEwypR5BGFqmJyWoCBMmeSwS54yDkoeGGU44H9f1E1u8sZJHtS55h4hJj/m0Ci1Gl
	Ni07nAMmowxi4yg6NpROO7Aab2oTN532pCK5MDRzg1x1iivUpwTA1Shds6VI+S9deOCkCo9p+XE
	sOaQ7fHxJq2ICTWs4Y52TBiyczjlUxCHRrFc=
X-Received: by 2002:ac8:5dc7:0:b0:514:9ece:a15a with SMTP id d75a77b69052e-5213c7e6a0bmr236164671cf.45.1784735288064;
        Wed, 22 Jul 2026 08:48:08 -0700 (PDT)
X-Received: by 2002:ac8:5dc7:0:b0:514:9ece:a15a with SMTP id d75a77b69052e-5213c7e6a0bmr236164241cf.45.1784735287579;
        Wed, 22 Jul 2026 08:48:07 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac936dsm131989266b.22.2026.07.22.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:48:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:48:05 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
        Jason Wang <jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: rtc: time out alarm requests
Message-ID: <oeenihyehhfjnnbvrogrxyjyfqcak4jkwxmem3ww6pfpo66png@gyccpwq7eapk>
References: <20260714024352.71307-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024352.71307-1-zhaoguohan@kylinos.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1NSBTYWx0ZWRfX0Kx9RhMi6AjU
 8oh9iI0ArFYfEp+5lP/PgnXT6hDwc9vPfxq8PUAWMm4a5Feep1fTFlWNYybRJKxAfzuTvvy6JcT
 Kd3m6aobtN/v3TFWlvD6eHSHXNFdg0I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1NSBTYWx0ZWRfXyrwYx9PQ76yQ
 s88CmdJ0kN2BssdLvI9SyEyeNlrXk68HSAvuw3M9pvvJnGi6NwRN8qu/YM1LGLHqKUw4cP4LES0
 r0bNJzF6exdWLCIKgqrshkHjLpsDfAdgPscKyu3O/YzXEr9J6KDvZ9ZVl2kLzu6IJjovT7Ryynk
 TjMwG46o/pCHBcnued2RFSHig2jOVxh+03vNpfc4sNZ69JrdPXNVW4qkAs+VoUJFEb7OOL0CU7H
 WO5p2Gyx+sBeEQZ21KFIwv3awSMszjUCrwjwkIn89xoIk9F2x9+A8o4hxpCIO86CLfhWKvH/4H9
 RU/HJIff6asl3iME+kICJCRPldXnflX50B8opZQVmn0nBFuNVfgca28KdQEIZubVXI3HII0JGT/
 4/iGmkl/2qkrzPUiFG7bLVyiu4H8BpLTzh9YFq1XegFR9v7MtXR2/VXFh4/VIv3VzccEIAM9cVM
 l3iTq8cm10tEadfxlog==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60e638 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JFUxWelGuBFJwVQvUPMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GEtjRvJ-ImNjmZ02kX2cUuTFsiFAqTEA
X-Proofpoint-ORIG-GUID: GEtjRvJ-ImNjmZ02kX2cUuTFsiFAqTEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220155

On Tue, Jul 14, 2026 at 10:43:52AM +0800, GuoHan Zhao wrote:
> RTC class operations run with rtc_device.ops_lock held. The virtio RTC
> alarm requests currently wait without a timeout for the device to return
> their requestq buffers.
> 
> On surprise removal, virtio-pci marks the virtqueues broken before
> unregistering the virtio device. If an alarm request is waiting when the
> device stops responding, viortc_remove() blocks in viortc_class_stop()
> while trying to acquire ops_lock. The request cannot complete and device
> removal hangs until the waiting task is signalled.
> 
> Use the same 60-second timeout as clock read requests for alarm reads,
> alarm programming, and alarm interrupt enable requests. The existing
> message reference counting keeps a timed-out request alive until a late
> response or device teardown.
> 
> Fixes: 9d4f22fd563e ("virtio_rtc: Add RTC class driver")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Thanks for the fix!

Reviewed-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
