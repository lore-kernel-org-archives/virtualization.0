Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B5BC4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 14:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C851360FAB;
	Fri, 11 Nov 2022 14:17:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C851360FAB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN//8yPg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id crUMpLCbysFj; Fri, 11 Nov 2022 14:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 45E5860FB9;
	Fri, 11 Nov 2022 14:17:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45E5860FB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E071C0032;
	Fri, 11 Nov 2022 14:17:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB0AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EC22416C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:17:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EC22416C3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN//8yPg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIZliIzyrxda
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:17:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B44D8416A3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B44D8416A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668176227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiBdslSt1bSUruubf6PHEasMbX0U14MgxCHd3OqQhbo=;
 b=CN//8yPgnnRjbV7rJ0nPq4DCYOMUM3zJmhTdjLXyf5CmawBRoYeriBNeI7NTYelrT5EJkI
 1P2RqB77B30MVl/jxPMTWXjHyXc84Xg5miN0Pep4yGutTOVr/SUHnt9XSULQpemmV6KNlN
 LYr8wefRWeyqSBRqEqdyuBHpBsNSNj4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-Q6lKpVl2NAWzbgH2pFWcdQ-1; Fri, 11 Nov 2022 09:17:06 -0500
X-MC-Unique: Q6lKpVl2NAWzbgH2pFWcdQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 h18-20020adfa4d2000000b00236584fc8c7so1038100wrb.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiBdslSt1bSUruubf6PHEasMbX0U14MgxCHd3OqQhbo=;
 b=J7AfFDtW3HRYVBxTaRhPaCFOwgMwrIs3p5dBv/4v27T/L0cdIGoisScO56zPwOov8Y
 IkN+Na1Fk4cFazpWmeco/pDVUZl1Ia8LXbAqjp7xPWzYZrK7tQnOBV5ufVAJr0LGxtym
 W24M4k3cxnGEFGx37vJ1bvELnS5rZXSjfkcexBm9GU2qQfCNk8hZuLWI581QyCtI6nIh
 jtJa3oIL1A3JRwl98Dx6XAw/hIxX4aqcSApeTWR6lHTbR3Jh82KY15M6YUkRdewapDB2
 VC87ukEya4pWNelN7Ld/2Kr5brQy5gGOKy8Oxmen1FlOL0u2bwsKe4NkP0T0XZW7ZSg7
 4J2g==
X-Gm-Message-State: ANoB5pmwilZP8Zn5AtoMnzUHd9i61yM/LBE8eOWlbfCdIf1XCDwTY+rl
 WMUzG0tpqqmhvPCPhbtF5ZTqH7GMwfLYN3o7urYvc/USyPITAMQiYWx0zrbs1n0rWM10MGhduu3
 ZHWTnQEnv5/vQ3YSOALLC2Q9JEjycC3yLEl/IjnJyEA==
X-Received: by 2002:a05:600c:5029:b0:3b4:c00d:2329 with SMTP id
 n41-20020a05600c502900b003b4c00d2329mr1362980wmr.124.1668176224950; 
 Fri, 11 Nov 2022 06:17:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7TdDAdXx7EakuAx/sNwtHahvESbE7KfpO4jYmbfrt/39VsQCf+w2gM9sJ4e7JngUfVs4mR/g==
X-Received: by 2002:a05:600c:5029:b0:3b4:c00d:2329 with SMTP id
 n41-20020a05600c502900b003b4c00d2329mr1362967wmr.124.1668176224697; 
 Fri, 11 Nov 2022 06:17:04 -0800 (PST)
Received: from redhat.com ([2.52.3.250]) by smtp.gmail.com with ESMTPSA id
 p33-20020a05600c1da100b003c71358a42dsm11315749wms.18.2022.11.11.06.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 06:17:04 -0800 (PST)
Date: Fri, 11 Nov 2022 09:17:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221111091556-mutt-send-email-mst@kernel.org>
References: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
 <CAJs=3_AvDxkY-DZCbRUPw08DsHCoNS6s7cCjcjXMiFkq1K-03w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AvDxkY-DZCbRUPw08DsHCoNS6s7cCjcjXMiFkq1K-03w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Fri, Nov 11, 2022 at 02:20:01PM +0200, Alvaro Karsz wrote:
> > +       /* The virtio_blk_lifetime struct fields follow virtio spec.
> > +        * There is no check/decode on values received from the device.
> > +        * The data is sent as is to the user.
> > +        */
> 
> After more thought, I think that the driver should handle the
> virtio_blk_lifetime struct endianness.
> Something like:
> ...
> lifetime.pre_eol_info = __le16_to_cpu(lifetime.pre_eol_info);
> lifetime. device_lifetime_est_typ_a  = __le16_to_cpu(lifetime.
> device_lifetime_est_typ_a);
> lifetime. device_lifetime_est_typ_b  = __le16_to_cpu(lifetime.
> device_lifetime_est_typ_b);
> 
> if (copy_to_user((void __user *)arg, (void *)&lifetime,
> ...
> 
> What do you think?

I think if you are going to pass struct virtio_blk_lifetime to
userspace, better pass it as defined in the spec, in LE format.

> I'll wait a few days and create a new version.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
