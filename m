Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED0C6FA8F
	for <virtualization@archiver.kernel.org>; Wed, 30 Aug 2023 13:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F34340A0F;
	Wed, 30 Aug 2023 13:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F34340A0F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oi4msi9V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7uhObFlMVzP; Wed, 30 Aug 2023 13:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD90C4094C;
	Wed, 30 Aug 2023 13:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD90C4094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AED19C0071;
	Wed, 30 Aug 2023 13:30:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F3CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 13:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F17766103F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 13:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F17766103F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oi4msi9V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MF29qpe5ByGQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 13:30:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B96F60EF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 13:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B96F60EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
 b=Oi4msi9VB3j0ZgJuqCfU42WZObDCxWJQgAsZSl+Ouk+H2iUVnUXEzIGaL5vwsQk/KvfAk+
 Sr4GcZdrMPg08zs5kLCFGQoaMKuXUfz9yJjGHRsG29qALHoCv4Fb+tdDPJPSONkvCBUdry
 EIquKv6LZqSAsIYytV/oq6fMaN3Xd9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-cCBkstHtO5q7X0DJtDvnJQ-1; Wed, 30 Aug 2023 09:30:38 -0400
X-MC-Unique: cCBkstHtO5q7X0DJtDvnJQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so428899566b.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402237; x=1694007037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
 b=VImKnyPNpfljeifLj/B3dz0mRHkI6x7L7GApBK6fWITyL77InILu9CyfGYd3Njk8UY
 7cC3FYKUZSGj6yqNoKhfkFQBF0Dv2UBYRPQk5L3FB1D3K+YXQAlkj7cAH8w6N3N85EKQ
 YnZ58LsKrlXm3CJ8/kjWSZDFUDBM7YZ2hbVgDD3f+DEHWinoCyiMrRbrIFnl5Bh8D8aU
 Jr9tCykIzzBDJSuy6E2Vq424prx6DrYovO7TWm5wgR8o77Smvj2+Opx1yFm8QTMwV7qQ
 ip1Ecj8Vys/6NlwbBv4wRCU9TUEfKI6l4ijlSMERtkdLC2sCzS7+RfhHO3MSZRJgiAXZ
 YQ9Q==
X-Gm-Message-State: AOJu0YyR6F+uaqQsm28hX0qrcOu6/89Mf07zDDmwd9yLCCIIfk34t2+a
 yXrQCjdxt3D6otmuPHeHonhJJ12tTqXOfhLqdAT9Uk6KHa8FS6ra554PL3blz6yp6GQEJI48zaL
 bHCK1pzqgWIJ5Glckt9WG57231n8nrfZUN1vvJ60OaQ==
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id
 11-20020a170906008b00b009a57887ef09mr1872778ejc.32.1693402237184; 
 Wed, 30 Aug 2023 06:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxUHeyUiFVorh4ZDehN292nCkRvDukdS6QYJWdvud4F+ML6iNTqT9rYxTEkbhUobIqpPlWg==
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id
 11-20020a170906008b00b009a57887ef09mr1872753ejc.32.1693402236839; 
 Wed, 30 Aug 2023 06:30:36 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 ju26-20020a17090798ba00b00982a352f078sm7183100ejc.124.2023.08.30.06.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:30:35 -0700 (PDT)
Date: Wed, 30 Aug 2023 09:30:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230830091607-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
 <20230829130430-mutt-send-email-mst@kernel.org>
 <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Jakub Kicinski <kuba@kernel.org>, david.marchand@redhat.com
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

On Wed, Aug 30, 2023 at 01:27:18PM +0200, Maxime Coquelin wrote:
> 
> 
> On 8/29/23 19:05, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 8/11/23 00:00, Jakub Kicinski wrote:
> > > > On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > > > > > Directly into the stack? I thought VDUSE is vDPA in user space,
> > > > > > meaning to get to the kernel the packet has to first go thru
> > > > > > a virtio-net instance.
> > > > > 
> > > > > yes. is that a sufficient filter in your opinion?
> > > > 
> > > > Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> > > > and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> > > > experience with virt so no strong opinion, perhaps it does make sense
> > > > for someone's deployment? Dunno..
> > > > 
> > > 
> > > I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
> > > devices, as the device could be attached to vhost-vDPA and so not
> > > visible to the Kernel networking stack.
> > > 
> > > However, CAP_NET_ADMIN should be required to attach the VDUSE device to
> > > virtio-vdpa/virtio-net.
> > > 
> > > Does that make sense?
> > > 
> > > Maxime
> > 
> > OK. How are we going to enforce it?
> 
> Actually, it seems already enforced for all VDPA devices types.
> Indeed, the VDPA_CMD_DEV_NEW Netlink command used to add the device to
> the VDPA bus has the GENL_ADMIN_PERM flag set, and so require
> CAT_NET_ADMIN.

Hmm good point. Pity I didn't notice earlier. Oh well there's always
the next release.

> > Also, we need a way for selinux to enable/disable some of these things
> > but not others.
> 
> Ok, I can do it in a patch on top.
> Do you have a pointer where it is done for Virtio Block devices?
> 
> Maxime

It's not done yet - at the moment vduse device is always block so we
didn't need the distinction.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
