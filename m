Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7221CC49
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805824; cv=none; b=FvSsbtviRK63ei/IA5BTW6Lk4cR9/f6x+uqXqq3IK4w3ogpmCkCkds3XCNk0/bM4xqS5YD7nhmPUVA/dVVLmnXoPQeXsUnC8617YNMK/dx33VUD+N747DudM3sXJ/2RmcDD1XGfnXZriZL456uoeeD9EUY4aJD8+/zcoDd5rPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805824; c=relaxed/simple;
	bh=0B43x3hO60s/q7zuJq3RHOjXfJvIsP5KZNO4MN7Tppc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=obmI7oBw5Ug7rkicqOp119LQDiTallTlm2IJBNuuADkYxw/0gHtudNiXX1QynUigVREmX6ZHz9677A+uNBIq/hhN/ymP5Bv6+aDkEH8wlmdfYmB8ZsbGMGTGXPH+YXaqos9m5IaYAqZ9bPdqfe1LhnZNPXP7RwDmpnesiNH6860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DECKPo1S; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DECKPo1S"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C648411E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 13:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQicLHnO_RZs for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Sep 2025 13:10:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3EC5083EC7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EC5083EC7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DECKPo1S
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3EC5083EC7
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
	b=DECKPo1SUylXy39P44wVpzMhUT+EypRxLpfO4IcaL/fBeyI+Wu13YdAbJ98dYjb/+o31O6
	/0ZNnafaqFkkWgqVn51c5pBwphpaEDiRvAeY5ZedEHxY3FXWxJ5p53xWiP/6rWYuqBRSxS
	oTiaJa7kcFOxICzJvnV7OjhxoNzjBCs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-oCB2JbqlOg-IlQLQ4kHATQ-1; Thu, 25 Sep 2025 09:10:17 -0400
X-MC-Unique: oCB2JbqlOg-IlQLQ4kHATQ-1
X-Mimecast-MFC-AGG-ID: oCB2JbqlOg-IlQLQ4kHATQ_1758805817
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee130237e1so432601f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805816; x=1759410616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
        b=K7z0gIK+ZO/eXr5gQf+Zue5Xx7cecyzTmyr0or1E9otrWOXJ0zgjeY01u+jyvdZa2m
         Ef38OAmR2qJBwhFmMNFYWoDHr+tELD/2V2GAsmqn7aGrSO9kfQmuCOQZxGdTWxBaszcW
         Zn4bLDua83zV6d2X68vs9cjWPGCnXcpyoOvY4wFBf165g7lTXiDznZdjrSOOBNNIe40v
         ZFNWSH8pZ+MTJPV8PDqCDnolXzJl+i8vs/FZbwtEMQhFCZIspO1iFV8H+XbUsMGvNKHU
         QzAaApofCzHGWfLzEFf+39b91DvnmtcJbrGxJ7Pp6jNElvMfbPYSVIWg9ydzatFZlCfY
         kftw==
X-Forwarded-Encrypted: i=1; AJvYcCUzw+p0v8rzLC0gWD4xPXBbB34lT8fCtEQKZtb4uawFkTEXwflztbTzgBhCDhGaGt1ruX9GaKV78YLUj49B+A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxYBg5TRwUHkX99f8jtYzsJFKsWYoNcTXUQDQ+q7NVwqaa1C9i9
	Y+fB4TjBos+ULAoWB2X8a+pzTQ2Hr44RkSfUkdjMINusI3r1cK9/B2bPVlAnUlEJPZvmpcxHHk/
	JLoPZL/rYbwKSjcGBwjCX30tXVVp72kVBDGiVC6cX9xfYRb9/DNgM1T7nFSMO3nUI7bcZ0d3sjT
	VyQy6M2vI=
X-Gm-Gg: ASbGnctWtTF0Fhs9wvyCL5YPG8oMGRBNASqWL1CR076mbjR1jPho3p+I3qALoznmfam
	q1u5uUOcoks0M8BTUA7aXhi/ydl6tYGuhqtQVEKZ4j4M3r6h5aWSHic/6/darZsHptEy2LO43oP
	9CZ0kPIpDhge26qaLnVWc45L1Z/3D+hbBgq9ILS620nyDns+7HVCiJWOh8NyRS7qeakXPh4LlSp
	JEAEFn5Ll9Tgn4mQ5ygO6GA6LsjyJalSepa4+ykkJmyTKHWRJHIi8orsyh8P8eBDr/FL4JHgilk
	js0JRv3J6pCFQg+N4qcuCf70qCCfRuPazg==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216278f8f.49.1758805816377;
        Thu, 25 Sep 2025 06:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzU/fT07/taXxNhpSlgViOVy92VqAS1NyA0bx0hGfqPg/L3VBSKrQfSmeVvB7FScm07URuig==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216242f8f.49.1758805815830;
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm3112468f8f.13.2025.09.25.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, bigeasy@linutronix.de,
	hi@alyssa.is, jasowang@redhat.com, jon@nutanix.com, mst@redhat.com,
	peter.hilber@oss.qualcomm.com, seanjc@google.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250925091012-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w81eeT8zi5v-PagrvT-y0jBSikVrr19rZDS5AkDqP6M_1758805817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a couple more fixes I'm testing but the issues have
been with us for a long time, and they come from
code review not from the field IIUC so no rush I think.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cde7e7c3f8745a61458cea61aa28f37c3f5ae2b4:

  MAINTAINERS, mailmap: Update address for Peter Hilber (2025-09-21 17:44:20 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this fixes crashes and hangs in
vhost-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Jason Wang (2):
      vhost-net: unbreak busy polling
      vhost-net: flush batched before enabling notifications

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Peter Hilber (1):
      MAINTAINERS, mailmap: Update address for Peter Hilber

Sebastian Andrzej Siewior (1):
      vhost: Take a reference on the task in struct vhost_task.

 .mailmap                      |  1 +
 MAINTAINERS                   |  2 +-
 drivers/vhost/net.c           | 40 +++++++++++++++++-----------------------
 drivers/vhost/scsi.c          |  2 +-
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 kernel/vhost_task.c           |  3 ++-
 7 files changed, 29 insertions(+), 32 deletions(-)

