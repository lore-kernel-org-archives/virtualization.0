Return-Path: <SRS0=Fxu4=PL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCACC433F5
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 20:11:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C76C60F6F
	for <virtualization@archiver.kernel.org>; Sat, 23 Oct 2021 20:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C76C60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA614400C5;
	Sat, 23 Oct 2021 20:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q_tGedKqmVHp; Sat, 23 Oct 2021 20:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2214B40187;
	Sat, 23 Oct 2021 20:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0D87C0019;
	Sat, 23 Oct 2021 20:11:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8B7FC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2C31818B5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kHegO51dLMsS
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3B3F814A0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635019875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXVp8tyrghvJw92JwPIZDHyEdU7IU/XO1DvnZcDPNf8=;
 b=XfuXp4iYVvrsk4TAOm0e09BL3RJqToocR/nuAcOFt6i4y51FpEimJldNNP2GtEnUjn/JTB
 2HYKPxQxNiwGXxCq5dC1axFg4YVXH0umiQh8a5pmyWs02LRQkVk6Ejjuch0j8WuhwrZ5ZF
 gIVx6t6MZH9fHtILaCoK4S49eH9Rov4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-gz-LAX2ZOuyvn3FWVKLK6w-1; Sat, 23 Oct 2021 16:11:13 -0400
X-MC-Unique: gz-LAX2ZOuyvn3FWVKLK6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 k6-20020a7bc306000000b0030d92a6bdc7so2579725wmj.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 13:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aXVp8tyrghvJw92JwPIZDHyEdU7IU/XO1DvnZcDPNf8=;
 b=qEbyDOPYh8pkDkG21VdF6hqSuUb3Ecajkhpe8RWwHLNie/avgwpOxgLRXxWJvW4wFL
 sZ7A3dcmhT5gssEQVl68VwJiVpQNyt8A7F7BgahAoBgvxMLZVBLwL0VUYbklBx/uJz+/
 h7KNNlF7sUVWLv4znes2abZNVzW39D5ZB2GlMIZCxg836vQ6K9bwnNrySsGI5ljBtq8a
 ZZfOf563pjD3iBxNEYrqUFGkMwu7c/tmoXGXLc4T8PRdYyUQ8+PNic2sFD6AjAFhE3Cw
 yRl50MF+SNTtVECo3Xqt4p7eO4/7R617XLKVOkV/0Ys98dC8wTi9jEsFNWQOvNL7qNFx
 jHPA==
X-Gm-Message-State: AOAM531ktACgPRdKPqLCf+FCSi00/imaVL5+YJwn3To+Fsu1a16JSP7l
 uy3/SAawsPrPGvrh+f+HeIk2tzyraJ5GEvd4UQTNb/9dmQU2Zwi1hf1/JBOETTIur1jPmTJCDtX
 SIgXMBnqo0KrVghoQbIjJX3113zBsbUmLNwCe6S7P7A==
X-Received: by 2002:a05:600c:4e94:: with SMTP id
 f20mr8838237wmq.166.1635019872611; 
 Sat, 23 Oct 2021 13:11:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0SYiUm8Dg2wDtDS76O9WIfq6qcZsbjs5OvzyUDna2Kx4HMh0JOKdg+tqLwDRmgRp5+ULpfw==
X-Received: by 2002:a05:600c:4e94:: with SMTP id
 f20mr8838220wmq.166.1635019872410; 
 Sat, 23 Oct 2021 13:11:12 -0700 (PDT)
Received: from redhat.com ([2.55.9.147])
 by smtp.gmail.com with ESMTPSA id f18sm11302380wrg.3.2021.10.23.13.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Oct 2021 13:11:11 -0700 (PDT)
Date: Sat, 23 Oct 2021 16:11:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <20211023160838-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <20211022064359-mutt-send-email-mst@kernel.org>
 <94289c36-431a-513f-9b52-b55225f6b89d@oracle.com>
 <28250f62-ff38-901f-6014-9e975381d523@oracle.com>
MIME-Version: 1.0
In-Reply-To: <28250f62-ff38-901f-6014-9e975381d523@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Fri, Oct 22, 2021 at 01:17:26PM -0500, michael.christie@oracle.com wrote:
> On 10/22/21 11:12 AM, michael.christie@oracle.com wrote:
> > On 10/22/21 5:47 AM, Michael S. Tsirkin wrote:
> >>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >>> index c998860d7bbc..e5c0669430e5 100644
> >>> --- a/include/uapi/linux/vhost.h
> >>> +++ b/include/uapi/linux/vhost.h
> >>> @@ -70,6 +70,17 @@
> >>>  #define VHOST_VRING_BIG_ENDIAN 1
> >>>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> >>>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> >>> +/* By default, a device gets one vhost_worker created during VHOST_SET_OWNER
> >>> + * that its virtqueues share. This allows userspace to create a vhost_worker
> >>> + * and map a virtqueue to it or map a virtqueue to an existing worker.
> >>> + *
> >>> + * If pid > 0 and it matches an existing vhost_worker thread it will be bound
> >>> + * to the vq. If pid is VHOST_VRING_NEW_WORKER, then a new worker will be
> >>> + * created and bound to the vq.
> >>> + *
> >>> + * This must be called after VHOST_SET_OWNER and before the vq is active.
> >>> + */
> >>
> >> A couple of things here:
> >> it's probably a good idea not to make it match pid exactly,
> >> if for no other reason than I'm not sure we want to
> >> commit this being a pid. Let's just call it an id?
> > 
> > Ok.
> > 
> >> And maybe byteswap it or xor with some value
> >> just to make sure userspace does not begin abusing it anyway.
> >>
> >> Also, interaction with pid namespace is unclear to me.
> >> Can you document what happens here?
> > 
> > This current patchset only allows the vhost_dev owner to
> > create/bind workers for devices it owns, so namespace don't come
> 
> I made a mistake here. The patches do restrict VHOST_SET_VRING_WORKER
> to the same owner like I wrote. However, it looks like we could have 2
> threads with the same mm pointer so vhost_dev_check_owner returns true,
> but they could be in different namespaces.
> 
> Even though we are not going to pass the pid_t between user/kernel
> space, should I add a pid namespace check when I repost the patches?

Um it's part of the ioctl. How you are not going to pass it around?

So if we do worry about this, I would just make it a 64 bit integer,
rename it "id" and increment each time a thread is created.
 
> 
> > into play. If a thread from another namespace tried to create/bind
> > a worker we would hit the owner checks in vhost_dev_ioctl which is
> > done before vhost_vring_ioctl normally (for vdpa we hit the use_worker
> > check and fail there).
> > 
> > However, with the kernel worker API changes the worker threads will
> > now be in the vhost dev owner's namespace and not the kthreadd/default
> > one, so in the future we are covered if we want to do something more
> > advanced. For example, I've seen people working on an API to export the
> > worker pids:
> > 
> > https://lore.kernel.org/netdev/20210507154332.hiblsd6ot5wzwkdj@steredhat/T/
> > 
> > and in the future for interfaces that export that info we could restrict
> > access to root or users from the same namespace or I guess add interfaces
> > to allow different namespaces to see the workers and share them.
> > 
> > 
> >> No need to fix funky things like moving the fd between
> >> pid namespaces while also creating/destroying workers, but let's
> >> document it's not supported.
> > 
> > Ok. I'll add a comment.
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
