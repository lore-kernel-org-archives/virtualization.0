Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE8134CB
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868103; cv=none; b=oCTkqna0G4oueL0mmKqha508p6+1AxNCjUU8BvALASvGh6thQcvZ6FhSLnmSvmdF1CpyG7XnzUW2Nnw5FofmL2NLlaCeKXmyk/BF03P7gw13bIepdZaKqyq5chHR8GekoksIbUtIM6S61gl0lKk8C/ArucCpWzV5vD/h/BdnXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868103; c=relaxed/simple;
	bh=TJrR+P3kcQiC4CU5wvoEdPeNycgL9ryBU0wgxdOlCuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V3KvWmscMTh6ZbdzqRCUlkcPf2ua3k4l/0GaDVLBUVvC8FRbSipV7JGlLTenlFB2sjklTowRC5LpplwNbgubGU9p9PwnyDE4VFUnD63k5G2O6UycDVQz6EaKejuz1vtoNBXdFmGtE5zoVjqWrrjR8EdnGwTurOe5BEBaxqFO8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRqvGgaP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRqvGgaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710868100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKm4SA40NE75oQHKRPKuyuQyA3JGQkiAmMAnaTMfulU=;
	b=IRqvGgaPOpb+sLd1eNsgLKROdhklLGcxFvx+EL6aWQEi3iLM42gTgI9bgbM641G5Moqa62
	38FBEvTbuS2vxjgdl1MB8catp3PUuvjdyndrPVdlXVHQE8bZ8kpKBsnYlalmhx6GDToYb7
	VnoJ4cBAaqYCCsvb7QbumUOvAwS1Zf0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-PeHt4CqUNX-5A8_dz-CsgQ-1; Tue, 19 Mar 2024 13:08:18 -0400
X-MC-Unique: PeHt4CqUNX-5A8_dz-CsgQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78a162853f5so80879885a.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 10:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868098; x=1711472898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKm4SA40NE75oQHKRPKuyuQyA3JGQkiAmMAnaTMfulU=;
        b=lBUg+q0Gkn4Gal1QrFngfyk+GgfrrMVRFpSWL61rFBREzOlX3cUBQX21aqe7rIfc1Y
         71utUblYpWjBpt1sripzLm0TE+9TWLD2JMM//SpqB4Rx2LVnxAHFY7rhRlx+PLq4L+F1
         nyBIAkoQ/bzSPiV0wG4RXMNNwd+VlQ39N+xKGflglIoRpNZp23YlK4ZUE1bPo02uaqJu
         dx/4hY1Dng4rTQGr8Zhsepjp/A3OZ8H/Ww7DxDxYryywka7ZmC7cBi7lGOGBU+oJhw8o
         1FQjMJ9OnID99+Yv0c//Co/eVGyyb6KE++iGgS8STcDgsgB9HeIaVfHKMlZzYvEfZt4A
         GVCw==
X-Forwarded-Encrypted: i=1; AJvYcCXchJExcdz6tNkcNfEvYbURUxkJYh3Woqp1WNyOtPzEUFcCUZX/QVUr+/SmvDXHCM3MxPVSdzGv8h99+1/rs2Y1V694l01pF9G5HEBJi9c=
X-Gm-Message-State: AOJu0YylhnQIC5fHpobH2OpbTXbB8LYXJfqSK9gw0bXg69+J0GedMQ6Y
	UJYsEHdJGIQOWc3sZ+Xk8WVr7/m3zVHR7h7LwYpj3/pzri3LVk6r2j+RY6musI8zk09vDWOMio2
	FTiV/i6rSHl8CM0y0GY83sPkXSrneF2G61p0r59fVeCVox8fDwNItb3pUHrzRJE3n
X-Received: by 2002:a05:6214:2b97:b0:691:64e9:9a4a with SMTP id kr23-20020a0562142b9700b0069164e99a4amr22027853qvb.53.1710868098447;
        Tue, 19 Mar 2024 10:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV95rY9puxj6ddkdUCib9NyUunNmGZEQNmhm68/L1teAKeaOtVBNK4+DrPPGw4N4EDgYEiUQ==
X-Received: by 2002:a05:6214:2b97:b0:691:64e9:9a4a with SMTP id kr23-20020a0562142b9700b0069164e99a4amr22027833qvb.53.1710868098198;
        Tue, 19 Mar 2024 10:08:18 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id z10-20020a056214040a00b00690d951b7d9sm6643175qvx.6.2024.03.19.10.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:08:17 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:08:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 08/10] vDPA: report virtio-block write zeroes
 configuration to user space
Message-ID: <disso3ouyi3wrxqx5fa2v2kiaub3lsfdfwhhf3ghpf56oegczj@gwzaojtdoln5>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-9-lingshan.zhu@intel.com>
 <kr2l5cuwdblc5o3xae324uxc2gmphe4wffgunthvhnjfbhqkmz@erwxl3v22gdy>
 <20240319130118-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240319130118-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 19, 2024 at 01:02:21PM -0400, Michael S. Tsirkin wrote:
>On Tue, Mar 19, 2024 at 05:36:01PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 19, 2024 at 02:56:04AM +0800, Zhu Lingshan wrote:
>> > This commits reports write zeroes configuration of
>> > virtio-block devices to user space, includes:
>> > 1)maximum write zeroes sectors size
>> > 2)maximum write zeroes segment number
>> >
>> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> > ---
>> > drivers/vdpa/vdpa.c       | 23 +++++++++++++++++++++++
>> > include/uapi/linux/vdpa.h |  2 ++
>> > 2 files changed, 25 insertions(+)
>> >
>> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> > index bf3fa90908a7..adbcbc7b18b2 100644
>> > --- a/drivers/vdpa/vdpa.c
>> > +++ b/drivers/vdpa/vdpa.c
>> > @@ -1064,6 +1064,26 @@ static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
>> > 	return 0;
>> > }
>> >
>> > +static int
>> > +vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
>> > +				     const struct virtio_blk_config *config)
>> > +{
>> > +	u32 val_u32;
>> > +
>> > +	if ((features & BIT_ULL(VIRTIO_BLK_F_WRITE_ZEROES)) == 0)
>> > +		return 0;
>> > +
>> > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_sectors);
>> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC, val_u32))
>> > +		return -EMSGSIZE;
>> > +
>> > +	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_seg);
>> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG, val_u32))
>> > +		return -EMSGSIZE;
>>
>> Should we cover also `config->write_zeroes_may_unmap` ?
>
>
>This review came too late I applied the patch. Generally
>if I don't see any response in about
>a week I assume there is not interest.

Ooops, sorry about that! I should add me as a reviewer for vDPA
otherwise lately it's hard for me to monitor patches :-(

BTW, some comments can be resolved with later patches if you think it
makes sense to resolve them.

Thanks,
Stefano

