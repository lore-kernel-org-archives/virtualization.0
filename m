Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEDEC433EF
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 09:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA71D425B4;
	Fri, 24 Jun 2022 09:14:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA71D425B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKY7qQSe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aAknuw3cUn9; Fri, 24 Jun 2022 09:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DE5142584;
	Fri, 24 Jun 2022 09:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DE5142584
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD6F5C0039;
	Fri, 24 Jun 2022 09:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CD9C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D130D425B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D130D425B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrcsHVSiygNW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9183542584
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9183542584
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656062047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glFz0yEPd5ahmG1wMSVmuqssquTjanShg2UhFo4gmlE=;
 b=QKY7qQSelDvtfnEcBEFVTx3AOS9xF76YpM8xkq027ivJP90TXDGrHL/Tb6Qk0sCEPvJvWh
 c0lcvH+frKW6l0m7AeMgsZHQ+zEVZrlvWTTdvdVY9KgGpnl7Ggq959DXtHoFyKCYMOOKZX
 KshPy2QMA3WTv6r3XYxEABv+edXh0Ng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-wEF00ZHaNg22XVEWeYEzNA-1; Fri, 24 Jun 2022 05:14:06 -0400
X-MC-Unique: wEF00ZHaNg22XVEWeYEzNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 l17-20020a05600c4f1100b0039c860db521so1195306wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=glFz0yEPd5ahmG1wMSVmuqssquTjanShg2UhFo4gmlE=;
 b=L4Hd1DfMzlNYHqzAwerOIEuObHSjnW7iGqRGIc6JnIARlUlyoBaV4vMSxar2Cw9Yhr
 qrLLcgLKSXzIN3bZFpV1cxnKDM6LbAC5oNL5j2cGgXT+Da3aZDEzayviivNgMypc32LN
 m+lJx8WDymczVXRDRLJnqi53I+1Oi9R9T8Ga7aEoblF3MZ7plFBQ0la3K8QZegm9YYfe
 Zlm3pynabeuf3n2w6KPa++8+dbd7svne8uFvEJx0NPwcIt05CwOWxrO6ZzowqAEehvOv
 vXJe/caOs4fZxEB8+PKRsmyot6sbTuCouduOdQzcTFC3zXisWhpbsZiZ5HgvgQwIQKcf
 opIQ==
X-Gm-Message-State: AJIora+cMUcO6SMZ690Mw2RZTuJp7/WPU7qlicNpmPpefaA21Ye/Ole8
 bC8xn6H4WPipDtJiNYiQBiPzB68YCdTjUTNB6QidRUoSCOPhjUUO0pW00A2EcLQMPo3wDRbVish
 cUAaCdaOFiKbn46zyvxOdBmtr4qfLyRgh8ZqIKuiBNQ==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9236:6207 with SMTP id
 i8-20020a0560001ac800b0021b92366207mr11874827wry.123.1656062044433; 
 Fri, 24 Jun 2022 02:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+v1Mo2hL5d9qzq/pxsLzqhnsh8+crKgUNMKL9qPMWqbIpLCOjYlzZkK4pNrV4/4W7u8qnwQ==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9236:6207 with SMTP id
 i8-20020a0560001ac800b0021b92366207mr11874810wry.123.1656062044239; 
 Fri, 24 Jun 2022 02:14:04 -0700 (PDT)
Received: from redhat.com ([2.55.188.216]) by smtp.gmail.com with ESMTPSA id
 w4-20020a7bc104000000b0039c45fc58c4sm2105865wmi.21.2022.06.24.02.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 02:14:03 -0700 (PDT)
Date: Fri, 24 Jun 2022 05:14:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: virtio_balloon regression in 5.19-rc3
Message-ID: <20220624051309-mutt-send-email-mst@kernel.org>
References: <64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk>
 <402bb9b5-7d6e-ed69-8b66-3ebefd80ff15@redhat.com>
 <CACGkMEs45CCniTjbxr3OThdbG=Q4nGrm_11LLDfR4rRLetSx0A@mail.gmail.com>
 <a1a127d144d65937c5543c142e69213c9b8d2d40.camel@decadent.org.uk>
MIME-Version: 1.0
In-Reply-To: <a1a127d144d65937c5543c142e69213c9b8d2d40.camel@decadent.org.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: debian-kernel@lists.debian.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
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

On Tue, Jun 21, 2022 at 06:10:00PM +0200, Ben Hutchings wrote:
> On Tue, 2022-06-21 at 17:34 +0800, Jason Wang wrote:
> > On Tue, Jun 21, 2022 at 5:24 PM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 20.06.22 20:49, Ben Hutchings wrote:
> > > > I've tested a 5.19-rc3 kernel on top of QEMU/KVM with machine type
> > > > pc-q35-5.2.  It has a virtio balloon device defined in libvirt as:
> > > > 
> > > >     <memballoon model="virtio">
> > > >       <address type="pci" domain="0x0000" bus="0x05" slot="0x00" function="0x0"/>
> > > >     </memballoon>
> > > > 
> > > > but the virtio_balloon driver fails to bind to it:
> > > > 
> > > >     virtio_balloon virtio4: init_vqs: add stat_vq failed
> > > >     virtio_balloon: probe of virtio4 failed with error -5
> > > > 
> > > 
> > > Hmm, I don't see any recent changes to drivers/virtio/virtio_balloon.c
> > > 
> > > virtqueue_add_outbuf() fails with -EIO if I'm not wrong. That's the
> > > first call of virtqueue_add_outbuf() when virtio_balloon initializes.
> > > 
> > > 
> > > Maybe something in generic virtio code changed?
> > 
> > Yes, we introduced the IRQ hardening. That could be the root cause and
> > we've received lots of reports so we decide to disable it by default.
> > 
> > Ben, could you please try this patch: (and make sure
> > CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set)
> > 
> > https://lore.kernel.org/lkml/20220620024158.2505-1-jasowang@redhat.com/T/
> 
> Yes, that patch fixes the regression for me.
> 
> Ben.


Jason are you going to fix balloon to call device_ready before
registering device with linux?
> -- 
> Ben Hutchings
> Any smoothly functioning technology is indistinguishable
> from a rigged demo.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
