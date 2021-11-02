Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A4C433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:32:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B15960F02
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B15960F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C21D080C6D;
	Tue,  2 Nov 2021 07:32:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-9xq65y1uIY; Tue,  2 Nov 2021 07:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6564280C15;
	Tue,  2 Nov 2021 07:32:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36E03C0012;
	Tue,  2 Nov 2021 07:32:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B6B5C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E021680C37
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kAVjL9SwrX8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:32:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 407AC80C15
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635838361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXIGWxIexqQhEsP8RmW7lyQcuftiwinbtzPGfJNvL7E=;
 b=FPG0xadHxuDkoJasjpO90QcC+CxK1SH4H4ueaIZtA5ngng3fr0dezAOCZpoh2DsCEKRLXu
 K/Gf6fLV20FtYV2l8OMSWWtUBfMPHLeaWo45bIjyd24jCPLP2SMJ0eMnDLxg0kUJnjT5w7
 pMB8AWR2I0wWe4B3E5lZj1i7wu1zTuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-6eogVxeoNGqi0K9CY7p0hA-1; Tue, 02 Nov 2021 03:32:39 -0400
X-MC-Unique: 6eogVxeoNGqi0K9CY7p0hA-1
Received: by mail-wm1-f69.google.com with SMTP id
 128-20020a1c0486000000b0030dcd45476aso6563111wme.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jXIGWxIexqQhEsP8RmW7lyQcuftiwinbtzPGfJNvL7E=;
 b=OBaxfY+2tfn5Wt+tPbVzxz3mqpwLoBclXzwUAyvYb5BGdSqc4apW3DyDgdDTv3J55A
 x5PggWTv5w/xby4zwyv/XmZnjxzMfe8EBvr8mlodw+N7OmtlJYRQSg+hxD5iR4a22Nxl
 DvnBSFtje3ero+RlROe2yp677W8L9P1v/sedRYOeq/NYg6OjPHwLuaLILhkYW4r8sg0K
 MPR+ToefjwYmVTTtUMYcyTn/ZgMI9hccQ+n7r2YUEbsN5YYZVSObpevokOCGaqFrC4Eu
 l0RHPT4D0ustDG2gsUBuX3mJuyNAeyG0xjYTb3+wtoRdUoB86pCsDzK99lWJDs5b8q6p
 BnSA==
X-Gm-Message-State: AOAM5331P7gtiyKj8WMW61nbTZksB5PWlelkzwRJpX8/+N5xDXdhK8T1
 a7Pdq7yKOpEvtbZst1qmwxoY7lNNDcxU265NeehOxMFHVlgbzqqRWj9QsMvvtWkN44geRKa2DTc
 BjIH+E/r19Mj87Q+IyrWpm0bqhFrEfg71SRLSMEby6g==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr28024893wrt.419.1635838358534; 
 Tue, 02 Nov 2021 00:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMqCM2P9kaHXyYe/WWB38JSW9QHSKtfVRjZJzoRSB8gwOOJjGge06qArXnzrvSPeg8WOgJpA==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr28024866wrt.419.1635838358332; 
 Tue, 02 Nov 2021 00:32:38 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:b499:edfc:9aad:137a:a971])
 by smtp.gmail.com with ESMTPSA id 9sm9766103wry.0.2021.11.02.00.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 00:32:37 -0700 (PDT)
Date: Tue, 2 Nov 2021 03:32:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [RFC PATCH v5 02/26] vhost: Fix last queue index of devices with
 no cvq
Message-ID: <20211102033023-mutt-send-email-mst@kernel.org>
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-3-eperezma@redhat.com>
 <87a6inow7s.fsf@secure.mitica>
MIME-Version: 1.0
In-Reply-To: <87a6inow7s.fsf@secure.mitica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization@lists.linux-foundation.org, Parav Pandit <parav@mellanox.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 02, 2021 at 08:25:27AM +0100, Juan Quintela wrote:
> Eugenio P=E9rez <eperezma@redhat.com> wrote:
> > The -1 assumes that all devices with no cvq have an spare vq allocated
> > for them, but with no offer of VIRTIO_NET_F_CTRL_VQ. This may not be the
> > case, and the device may have a pair number of queues.
>                                   ^^^^
> even
> =

> I know, I know, I am Spanish myself O:-)

Nobody expects the Spanish ;)

> > To fix this, just resort to the lower even number of queues.
> =

> I don't understand what you try to achieve here.
> =

> > Fixes: 049eb15b5fc9 ("vhost: record the last virtqueue index for the
> > virtio device")
> > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > ---
> >  hw/net/vhost_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 0d888f29a6..edf56a597f 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -330,7 +330,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >      NetClientState *peer;
> >  =

> >      if (!cvq) {
> > -        last_index -=3D 1;
> > +        last_index &=3D ~1ULL;
> >      }
> =

> As far as I can see, that is a nop. last_index is defined as an int.
> =

> $ cat kk.c
> #include <stdio.h>
> =

> int main(void)
> {
> 	int i =3D 7;
> 	i &=3D -1ULL;

Stefano's patch has ~1ULL , not -1ULL here.

> 	printf("%d\n", i);
> 	i =3D 8;
> 	i &=3D -1ULL;
> 	printf("%d\n", i);
> 	i =3D 0;
> 	i &=3D -1ULL;
> 	printf("%d\n", i);
> 	i =3D -2;
> 	i &=3D -1ULL;
> 	printf("%d\n", i);
> 	return 0;
> }
> $ ./kk
> 7
> 8
> 0
> -2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
