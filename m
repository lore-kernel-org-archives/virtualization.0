Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102728C870
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301197; cv=none; b=sbRQNONgpH1oTHyTUtbwq4n0/hTPzP8dsaIwEconJLiNRF9snKvZQJO9WChF/YqwbQRCPCcqMBQ0ilPYgGhP0dDn0Jpc9u86WQrISQlAMAJAPp/A0vXqH/ypSSQ1Er/G9elg3zIhyvvIKOlajgv/9nEk56mo+2V6BF8NtmIBe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301197; c=relaxed/simple;
	bh=TlBBWhjw66vU0WVncgBo0ciJaAdFdenxkE0NF7pgGLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=nWnZ6XUKSJQh4Nd3B1xCa2u8Olrs1BmBWVQ5adq048ej2YtocL4ZEF81qcuHLgrYDG23qVdYje23R3OpIY1dmljMdyKVTALTu1OGLpMLLv8/zTe06BU4FQSAW54TnCUPYRr8lXjptjxmS6jrBFDpabyCsBtJnu4qdbWtoh1JVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApYPHPZz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApYPHPZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751301193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PCXz84xtjif+9AQOmzcJZnqlDzRDa6bAl/lnTU35pOE=;
	b=ApYPHPZze4CWGUk2cNGvw32uP8Rk7MhR8tH9Y8Bkd5cCP3ml1/GRgReKWd72jUqqi/Li55
	rnKbMobahY/3hs5PMyITgkoDGAGnfOaueYnouGau9BDAhbBIuYUExmJHO3KacmGTVVG4sF
	E+8l+cy9fRRSlP/+pJlcxjSrTKhbmto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-EouXCY3tPWK5B-nIj4PGcg-1; Mon, 30 Jun 2025 12:33:12 -0400
X-MC-Unique: EouXCY3tPWK5B-nIj4PGcg-1
X-Mimecast-MFC-AGG-ID: EouXCY3tPWK5B-nIj4PGcg_1751301191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450de98b28eso26312745e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 09:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301191; x=1751905991;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCXz84xtjif+9AQOmzcJZnqlDzRDa6bAl/lnTU35pOE=;
        b=vcncTkdZ+h3jMK/UGA5gXRJ+cV1PkLYJzXlRNYjZ3nqZCQscFLsZuE7vQboMqS6yZW
         d6DARePOS1BUrv2XgpiQPVk2yuYyf4fxY0bMF/VDZwOYODX7HbYqN4fUIjealpnCLH9x
         H2aIRp5i8qOsTDlkJ67Dv3mUUzQBmrlp4sBhZRTCe0UYoVgGExrk67Wtb/UACplLzW5t
         G6gQIh33QQHQMxFSsOYwkJUSrfCjx3zLs/zz4XSLeYye37Y38IQbW5rDF3WtbIbD2DV2
         qEXCawFEqsc0gJBzU2Lj5ere45uZSvjov5K6HHwKMJ6j54ujKYJPsR5T3Jrshg+q8vpk
         Rgqg==
X-Gm-Message-State: AOJu0YySHlRojZLnArg2corD/mlbXeZ9XbbKJttBCkDeuTmA/Ih4qJG5
	tyxu1Wll9F+RFMHLeBCA4PzdkB29z9mA/PItxQ9GNv91/H5clBMf/CMopaoG6VSfy+0ulO3FFyN
	ol/OL3OFsOjMypEXnqISiwANop/+pbscKCD8qr2nRpPd61p0OOqkGRw8UpYAKEyvLrpga
X-Gm-Gg: ASbGncsoQG/BSNa9BC1WzuGO2JKODtBDwM7iaxRFQYLXDVWzMh66MP53NFsVbtO5BGj
	mfdKqBFLaU9UupwgRocNXsgpSPoG39h2tF8dX3jdG/sRvdi+omMMT/nJskX7uzlpEssW/7TcmH9
	aHOL+eZME+Oyi49S3N4gCyANCgNQTM3OE8aLeaFksUqljMEaTe+Boe3kTpMOCy9jBBsPJmKlEAQ
	Krh8viuti7az+DLKugKdaK7i2NyZYn2fuME2sRwW0Dd0jzb20tK2vGtjHvV9S6To+h1QJzIiJEU
	4DN/R+vvID4KvkSMzSqafuqhOmSNYZcrZJZBWGLKYBUZRXpn5wv4zg==
X-Received: by 2002:a05:600c:548a:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-453a7912cabmr2232205e9.6.1751301190529;
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSfXHhHLnv7HHQ+5LMg0eJpi2fcwuM4hIgZV34bWufMI5k6opX1s+0mXAanNIxjpTh6gD5WQ==
X-Received: by 2002:a05:600c:548a:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-453a7912cabmr2231815e9.6.1751301190105;
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm142554375e9.30.2025.06.30.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:33:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next v5 0/2] vsock/test: check for null-ptr-deref when
 transport changes
Date: Mon, 30 Jun 2025 18:33:02 +0200
Message-Id: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD68YmgC/23NwWrEIBQF0F8ZXNeiT42mq/5HGcrr86WR0qSoy
 AxD/r2STSdMl5fLufcmCufERbycbiJzSyWtSw/u6SRoxuWTZYo9C1DglFGDrFzqeysrfUnD3uN
 IHsE60cFP5ild9rE3sXCVC1+qOPdmTqWu+bq/NL33/w02LZVUBtSHQ6JphNfMccb6TOv3vtPgz
 mp7sCC1NKRQx+ADDvHBmj87aH2wpttgtUWINk7D46+9s3D8td2q4GmkwODwaLdt+wVA6J2CYwE
 AAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>, 
 Hyunwoo Kim <v4bel@theori.io>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QB_kSokx5CIkJqxih1Q-slhfrZN4GMiJ2Qw_qmvggyE_1751301191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2].

Note that this test *cannot* fail, it hangs if it triggers a kernel
oops. The intended use-case is to run it and then check if there is any 
oops in the dmesg.

This test is based on Hyunwoo Kim's[3] and Michal's python 
reproducers[4].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v5:
- Addressed Stefano's comments:
    - Use a macro for G2H transport detection
    - Improved commits and comments text
    - Rebased on latest net-next
- Link to v4: 
https://lore.kernel.org/r/20250624-test_vsock-v4-1-087c9c8e25a2@redhat.com

Changes in v4:
- Addressed Stefano's comments:
    - Minor style changes
    - Use `get_transports()` to print a warning when a G2H transport is 
    loaded
    - Removed check on second connect: Because the first connect is 
    interrupted, the socket is in an unspecified state (see man connect) 
    . This can cause strange and unexpected behaviors (connect returning 
    success on a non-existing CID).

- Link to v3: 
https://lore.kernel.org/r/20250611-test_vsock-v3-1-8414a2d4df62@redhat.com

Sorry, this took waaay longer than expected.

Changes in v3:
Addressed Stefano's and Michal's comments:
    - Added the splat text to the commit commessage.
    - Introduced commit hash that fixes the bug.
    - Not using perror anymore on pthread_* functions.
    - Listener is just created once.

- Link to v2:
https://lore.kernel.org/r/20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com

Changes in v2:
- Addressed Stefano's comments:
    - Timeout is now using current_nsec()
    - Check for return values
    - Style issues
- Added Hyunwoo Kim to Suggested-by
- Link to v1: 
https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com

---
Luigi Leonardi (2):
      vsock/test: Add macros to identify transports
      vsock/test: Add test for null ptr deref when transport changes

 tools/testing/vsock/Makefile     |   1 +
 tools/testing/vsock/util.h       |   4 +
 tools/testing/vsock/vsock_test.c | 170 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
---
base-commit: 647496422ba9d2784fb8e15b3fda7fe801b1f2ff
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

