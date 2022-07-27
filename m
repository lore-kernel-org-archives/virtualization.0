Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150E6C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 07:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95E5B4028D;
	Wed, 27 Jul 2022 07:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95E5B4028D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ow0KRks+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2u98T-4tlNAs; Wed, 27 Jul 2022 07:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B64EA40294;
	Wed, 27 Jul 2022 07:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B64EA40294
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69B20C0033;
	Wed, 27 Jul 2022 07:25:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0466B60ACF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0466B60ACF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ow0KRks+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLnTXXdM97OB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:25:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D036E60AC0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D036E60AC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658906707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1uhvQJgNgBb/EtrY8/HY6JS8Vo63objp9HUag9lldKg=;
 b=Ow0KRks+sRJjiuH4lW+6VmpxnABMYuWTsbxnh1Mpu0FJjF14EgfG43E/snrh9dLVnocEqB
 dDwsofuuX5VQM4Rs/cAT9Ai722QzBoySDUWXWdxYhuM0fJDrvpKksKeQV50Hx00GwjZeQ+
 wyOhPIyz1/pC50LrKHcBZfYYbq7b/sA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-SzyXatmBOxWmXJvkpSbODg-1; Wed, 27 Jul 2022 03:25:06 -0400
X-MC-Unique: SzyXatmBOxWmXJvkpSbODg-1
Received: by mail-wr1-f71.google.com with SMTP id
 t12-20020adfba4c000000b0021e7440666bso1542550wrg.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 00:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=1uhvQJgNgBb/EtrY8/HY6JS8Vo63objp9HUag9lldKg=;
 b=Z5rrl5aWikw7vMl8/3YJX1rPnfuFekR1aqi2F0zIYmuhOTIZMgeTz2nCalqQ3qQZhB
 gW5RU4WxhSaC6GJBdw8lShIBD8EVB0qzN8O++3dfF6JwyP4a9O4OCwe/Po+KfaAk3DoR
 judwWFluHb+ElcXvD/FV/a95o/+pFkyI4TZtQkSNMB/fyvPo3kRJKw2brzIM7+Ys1SwT
 CjNiwv93rajXo2RdRzwyUDrzMavs4ukaujs7baTBinHUCed99ejeRXg3uPM2YxvrjWZ/
 ey4HS4doQQQOM2osKhp5VA9ln41NMhHqd3Oa6yUrDdLhnGm56hMSuFqHxc/+IyaPRm+e
 EhoQ==
X-Gm-Message-State: AJIora+UDioTKPRODwNKlzAssd/sbVeGw/LcPBypWYS9zp83WoVc70sV
 qNTWPgFfvbMRmc2amdc1TIfja1Otu2xw484WIDkK8mqZUoDwBrBwTqT4ysZ30/EVToL8ZSO7KAv
 lK3BhT5m0LkKLN8gBXseGwFnmCUpXQhLEMvt+CncogA==
X-Received: by 2002:a5d:4d41:0:b0:21e:a5e3:cb9b with SMTP id
 a1-20020a5d4d41000000b0021ea5e3cb9bmr4027752wru.523.1658906705187; 
 Wed, 27 Jul 2022 00:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vdi1dmMTF6RxBH2H+iNqBm37tUcvS9QzwF73frC4+Mb1+XJ1V8EML989kkzICu8iUiUhyqYQ==
X-Received: by 2002:a5d:4d41:0:b0:21e:a5e3:cb9b with SMTP id
 a1-20020a5d4d41000000b0021ea5e3cb9bmr4027735wru.523.1658906704925; 
 Wed, 27 Jul 2022 00:25:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a5d428a000000b0021eaf4138aesm3574743wrq.108.2022.07.27.00.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 00:25:04 -0700 (PDT)
Date: Wed, 27 Jul 2022 03:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220727032334-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400869D5921E28CE2DC7263AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220719093841-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400F967A710B1151AD5132CAB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB5400AB08EE51E6BF05EEBDE2AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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

On Wed, Jul 27, 2022 at 06:51:56AM +0000, Eli Cohen wrote:
> I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net device (e.g. through libvirt <mtu size="9000"/>).
> Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom to do it using its copy of virtio_net_config.
> 
> The code in qemu that is responsible to allow to consider the device MTU restriction is here:
> 
> static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VirtIONet *n = VIRTIO_NET(dev);
>     NetClientState *nc;
>     int i;
> 
>     if (n->net_conf.mtu) {
>         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
>     }
> 
> The above code can be interpreted as follows:
> if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from the device (that actual value is ignored).
> 
> I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates that we should read the actual limitation for the device.
> 
> If this makes sense I can send a patch to fix this.

Well it will then either have to be for vdpa only, or have
compat machinery to avoid breaking migration.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
