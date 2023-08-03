Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9556C001DF
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 14:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5633941ECC;
	Thu,  3 Aug 2023 14:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5633941ECC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hHZWQopQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJT5KtHSveX0; Thu,  3 Aug 2023 14:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7ACBA4190C;
	Thu,  3 Aug 2023 14:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ACBA4190C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61703C0071;
	Thu,  3 Aug 2023 14:37:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 352B2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 14:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D86241E88
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 14:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D86241E88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wWVKEnFeTYSr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 14:37:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E1D541F19
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 14:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E1D541F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691073447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=OknEm8VC5sm8GzRRkTiE0WaT99Wf05uG5BceRobSi2M=;
 b=hHZWQopQON2A0sN4MRBTQDsEqJK29tVrtQf+x8fRRjD5sga7ZRW2l2uczL5fckVFtkqIBS
 CMS/mcIyWg52sgVpOIlXaFXM0QhrVEsjvEfhAHUH1wbgFcVAA4u3yKWbpNa5PS5CCkR4L+
 12V5zBfvLGjJCKR2dghkYwm17AlOEwo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-303JRKj2NfiHIlMJTl2Ejw-1; Thu, 03 Aug 2023 10:37:21 -0400
X-MC-Unique: 303JRKj2NfiHIlMJTl2Ejw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F77280D210;
 Thu,  3 Aug 2023 14:37:20 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E581C585A0;
 Thu,  3 Aug 2023 14:37:20 +0000 (UTC)
Date: Thu, 3 Aug 2023 10:37:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: Unbinding virtio_pci_modern does not release BAR4 in Linux 6.5.0-rc4
Message-ID: <20230803143718.GA2330143@fedora>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0987191376274712237=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0987191376274712237==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gHDPkeVRc+BebveC"
Content-Disposition: inline


--gHDPkeVRc+BebveC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
After running "driverctl --nosave set-override 0000:01:00.0 vfio-pci" on
a virtio-blk-pci device, /proc/iomem shows that BAR4 is still owned by
virtio_pci_modern even though the vfio-pci driver is now bound to the
PCI device.

This regression was introduced after 6.4.7 but I don't see the culprit
in the git logs.

Unfortunately I don't have time to investigate further right now but
I've included instructions on how to reproduce this below.

Can anyone else reproduce this and can we still fix it for the upcoming
Linux 6.5?

Thanks,
Stefan
---
$ qemu-system-x86_64 \
    -M q35,accel=kvm,kernel-irqchip=split \
    -cpu host \
    -m 1G \
    -device intel-iommu,intremap=on,device-iotlb=on \
    --blockdev file,filename=test.img,cache.direct=on,node-name=drive0 \
    --device virtio-blk-pci,drive=drive0 \
    -blockdev file,filename=test2.img,cache.direct=on,node-name=drive2 \
    --device ioh3420,id=pcie.1,chassis=1 \
    --device virtio-blk-pci,disable-legacy=on,disable-modern=off,drive=drive2,iommu_platform=on,ats=on,bus=pcie.1

(guest)# driverctl --nosave set-override 0000:01:00.0 vfio-pci
(guest)# cat /proc/iomem

--gHDPkeVRc+BebveC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTLu54ACgkQnKSrs4Gr
c8gnoggAkr/wVkzva9qBRY1P4WhULrl3gcphJn4LlD+2Fi8lOyOkznl+VlCyDk8p
9/EfM/b6RPnKipjUG++iotttjJYF8Nk7xM3tAUHU8Ksxt/CGmNRvYSJXQavFbVH+
F20HG1yNUwvNnxQtHWdPD93eGNywzCpcXECXTdLf9xlMv5WmBTI2JgObGLpTxWGy
8qwZ6i/j45i4HnuGh6GWBPMm22j7G3/uGsC4VXdSJyn9gWSoDQRwwdZkFWbrGnqn
+BT3D2IGFwnfvqp0rMA4GmRE/I5vAR7J4xDEAMB7V2F23GDA3TdBfjhhN+igLo27
JN/odjixuxyepPGNfNqeDuEjPkGiZQ==
=5EmQ
-----END PGP SIGNATURE-----

--gHDPkeVRc+BebveC--


--===============0987191376274712237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0987191376274712237==--

