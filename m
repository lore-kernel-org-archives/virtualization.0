Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A4214801
	for <virtualization@lists.linux.dev>; Fri,  8 Aug 2025 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639265; cv=none; b=PKmy7MRyr6vowOTatmkmoveCV3MJ46Ph39i2l5APBZRIHCenGUJwasDHjoK9r4qQlcVeXtHSUo13So8nRCfh4PDFuYCFYlBJNnjC6+x4PCbqxAsQEoNEs1Aqn2eWIBeazRzQ72et2EJjUaW8Nhn+pLCEtbROk6HKRtvBUgWS2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639265; c=relaxed/simple;
	bh=AKeo2sd5swEgX4Q2i5QLzi6U9GgVahrKWPaX3AstgMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiwMV55CN9/ENpUdxAwNlPYjV9sLR9EIapsYLcl56MMUcXTyoZfrYP65oxxUKsZNWptf2RyeGctzx+haLSMkWX4+DtkFpafq8LzH6HNd88DXei6NhoUL0QD+mRx2rCKtzYHMsqKluwQ5m2n9T+w0ypq13tiEcINdgal13WRgQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cu6dOfSK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu6dOfSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754639262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9z92Cgx46Jeef+FwLHmeK77VJYJkUePJFOt0Vz3vqio=;
	b=Cu6dOfSKQTcSf4J0HtPxi18Kc5LoZzpF3HNtIJgxpn4ibAPS7CD6UhM5hty7OGsTQFrRI1
	KwyVLKhdyLhQnmA7JVWwlPUpbaMk+ErsDSEQeS/t7p2Nf5X2G5BSqqW3SmCRR5OFgIuMoh
	unFRelhrBGknxu+108bZgLm3wPkfSnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-fYcNuUheMN-MtHdaiXPtsQ-1; Fri,
 08 Aug 2025 03:46:31 -0400
X-MC-Unique: fYcNuUheMN-MtHdaiXPtsQ-1
X-Mimecast-MFC-AGG-ID: fYcNuUheMN-MtHdaiXPtsQ_1754639190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A8E518002A1;
	Fri,  8 Aug 2025 07:46:29 +0000 (UTC)
Received: from [10.44.22.5] (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62D43180047F;
	Fri,  8 Aug 2025 07:46:25 +0000 (UTC)
Message-ID: <cb43b303-0f8b-411f-bbae-a98f0dd37d2e@redhat.com>
Date: Fri, 8 Aug 2025 09:46:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Yongji Xie <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev,
 Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com,
 Maxime Coquelin <mcoqueli@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
 <20250807115752.1663383-3-eperezma@redhat.com>
Content-Language: en-US
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20250807115752.1663383-3-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 8/7/25 1:57 PM, Eugenio Pérez wrote:
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 9a56d0416bfe..b4b139dc76bb 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -31,6 +31,7 @@
>    * @features: virtio features
>    * @vq_num: the number of virtqueues
>    * @vq_align: the allocation alignment of virtqueue's metadata
> + * @ngroups: number of vq groups that VDUSE device declares
>    * @reserved: for future use, needs to be initialized to zero
>    * @config_size: the size of the configuration space
>    * @config: the buffer of the configuration space
> @@ -45,7 +46,8 @@ struct vduse_dev_config {
>   	__u64 features;
>   	__u32 vq_num;
>   	__u32 vq_align;
> -	__u32 reserved[13];
> +	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
> +	__u32 reserved[12];
>   	__u32 config_size;
>   	__u8 config[];
>   };
> @@ -160,6 +162,16 @@ struct vduse_vq_state_packed {
>   	__u16 last_used_idx;
>   };
>   
> +/**
> + * struct vduse_vq_group - virtqueue group
> + * @num: Index of the virtqueue group
> + * @num: Group
> + */
> +struct vduse_vq_group {
> +	__u32 index;
> +	__u32 num;
> +};
> +
>   /**
>    * struct vduse_vq_info - information of a virtqueue
>    * @index: virtqueue index
> @@ -182,6 +194,7 @@ struct vduse_vq_info {
>   	union {
>   		struct vduse_vq_state_split split;
>   		struct vduse_vq_state_packed packed;
> +		struct vduse_vq_group group;
>   	};
>   	__u8 ready;
>   };
> @@ -274,6 +287,8 @@ enum vduse_req_type {
>   	VDUSE_GET_VQ_STATE,
>   	VDUSE_SET_STATUS,
>   	VDUSE_UPDATE_IOTLB,
> +	VDUSE_GET_VQ_GROUP,
> +	VDUSE_GET_VRING_DESC_GROUP,
>   };
>   
>   /**
> @@ -328,6 +343,7 @@ struct vduse_dev_request {
>   		struct vduse_vq_state vq_state;
>   		struct vduse_dev_status s;
>   		struct vduse_iova_range iova;
> +		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
>   		__u32 padding[32];
>   	};
>   };
> @@ -350,6 +366,7 @@ struct vduse_dev_response {
>   	__u32 reserved[4];
>   	union {
>   		struct vduse_vq_state vq_state;
> +		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
>   		__u32 padding[32];
>   	};
>   };

Same comment as for patch 5, padding should be updated.

Regards,
Maxime

