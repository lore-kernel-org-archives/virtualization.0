Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329CDE8181B
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 05:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0DCE41B77;
	Tue, 26 Sep 2023 05:34:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0DCE41B77
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ql5QHHRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Py_vLOGiAzU5; Tue, 26 Sep 2023 05:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F13F64191A;
	Tue, 26 Sep 2023 05:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F13F64191A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3846C0039;
	Tue, 26 Sep 2023 05:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C688C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47E844177B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47E844177B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ql5QHHRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1e3xdjL53R7e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:34:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 849C440377
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 849C440377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695706492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlZAa2UjvOsuyM8pmm/wDliagPEyeZHIRgEbMXeCfoo=;
 b=Ql5QHHRAc/eUSIJlgUF6ip4liA1622JO/amwjE85ckub6htXzQfSxc0SVAbWeCJ6frh3LT
 gKpOG/z6Y1nWVlnALK090iVL+a//VshHIHp33rjS7ZKY7MW1L2tbE5K3TR5vEY26eEAOyF
 wWefHCHXwRnTZmKtzYC5eMcD8aA8xWM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-O72Zj79cOr2TRhTvZ550Og-1; Tue, 26 Sep 2023 01:34:50 -0400
X-MC-Unique: O72Zj79cOr2TRhTvZ550Og-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso621085566b.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 22:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695706489; x=1696311289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlZAa2UjvOsuyM8pmm/wDliagPEyeZHIRgEbMXeCfoo=;
 b=lisrAc9MaEBx0a4HkPSJuH1PljdQeLy94g55JPfyPCsVuauoXLsTDfFxMFKgEorjPT
 epsdoWIu58lhUPk9xOYLemCjpqT0aMRUD0K08+6QWCq7J2YJMfAQXAYaABcca+KwN93W
 gHLgXSiXKa+7OxatF1sKkxHOSyN7P/g4CP63Rr0q+svwQbR3ppdlnxT9M9NgiMO5f/ao
 oIYKFathwcmg6TTpDgZOfuj1qlwIGn8HAZzyIY6rTwiAYx2mva4TOJq4tWTvYtVqPO7P
 gVlhAh/SVtgjBIc5RqMnBS66e2JlByyG09xtRKi7A8vh/xOhyTQWO6ruFGvlyc4N4LKE
 5cNg==
X-Gm-Message-State: AOJu0YygxH+lp+WcMktWqFlbHONzuHZn4MIv7/30Uc4PKZnXeLRAfEAR
 08DQx+lBvikXEaTDODTGPFg9q0dO4o/7aHsCjZMTu+J6nAF6iwlEhARWc/AidU5Uh9lbct67wLG
 hpGVRzQSuYTg7aPedo3YLOKpLiCAiTARXwOHbTqBjjg==
X-Received: by 2002:a17:907:da6:b0:9ae:65a5:b6f4 with SMTP id
 go38-20020a1709070da600b009ae65a5b6f4mr8974762ejc.20.1695706489789; 
 Mon, 25 Sep 2023 22:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzkXlaim5/oWjEAmJmUxy8o9CN6yWWgjaiSAxwdGQ4Ks7jnhTVPgRLo4AR3/PP1nrSlJUkEA==
X-Received: by 2002:a17:907:da6:b0:9ae:65a5:b6f4 with SMTP id
 go38-20020a1709070da600b009ae65a5b6f4mr8974747ejc.20.1695706489472; 
 Mon, 25 Sep 2023 22:34:49 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 lg15-20020a170906f88f00b0099d0a8ccb5fsm7160863ejb.152.2023.09.25.22.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 22:34:48 -0700 (PDT)
Date: Tue, 26 Sep 2023 01:34:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230926012236-mutt-send-email-mst@kernel.org>
References: <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
 <20230925143708-mutt-send-email-mst@kernel.org>
 <20230926004059.GM13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230926004059.GM13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, Sep 25, 2023 at 09:40:59PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 03:44:11PM -0400, Michael S. Tsirkin wrote:
> > > VDPA is very different from this. You might call them both mediation,
> > > sure, but then you need another word to describe the additional
> > > changes VPDA is doing.
> > 
> > Sorry about hijacking the thread a little bit, but could you
> > call out some of the changes that are the most problematic
> > for you?
> 
> I don't really know these details. The operators have an existing
> virtio world that is ABI toward the VM for them, and they do not want
> *anything* to change. The VM should be unware if the virtio device is
> created by old hypervisor software or new DPU software. It presents
> exactly the same ABI.
> 
> So the challenge really is to convince that VDPA delivers that, and
> frankly, I don't think it does. ABI toward the VM is very important
> here.

And to complete the picture, it is the DPU software/firmware that
is resposible for maintaining this ABI in your ideal world?


> > > In this model the DPU is an extension of the hypervisor/qemu
> > > environment and we shift code from x86 side to arm side to increase
> > > security, save power and increase total system performance.
> > 
> > I think I begin to understand. On the DPU you have some virtio
> > devices but also some non-virtio devices.  So you have to
> > use VFIO to talk to the DPU. Reusing VFIO to talk to virtio
> > devices too, simplifies things for you. 
> 
> Yes
> 
> > If guests will see vendor-specific devices from the DPU anyway, it
> > will be impossible to migrate such guests away from the DPU so the
> > cross-vendor migration capability is less important in this
> > use-case.  Is this a good summary?
> 
> Well, sort of. As I said before, the vendor here is the cloud
> operator, not the DPU supplier. The guest will see an AWS virtio-net
> function, for example.
> 
> The operator will ensure that all their different implementations of
> this function will interwork for migration.
> 
> So within the closed world of a single operator live migration will
> work just fine.
> 
> Since the hypervisor's controlled by the operator only migrate within
> the operators own environment anyhow, it is an already solved problem.
> 
> Jason


Okay the picture emerges I think. Thanks! I'll try to summarize later
for everyone's benefit.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
