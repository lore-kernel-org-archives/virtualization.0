Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94945C433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 09:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F476404C0;
	Thu, 26 May 2022 09:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1FYu9Kw_v6f; Thu, 26 May 2022 09:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B320E40541;
	Thu, 26 May 2022 09:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8136FC0039;
	Thu, 26 May 2022 09:07:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B0BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 09:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4895F40541
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 09:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KFkiMO1668gl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 09:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3F1C404C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653556039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrhZj/f2a1K5xyngYjaDLFoTBYuesG1Fa4WdS5JUxdc=;
 b=PqsbdUzHwK3A5hrBfI2O18NMQn7wLtI8TQIn5oZRsAPlgAuhtlki1fOcWkE6dU22yzKPCO
 D70sUJQpUbXQryivYe9qz6OFubPiffizY1KT2OWb59e0ZjVp5FLkqiNyI5+qBoQzHAamOn
 oHStQfoK7Ok3q9CIsqS0u4QK9CPUejs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-j_5iBs8fPhujd2NpplmJ7w-1; Thu, 26 May 2022 05:07:18 -0400
X-MC-Unique: j_5iBs8fPhujd2NpplmJ7w-1
Received: by mail-wm1-f70.google.com with SMTP id
 m26-20020a05600c3b1a00b00397220d6329so780854wms.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 02:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KrhZj/f2a1K5xyngYjaDLFoTBYuesG1Fa4WdS5JUxdc=;
 b=vAaMLDMbmxPda6ZyZyzr4vojGIjYphd/GvxBryvOOKkf4qASXh/fs2/I/vIGxRojJ8
 x2REw1Ytka0gKf/SRl/R47UyjS8t9qU1a5HMc9m4jmIe83N/2lKR4//Z4izUuPWDsG9e
 QLN7I+hz9Y3X+r9eqJTuWE8ooEDmotLPOuTEHvtYbpz8fvYpW+AI+zncr/uiNKl0y5ei
 Y1J0f2WWhPg1aOLlvifocRJd/jn0YKlBcgQ1EzkF675NZVIFBrXisTzTpbag6SaFfTsi
 BWbe4Ra/NTEUFxlyjHxbc87fs8pRiAzzcxnoMtfpxNXdeofyJDG/Kg5M2fnCjs9dAw+Z
 55fw==
X-Gm-Message-State: AOAM530tNj3zz015GOUA9igHodZM9Jx7PZ7r3fkVIvNO0hhSoXKNJ7Kv
 2tzDfYSASnvbeD+d4rG+n6MJKCWp2ouFn6EzkCQe0u/Pj2AXtYVYt7ZjLv6en6EbJFTpBWQhBfo
 KiSLB850pxc+c/vPbCobEnrXPAjws6aJSfZW5EjCjew==
X-Received: by 2002:a05:600c:3d0d:b0:397:460d:3360 with SMTP id
 bh13-20020a05600c3d0d00b00397460d3360mr1385892wmb.54.1653556037168; 
 Thu, 26 May 2022 02:07:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsQMSJXaL5D4KLoVhLNCOsXSL5t/a06VfP1CmmgXg13RDPmXb5nBs/26we+aadnB6KRWEdCQ==
X-Received: by 2002:a05:600c:3d0d:b0:397:460d:3360 with SMTP id
 bh13-20020a05600c3d0d00b00397460d3360mr1385860wmb.54.1653556036941; 
 Thu, 26 May 2022 02:07:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 p36-20020a05600c1da400b003974027722csm1247492wms.47.2022.05.26.02.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 02:07:16 -0700 (PDT)
Date: Thu, 26 May 2022 11:07:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vdpa: introduce STOP backend feature bit
Message-ID: <20220526090706.maf645wayelb7mcp@sgarzare-redhat>
References: <20220525105922.2413991-1-eperezma@redhat.com>
 <20220525105922.2413991-3-eperezma@redhat.com>
 <BL1PR12MB582520CC9CE024149141327499D69@BL1PR12MB5825.namprd12.prod.outlook.com>
 <CAJaqyWc9_ErCg4whLKrjNyP5z2DZno-LJm7PN=-9uk7PUT4fJw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc9_ErCg4whLKrjNyP5z2DZno-LJm7PN=-9uk7PUT4fJw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Dawar,
 Gautam" <gautam.dawar@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 26, 2022 at 10:57:03AM +0200, Eugenio Perez Martin wrote:
>On Wed, May 25, 2022 at 1:23 PM Dawar, Gautam <gautam.dawar@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>> -----Original Message-----
>> From: Eugenio P=E9rez <eperezma@redhat.com>
>> Sent: Wednesday, May 25, 2022 4:29 PM
>> To: Michael S. Tsirkin <mst@redhat.com>; netdev@vger.kernel.org; linux-k=
ernel@vger.kernel.org; kvm@vger.kernel.org; virtualization@lists.linux-foun=
dation.org; Jason Wang <jasowang@redhat.com>
>> Cc: Zhu Lingshan <lingshan.zhu@intel.com>; martinh@xilinx.com; Stefano G=
arzarella <sgarzare@redhat.com>; ecree.xilinx@gmail.com; Eli Cohen <elic@nv=
idia.com>; Dan Carpenter <dan.carpenter@oracle.com>; Parav Pandit <parav@nv=
idia.com>; Wu Zongyong <wuzongyong@linux.alibaba.com>; dinang@xilinx.com; C=
hristophe JAILLET <christophe.jaillet@wanadoo.fr>; Xie Yongji <xieyongji@by=
tedance.com>; Dawar, Gautam <gautam.dawar@amd.com>; lulu@redhat.com; martin=
po@xilinx.com; pabloc@xilinx.com; Longpeng <longpeng2@huawei.com>; Piotr.Um=
inski@intel.com; Kamde, Tanuj <tanuj.kamde@amd.com>; Si-Wei Liu <si-wei.liu=
@oracle.com>; habetsm.xilinx@gmail.com; lvivier@redhat.com; Zhang Min <zhan=
g.min9@zte.com.cn>; hanand@xilinx.com
>> Subject: [PATCH v3 2/4] vhost-vdpa: introduce STOP backend feature bit
>>
>> [CAUTION: External Email]
>>
>> Userland knows if it can stop the device or not by checking this feature=
 bit.
>>
>> It's only offered if the vdpa driver backend implements the stop() opera=
tion callback, and try to set it if the backend does not offer that callbac=
k is an error.
>>
>> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>> ---
>>  drivers/vhost/vdpa.c             | 16 +++++++++++++++-
>>  include/uapi/linux/vhost_types.h |  2 ++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index 1f1d1c425=
573..32713db5831d 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -347,6 +347,14 @@ static long vhost_vdpa_set_config(struct vhost_vdpa=
 *v,
>>         return 0;
>>  }
>>
>> +static bool vhost_vdpa_can_stop(const struct vhost_vdpa *v) {
>> +       struct vdpa_device *vdpa =3D v->vdpa;
>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
>> +
>> +       return ops->stop;
>> [GD>>] Would it be better to explicitly return a bool to match the retur=
n type?
>
>I'm not sure about the kernel code style regarding that casting. Maybe
>it's better to return !!ops->stop here. The macros likely and unlikely
>do that.

IIUC `ops->stop` is a function pointer, so what about

     return ops->stop !=3D NULL;

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
