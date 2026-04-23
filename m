Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39B3603D9
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967364; cv=none; b=eXG1n4N0n4tr5k8oTGgCUd9K8GxlaPeQilT1sZH9EG+h79uyN4AIAeCJRWFnNHe/L0FXSRe6l3NnweH3W3zokibd8Rys/8C1CFblLkVbrAhnnPJH1fpdxQnpRuK6PMv0yRBTH3TE3iINPOaxSzk4eCoGAyzRUt7gp6IxUogI0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967364; c=relaxed/simple;
	bh=B8pi58elRtqxuENkeRM5CjB/0M9jad0ChC9yB/j4xfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E56ubEfuVbMO4699lqVbo4BGoCO/s652o0a52ZDFCy09f3UwPDvK17fsL+9k3Ze5/NLIYUsRMuX3IfWt67y761t9zoaz0OhqTkRRYiOk8rCxqpmxx/h7iVQ54yBk02oAAQRB/s6jsUly/rYEhvSTaecEmhzoCQJpIdptZ6I7Efo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdbQNt+C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPsy2BGx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdbQNt+C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPsy2BGx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NFNbsJ1204771
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qL5pkb9o0CCnuyrbw4vzw/oR
	B4wriojHDOoDpXabybI=; b=YdbQNt+CCtPDT/4eZI5bRqwzwpvi5rmTpcGNb4IA
	zNm6jGElq9wh8UKqtlwh4jTwfBq+STD897erivL1oe50VbB30ctv1Ktg7bRdCxCJ
	9H/5wyk9RYs3N7OT87pOBYR4E0V3C63BLKo+4dDF4HKpolDPwkuxwe5IGNkpMQPy
	UCty3UoercpqbU4UwDkyisz62NFhQzctmIAdZTKjL3PcQMjX4ptj5oAs+76AJwmC
	V2tehZ2iARKPYvSvDu3ZQyzGYh6bVv8sHDmJDUTXLlb+R7Fnakwl7RklTgmYgYfi
	CYcNRY8NPRYbCx9l8p3JBej+F+Fbzco8ELduMWSNIQ1sZw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggna7aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:02:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso69326915ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967361; x=1777572161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qL5pkb9o0CCnuyrbw4vzw/oRB4wriojHDOoDpXabybI=;
        b=gPsy2BGx5Rwr6IW0tgQBcuShzp67nyI1VLXjQWTxLavb2bFidI+v6w8uYwyYH6fgmg
         SHjuCREdA5kVitcUFYuhPKKlmgcKQGSBMCuTgnmiVvQ5vAtnY17bzAb5YFXiZS3WCdSs
         OaGhzPtXSnFh0cZn8USVVAz8XNok1qSXUgHVCg/WuN9rB7Nq+55kZocgL3jA8qz9lJoa
         AwEwZFm0coEOe3wnQVStcQM4aeonz+ENzzq17f6CWJ8LOTzzLpe2LrBnMZJZoIPYaIgE
         9Zf/THmmzLP+lIRG8K/JdDvWeVCHE20VHdWxQ0ihi1Tf52bvE221C61bB1oBPCV441sF
         UjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967361; x=1777572161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qL5pkb9o0CCnuyrbw4vzw/oRB4wriojHDOoDpXabybI=;
        b=mT7KpkFW0m+XZO8ujQ0LTSzYBMg/puGq6ehVSS87MYdS6A+PIxXNbylzx5YlpDIgOs
         8nRfpRg8Ux+8tWxVltsA4ysd+oHvsm171xBIj/dXa+H/T3tEAQ7ITDqBOfNSDule3328
         rdYICqNEIJfXc68BUD/xfcAqRdcEq/GAFeeTU/Fzvx1bw/90Zdo/R9n/038m96TbiXtu
         N6R3u7C/U4Ir1HeOVDHLNM7vAGiGDiDIMWv+hOfpDa177Q15LRYDewmpUUbFjXWE5Uo9
         pK+VfS+oGwl1AB8mM7JxgQI3ni/8cJejZxI8/83u3/SpQflWH7X7LhpboZ5ggx+ChT9D
         Kq0g==
X-Forwarded-Encrypted: i=1; AFNElJ/RBpXONvg1l5S0xS92WJDF58qAt3x1dWfv0HiqUYVIgC61Hu4O0txrZhRPmM/txqOvcLoi1g7IJcFfD1HX3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9Y1rG4QcrnkFXjRPY3THpXQ/oUFpqp0IP4SK7hgTS5+7kAelj
	RH3581CT1zcvutcwWj0cGaYfhMbEAY28pQTzj78kKMDZ5ojRZtDXb5dsCFcwF4I8J+f0b+p7cLl
	mwfR0DtPQOFbVRAomrtVfLi1SYp2qukWS0mT1xt+4qK6kOeaB5o7sA5n+2LZEAeHXbXnL1g==
X-Gm-Gg: AeBDiesfkEuvUcY/gBU6C84n7qeSFKLzYDx5wdux2QuI5aTflRYv74/7zUWD+ZM8paM
	u/1lwdW6+4QHaGhlEuHbezIZS0tboOdsHng5uHKHKVAg9AsMqLJsuLxz6rpxSc0Gn2gXdPw8K2e
	fDlAm6OQjzDKNv+SNmhUzReMKpY2iVmir63StmX+vI+R1/gGJoZaDcfZzHe8FRKd53Epke7Ty6O
	ZiXsbTfvvzImCAH97OANiucTqFGq8NpbANgYFPJifxoVaC06wR4c3Ag3rcZ7p/ixGzXD/JDGZ0p
	VkGDghEVARg4pozFiQr7iuvoJR7PZjS+XFN7HTfFnSp3JRzrMlLd6Pyh3iqkmG1jDEm223hdzGK
	Rm+gQwrtEzRfQnmRPhhupROS5Eo90E3C5HpLgAJnv6cePYT2CU9cDGMcRyfzYUFKGmuM=
X-Received: by 2002:a17:903:34cd:b0:2b0:7026:24c2 with SMTP id d9443c01a7336-2b5f9f6558bmr199759625ad.36.1776967361098;
        Thu, 23 Apr 2026 11:02:41 -0700 (PDT)
X-Received: by 2002:a17:903:34cd:b0:2b0:7026:24c2 with SMTP id d9443c01a7336-2b5f9f6558bmr199759095ad.36.1776967360383;
        Thu, 23 Apr 2026 11:02:40 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455926c61sm670064866b.63.2026.04.23.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:02:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:02:38 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: JiaJia <physicalmtea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: rtc: tear down old virtqueues before restore
Message-ID: <iwb4axxcxti6bpgpde5cv3n7y46xaopvkbdd2kug3qhn2ehfim@ny45mixj7ncn>
References: <20260417214953.793956-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417214953.793956-1-physicalmtea@gmail.com>
X-Proofpoint-ORIG-GUID: E9omZWYk9hDQfVBLY7DveRMd1542AjUm
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ea5ec2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=WY53yCBdcWsR-8r_lBEA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfXzS2xzxa3fLvl
 BaY0rPJ456wWckQTlItgHAeTzcqoBFB/WEy+t8M4dSsG9+Qk2Ws/gSzyRV5wuF+JDNSGxmr2Omr
 ZqTe7XtYnMf5ixCwtf7vxbTZ9dK8cMkg98dfGaXi+66Xf5BG9ciInl5NfUpNKYUtoSnS8pJYMUf
 dtOLRcQAoDHBiJ5dgsUAfGPZ3BhpCHxIgfAPuvQDsOc7wk1Av4SH6a2BnokZ8NMGXzK4D8BSzFD
 Bc7mQxdhYHt6y0UFfmgdsJvP0IQbNV9MdIdNabvJwB3aWSdY01R0ZJA4l8Iv4USvV0J9W0oRaiY
 8WUAuhUEVESKOCkq1kPlOyBPnJvZg3uL3eUDTXlmVOb0nY8+vOjzuFMjNp4xexK+0T7c62/WV+x
 16bkOoEnMdYFRL9DdqHEaf9cAXMO62Mjf/lDAs1FvUFtj/Ih6rPx6qA5X5KyjCxSOSJHa5xRa1X
 eh2WAb2HiGgC9aYLb3Q==
X-Proofpoint-GUID: E9omZWYk9hDQfVBLY7DveRMd1542AjUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230175

On Fri, Apr 17, 2026 at 05:08:31PM +0800, JiaJia wrote:
> virtio_device_restore() resets the device and restores the negotiated
> features before calling ->restore(). viortc_freeze() intentionally
> leaves the existing virtqueues in place so the alarm queue can still
> wake the system, but viortc_restore() immediately calls
> viortc_init_vqs() without first deleting those old queues.
> 
> If virtqueue reinitialization fails on virtio-pci, the transport error
> path runs vp_del_vqs() against a new vp_dev->vqs array while vdev->vqs
> still holds the old virtqueues. vp_del_vqs() then looks up queue state
> through that new array and can dereference a NULL info pointer in
> vp_del_vq(), crashing the guest kernel during restore.
> 
> Delete any old virtqueues before rebuilding them, and clear the cached
> queue pointers so later message requests fail cleanly if restore does
> not complete.
> 
> Signed-off-by: JiaJia <physicalmtea@gmail.com>

Thanks for identifying the bug and providing a fix!  I had a look at the
bugfix and I added some comments below on how I think the fix could be
improved.

> ---
> Runtime evidence from a standard hibernation test_resume run on a guest
> with virtio-rtc-pci (no fault injection):
> 
>   KASAN null-ptr-deref report in vp_del_vq.isra.0+0x70/0xd0
> 
>   Call trace:
>     vp_del_vq.isra.0+0x70/0xd0
>     vp_del_vqs+0xec/0x358
>     vp_find_vqs_msix+0x24c/0x6a8
>     vp_find_vqs+0x88/0x360
>     vp_modern_find_vqs+0x20/0x90
>     viortc_init_vqs+0xd0/0x128
>     viortc_restore+0x28/0xb8
>     virtio_device_restore_priv+0x184/0x288
>     virtio_pci_restore+0x44/0x58
> 
>  drivers/virtio/virtio_rtc_driver.c | 38 ++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
> index a57d5e06e..c1adde27d 100644
> --- a/drivers/virtio/virtio_rtc_driver.c
> +++ b/drivers/virtio/virtio_rtc_driver.c
> @@ -427,6 +427,15 @@ static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
>  	sg_init_one(out_sg, msg->req, msg->req_size);
>  	sg_init_one(in_sg, msg->resp, msg->resp_cap);
>  
> +	if (!vq->vq) {
> +		/*
> +		 * Keep runtime interfaces in a safe failed state if restore
> +		 * teardown removed the virtqueues.
> +		 */
> +		viortc_msg_release(msg);
> +		return -ENODEV;
> +	}
> +
>  	spin_lock_irqsave(&vq->lock, flags);
>  
>  	ret = virtqueue_add_sgs(vq->vq, sgs, 1, 1, msg, GFP_ATOMIC);
> @@ -478,6 +487,17 @@ static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
>  	return 0;
>  }
>  
> +static void viortc_del_vqs(struct viortc_dev *viortc)
> +{
> +	struct virtio_device *vdev = viortc->vdev;
> +	unsigned int i;
> +
> +	vdev->config->del_vqs(vdev);
> +
> +	for (i = 0; i < ARRAY_SIZE(viortc->vqs); i++)
> +		viortc->vqs[i].vq = NULL;
> +}
> +

If keeping this (see my comment at the bottom), it should go further
down, e.g. above viortc_probe().

>  /*
>   * common message handle macros for messages of different types
>   */
> @@ -1316,7 +1336,7 @@ static int viortc_probe(struct virtio_device *vdev)

In order to delete virtqueues consistently everywhere, I think it makes
sense to also "goto err_reset_vdev;" if viortc_init_vqs() fails in
viortc_probe().

>  
>  err_reset_vdev:
>  	virtio_reset_device(vdev);
> -	vdev->config->del_vqs(vdev);
> +	viortc_del_vqs(viortc);
>  
>  	return ret;
>  }
> @@ -1332,7 +1352,7 @@ static void viortc_remove(struct virtio_device *vdev)
>  	viortc_clocks_deinit(viortc);
>  
>  	virtio_reset_device(vdev);
> -	vdev->config->del_vqs(vdev);
> +	viortc_del_vqs(viortc);
>  }
>  
>  static int viortc_freeze(struct virtio_device *dev)
> @@ -1353,9 +1373,11 @@ static int viortc_restore(struct virtio_device *dev)
>  	bool notify = false;
>  	int ret;
>  
> +	viortc_del_vqs(viortc);
> +
>  	ret = viortc_init_vqs(viortc);
>  	if (ret)
> -		return ret;
> +		goto err_del_vqs;
>  
>  	alarm_viortc_vq = &viortc->vqs[VIORTC_ALARMQ];
>  	alarm_vq = alarm_viortc_vq->vq;
> @@ -1364,16 +1386,22 @@ static int viortc_restore(struct virtio_device *dev)
>  		ret = viortc_populate_vq(viortc, alarm_viortc_vq,
>  					 VIORTC_ALARMQ_BUF_CAP, false);
>  		if (ret)
> -			return ret;
> +			goto err_del_vqs;
>  
>  		notify = virtqueue_kick_prepare(alarm_vq);
>  	}
>  
>  	virtio_device_ready(dev);
>  
> -	if (notify && !virtqueue_notify(alarm_vq))
> +	if (notify && !virtqueue_notify(alarm_vq)) {
>  		ret = -EIO;
> +		goto err_del_vqs;
> +	}
> +
> +	return ret;
>  
> +err_del_vqs:
> +	viortc_del_vqs(viortc);

This looks racy to me, since we can end up here after
virtio_device_ready(), when viortc_cb_alarmq() could run.  But after
virtio_device_ready(), deleting the virtqueues does not seem to be
required.  So directly returning an error after virtio_device_ready()
should work.

Alternatively, I'd suggest calling the logic from viortc_remove()
instead of just viortc_del_vqs() (factored out as __viortc_remove()).
This would have the benefit of using the same logic to stop the device
in both cases.

This should also make the viortc_del_vqs() wrapper and vq->vq check
unnecessary due to viortc_clocks_deinit() having been called.

The tradeoff would be that self-healing on another restore would not be
possible any more.

Best regards,

Peter

>  	return ret;
>  }
>  
> -- 
> 2.34.1
