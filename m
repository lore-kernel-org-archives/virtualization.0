Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C178C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 09:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B301813B3;
	Tue, 14 Dec 2021 09:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMskxXPqUB0g; Tue, 14 Dec 2021 09:42:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BAEB9812FC;
	Tue, 14 Dec 2021 09:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1916C002F;
	Tue, 14 Dec 2021 09:42:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09FF2C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 09:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBDCA60777
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 09:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CY63bMgwO6f6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 09:42:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A538B6068D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639474964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxho3ycUAvfpHG/RPtdDeRmXf39/H7L7gvIQxMurI68=;
 b=GULoQRa4VE+Rk0enN+v5H6tzbU+ppblaO2VhHLSgxiEOZeinLlpHFj8CWsc6B0jyevKsZ1
 06OYm3kGXyTgv9nn5rpRlXkyEXK0khTgsRuMjZ5ziJTm81zU+miOx+j85vY386MsHNSV3K
 InvxdgyKfJNmx8xD/xBn8OE804c5Hqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-obzvwIoPMeCgiahosdgnNA-1; Tue, 14 Dec 2021 04:42:42 -0500
X-MC-Unique: obzvwIoPMeCgiahosdgnNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 r129-20020a1c4487000000b00333629ed22dso12936804wma.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zxho3ycUAvfpHG/RPtdDeRmXf39/H7L7gvIQxMurI68=;
 b=wwYfGwnX53MBEGt6nJG9mweGxQqsd/wU9wfseiQ+UZpS89R+3ggYJ0rh1PTi8JTcsX
 uyj9CYzvH1lxfbgOKTP5Ozr3wi6mqpzsY+bUPvTA+wapqZ32IMXGEAk2aEMdv6IGhGJ6
 hwZnXCX1hnVT5BtrlstpkZ7/eHBHg15UoFYuWt+qsxaUBr+pEsi2Oqdc//LhM9wBM1AA
 VU2Jb1LGfUM7gA1qS8skMToCpgnJvoh5ZBtIBzvk42Qo7yP6nTcNqnyeoylLDz/bDE3T
 YXRYpqqOE7qgmolzd8iGLxL1a3sz3ZcYakd90Gd6Z9b6wHgjGtK4acnBVv/jkS9qqj+y
 EKzw==
X-Gm-Message-State: AOAM530BjKpsNdM8HOmUudRyYep5p5oKaHS2dY3UVO2VnLG6CdniiKMd
 enTmwHDiJiuDW2yTsP7V8Pj6/AXd/q+BRJh28nsJkXs/PLGx5dvfdX2Up3uvk0OdgOHFz0mKDae
 /uKgCvRRObmHdwOjzZiTSImzmJFWg31VuWqViHw6fsA==
X-Received: by 2002:a1c:f60a:: with SMTP id w10mr5657985wmc.53.1639474961152; 
 Tue, 14 Dec 2021 01:42:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnYWeVTbMSTE4HoMJ/gcfykHh5FajU7wFziSkFlhPBXKVJtT+YBZN1XYdv1V3rB/GX6b/Blw==
X-Received: by 2002:a1c:f60a:: with SMTP id w10mr5657965wmc.53.1639474960911; 
 Tue, 14 Dec 2021 01:42:40 -0800 (PST)
Received: from steredhat (host-87-21-203-138.retail.telecomitalia.it.
 [87.21.203.138])
 by smtp.gmail.com with ESMTPSA id 8sm8013486wrb.49.2021.12.14.01.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 01:42:40 -0800 (PST)
Date: Tue, 14 Dec 2021 10:42:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>,
 virtualization-owner@lists.linux-foundation.org
Subject: Re: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Message-ID: <20211214094235.6uzzxigykd76o6uq@steredhat>
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Eli,
I don't know what's wrong, but I've only received replies through the 
virtualization@lists.linux-foundation.org mailing list.

Even in the archive I can't find your original series.

Adding virtualization-owner@lists.linux-foundation.org to double check 
what's going wrong.

Thanks,
Stefano

On Tue, Dec 14, 2021 at 11:17:00AM +0800, Jason Wang wrote:
>On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
>>
>> Allow the user to configure the max number of virtqueue pairs for a vdpa
>> instance. The user can then control the actual number of virtqueue pairs
>> using ethtool.
>>
>> Example, set number of VQPs to 2:
>> $ ethtool -L ens1 combined 2
>>
>> A user can check the max supported virtqueues for a management device by
>> runnig:
>>
>> vdpa dev show
>>     vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
>>             max_vqp 3 max_vq_size 256 max_supported_vqs 256
>
>I think the maxsupported_vqs should be an odd number since it should
>contain control vq.
>
>>
>> and refer to this value when adding a device.
>>
>> To create a device with a max of 5 VQPs:
>> vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
>
>A question, consider the parent support both net and block, if user use
>
>vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1
>
>How do we know it's a net or block device? Or do you expect some block
>specific attributes to be added?
>
>Thanks
>
>>
>> V1 -> V2:
>> 1. Do not return the index of the control VQ. Instead return an
>>    indication if Ctrl VQ was negotiated.
>> 2. Do not returen conig information if FEATURES_OK is not set to avoid
>>    reporting out of sync information.
>> 3. Minor fixes as described by the individual patches
>> 4. Add patches to return the max virtqueues a device is capable of
>>    supporting.
>>
>> Eli Cohen (10):
>>   vdpa: Provide interface to read driver features
>>   vdpa/mlx5: Distribute RX virtqueues in RQT object
>>   vdpa: Read device configuration only if FEATURES_OK
>>   vdpa: Allow to configure max data virtqueues
>>   vdpa/mlx5: Fix config_attr_mask assignment
>>   vdpa/mlx5: Support configuring max data virtqueue pairs
>>   vdpa: Add support for returning device configuration information
>>   vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
>>   vdpa: Support reporting max device virtqueues
>>   vdpa/mlx5: Configure max supported virtqueues
>>
>>  drivers/vdpa/alibaba/eni_vdpa.c    | 16 +++--
>>  drivers/vdpa/ifcvf/ifcvf_main.c    | 16 +++--
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 94 +++++++++++++++++-------------
>>  drivers/vdpa/vdpa.c                | 42 ++++++++++++-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++--
>>  drivers/vdpa/vdpa_user/vduse_dev.c | 16 +++--
>>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 +++--
>>  drivers/vhost/vdpa.c               |  2 +-
>>  drivers/virtio/virtio_vdpa.c       |  2 +-
>>  include/linux/vdpa.h               | 16 +++--
>>  include/uapi/linux/vdpa.h          |  9 +++
>>  11 files changed, 178 insertions(+), 72 deletions(-)
>>
>> --
>> 2.33.1
>>
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
