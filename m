Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0DBC19F2C
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 05:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAFF681A46;
	Tue, 16 Aug 2022 05:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAFF681A46
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NCmAuI0a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IyiX98z2xYnD; Tue, 16 Aug 2022 05:36:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A27F81A27;
	Tue, 16 Aug 2022 05:36:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A27F81A27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D83EC0033;
	Tue, 16 Aug 2022 05:36:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06161C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B74B7409E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B74B7409E9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NCmAuI0a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2rHQXLTVBNvc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECAA5409B4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECAA5409B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660628186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WjKAhjhunNiMNkU3Od6M/0vKjOdgqMSNXwPsu3GbYh8=;
 b=NCmAuI0aPjSxucEYBU8yGeLRCd7GRTTzcKYkF9clHE2EdnFkg2mBy61WzUWhXosK614Qy6
 S1dqvkA1kiEzxSqLvE6o18ZOM/Y3reNsvD0YsEseL8TriNJTnIdG6eExj+oPzAB33p+z7y
 I/pYck+/PMumsu4I/c6K6g8QKdJ/sLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-dh-FM6XrNRSxlnW9dNrNyw-1; Tue, 16 Aug 2022 01:36:24 -0400
X-MC-Unique: dh-FM6XrNRSxlnW9dNrNyw-1
Received: by mail-wr1-f71.google.com with SMTP id
 h13-20020adfaa8d000000b00225174e4965so63632wrc.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=WjKAhjhunNiMNkU3Od6M/0vKjOdgqMSNXwPsu3GbYh8=;
 b=jzeis+Tn/JXSX4wjOqXzY3ccBKyukP8/D1fkuk+20p2xqwSINr1tcJ847IDOydenR4
 ACo+q45x0xHZC7kYXoWBIMIGfkAAF799vYi09i6AZFL7gSTukXe3IdoEPZa14R3QBeiY
 j+O/XOera44pIaKid+k15xjbqL9icK2LQ30yQVv/DXhcrAES3rTeXI8DnFnvZUlLhBKG
 DLUwfADOFXGNLjblJrpFlsVJkFekwsUNZvvWaqTsfFx+dKXPTBbgJ1zyVcODAL1oImnA
 QYCPaNo/iLwt7jL8XFx2iBAsxecP6UbAX6hCEpJ8HeYvi1wCCuoeoCggKAyBLtLcxlhF
 nxHA==
X-Gm-Message-State: ACgBeo2NMsVitPcKps5SFYoHaLsZrgQVirpSDgaiagNAxgwm9Kj2qGL2
 EIF84vdHXS/RTMUKvS6419RcMcwCCNAMJ9oIneMA7z9qTRwkBG3RgGAvV9K5uN7+YCpydYqXxJR
 Q8/yBvWdZWB38gH7eVLG3s8uJnKCm4k5lacmYm5sKDw==
X-Received: by 2002:a05:600c:5023:b0:3a6:3f9:a031 with SMTP id
 n35-20020a05600c502300b003a603f9a031mr1681803wmr.131.1660628183682; 
 Mon, 15 Aug 2022 22:36:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ytdoo+ffEU/Wth88pKDtXl7fYx4Itdz9p5tt4Lf/IjatyzTa6AA/SXcS7E/UC3HmlhH/8rQ==
X-Received: by 2002:a05:600c:5023:b0:3a6:3f9:a031 with SMTP id
 n35-20020a05600c502300b003a603f9a031mr1681790wmr.131.1660628183420; 
 Mon, 15 Aug 2022 22:36:23 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 v17-20020a5d43d1000000b0021eed2414c9sm8763232wrr.40.2022.08.15.22.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:36:22 -0700 (PDT)
Date: Tue, 16 Aug 2022 01:36:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] virtio: drop sizing vqs during init
Message-ID: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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



Supplying size during init does not work for all transports.
In fact for legacy pci doing that causes a memory
corruption which was reported on Google Cloud.

We might get away with changing size to size_hint so it's
safe to ignore and then fixing legacy to ignore the hint.

But the benefit is unclear in any case, so let's revert for now.
Any new version will have to come with
- documentation of performance gains
- performance testing showing existing workflows
  are not harmed materially. especially ones with
  bursty traffic
- report of testing on legacy devices


Huge shout out to Andres Freund for the effort spent reproducing and
debugging!  Thanks to Guenter Roeck for help with testing!


changes from v3
	added a vdpa revert
changes from v2
	drop unrelated patches
changes from v1
	revert the ring size api, it's unused now

Michael S. Tsirkin (5):
  virtio_net: Revert "virtio_net: set the default max ring size by
    find_vqs()"


Michael S. Tsirkin (6):
  virtio_net: Revert "virtio_net: set the default max ring size by
    find_vqs()"


Michael S. Tsirkin (6):
  virtio_net: Revert "virtio_net: set the default max ring size by
    find_vqs()"
  virtio: Revert "virtio: add helper virtio_find_vqs_ctx_size()"
  virtio-mmio: Revert "virtio_mmio: support the arg sizes of find_vqs()"
  virtio_pci: Revert "virtio_pci: support the arg sizes of find_vqs()"
  virtio_vdpa: Revert "virtio_vdpa: support the arg sizes of find_vqs()"
  virtio: Revert "virtio: find_vqs() add arg sizes"

 arch/um/drivers/virtio_uml.c             |  2 +-
 drivers/net/virtio_net.c                 | 42 +++---------------------
 drivers/platform/mellanox/mlxbf-tmfifo.c |  1 -
 drivers/remoteproc/remoteproc_virtio.c   |  1 -
 drivers/s390/virtio/virtio_ccw.c         |  1 -
 drivers/virtio/virtio_mmio.c             |  9 ++---
 drivers/virtio/virtio_pci_common.c       | 20 +++++------
 drivers/virtio/virtio_pci_common.h       |  3 +-
 drivers/virtio/virtio_pci_legacy.c       |  6 +---
 drivers/virtio/virtio_pci_modern.c       | 17 +++-------
 drivers/virtio/virtio_vdpa.c             | 16 ++++-----
 include/linux/virtio_config.h            | 26 +++------------
 12 files changed, 34 insertions(+), 110 deletions(-)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
