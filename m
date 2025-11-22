Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A62F1FDB
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763813123; cv=none; b=haB4ZXde/2XBnRgOjLb5vSvaFMtrHkMr774vu1TmE4P+M892xVNGkagiaCm81ToYinz5H4Qz0TuOTden/8xeOpnJHTE5RuBG2g1/ZVLCjAugUKkoW3J7wK4AgC4pBaGj2U5RVHKTGE6xVlKf2EigNLCx5a2bRcNjj2KnogkspzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763813123; c=relaxed/simple;
	bh=uXGvMROAHpshYmghRoQmWEyc2actGmT3hsXg3x67nQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQsBviqwN79ZIcfbEUb0RcZ0ngQA2Zi5NPPxMJGENplqEvRxe4sfdusNQ0hTDShmW/dbgMRKeCq7oyl6MH98Ve0urJfI4yfFJ7314pCTAfCKItfgQI1jlwFcV3IG991z/6dnKEmToY33QTOUlIgznE9dnpL76eIveP8jck1KAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QRMmlt5X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b/+589X4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRMmlt5X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/+589X4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AM5IB0d1883044
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 12:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMWEgHg+/7nPckwM6kiC7O9uDBWsoXKWRxhmJGNuWpI=; b=QRMmlt5XghFkwSc2
	0Tibg8ewJujZRoG9+z9cygSPVAIK9qf6JWgJ2HDYA1f5n8diMxpz2zk1RL4nojIq
	K5T/VkWgCo8aH/16Zc/6NjDc+vZtLamvPJ9toN4+0AtUrHDh7h2ZV4JBRecfiZPJ
	AvhqOixDAqY2PompXPiy5vEiyEg8Bdhwc07GLFRf31XNNDSt83K9VdwDKcmOHumi
	8R6WNZNKXjCfY874Rr0iy1ipuRjfOe8/hAl2ZQSGSZ4C2PHBcXHDNCoNaCZMhcHQ
	rxB2PbOwziyiooww3wtPF4OeePG+QJnk9S+qsMPAPrHKDZbccqbXpCYrZfZxH98S
	pDcv7w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6a50mgf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 12:05:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297d50cd8c4so95864415ad.0
        for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763813119; x=1764417919; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMWEgHg+/7nPckwM6kiC7O9uDBWsoXKWRxhmJGNuWpI=;
        b=b/+589X4IjqjrKTHO2GVVuuZFAeMAKvYZW0YievUVCwAuRpfuS27qZ5Si8+QNUAZQ8
         5GGzBeNfKqGFtQ3Kd6q0K2hV5hk6iVgTrrXjadyMh7g9dWvnyWhh79aE6wfBRJM98ZeD
         nU1T3ZKwT4JE5cVU42/G0DLsB/uRvclGx/TsM7srlcAAmiU6wevSxzoi4EQXDA/x4K7d
         2euhIMU58HEtOZkzXsMZCGXjgj/S4U8slRDGk5butr0hYfPVM5ajAzvnTEVLHkCVMyTf
         xLO6vkwQckQ2SyhQySbgycCCRzj+pkeIyIUp0CbH/cwEW7YbNDxjdBPSEzWIiXJdT6HV
         ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763813119; x=1764417919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMWEgHg+/7nPckwM6kiC7O9uDBWsoXKWRxhmJGNuWpI=;
        b=sJ7eHt+4vQi49wg7UYCyjudaqMiARMPhM4CJqi1xlX5bGM9ytGM6y8DNBhhDO1Qj6y
         78Qrls+dmoG8Hv95pTZ7s2UcfjUONeLPMya/eA4K2psfI/fWilh7lLehAob2RATSJymW
         ES9LINUjD2AZONUo2rJLNLhPxokJntEkFNDe/4pdmXh8HhbOf1G4RUaY8LJi/sEkV8q5
         MoOOSH+7sG0EF+0b5aU1t8hOe3c6uWTofDkvnEzgrvLziqcscGWPChFG4T4OhwpwcO+/
         axJ5acM9CPs74qOsDqLF1oMxXKlPeD8xV685bcLBzKaVcM10P6drL+zVb7OkAODhSrjm
         /EIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnMiS+GecQOhybxmNALawipf4276BKb7m/y4hXquGTJARuiqGz+TGXg+9fuEKnwPFPVJZmG3t1Ua/d7NZ+aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIKUVOK9/7i4ZbU7C8FN0krtYdn0ruY2AZstCVRGtAId7WOSa/
	tDnvKSMtEwsXtMOz4thDUOJeGkA/ql3WMFi+sIlx3UEfBw/DsH6srR2S78xK75J7ZJWMyVDIqRb
	3htoCLDUzkhnPoAcM0+PejPwlqBwL+J+A/cY77njVwQleFlejivyrkzlTMfUo87i9TxnRcA==
X-Gm-Gg: ASbGnctXwqBHxNQlZTiSdHmxtvpOXdJkW7i4Hvdi8BWQlhbJywBh37SzXRyqPIouVMj
	ZvENSbANT2DWJG8JYxsnsmrxiKMc0ls9zs3lNCGdZ7o2+d8Dd3vHoicsf1NXhWQ6Xa0xwr6HUpF
	ca8gEqFIF06w52NIldYW2pp1PPBx+bz9K7C11WnUyR43m72ySuADCPBp/P5Lx4kdMxaLka1sIBz
	WbqkZlysEhO17lT+aqX80zuQCp4F69YNjEQJl5pNVqjrdmoC5Gfdj5ApTx9EFie90odrR22lSyI
	U3vU7vpKJUc7zbQjQyZ/mYhhF5J8zdXyMAa+NaP2p0Ybwn6aG+OUR6CYiCYBR6BqgKbrMBXPWA1
	7Ak2z4ttRde/ZdfDHjZC2jythaKbr01Jud7Th8DNRIhydGXZZqcidhJAYxnvJUPnX9asCphU18H
	uvHfsMDQ==
X-Received: by 2002:a17:902:ce05:b0:298:6a9b:238b with SMTP id d9443c01a7336-29b6bf5d1f9mr53407055ad.51.1763813118586;
        Sat, 22 Nov 2025 04:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh7a4t8X5LiwBFrOGGuWCgNkjbWSu6rXohSgNewzmCoDcX1pSM4YDCYw1lbt4dDWSyc/4t0A==
X-Received: by 2002:a17:902:ce05:b0:298:6a9b:238b with SMTP id d9443c01a7336-29b6bf5d1f9mr53406925ad.51.1763813118076;
        Sat, 22 Nov 2025 04:05:18 -0800 (PST)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fff4sm84712425ad.68.2025.11.22.04.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 04:05:17 -0800 (PST)
Message-ID: <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
Date: Sat, 22 Nov 2025 20:05:12 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        virtualization@lists.linux.dev, xiaoxiang@xiaomi.com,
        Xiang Xiao <xiaoxiang781216@gmail.com>, zhongqiu.han@oss.qualcomm.com,
        arnaud.pouliquen@foss.st.com
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251114184640.3020427-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hup72kTS c=1 sm=1 tr=0 ts=6921a700 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8 a=zd2uoN0lAAAA:8
 a=j2MSVUfDAAAA:8 a=85zCUTaWTTiqXNVO5SsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=9a3gGlFUS2ax-cngMeOV:22
X-Proofpoint-GUID: E8iRpN_CNyniZXT6pvLuL-rKc-ulgJD4
X-Proofpoint-ORIG-GUID: E8iRpN_CNyniZXT6pvLuL-rKc-ulgJD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDA5OCBTYWx0ZWRfX2p/8ftHgwDAx
 Fbxgcmt+gqsOh/uqM/VTxIL9C/ZOVZr8PJF0fnfpnlizxZ4h5nQCn+uJt7DUOoJGzuG7vJO5Avd
 p5Xn0RpVZDWk5+FCBqgd5BEs0ng3AUqwznWS6hqcBHYL/VHAwphYmKaPx7bYHHdSmcg7PD+wHvH
 62XyTdaYBxBNr0hB5VRW+VXqsS+VbqD/47UWxBFOhnzTKf8fFEtaAB2wA2DAn0ymdQ/UcGUz4ns
 2qj6BX9gr3nDSUdcIq+Vt7PMiVI39leSdpz9eCqUTUGkVySnJLchksyzQnuEWwStdYYvyjSjfo8
 soPKC3UTH9jygUVkGpXq+a27pqdYGLOJ2e8RUnmtuohMEeiF3ahGFJcEENtCI7qW/YHDfZkwLK7
 p1v1XTiKf+FLGL3dq/q6hs8Y02fBYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220098

On 11/15/2025 2:46 AM, Tanmay Shah wrote:
> From: Xiang Xiao <xiaoxiang781216@gmail.com>
> 
> 512 bytes isn't always suitable for all case, let firmware
> maker decide the best value from resource table.
> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
>   include/linux/virtio_rpmsg.h     | 24 +++++++++++
>   2 files changed, 74 insertions(+), 18 deletions(-)
>   create mode 100644 include/linux/virtio_rpmsg.h
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index cc26dfcc3e29..03dd5535880a 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -25,6 +25,7 @@
>   #include <linux/sched.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_ids.h>
> +#include <linux/virtio_rpmsg.h>
>   #include <linux/virtio_config.h>
>   #include <linux/wait.h>
>   
> @@ -39,7 +40,8 @@
>    * @sbufs:	kernel address of tx buffers
>    * @num_rbufs:	total number of buffers for rx
>    * @num_sbufs:	total number of buffers for tx
> - * @buf_size:	size of one rx or tx buffer
> + * @rbuf_size:	size of one rx buffer
> + * @sbuf_size:	size of one tx buffer
>    * @last_sbuf:	index of last tx buffer used
>    * @bufs_dma:	dma base addr of the buffers
>    * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
> @@ -60,7 +62,8 @@ struct virtproc_info {
>   	void *rbufs, *sbufs;
>   	unsigned int num_rbufs;
>   	unsigned int num_sbufs;
> -	unsigned int buf_size;
> +	unsigned int rbuf_size;
> +	unsigned int sbuf_size;
>   	int last_sbuf;
>   	dma_addr_t bufs_dma;
>   	struct mutex tx_lock;
> @@ -70,9 +73,6 @@ struct virtproc_info {
>   	atomic_t sleepers;
>   };
>   
> -/* The feature bitmap for virtio rpmsg */
> -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> -
>   /**
>    * struct rpmsg_hdr - common header for all rpmsg messages
>    * @src: source address
> @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
>    * processor.
>    */
>   #define MAX_RPMSG_NUM_BUFS	(256)
> -#define MAX_RPMSG_BUF_SIZE	(512)
> +#define DEFAULT_RPMSG_BUF_SIZE	(512)
>   
>   /*
>    * Local addresses are dynamically allocated on-demand.
> @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>   
>   	/* either pick the next unused tx buffer */
>   	if (vrp->last_sbuf < vrp->num_sbufs)
> -		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> +		ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
>   	/* or recycle a used one */
>   	else
>   		ret = virtqueue_get_buf(vrp->svq, &len);
> @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
>   	 * messaging), or to improve the buffer allocator, to support
>   	 * variable-length buffer sizes.
>   	 */
> -	if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> +	if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
>   		dev_err(dev, "message is too big (%d)\n", len);
>   		return -EMSGSIZE;
>   	}
> @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>   	struct rpmsg_device *rpdev = ept->rpdev;
>   	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>   
> -	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> +	return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
>   }
>   
>   static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>   	 * We currently use fixed-sized buffers, so trivially sanitize
>   	 * the reported payload length.
>   	 */
> -	if (len > vrp->buf_size ||
> +	if (len > vrp->rbuf_size ||
>   	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
>   		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
>   		return -EINVAL;
> @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>   		dev_warn_ratelimited(dev, "msg received with no recipient\n");
>   
>   	/* publish the real size of the buffer */
> -	rpmsg_sg_init(&sg, msg, vrp->buf_size);
> +	rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
>   
>   	/* add the buffer back to the remote processor's virtqueue */
>   	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	else
>   		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>   
> -	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> +	/*
> +	 * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
> +	 * size from virtio device config space from the resource table.
> +	 * If the feature is not supported, then assign default buf size.
> +	 */
> +	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> +		/* note: virtio_rpmsg_config is defined from remote view */
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     txbuf_size, &vrp->rbuf_size);
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     rxbuf_size, &vrp->sbuf_size);
> +
> +		/* The buffers must hold rpmsg header atleast */
> +		if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
> +		    vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {


Hello Tanmay,

May I know if the omission of = here is to accommodate the ping/pong/ack
scenarios? mtu will 0


> +			dev_err(&vdev->dev,
> +				"vdev config: rx buf sz = %d, tx buf sz = %d\n",
> +				vrp->rbuf_size, vrp->sbuf_size);
> +			err = -EINVAL;
> +			goto vqs_del;
> +		}
> +
> +		dev_dbg(&vdev->dev,
> +			"vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
> +			vrp->rbuf_size, vrp->sbuf_size);
> +	} else {
> +		vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> +		vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> +	}
>   
> -	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
> +	total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> +			  (vrp->num_sbufs * vrp->sbuf_size);
> +	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>   
>   	/* allocate coherent memory for the buffers */
>   	bufs_va = dma_alloc_coherent(vdev->dev.parent,
> @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	vrp->rbufs = bufs_va;
>   
>   	/* and second part is dedicated for TX */
> -	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> +	vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
>   
>   	/* set up the receive buffers */
>   	for (i = 0; i < vrp->num_rbufs; i++) {
>   		struct scatterlist sg;
> -		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> +		void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
>   
> -		rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> +		rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
>   
>   		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
>   					  GFP_KERNEL);
> @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>   static void rpmsg_remove(struct virtio_device *vdev)
>   {
>   	struct virtproc_info *vrp = vdev->priv;
> -	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> -	size_t total_buf_space = num_bufs * vrp->buf_size;
> +	size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> +				 (vrp->num_sbufs * vrp->sbuf_size);
>   	int ret;
>   
>   	virtio_reset_device(vdev);
> @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>   
>   	vdev->config->del_vqs(vrp->vdev);
>   
> +	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>   	dma_free_coherent(vdev->dev.parent, total_buf_space,
>   			  vrp->rbufs, vrp->bufs_dma);
>   
> @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
>   
>   static unsigned int features[] = {
>   	VIRTIO_RPMSG_F_NS,
> +	VIRTIO_RPMSG_F_BUFSZ,
>   };
>   
>   static struct virtio_driver virtio_ipc_driver = {
> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> new file mode 100644
> index 000000000000..6406bc505383
> --- /dev/null
> +++ b/include/linux/virtio_rpmsg.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */


Echo Arnaud's comments. If it is intended for UAPI, please keep it in
include/uapi/linux


> +/*
> + * Copyright (C) Pinecone Inc. 2019
> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> + */
> +
> +#ifndef _LINUX_VIRTIO_RPMSG_H
> +#define _LINUX_VIRTIO_RPMSG_H
> +
> +#include <linux/types.h>
> +
> +/* The feature bitmap for virtio rpmsg */
> +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> +#define VIRTIO_RPMSG_F_BUFSZ	2 /* RP get buffer size from config space */

May I know why skip bit 1?


> +
> +struct virtio_rpmsg_config {
> +	/* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> +	__u32 txbuf_size;
> +	__u32 rxbuf_size;
> +	__u32 reserved[14]; /* Reserve for the future use */

Should we use __virtio32 instead of __u32 to avoid endianness issues?


> +	/* Put the customize config here */
> +} __attribute__((packed));
> +
> +#endif /* _LINUX_VIRTIO_RPMSG_H */


-- 
Thx and BRs,
Zhongqiu Han
