Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CCAC6FD1F
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 10:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4EE24183D;
	Sun, 12 Mar 2023 10:25:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4EE24183D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U254Ki+X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fbq-aR-dt5_j; Sun, 12 Mar 2023 10:25:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF28F416E7;
	Sun, 12 Mar 2023 10:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF28F416E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C01C0071;
	Sun, 12 Mar 2023 10:25:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAB56C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 10:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A11274176C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 10:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A11274176C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbXpbAWuCWh7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 10:25:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B624416E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B624416E7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678616715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXkk+bo18qTgFk5moKFN7B92iiR/As5vddC+8S+S5ic=;
 b=U254Ki+XG53ZfwYzZ7fb9N01gIj6x/peDoMwXExTQsgN5RcaJ0Vw93vjQw+5WJzJ3+HSn6
 2wuexTwXQRw4UEHpJNa+WHZ4ep0UNTs06+Tm/Q+utgJBz1rcE4GwUXRBzsccdfHsRqUVrs
 ShIfwO8m5a9LnJheEq9NNFfxfzOI9sU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-FlJmaw5tOkqZrZa351vTEg-1; Sun, 12 Mar 2023 06:25:13 -0400
X-MC-Unique: FlJmaw5tOkqZrZa351vTEg-1
Received: by mail-ed1-f71.google.com with SMTP id
 e18-20020a056402191200b004fa702d64b3so3606236edz.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 03:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678616712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXkk+bo18qTgFk5moKFN7B92iiR/As5vddC+8S+S5ic=;
 b=rq1rc6Cdk49SzRUPOA5RUZvlfXkavP9uAY8DuuT0hFNPWgL3WRETIxbgjLxPy+DQ36
 KU4/Tq2ZF/27Tc5j/gen7ryNquV+V+NOHMgQS059Qrt4+mRrEFVaUmR2Pa3H6vSjNq9Y
 I0ZgbrfF9bZYBlzJHGQFmEsPCVHPWJVsHT5lwNp7LkTw/z1drEdX17lvgc5o1O6AW5Aj
 TzLO8sR6nVWdBR3BYmn16HQyQ3BjtKhNCfPS50rWbuGjS+7cylu6DVreQ9qWGS8SDP1Q
 HvlYoJnq8NCDljh/Qv8MZRAbD2ST/uVzVnRKbWUBXNg/aDMGxVxUbhYEwgtZN+QseHsE
 EOFA==
X-Gm-Message-State: AO0yUKXNlI/3csq5zAApLKQXQmI1zep3EFOA9GzmxCwDeywotluCsRYq
 zUa0fFrEWB3ad9t0dlhfa5A5Tr5Lip7xh71Fi5eQmfzwzB/Fe4nYY4Q5I9GslCdohHRioAtYbXF
 ML38ay2bew2Ev0Qp3DjskbDtEBS6HHRyw/MCOd0fTUA==
X-Received: by 2002:a17:907:6289:b0:91d:9745:407e with SMTP id
 nd9-20020a170907628900b0091d9745407emr7799652ejc.18.1678616712719; 
 Sun, 12 Mar 2023 03:25:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Xk1f2bF7i87QqYQvVBuYhNLE0YiaA43XdMk6WHTfahjqThLHzPXP1hZuwBonoO6VHOspIHg==
X-Received: by 2002:a17:907:6289:b0:91d:9745:407e with SMTP id
 nd9-20020a170907628900b0091d9745407emr7799634ejc.18.1678616712418; 
 Sun, 12 Mar 2023 03:25:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fb:4775:5c5c:4007:acc2:a326])
 by smtp.gmail.com with ESMTPSA id
 du1-20020a17090772c100b00926a3155fd0sm454438ejc.98.2023.03.12.03.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Mar 2023 03:25:11 -0700 (PDT)
Date: Sun, 12 Mar 2023 06:25:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230312054559-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: perezma@redhat.com, virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>, parav@mellanox.com
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

On Sun, Mar 12, 2023 at 11:10:25AM +0200, Eli Cohen wrote:
> 
> On 12/03/2023 10:58, Michael S. Tsirkin wrote:
> > On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
> > > One can still enable it when creating the vdpa device using vdpa tool by
> > > providing features that include it.
> > > 
> > > For example:
> > > $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > What's the reason to turn it off by default? It's generally a
> > performance win isn't it?
> It has negative impact on packet rate so we want to keep it off by default.

Interesting.  I feel this would benefit from a bit more analysis.
Packet rate with dpdk? With linux? Is there a chance this will regress
some workloads?
VIRTIO_NET_F_MRG_RXBUF was designed to save memory, which is good
for small tcp buffers.

> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 4abc3a4ee515..3858ba1e8975 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3154,6 +3154,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >   			return -EINVAL;
> > >   		}
> > >   		device_features &= add_config->device_features;
> > > +	} else {
> > > +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
> > >   	}
> > >   	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > >   	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> > > -- 
> > > 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
