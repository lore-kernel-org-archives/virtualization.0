Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68A1CD8CA4
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 15:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56C04613C6;
	Tue, 10 Oct 2023 15:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56C04613C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI2WDoi6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QeKFdaXWIAC; Tue, 10 Oct 2023 15:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE96E61027;
	Tue, 10 Oct 2023 15:15:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE96E61027
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B08DDC0039;
	Tue, 10 Oct 2023 15:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67598C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 421418132E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 421418132E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI2WDoi6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NzbcrrFn9VUX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:15:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED1CD80DA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:15:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED1CD80DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696950903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHpFxBERmN94QT85J+WdpBBalBO00T++ys1+HPeoAWk=;
 b=fI2WDoi6bZWAV2RkQJ8sQTK3G0KXBxgNs1RmOorsuaaoGCnscypS0airj0sRxrXQ/vf3D6
 RxsputkbwJRrEwazM5x7VK/gkuS64pl/hz00l5Rn64QBJNmSTq2mmnSiQAxPjo1IHEhGS0
 WoHvm8P/pJYXMouEEFV78EcapZ7/qEk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ZrSxlOhXPxaY38KrfQyOnA-1; Tue, 10 Oct 2023 11:15:01 -0400
X-MC-Unique: ZrSxlOhXPxaY38KrfQyOnA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-327ab41de6cso4138272f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 08:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696950900; x=1697555700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHpFxBERmN94QT85J+WdpBBalBO00T++ys1+HPeoAWk=;
 b=ECSGPU4SJ5KhrGxdLZOnFeiOqoltm44GHpHQqhIYhZlFK21SSuAf/jmQ1Xrs+uJP+j
 X5bBuGBQZ/xT3oWEWVj/FD0IbMZkH5tccRcpr4Sa9x4aLoRtAzATqS0/XM8xa9UC5x32
 ha2IzmbNXD6lwZWbUrnzouUtc9ScZGH9nJIri2adM2I1piggXM+jVrKFE/bxeZ3024EH
 xn7miGCzXUERMdbhgYsr/n0dX3L/ndRmbpuzR9idRkVz5GiLmwp4HvWECzly67RLMZMv
 q259TWeEYAQUW/BhlRcEc4KjBNiyVV5Xryzj4Q2xMZbOhLt25yA9wFYr4pEyIvBTrFXS
 NA7Q==
X-Gm-Message-State: AOJu0YwaP0sROKoR9kYSzhMozFnLLnFhrYa1lzJtYF8Q6XBuF8cuELfP
 sUFShBraIklJg39dsr35msyaE/39Ca0v4nK5pWY2r4xWvlENcEpI/m0pgMvQ6xoBPVo+CUskUgY
 I4VmjttDEosmZT1+gRuysWNQdYzjHTmg/6a9BZfKDuQ==
X-Received: by 2002:a5d:6a07:0:b0:321:7844:de44 with SMTP id
 m7-20020a5d6a07000000b003217844de44mr16804689wru.45.1696950900457; 
 Tue, 10 Oct 2023 08:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG84AaoUmlneyrEi00sIOswcQ5D6yjewF+xLa/MTuiZ1Uy9G0hmbcn7y3K+vJT1cU5isAVSoA==
X-Received: by 2002:a5d:6a07:0:b0:321:7844:de44 with SMTP id
 m7-20020a5d6a07000000b003217844de44mr16804672wru.45.1696950899983; 
 Tue, 10 Oct 2023 08:14:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 w15-20020adfcd0f000000b0030647449730sm13068784wrm.74.2023.10.10.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 08:14:59 -0700 (PDT)
Date: Tue, 10 Oct 2023 11:14:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010111339-mutt-send-email-mst@kernel.org>
References: <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
 <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 06:09:44PM +0300, Yishai Hadas wrote:
> On 10/10/2023 17:54, Michael S. Tsirkin wrote:
> > On Tue, Oct 10, 2023 at 11:08:49AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 10, 2023 at 09:56:00AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > > > However - the Intel GPU VFIO driver is such a bad experiance I don't
> > > > > want to encourage people to make VFIO drivers, or code that is only
> > > > > used by VFIO drivers, that are not under drivers/vfio review.
> > > > So if Alex feels it makes sense to add some virtio functionality
> > > > to vfio and is happy to maintain or let you maintain the UAPI
> > > > then why would I say no? But we never expected devices to have
> > > > two drivers like this does, so just exposing device pointer
> > > > and saying "use regular virtio APIs for the rest" does not
> > > > cut it, the new APIs have to make sense
> > > > so virtio drivers can develop normally without fear of stepping
> > > > on the toes of this admin driver.
> > > Please work with Yishai to get something that make sense to you. He
> > > can post a v2 with the accumulated comments addressed so far and then
> > > go over what the API between the drivers is.
> > > 
> > > Thanks,
> > > Jason
> > /me shrugs. I pretty much posted suggestions already. Should not be hard.
> > Anything unclear - post on list.
> > 
> Yes, this is the plan.
> 
> We are working to address the comments that we got so far in both VFIO &
> VIRTIO, retest and send the next version.
> 
> Re the API between the modules, It looks like we have the below
> alternatives.
> 
> 1) Proceed with current approach where we exposed a generic API to execute
> any admin command, however, make it much more solid inside VIRTIO.
> 2) Expose extra APIs from VIRTIO for commands that we can consider future
> client usage of them as of LIST_QUERY/LIST_USE, however still have the
> generic execute admin command for others.
> 3) Expose API per command from VIRTIO and fully drop the generic execute
> admin command.
> 
> Few notes:
> Option #1 looks the most generic one, it drops the need to expose multiple
> symbols / APIs per command and for now we have a single client for them
> (i.e. VFIO).
> Options #2 & #3, may still require to expose the virtio_pci_vf_get_pf_dev()
> API to let VFIO get the VIRTIO PF (struct virtio_device *) from its PCI
> device, each command will get it as its first argument.
> 
> Michael,
> What do you suggest here ?
> 
> Thanks,
> Yishai

I suggest 3 but call it on the VF. commands will switch to PF
internally as needed. For example, intel might be interested in exposing
admin commands through a memory BAR of VF itself.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
