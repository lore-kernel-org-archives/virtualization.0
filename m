Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9C5C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 04:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE19060DFD;
	Mon, 24 Apr 2023 04:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE19060DFD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P741F4Ch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vg1ECn-44M0c; Mon, 24 Apr 2023 04:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4613B60E73;
	Mon, 24 Apr 2023 04:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4613B60E73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACFFC0036;
	Mon, 24 Apr 2023 04:51:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D14D1C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E3B8402F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E3B8402F4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P741F4Ch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXYoYJr17O-Z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB69A40133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB69A40133
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682311915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0U3/OUdHL9NTJMWrP5H//SyAnDUuzq1ohvCUqKW4ek=;
 b=P741F4ChGP5Q5y9TSugqmquk85pvvD8qb/clly+OSMEXGj4Af4IoxwWeDTYIej7LkKXN+A
 RBcTjkDHCgWFQBMoJ9gH/2MuGYUbE3lk8gZIQrjdFQ/KTdSGSRtXHzDkeDN6ZRMcSFPnlX
 BnljpuN7snLgbEX5x7mP4bJGVG4YKoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-spm2mF_0N26U7MIAuvB_Mg-1; Mon, 24 Apr 2023 00:51:54 -0400
X-MC-Unique: spm2mF_0N26U7MIAuvB_Mg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f175a24fd1so21144325e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 21:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682311913; x=1684903913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0U3/OUdHL9NTJMWrP5H//SyAnDUuzq1ohvCUqKW4ek=;
 b=jsnSPphXbNgzfkQF7h7au25ENAi5uAWAck9MSqQhA8qywFTSlgc0OoPSn4dNQIeJ32
 jZPD0fGBwhYlS8+mgapvt7ktEtrOFiwemgCdx1CHIX8xQiqdkxSQO0dtr7pKmNVHJfow
 RKGRHcdmUxfH0NrJaDz0zm7h/4mfT9JvaRXsbNdzs/0w2dQLaqqGKkL3M0keoZuCWLcA
 NH2yXFOCvG4dJchGJJ+X0Cm2c8qCv9Gc4NSJ6yTq/kJwUchBRhb7j0CCpZkdscciCQfu
 ixSabMQUJFgHLxW7T8iZZVrAEzZnkSCX+zfzq57f7ttBCEa8yIZ68VSwN0auV0ynPBLK
 pK8w==
X-Gm-Message-State: AAQBX9f839ZBb+T66qv4YCG3DczcDSd17Giogz2+lHv95J5pZuVIPbRk
 hrXJg9S5h5NKueFW0IM211m0Cnah0kaE7TvaeYiioHLQPLDvGahbC/0wclFXCrUBLY6b7in2Za9
 8vvnI91Rz4MKBmzbR/UYmMWG5u92z+XNJFjNUTukRcQ==
X-Received: by 2002:a7b:c5c7:0:b0:3f1:75d0:6151 with SMTP id
 n7-20020a7bc5c7000000b003f175d06151mr6708099wmk.1.1682311913142; 
 Sun, 23 Apr 2023 21:51:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8HUXwsqtbDpswS77W8Gswil4ED3XzcCiWSG8u/XGUTTaS4pkg25O4xx5CxbA38mCscI0qIg==
X-Received: by 2002:a7b:c5c7:0:b0:3f1:75d0:6151 with SMTP id
 n7-20020a7bc5c7000000b003f175d06151mr6708090wmk.1.1682311912787; 
 Sun, 23 Apr 2023 21:51:52 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 r3-20020a05600c35c300b003f1836c98b7sm12245598wmq.48.2023.04.23.21.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 21:51:52 -0700 (PDT)
Date: Mon, 24 Apr 2023 00:51:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Message-ID: <20230424005130-mutt-send-email-mst@kernel.org>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230331204854.20082-1-lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Apr 01, 2023 at 04:48:49AM +0800, Zhu Lingshan wrote:
> Formerly, ifcvf driver has implemented a lazy-initialization mechanism
> for the virtqueues and other config space contents,
> it would store all configurations that passed down from the userspace,
> then load them to the device config space upon DRIVER_OK.
> 
> This can not serve live migration, so this series implement an
> immediate initialization mechanism, which means rather than the
> former store-load process, the virtio operations like vq ops
> would take immediate actions by access the virtio registers.
> 
> This series also implement irq synchronization in the reset
> routine


Please, prefix each patch subject with vDPA/ifcvf:


> Zhu Lingshan (5):
>   virt queue ops take immediate actions
>   get_driver_features from virito registers
>   retire ifcvf_start_datapath and ifcvf_add_status
>   synchronize irqs in the reset routine
>   a vendor driver should not set _CONFIG_S_FAILED
> 
>  drivers/vdpa/ifcvf/ifcvf_base.c | 162 +++++++++++++++++++-------------
>  drivers/vdpa/ifcvf/ifcvf_base.h |  16 ++--
>  drivers/vdpa/ifcvf/ifcvf_main.c |  97 ++++---------------
>  3 files changed, 122 insertions(+), 153 deletions(-)
> 
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
