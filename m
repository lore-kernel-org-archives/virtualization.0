Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F6DC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:33:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A25611AC
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A25611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2212660895;
	Thu, 15 Apr 2021 08:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDEIg4jE86Cb; Thu, 15 Apr 2021 08:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B210660590;
	Thu, 15 Apr 2021 08:33:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 886B3C000C;
	Thu, 15 Apr 2021 08:33:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8F8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06D27400EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_KrdQ4DdA5F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9BA140FA6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618475624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFlAp3YvJs0F97eeMuQpRtEailEfpWs3ksvlCDUwXGU=;
 b=jRruHO67P2po/mnAKqpRWVN3Y+iCe5DwEL+a+qf5LKwPhSWewCNgNJ/p+cIhcYLKhlgU5H
 9wRsomrGck1sm3kVTSjW6fJCrMQTzp+e3tAir2Zl8SZfTOVV0uY6XyC5RZT6SgCIB4/17P
 O2Lkm0JUeQ+/p6/E61Bf5zYp6L3zQX4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-DDwt3vh1Od6YBlwaLyrlCg-1; Thu, 15 Apr 2021 04:33:42 -0400
X-MC-Unique: DDwt3vh1Od6YBlwaLyrlCg-1
Received: by mail-ed1-f70.google.com with SMTP id
 l22-20020a0564021256b0290384ebfba68cso950432edw.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 01:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rFlAp3YvJs0F97eeMuQpRtEailEfpWs3ksvlCDUwXGU=;
 b=qEFtEMcK9jQKsZ/4VgxTlA8jWEBHKa9JZTIX/cozk6443CmkZKAdXyKgdVD9rCFhIC
 PpzPKMAh5khRzFIVflldI4rcszZA2Qh3p/1PKeSta8nthoky6CTR8ybrBjJFhR9vgjLL
 RJAvvbBEfbSbJHugmcSxzmNx2UAQDntGc9K3dJH56dEm3XCO5EGqUZ/NxaYhaztydNcw
 pKerIC0sRfJBdvg3GdayrukqrxDFseQ0VGiPS9PHH1GF+aiYMtsViEkZvnFjFa2bIHXl
 GIacMoVNgDWdLbf6NfTuYTpG/chGFKA4Kd99rwfOcdWnCL8naFq9gqNXrADlRsG76GAP
 UV9A==
X-Gm-Message-State: AOAM530EewE7EYgw1wz5t5pHRoSur/MLIB3FNuyLRDn1f5RltLOqNFpt
 HNEguNk4sLu52crAeIp8IcQFn6FQyw6Y+5gYIMa9f+EtQTAaFfXmdjo2qSVM4PrJGwb4h0OIccy
 PPX+WhCj4yPL9bROi4DU33yAj1Rvob0n1tCZ4lahMxA==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr2754568eds.52.1618475621507;
 Thu, 15 Apr 2021 01:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZa+D9nMdXw6pzlj0Za+o0qAqJsTL5rMTXAQ3+vABY5T8qNRRk2hc2mUbEVvoY1yQonb14Uw==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr2754555eds.52.1618475621324;
 Thu, 15 Apr 2021 01:33:41 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id kj24sm1383626ejc.49.2021.04.15.01.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 01:33:40 -0700 (PDT)
Date: Thu, 15 Apr 2021 10:33:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
Message-ID: <20210415083339.4whghntxtodt24xz@steredhat>
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-4-lingshan.zhu@intel.com>
 <20210415081236.anbssqtsyjnmiaby@steredhat>
 <406df891-246e-4eaf-030c-192d49813af0@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <406df891-246e-4eaf-030c-192d49813af0@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Thu, Apr 15, 2021 at 04:23:15PM +0800, Zhu Lingshan wrote:
>
>
>On 4/15/2021 4:12 PM, Stefano Garzarella wrote:
>>On Wed, Apr 14, 2021 at 05:18:32PM +0800, Zhu Lingshan wrote:
>>>get_config_size() should return the size based on the decected
>>>device type.
>>>
>>>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>---
>>>drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++++++++++-
>>>1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c =

>>>b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>index 9b6a38b798fa..b48b9789b69e 100644
>>>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>@@ -347,7 +347,16 @@ static u32 ifcvf_vdpa_get_vq_align(struct =

>>>vdpa_device *vdpa_dev)
>>>
>>>static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
>>>{
>>>-=A0=A0=A0 return sizeof(struct virtio_net_config);
>>>+=A0=A0=A0 struct ifcvf_hw *vf =3D vdpa_to_vf(vdpa_dev);
>>>+=A0=A0=A0 size_t size;
>>>+
>>>+=A0=A0=A0 if (vf->dev_type =3D=3D VIRTIO_ID_NET)
>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D sizeof(struct virtio_net_config);
>>>+
>>>+=A0=A0=A0 if (vf->dev_type =3D=3D VIRTIO_ID_BLOCK)
>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D sizeof(struct virtio_blk_config);
>>>+
>>>+=A0=A0=A0 return size;
>>
>>I'm not familiar with the ifcvf details, but can it happen that the =

>>device is not block or net?
>>
>>Should we set `size` to 0 by default to handle this case or are we =

>>sure it's one of the two?
>>
>>Maybe we should add a comment or a warning message in this case, to =

>>prevent some analysis tool or compiler from worrying that `size` =

>>might be uninitialized.
>>
>>I was thinking something like this:
>>
>>=A0=A0=A0=A0switch(vf->dev_type) {
>>=A0=A0=A0=A0case VIRTIO_ID_NET:
>>=A0=A0=A0=A0=A0=A0=A0 size =3D sizeof(struct virtio_net_config);
>>=A0=A0=A0=A0=A0=A0=A0 break;
>>=A0=A0=A0=A0case VIRTIO_ID_BLOCK:
>>=A0=A0=A0=A0=A0=A0=A0 size =3D sizeof(struct virtio_blk_config);
>>=A0=A0=A0=A0=A0=A0=A0 break;
>>=A0=A0=A0=A0default:
>>=A0=A0=A0=A0=A0=A0=A0 /* or WARN(1, "") if dev_warn() not apply */
>>=A0=A0=A0=A0=A0=A0=A0 dev_warn(... , "virtio ID [0x%x] not supported\n")
>>=A0=A0=A0=A0=A0=A0=A0 size =3D 0;
>>
>>=A0=A0=A0=A0}
>>
>>Thanks,
>>Stefano
>agree, will add this in V2

Great, maybe something similar also in patch 2/3 for `features` in =

ifcvf_vdpa_get_features().

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
