Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207655;
	b=Or4Hj5Lh9VIlCzCAuo/YY2AxA8OCJSnBdAG6IWrLmJpxbgCxkrf58ORZbLhvA7r+WOVl
	 GH0idO6eT+bytmrhwYCT3A/jfPjefmpO2ht47e+gcuPHuYpOMSDwFbqsvjjpx4mi/8KUT
	 gsPLPo1pDuInkvKFBbLd8EaV2MOs16yBERSbYuuCiY3NKYmC6rauRMRh3W8hGaicSaPKa
	 AlJsZEY6kJ7+QGypjGPOAglRE7nxopQ2YhXStqGL/MS46Y5qWWVMSp+JVXkc+Je01aTEj
	 4krZfZbtOBHkTx3IFogYuVEGvLm2W8Mmtn1AQzTZI6atGez1pez7M1r5HECayVUISvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=yVEZdfrqnWoREnyQLPgTpyCdDOhNLBO5hd1CUBjj4Qg=;
	b=HFk/Bp4FNdWucTMj7Yi4BYMCOwaB3n9RC17GDY52CAmPXclva6X3eiVqOzqcxBcm+1L5
	 BZR1U4UVBTvZ89dP4x5gdh9JgJLIXGSGHpjbq6n34Y77mC4dFeQ5chnP5seJyaL/qD6EK
	 QcIxXTezPfcvWP3cDto686StIqvaFW305T3anx0uxtZAtJ5OOFPELUKK7H/JnTLjjQZLS
	 FLiPnCVKLN7lRxWpbMgnTIkCpPs+YkMF/BatqwvkzBwVt7p4ctwbY6j+Kele+nApU6WUc
	 uLUhlJtpoYWSzSYa8vsrq2S5TlUp4NDTaaKLhhXo+9dtGsSbSvqz8rbC7BZKeEQcFVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=AIlfUdj1;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA0606A710
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 20:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56BA0606A710
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=AIlfUdj1
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHA4km1877707;
	Fri, 20 Nov 2026 12:47:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=yVEZdfrqnWo
	REnyQLPgTpyCdDOhNLBO5hd1CUBjj4Qg=; b=AIlfUdj1UWpwHAKlNe10VDFmUMi
	rgn3PmdUOrYQqUaOe3M5TrEW5FxLSPZeIw7XHmGEZaKY4zS1m9UsBes6uxfpGhDK
	Zy12zzS1umyDlAYRUseJSRtMNklW3Gob6oFwDSFckoqiS7wo1hBG5WnY1fTYcmxv
	lIN2NIAAKqV5FFzu9LwXfx0L3kzvWjPKF9qU7NsTE79CzCkhpjOVOYqXvcuyQcm6
	8goQ+fHF/F2k2gb7nAAki1tZowd4kGOqFAcQupo3nJngCuTo5tdAHrHIsfa5PKQ+
	83nLgwPR8TsmkxRHbPkCtUrEFd8dOB43VpIO3IlbhHp6UBperhRO7KmksOw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tc41pjv-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 12:47:07 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 20:47:07 +0000
Date: Fri, 20 Nov 2026 12:47:06 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Tao Cui <cui.tao@linux.dev>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>,
        <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>, <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] vhost: account the per-device kernel allocations to
 memcg
Message-ID: <awCxyqE/9iSYBjZF@devvm29614.prn0.facebook.com>
References: <20261120054517.526275-1-cui.tao@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261120054517.526275-1-cui.tao@linux.dev>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA4MiBTYWx0ZWRfX4xJSOFOxWakw
 f0+6TcEAk+PtYtOm+LJafn/EIiSWnGMpUHlq7Ynou6Qm90/9/nkMRLNtF1Zmgre7RHXF+3L//9N
 YhQnGqBqFtrXFo3jCpCd6EVEsGN1PQ4=
X-Proofpoint-ORIG-GUID: sbvE7vr0sW5nObX-GRT6i78cDrRadJ8W
X-Authority-Analysis: v=2.4 cv=PuMG/AM3 c=1 sm=1 tr=0 ts=6b00b1cb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=je9U-9MI8qmF_auVsecA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: sbvE7vr0sW5nObX-GRT6i78cDrRadJ8W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA4MiBTYWx0ZWRfX3tINTm8axShi
 +1eTy2E3e4veKEtl8JzihHLuiMVfs8cD04Qb/vCI2OV4fPa1paI1r6hBZXt0H6fzsTeA4wNZYXJ
 0vnhQ4GlMyBFODqEUBLvkuXvi1EJRj5YRHhHhK+kIXNf4kz5D3TfslknX/USx/elFeQkijcNy4L
 4OIyud5pc2ZAq+HUJMNCtkvgfsZQDlMYRfaKWwzQFjXKVys9VeXbjILL9zUpaslbCE74ZrSHaur
 ubsPYUTA/3O40T2Yk56omgcfBvVGD8iv1YuB52sctsySvWu4Y1I4Fhir7pyskat8pgamrYTPgHH
 CFUD+4zWTp3hRtNAvuIdeLEpBvL3HCoVwmRZDNdnsIZeY8364z81gBF8gDX5G0iSZENSgJrIVdp
 B7SqnYav3WXOJl43gTaDF2uqo7/if+3RKrgpqj5NYKc27JK+r+Qo0c0k1SKu/PpNicS2a4KGy7l
 R+Hq812rDBCQ3OU3m6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Fri, Nov 20, 2026 at 01:45:17PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Everything except the worker struct is allocated with plain GFP_KERNEL:
> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
> the pending message nodes, and the vhost_net/vhost_vsock device structs
> with their fallback to vmalloc.  The worker has been accounted since the
> vhost_task conversion.
> 
> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
> device plugins hand out with passthrough, holds roughly 150KB of
> resident kernel memory per device after SET_OWNER.  Charge the rest the
> same way the worker already is.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
> Changes in v2:
> - rebased on next-20261118, where the vq->nheads allocation now uses
>   kmalloc_objs(); the flag addition follows the new form.  No
>   functional change.  Carries Michael's Acked-by from v1.
> Link to v1: https://lore.kernel.org/r/20261106131829.3228926-4-cui.tao@linux.dev
> 
>  drivers/vhost/net.c   | 14 ++++++++------
>  drivers/vhost/vhost.c | 17 +++++++++++------
>  drivers/vhost/vsock.c |  5 +++--
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 435d8ed3851f..390858056d20 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	/* No zero copy backend? Nothing to count. */
>  	if (!zcopy)
>  		return NULL;
> -	ubufs = kmalloc_obj(*ubufs);
> +	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> @@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
>  		if (!zcopy)
>  			continue;
>  		n->vqs[i].ubuf_info =
> -			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
> +			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
> +				     GFP_KERNEL_ACCOUNT);
>  		if  (!n->vqs[i].ubuf_info)
>  			goto err;
>  	}
> @@ -1340,17 +1341,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	struct xdp_buff *xdp;
>  	int i;
>  
> -	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			 __GFP_ACCOUNT);
>  	if (!n)
>  		return -ENOMEM;
> -	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
> +	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		kvfree(n);
>  		return -ENOMEM;
>  	}
>  
>  	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
> -			      GFP_KERNEL);
> +			      GFP_KERNEL_ACCOUNT);
>  	if (!queue) {
>  		kfree(vqs);
>  		kvfree(n);
> @@ -1358,7 +1360,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	}
>  	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>  
> -	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
> +	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
>  	if (!xdp) {
>  		kfree(vqs);
>  		kvfree(n);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index dc973287567c..e8f9dce52aa7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -526,10 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
> -		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
> -		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
> -		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
> -		vq->nheads = kmalloc_objs(*vq->nheads, dev->iov_limit);
> +		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
> +					    GFP_KERNEL_ACCOUNT);
> +		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
> +				       GFP_KERNEL_ACCOUNT);
> +		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
> +					 GFP_KERNEL_ACCOUNT);
> +		vq->nheads = kmalloc_objs(*vq->nheads, dev->iov_limit,
> +					  GFP_KERNEL_ACCOUNT);
>  		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
>  			goto err_nomem;
>  	}
> @@ -2052,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>  		return -E2BIG;
>  	if (max_iotlb_entries <= 0)
>  		return -EINVAL;
> -	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
> +	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
> +			       GFP_KERNEL_ACCOUNT);
>  	if (!newmem)
>  		return -ENOMEM;
>  
> @@ -3407,7 +3412,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  {
>  	/* Make sure all padding within the structure is initialized. */
> -	struct vhost_msg_node *node = kzalloc_obj(*node);
> +	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
>  	if (!node)
>  		return NULL;
>  
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0..2fa205967f8a 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -719,11 +719,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			     __GFP_ACCOUNT);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
> +	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		ret = -ENOMEM;
>  		goto out;
> -- 
> 2.53.0
> 

The vsock bits look good to me!

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
