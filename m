Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE58C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 12:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B83E283C59;
	Thu, 26 Oct 2023 12:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B83E283C59
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dd0DAlEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1UTtwgvzKjZ; Thu, 26 Oct 2023 12:12:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 982F283C4F;
	Thu, 26 Oct 2023 12:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 982F283C4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C4ABC0039;
	Thu, 26 Oct 2023 12:12:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D96C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DD6161413
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DD6161413
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dd0DAlEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AiwCqRS7k3K8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:12:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D365A61411
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D365A61411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698322357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sw0ciuKp3G615G2MMkLr4CNXXMI+u1W0xGXFFb8/g9M=;
 b=Dd0DAlEfKCcrijR95D/P1CyBnyQ6gLofYPs/2RL3y7/2WeghikjU9sw9uvcAr/Xqq7Cbri
 FcRRfcnDlNIuTi2l3ctEqPYJDuDkc3Aq68zQ1mbQrcSaQlSwk1tKgdCaLpZgMkFSR/6bMm
 1nXrTD0r7xdJJ0O4eY19M2w6qP9q7kU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Vo2FqAfWN5OY6B3L92PeJw-1; Thu, 26 Oct 2023 08:12:36 -0400
X-MC-Unique: Vo2FqAfWN5OY6B3L92PeJw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b98d8f6bafso59412966b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698322355; x=1698927155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sw0ciuKp3G615G2MMkLr4CNXXMI+u1W0xGXFFb8/g9M=;
 b=nzCTLb5904H7BwA3cLLIojPsDP1P9Y3hJNDRY8+eQ4kTBpfL9g4/kPwGq1drZkoROP
 IL177mMrpLUt71zDVUOvAwjW3o5PF//g8xU4AcrIv9Q/Bc794aPmvD8Ld5mX0jXb4Ub8
 EJJbCaFm83QFyxzCPkSb4ENz7Pew0U+i7JZEcEbWrhx/UOkPGaj8Ciu5H21jEZxJXpT2
 wMXfai/MXaoggQTLaWaCpJBhb3Vi0YO+Piqj3fd8pNPPZIhsES3IfOG/6BckQPaTsNMv
 HiycsKVCJ2E3vj4fNv7v0zAislcp1x8ByUQ5HbYmj8mmaLhrCvwSJkVsZLYgdQV+RMtM
 Wg1Q==
X-Gm-Message-State: AOJu0YzNrFcj905tvd7HKQYVOl/fGKG31Gu5LrQjCGHjtUoVr8E23WTi
 ALxEBqZjoOaiEj6kh4EUFiE/vHcD3hGhdA0gISMqAhyY3hbw4+djhtR9J/5KI5oPLOSgzLwAtXo
 bxLz9K0irnQ+19jXJz7XZTYno3+5SUeQEU4UcNyBRTw==
X-Received: by 2002:a17:906:c155:b0:9be:3c7e:7f38 with SMTP id
 dp21-20020a170906c15500b009be3c7e7f38mr14812220ejc.10.1698322355271; 
 Thu, 26 Oct 2023 05:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHVa3xvaMnJebgjah5302uh7+94jbODNYbjHlprQ/tZEJoXbNESX/f6UNZCk2l/eXC+oRQSQ==
X-Received: by 2002:a17:906:c155:b0:9be:3c7e:7f38 with SMTP id
 dp21-20020a170906c15500b009be3c7e7f38mr14812195ejc.10.1698322354926; 
 Thu, 26 Oct 2023 05:12:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a1709063b0100b0099b8234a9fesm11560164ejf.1.2023.10.26.05.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:12:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:12:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026081033-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, Oct 26, 2023 at 03:08:12PM +0300, Yishai Hadas wrote:
> > > Makes sense ?
> > So do I understand correctly that virtio dictates the subsystem device
> > ID for all subsystem vendor IDs that implement a legacy virtio
> > interface?  Ok, but this device didn't actually implement a legacy
> > virtio interface.  The device itself is not tranistional, we're imposing
> > an emulated transitional interface onto it.  So did the subsystem vendor
> > agree to have their subsystem device ID managed by the virtio committee
> > or might we create conflicts?  I imagine we know we don't have a
> > conflict if we also virtualize the subsystem vendor ID.
> > 
> The non transitional net device in the virtio spec defined as the below
> tuple.
> T_A: VID=0x1AF4, DID=0x1040, Subsys_VID=FOO, Subsys_DID=0x40.
> 
> And transitional net device in the virtio spec for a vendor FOO is defined
> as:
> T_B: VID=0x1AF4,DID=0x1000,Subsys_VID=FOO, subsys_DID=0x1
> 
> This driver is converting T_A to T_B, which both are defined by the virtio
> spec.
> Hence, it does not conflict for the subsystem vendor, it is fine.

You are talking about legacy guests, what 1.X spec says about them
is much less important than what guests actually do.
Check the INF of the open source windows drivers and linux code, at least.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
