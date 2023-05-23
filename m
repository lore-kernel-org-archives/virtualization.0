Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53818C77B75
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 08:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD6DB83BB5;
	Tue, 23 May 2023 08:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD6DB83BB5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fqkif2y9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iH8zkRYaAW3I; Tue, 23 May 2023 08:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EAF383B74;
	Tue, 23 May 2023 08:28:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EAF383B74
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6585C0035;
	Tue, 23 May 2023 08:28:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30320C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F17794092B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F17794092B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fqkif2y9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0t3LkWmPYda3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C170740903
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C170740903
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684830500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oI/4wShwGXiYC/M0FetC+F33lv+S4Jn3oTnjllbt4NQ=;
 b=Fqkif2y9NCQ1h4k75U8O2ULq79T1jUj+OnU1JBv27MNip911gmv2rMMVih/pTabzJNd6yg
 9GtAkkut379a5UqGRNAM0D7Vm0J3TSS+L/UzjwUVrfpQ8shZwJbouq3uGyP78l1+8muLdk
 8b4vWXMYoOftA+3aajRB5ztbTcJlEDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-hKzeR28ZPXuXCKe7KFHU3A-1; Tue, 23 May 2023 04:28:18 -0400
X-MC-Unique: hKzeR28ZPXuXCKe7KFHU3A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30940b01998so2573704f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 01:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684830497; x=1687422497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oI/4wShwGXiYC/M0FetC+F33lv+S4Jn3oTnjllbt4NQ=;
 b=Qf4lefUBxkbDZ/65la+018f3OwFn525nv4ppbOpP98n0L/sp4BV96auAB5OtDiydma
 nL8MDNmWlQvt9Dasrk0h+0D6gNHgUWAM4rGbdUp/MWV1N2s4okB7jFierCiPb8/O75FY
 0v8w1svTIsCJfR9nc0s41ZcYTeF94/dHSnVGhWzgPPvPGRRtSXG8mBWpjuQ0cF4K5r06
 2xp1y3VXW87f+IMnVDh+xKI2PtQTdrYfHlsrfE9A7OASP+JRsGZYH8djCytEiwahbQvD
 jTe/hzact01QodLd1q+foLEFXjN/0wCHSvuo3yHDRzVFMqU7wkskKw/ssvAN9upqjN0k
 HZcQ==
X-Gm-Message-State: AC+VfDwC2EFAMIuIdgJogNHZ+vY/aIgoPsyJF6VOFg7Zqhzl77iAT/Rt
 poN7flzFn+++3ImXQPpg1dkZykx1XZr5sX+QM1K9kfVCJucnAt81qTn2cRRq4nz5GyLa2DmCPAE
 dBTFJJsLlC3nYki7C37L7xQ83EkZ0waOQ0Hk1gPVZJA==
X-Received: by 2002:a5d:4d51:0:b0:306:36e7:db27 with SMTP id
 a17-20020a5d4d51000000b0030636e7db27mr9640529wru.16.1684830497568; 
 Tue, 23 May 2023 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aKAkuwRvqBd8TQwt5AdDaihv1b8LIeMa6LhXWh+lkVCJmWhq9+OEUqCBef4zC61PJ7aUEXA==
X-Received: by 2002:a5d:4d51:0:b0:306:36e7:db27 with SMTP id
 a17-20020a5d4d51000000b0030636e7db27mr9640514wru.16.1684830497261; 
 Tue, 23 May 2023 01:28:17 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 q3-20020a7bce83000000b003f4fb5532a1sm10926705wmj.43.2023.05.23.01.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 01:28:16 -0700 (PDT)
Date: Tue, 23 May 2023 04:28:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: vhost stable branch
Message-ID: <20230523042446-mutt-send-email-mst@kernel.org>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
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

On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> Hi,
> 
> I am looking for the stable branch for vdpa fixes in the vhost tree [1]. There
> are 3 branches that seem identical: linux-next, test and vhost. linux-next seems
> to be -next branch. Which one would be the stable branch?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 
> Thanks,
> Dragos

Here's the changelog if you want to know what I'm intending to send:

 tools/virtio: ringtest: Add .gitignore
 vhost_net: revert upend_idx only on retriable error
 virtio_net: Fix error unwinding of XDP initialization
 virtio_net: Close queue pairs using helper function
 virtio_net: suppress cpu stall when free_unused_bufs
 hwrng: virtio - Fix race on data_avail and actual data
 virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
 tools/virtio: fix build break for aarch64
 virtio-crypto: fix NULL pointer dereference in virtio_crypto_free_request
 virtio_net: Fix error unwinding of XDP initialization
 vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister

If I missed any fixes let me know!
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
