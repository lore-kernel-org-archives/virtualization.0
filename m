Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42437C4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 08:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB647610D1;
	Tue, 31 Oct 2023 08:23:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB647610D1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bqo2Crsq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wa1BO1gfoQMI; Tue, 31 Oct 2023 08:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 862216117B;
	Tue, 31 Oct 2023 08:23:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 862216117B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A538AC008D;
	Tue, 31 Oct 2023 08:23:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12A78C008D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0755A82C91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:23:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0755A82C91
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bqo2Crsq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMOgE_RvldJY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:23:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4503982C7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4503982C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698740589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkPsJmsvqXKseM89Bl+2H72cqwC7IoO2lINO3/fCkdY=;
 b=bqo2CrsqFnHUxot5eRIhWPPZxLGYFIgQSHlhzux29Ujq5JuYFoA5yS1reE2II+0wSJinT0
 t9s3SZEXdShfUNFdV794pA5MjzPzANQ8G85gbUWloS9DpwU5vi+hVlv+e9pD730PjBQiPb
 WPvD9dIsZRuHPunIfeWNjvbMkqcTLiI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-6zbt0tPnNqGpErxShXG3fA-1; Tue, 31 Oct 2023 04:23:08 -0400
X-MC-Unique: 6zbt0tPnNqGpErxShXG3fA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f5d49be0aso2690237f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698740587; x=1699345387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkPsJmsvqXKseM89Bl+2H72cqwC7IoO2lINO3/fCkdY=;
 b=w9pWJezIfne4+0lI7psSDw9UEeB7CymFSV3zQo+cr9ysITpRQn0X1KDX517ur5Jdbs
 km+OMEcZx+w7q1/3/dhPZwsaJguXgYLssQq9hNw9Ma+SCieIaun1dfIPAi+F7rEnObub
 pw1SYO9n/aOobnnCSz/wsEcpiK/alF1/v5dpGotOjgZSux+64wRfjhZsiMAWYZMmvVas
 NpWL4sVW/t3fkL/Y8GEGkGsc3NTdNLfONOMNmn1P+KcUDUrzuyd1BS9uXJzBlR8iAsrq
 nksoR2/YfmNAe0dlKLSKHgozt0nCT5484BTpmG5c1o/KvzHcvmnAG5n0WKMK8NSFuScO
 QVPw==
X-Gm-Message-State: AOJu0Yz6mMvXOq0m5jAJ9nHm6l2+Hqaep7oZ+d3bNXxC9M9i3ks55gs9
 8PHFtVVR4BTHFY2yNaUghgObq/i3jRlHnqb3yd2IbHHnoe3GOCIxXHCFEfamFCwA+guvaNyNr//
 TtgEWvphi3GqkFUFw1tTHdplLLnBpVsBSGv84FFlCxA==
X-Received: by 2002:a5d:6daa:0:b0:32f:914e:427f with SMTP id
 u10-20020a5d6daa000000b0032f914e427fmr1815541wrs.16.1698740586949; 
 Tue, 31 Oct 2023 01:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc9PcfR+ryqLtXXr3yzpBv1Zn+JInlQMRQv8GNG2r0TcqZoR483Dbi/gFCaOouLVRP4wmRPw==
X-Received: by 2002:a5d:6daa:0:b0:32f:914e:427f with SMTP id
 u10-20020a5d6daa000000b0032f914e427fmr1815518wrs.16.1698740586591; 
 Tue, 31 Oct 2023 01:23:06 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 c8-20020adfef48000000b0032f7c563ffasm906445wrp.36.2023.10.31.01.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 01:23:05 -0700 (PDT)
Date: Tue, 31 Oct 2023 04:23:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH V2 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231031042235-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-10-yishaih@nvidia.com>
 <4a5ab8d6-1138-4f4f-bb61-9ec0309d46e6@intel.com>
MIME-Version: 1.0
In-Reply-To: <4a5ab8d6-1138-4f4f-bb61-9ec0309d46e6@intel.com>
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

On Tue, Oct 31, 2023 at 04:17:45PM +0800, Yi Liu wrote:
> a dumb question. Is it common between all virtio devices that the legay
> interface is in BAR0?

It has to be, that is where the legacy driver is looking for it.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
