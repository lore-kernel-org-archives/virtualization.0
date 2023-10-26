Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89071C25B67
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18CE0616FD;
	Thu, 26 Oct 2023 13:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18CE0616FD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FkwYBlyB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SEeGxNEU0UvX; Thu, 26 Oct 2023 13:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F6BA616CE;
	Thu, 26 Oct 2023 13:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F6BA616CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B6B7C0071;
	Thu, 26 Oct 2023 13:15:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA1F9C0071
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 13:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 786E383C25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 13:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 786E383C25
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FkwYBlyB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qBeQi6qK8GN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 13:15:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF43883C24
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 13:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF43883C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698326122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V+ivfBY0EhBt3SvBEqkvRAnG/KAtacMk+jERdi9zRd8=;
 b=FkwYBlyBDlRN04s7JLIc1LdrYf1iWDhbEx1/XQw04ZWk4qiCS7jgr2kJ7xkDZ0++T3bpeo
 N3ceG4mFq3kncZ+/aLo5me0Lg4+6UBEentBqfJ3Ftn5yqvtMPMa/2ewiPn8em5DGi53FP/
 iKACTverB4z7iCrKwh0EixQO1EX2ZGA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-EzQ4f7wQM6etALkkJ9Nm4g-1; Thu, 26 Oct 2023 09:15:21 -0400
X-MC-Unique: EzQ4f7wQM6etALkkJ9Nm4g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae7663e604so62093866b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698326120; x=1698930920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+ivfBY0EhBt3SvBEqkvRAnG/KAtacMk+jERdi9zRd8=;
 b=ZU84ZZs/aT8FQ5Ji3QpTefDYZmhvhEWJWRS9uA451ai7IPE3ectKUS9XrVmrjmFfaJ
 wYX2cL+K5wKC7OQP98hwXKmH/AKwrprBqOUdwmjBs2hGMJGg1LGYgADiSbxzMgecMp90
 Jye3tx+YnfXBARGnC2Q17N8vxJxEW2PcViRwLer2JDRTw/KM0nP6RdnFSxJgBDRw03w5
 SoH18WKFZEpK/WgBqnw9Ys/1/yX+4beAU6W3aMar4ziCf2n5GBBsX4/me8fpYfmlgcWu
 /Tf+XgUFBMFah5p09vTKvTSCGOYDHCazGY9tBPLYUZoH1jb+BFpybwnLrI6rliFcLEyw
 D9gA==
X-Gm-Message-State: AOJu0Yyhwoeryk1eLjMOGH5nVvr32lNwMUKVhoGSagmsI1E/9Cy38BH3
 yLkUMA7x5bi9+sKT7jzHSd6hs2HDoukmjQartsD4FXH86gggJpdFy1GS7jkaOOvT22oMNv8bY+6
 /wBG+KQYztPYEoeO4jpBx+jKFEUEesjkZ2625faMhVw==
X-Received: by 2002:a17:907:940b:b0:9b2:74a1:6b30 with SMTP id
 dk11-20020a170907940b00b009b274a16b30mr11707769ejc.33.1698326119980; 
 Thu, 26 Oct 2023 06:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOL/fiO/SndAbiqJJ06r4gwbwdZjUHuuWA1xhHABgHCCooD5g48fXhYoIzcng70jfrbGhT/Q==
X-Received: by 2002:a17:907:940b:b0:9b2:74a1:6b30 with SMTP id
 dk11-20020a170907940b00b009b274a16b30mr11707756ejc.33.1698326119649; 
 Thu, 26 Oct 2023 06:15:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a170906354c00b0098f33157e7dsm11516690eja.82.2023.10.26.06.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 06:15:19 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:15:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026091459-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
 <20231026081033-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E1AF869C1296B987A34BDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E1AF869C1296B987A34BDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Thu, Oct 26, 2023 at 12:40:04PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, October 26, 2023 5:42 PM
> > 
> > On Thu, Oct 26, 2023 at 03:08:12PM +0300, Yishai Hadas wrote:
> > > > > Makes sense ?
> > > > So do I understand correctly that virtio dictates the subsystem
> > > > device ID for all subsystem vendor IDs that implement a legacy
> > > > virtio interface?  Ok, but this device didn't actually implement a
> > > > legacy virtio interface.  The device itself is not tranistional,
> > > > we're imposing an emulated transitional interface onto it.  So did
> > > > the subsystem vendor agree to have their subsystem device ID managed
> > > > by the virtio committee or might we create conflicts?  I imagine we
> > > > know we don't have a conflict if we also virtualize the subsystem vendor ID.
> > > >
> > > The non transitional net device in the virtio spec defined as the
> > > below tuple.
> > > T_A: VID=0x1AF4, DID=0x1040, Subsys_VID=FOO, Subsys_DID=0x40.
> > >
> > > And transitional net device in the virtio spec for a vendor FOO is
> > > defined
> > > as:
> > > T_B: VID=0x1AF4,DID=0x1000,Subsys_VID=FOO, subsys_DID=0x1
> > >
> > > This driver is converting T_A to T_B, which both are defined by the
> > > virtio spec.
> > > Hence, it does not conflict for the subsystem vendor, it is fine.
> > 
> > You are talking about legacy guests, what 1.X spec says about them is much less
> > important than what guests actually do.
> > Check the INF of the open source windows drivers and linux code, at least.
> 
> Linux legacy guest has,
> 
> static struct pci_device_id virtio_pci_id_table[] = {
>         { 0x1af4, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>         { 0 },
> };
> Followed by an open coded driver check for 0x1000 to 0x103f range.
> Do you mean windows driver expects specific subsystem vendor id of 0x1af4?

Look it up, it's open source.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
