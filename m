Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9525AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 05:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC100405E9;
	Wed, 23 Nov 2022 05:50:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC100405E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bbbI84zN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MA5V_DYH3xwP; Wed, 23 Nov 2022 05:50:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60BE4400DB;
	Wed, 23 Nov 2022 05:50:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60BE4400DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F9FC0032;
	Wed, 23 Nov 2022 05:50:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B84C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 05:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 295304014B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 05:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 295304014B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57ElIz7L2F58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 05:50:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E9BB400DB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E9BB400DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669182623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMYYiLCaB4GLtGxeCjzuDietMKLoY1I6jUe2ofSKrOo=;
 b=bbbI84zNGAa14LDs1XPhGsMQfjVgH277pTK4STmEcXNibeKvGXfP33N1wkOiDkN5rlXdo5
 svh2pBBl70Kfu6bKFA9gl1DnviyyJxxz9qX7wV33duT55HaB/yg+BeKnsrLMTTJznPDZdH
 afn6X1xHdj9hubYkHkSe1DhugPjj+nE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-Dm-inIX1Obi5gtkF6cRx5w-1; Wed, 23 Nov 2022 00:50:21 -0500
X-MC-Unique: Dm-inIX1Obi5gtkF6cRx5w-1
Received: by mail-ot1-f71.google.com with SMTP id
 q22-20020a05683022d600b0066d919dd4c4so6984374otc.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 21:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMYYiLCaB4GLtGxeCjzuDietMKLoY1I6jUe2ofSKrOo=;
 b=R7H6XhXqwhqq3gEEVk9cvev9P6/2L/LbtLhq5fHPhCrVnxvsGX04GUO02wGc3LBjtx
 DrD+1RwziJtf6EWQvnx4lnADfKLV5ynPZsEo4E7Tf432ZdKmhR2nKcdLpL6mzwf6fY1v
 Mw/hsKp9fwNdxh3Rkh/M6DtBS7w3yiTOK3n9w1C9rkMvTgw5dKZLP46bZu0hDz7XZicJ
 sOIEVCdLF+hepNuSZhNSjZLPeCrqfklWGavXZG0lf/EAgp6Y+ayIs6ba5UgQshSaeMO5
 cqaEtoFgavu6zYzk04UMkOBeUSqRLNCvvb5cbs9kXIoBurcB146tZJTzXpX8h8Nb3RBI
 +j3w==
X-Gm-Message-State: ANoB5pm6O+JZw++baCKndaRwws6qbIaFr6amRRV6/0B+IKd3ELLo6vZc
 dyZZZTlUOQ8vAK87kAW0sJb6i4ddp9h+TyRmlzQfvggauJeKtu3X0AD+bSj6uD5l3urIhZ0R4EO
 BYqbB6owYSaYKbJ6nh6pAJqdJwC45p+jdfFrFbe9tZbJ0mwH8ldyVH3LL9Q==
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr3268511oib.280.1669182620985; 
 Tue, 22 Nov 2022 21:50:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vUhvThjDXaYE0H+SpEJoxdmzmzDcZ/Xy2YPmdtfAXLakXiJ77qJrY4aA4PeK9ennZJJLXUGcaAYCvf5J5/sc=
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr3268502oib.280.1669182620811; Tue, 22
 Nov 2022 21:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20221117033303.16870-1-jasowang@redhat.com>
 <f9b35219-ba26-1251-5c78-d96ac91b0995@kernel.org>
In-Reply-To: <f9b35219-ba26-1251-5c78-d96ac91b0995@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Nov 2022 13:50:09 +0800
Message-ID: <CACGkMEv+LiT_pH9Km5_OW3EpdOoh7ifM85KwLog570hPAQBsqQ@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa: allow provisioning device features
To: David Ahern <dsahern@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 elic@nvidia.com
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

On Wed, Nov 23, 2022 at 3:53 AM David Ahern <dsahern@kernel.org> wrote:
>
> On 11/16/22 8:33 PM, Jason Wang wrote:
> > diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> > index 94e4dad1..7c961991 100644
> > --- a/vdpa/include/uapi/linux/vdpa.h
> > +++ b/vdpa/include/uapi/linux/vdpa.h
> > @@ -51,6 +51,7 @@ enum vdpa_attr {
> >       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> >       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> >       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > +     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> >
> >       /* new attributes must be added above here */
> >       VDPA_ATTR_MAX,
>
> this header file already has:
>         ...
>         VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>         VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>         VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>
>         VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>
>         /* virtio features that are supported by the vDPA device */
>         VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
>
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>
> in which case your diff is not needed. More importantly it raises
> questions about the status of the uapi file (is it correct as is or is
> an update needed) and which tree you are creating patches against?

I'm using git://git.kernel.org/pub/scm/network/iproute2/iproute2 main.
But I don't pull the new codes before sending the patches. Will fix
this.

>
> > @@ -615,8 +640,9 @@ static int cmd_mgmtdev(struct vdpa *vdpa, int argc, char **argv)
> >  static void cmd_dev_help(void)
> >  {
> >       fprintf(stderr, "Usage: vdpa dev show [ DEV ]\n");
> > -     fprintf(stderr, "       vdpa dev add name NAME mgmtdev MANAGEMENTDEV [ mac MACADDR ] [ mtu MTU ]\n");
> > -     fprintf(stderr, "                                                    [ max_vqp MAX_VQ_PAIRS ]\n");
> > +     fprintf(stderr, "       vdpa dev add name NAME mgmtdevMANAGEMENTDEV [ device_features DEVICE_FEATURES]\n");
>
> lost the space between mgmtdev and MANAGEMENTDEV

Will fix it.

Thanks

>
>
> > +     fprintf(stderr, "                                                   [ mac MACADDR ] [ mtu MTU ]\n");
> > +     fprintf(stderr, "                                                   [ max_vqp MAX_VQ_PAIRS ]\n");
> >       fprintf(stderr, "       vdpa dev del DEV\n");
> >       fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");
> >       fprintf(stderr, "Usage: vdpa dev vstats COMMAND\n");
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
