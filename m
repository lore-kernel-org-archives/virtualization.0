Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECB7C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:51:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF152310B
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF152310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D7098574F;
	Wed, 20 Jan 2021 00:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRz7mvNSbZhP; Wed, 20 Jan 2021 00:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BF3478567A;
	Wed, 20 Jan 2021 00:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1DB3C08A1;
	Wed, 20 Jan 2021 00:51:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C0DC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A742A856E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpUoDzx_93mf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:51:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4B48A8567A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611103867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMgxh4QT16BUU6+08uzYGYm4b9G6LkkPIkP55kDsU4k=;
 b=WzZFiAa2nF5j234uZCp2GKc9B2bwpIpOwQe47AA0GVPQIXpvQ6YWhUvYSxtITKUFTVEaZj
 GcoBsmqdzwrDPBOYvQAS6/yPZCtAEuCQnUUeVLhpB9DfOiAt0vzq+PmdYTqGYlCzwD8xaa
 xJAWhVuWGQf6IFZ1b6JzR51dNzSwo5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-r9MXn4OtOrutL3_HPlXfvg-1; Tue, 19 Jan 2021 19:51:05 -0500
X-MC-Unique: r9MXn4OtOrutL3_HPlXfvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4271800D42;
 Wed, 20 Jan 2021 00:51:01 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D795D9DD;
 Wed, 20 Jan 2021 00:51:01 +0000 (UTC)
Date: Tue, 19 Jan 2021 17:50:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: Re: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Message-ID: <20210119175057.5768b26b@x1.home.shazbot.org>
In-Reply-To: <b4a93e926d424ff199ab91ff88399087@intel.com>
References: <20210119082812.822291-1-vivek.kasireddy@intel.com>
 <20210119082812.822291-4-vivek.kasireddy@intel.com>
 <20210119083955.1cc9eae3@omen.home.shazbot.org>
 <b4a93e926d424ff199ab91ff88399087@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Wed, 20 Jan 2021 00:14:49 +0000
"Kasireddy, Vivek" <vivek.kasireddy@intel.com> wrote:

> Hi Alex,
> 
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, January 19, 2021 7:40 AM
> > To: Kasireddy, Vivek <vivek.kasireddy@intel.com>
> > Cc: virtualization@lists.linux-foundation.org; Kim, Dongwon <dongwon.kim@intel.com>
> > Subject: Re: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
> > 
> > On Tue, 19 Jan 2021 00:28:12 -0800
> > Vivek Kasireddy <vivek.kasireddy@intel.com> wrote:
> >   
> > > Getting a copy of the KVM instance is necessary for mapping Guest
> > > pages in the Host.
> > >
> > > TODO: Instead of invoking the symbol directly, there needs to be a
> > > better way of getting a copy of the KVM instance probably by using
> > > other notifiers. However, currently, KVM shares its instance only
> > > with VFIO and therefore we are compelled to bind the passthrough'd
> > > device to vfio-pci.  
> > 
> > Yeah, this is a bad solution, sorry, vfio is not going to gratuitously
> > call out to vhost to share a kvm pointer.  I'd prefer to get rid of
> > vfio having any knowledge or visibility of the kvm pointer.  Thanks,  
> 
> [Kasireddy, Vivek] I agree that this is definitely not ideal as I recognize it
> in the TODO. However, it looks like VFIO also gets a copy of the KVM 
> pointer in a similar manner:
> 
> virt/kvm/vfio.c
> 
> static void kvm_vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> {
>         void (*fn)(struct vfio_group *, struct kvm *);
> 
>         fn = symbol_get(vfio_group_set_kvm);
>         if (!fn)
>                 return;
> 
>         fn(group, kvm);
> 
>         symbol_put(vfio_group_set_kvm);
> }

You're equating the mechanism with the architecture.  We use symbols
here to avoid module dependencies between kvm and vfio, but this is
just propagating data that userspace is specifically registering
between kvm and vfio.  vhost doesn't get to piggyback on that channel.

> With this patch, I am not suggesting that this is a precedent that should be followed 
> but it appears there doesn't seem to be an alternative way of getting a copy of the KVM 
> pointer that is clean and elegant -- unless I have not looked hard enough. I guess we
> could create a notifier chain with callbacks for VFIO and Vhost that KVM would call 
> but this would mean modifying KVM.
> 
> Also, if I understand correctly, if VFIO does not want to share the KVM pointer with
> VFIO groups, then I think it would break stuff like mdev which counts on it. 

Only kvmgt requires the kvm pointer and the use case there is pretty
questionable, I wonder if it actually still exists now that we have the
DMA r/w interface through vfio.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
