Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D578107A8
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866961; cv=none; b=sfovw5dpTar5QDlP/mlylu/psDHkuZspQRxRA2YB2f1qktzritsGQM1AgNd10Fkvdq38360CanncW2l0YSbKV80YUQy32kp7m7QJjqDRubIC/CDimZzZ/v4VFBhONjS52dgfTugzYDJ2cO8bfMdqiy0qqSty8UQ/SrrX39lKF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866961; c=relaxed/simple;
	bh=26GaUJ8pFqKR7/vYEAILRVH4UUs0ZkzEj0WLK3ntMLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZHabNlRH9dmPgQozjChwsQuH45M/ITf7tYGAcWKQFEz0/t3NyUk0NvDBfA5WQz2b9g28VZuuuI/9mlJ9Fk/MMHhGaJGDf+WW/6P8LLFwv6FbmNhg4U2pFQ++8j59fXRcU6uEg7JPX6Mh+ikCB5cXPj3Uk2XDW6mOqRCKPUnq+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfmVOxau; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfmVOxau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7QnDQY4P8rYjt+n2sA3CyxMCr++Rt9mN4x4s5bFyIg=;
	b=AfmVOxauMsGcl1B7wiYKufrpX86dE7mMgF0JII0GZC2rcyYUxc740XAMvkNUdSNINFmeOG
	Son0Cj+quWMJ3DBVyCz1F/kzxTIdd3L8B7ynvHyDJk62nhLB6MnO3QM7esXb2PoMYwaYZV
	TAhgxVS8HZXaGxIe0zkQzlaFeDArqgU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-PKzXIdOMO0GamPfkKKZxSQ-1; Tue, 19 Mar 2024 12:49:18 -0400
X-MC-Unique: PKzXIdOMO0GamPfkKKZxSQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc647f65573so10255572276.2
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866957; x=1711471757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7QnDQY4P8rYjt+n2sA3CyxMCr++Rt9mN4x4s5bFyIg=;
        b=Ip6Nct869ll8gqJaHr0v0Mlls8oa5qRVzG4DvCduJDQC1/UGZsSUfONKhZxKxLTrkx
         TcTi188MWzOR7MzsQxIbAxwtQw7+AZTrCP8Z3tWSQIr2l6TRRxugX1Vz88ESe8D8Qzys
         ekVeWSETKqYbq7OQ32cUCg9frazdwIMLDyCtkba+JiKg2kItLV/+JV/VM1BSD0wAyJz8
         rUFurOmWYpJvedaukStjJkFf6dpjcApBY3r3wQsjYdXsdoTBnnGu8QyOn1MmqFzTE22j
         AOnQu6cA0TBOumY+Smz+8Yhpt/UeE8xerywKHsnIviQvFwpR23q8aFqI9uwgj4ivfO0J
         k3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hhRorzpJSCdpALzy9G9POaypCzFD1DRlPFm5ysxNwCLWH1HU+ch6bHLj+yNXwX9OGJ17t6Dyej6lf1nOn7F4ugYpXRD4MxkVAB2sYGM=
X-Gm-Message-State: AOJu0Yz5K+ZKHmRa9zjoJxfJHejW+YFK0J5bLHMDvu4Goa47z18NevyD
	fkYe4i9AG82T83/gGOkjcyygRrvdqonlsu8YbHXegtSbn2K/igT7VihqVLGytlVmh6EpmOtk96J
	xLWqzoo8FDRV3H3EaJtzsSmXnGROlQrGiTTPAAvPuFuaeCc1ZcL+qPJ3ZkEYSlfNFmy26IqrW
X-Received: by 2002:a05:6902:1b88:b0:dc7:5a17:6c3 with SMTP id ei8-20020a0569021b8800b00dc75a1706c3mr2390186ybb.53.1710866957340;
        Tue, 19 Mar 2024 09:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbGBVAJMB2cDjoHZdUdDEmnYSRT1lyTUzcKK9oUQopSai90h2MfvtHXLXK7REUsXUoqhk+wg==
X-Received: by 2002:a05:6902:1b88:b0:dc7:5a17:6c3 with SMTP id ei8-20020a0569021b8800b00dc75a1706c3mr2390175ybb.53.1710866957023;
        Tue, 19 Mar 2024 09:49:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id j1-20020ac84401000000b0042f376886d2sm6262529qtn.36.2024.03.19.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:49:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:49:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
Message-ID: <ktoczf6fo4ta54lsrliawcdhjuy65kedfnrqdx7w7qlvybje3n@cbb6e4upeu7t>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
>This series allows the user space applications query vDPA virtio-block
>device inforamtion.
>
>testing on vdpa_sim_blk, iproute2 output:
>sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
>{
>    "config": {
>        "vdpa_blk0": {
>            "capacity": 262144,
>            "segment size": 4096,
>            "block size": 512,
>            "max segments in a request": 32,
>            "num of queues": 1,
>            "logical blocks per physical block (log2)": 0,
>            "offset of first aligned logical block": 0,
>            "minimum io size": 1,
>            "optimal io size": 1,
>            "maximum discard sectors for a segment": 4294967295,
>            "max discard segments in a command": 1,
>            "discard sector alignment": 512,
>            "max write zeros sectors in a segment": 4294967295,
>            "max write zero segments": 1,
>            "read only": false,
>            "flush command support": true
>        }
>    }
>}
>
>Please help review

Thanks for this series, and sorry for the deleay.
I left some comments in the patch, about the virtio-blk config space
there are some missing fields:
- virtio_blk_geometry fields
- writeback field
- *secure_erase* fields
- virtio_blk_zoned_characteristics fields

Do you plan to add them later?

Thanks,
Stefano

