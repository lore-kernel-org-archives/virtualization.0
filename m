Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC652E40F
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082860; cv=none; b=ESWITFcFFtsXVEkfbIRnpJ/CdwCtGCv3nSQdR/eaNK4hJCxYkYTmaj/QS00RilEl3ff62GurRwA0qgYYcbkoJ80dxgL3xGxXmzWzYPhydzLrDUM5z33WOrkIfzY3zyfqeIJL8VEV9kCW8cjoIHAX1a/JJu0Ei3H6c9HP8/DHWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082860; c=relaxed/simple;
	bh=n2KAAD78OMxGo0jZELGn7CmgUzJxWbOTMafuTjmtr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZLwLU9ttEjWFXOZS1aFXBJ0NMOiQBrOMbG+ktWgHDdId4DCPARrCYKzDoxWQ1bpz4QxSfJtlOiQaFdgmMcbTFsPg1kMTECRpUcQDMjz8udL0r5JQxtCGxhzyG6jIxqm2kcmd6V3LleY34cAxUPTtHkYkTGXiQl+SKKyVK0PEhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmRZXQBA; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmRZXQBA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71A89400FD
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 08:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W79voW0mPayb for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Apr 2024 08:20:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8C972400A6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C972400A6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LmRZXQBA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C972400A6
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 08:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713082853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=scFFEffqql5VQw/Qv/aXLLxw/eS8TS+7oq2PNwfkz2I=;
	b=LmRZXQBAAjQTJFtA5XM5/3gcnwEhkyM8ZhDON19uZVKgs86iTptkbqHem3KXnT7vtRCj9Z
	w6veZVyjlIx7uCGBVPKclx7oOAU9oTF+B4ol8kNlAEASpvwrvf+FZ7Z2RKyFNHHSZT/Sgg
	1TTxm3HwhpjE3j9f50DQ4Ubtieh2izA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-gOMO5eOOPByEd_EDrwTEdg-1; Sun, 14 Apr 2024 04:20:50 -0400
X-MC-Unique: gOMO5eOOPByEd_EDrwTEdg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d02b62ddso1512371f8f.1
        for <virtualization@lists.linux-foundation.org>; Sun, 14 Apr 2024 01:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713082849; x=1713687649;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scFFEffqql5VQw/Qv/aXLLxw/eS8TS+7oq2PNwfkz2I=;
        b=TzTGQ22s2mhhX0wRKfp3VTjdldLfc3MjwhJgDNJ5M+xRQTmO3CeJUwnoPlpSB85bpa
         R3w+PgiAcZv0QqYEtRUtEN0rJqBDSdBRsI60Is76bGFVyEHuuOuMKFV6HLST8lzc6mr2
         pfymZ4wMTZizhFl66I8bqdd5FPlJ2ZyOG8nn0wR338PwDMECIhnL0/uvg7/u+QHFDMvD
         d4WDOzCQ+MNc247xF7ciPL/IfxKz9oPJdmfA39ctQmQxO3BfEwJPGmtuDBDEVlk5XY+Q
         m5DPhewqCfMf2nS1HrzDjqRuZQHrfn3zRLf/x/T0TxI//HwQak7S9JoUC7CCyK1S+NNG
         3/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVFaI5qx6Och4f8mgHbr6ckkovklJW8ogQefa+TG21yTDo4/hSTjVlxwA8RwH9GRVV73z4skx6tIOPmVD3Xw8K4DCLnbk1Ry8GvKjMLIsMxi9zYX+DdoWbzlg==
X-Gm-Message-State: AOJu0YxPHKPD4M6cxaw3zBQjy8+WRl/F4r7yeeQp8o9nUMi8aNJzHtlu
	zua9J7rhQ+RGgtkYjJcYcqOQhs/kGqmVYKaTtLgAG+700vHhft0iJ3F6DM8/1JzXb++43hl7FcD
	MQiOMpCt/YnWTEYX7syIo1UMsxfDhzos49EOcrhi62KggubURSAFB7jWGE51LM2U5IjJyPwlQbi
	E5sXI=
X-Received: by 2002:a5d:5982:0:b0:343:72d3:8bf9 with SMTP id n2-20020a5d5982000000b0034372d38bf9mr5520277wri.47.1713082848858;
        Sun, 14 Apr 2024 01:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV2guaUDq+KT8qZEYNEDAPvDV9IQkfqcCeSva0EuQiOh6/tEv0M8rQI8Ss1T1bEmXAO0Z4xA==
X-Received: by 2002:a5d:5982:0:b0:343:72d3:8bf9 with SMTP id n2-20020a5d5982000000b0034372d38bf9mr5520260wri.47.1713082848235;
        Sun, 14 Apr 2024 01:20:48 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d488d000000b00347321735a6sm4416572wrq.66.2024.04.14.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:20:47 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:20:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	acme@kernel.org, gshan@redhat.com, jasowang@redhat.com,
	jie.deng@intel.com, krzysztof.kozlowski@linaro.org,
	lingshan.zhu@intel.com, mst@redhat.com, namhyung@kernel.org,
	stable@kernel.org, xianting.tian@linux.alibaba.com,
	yihyu@redhat.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20240414042047-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 76f408535aab39c33e0a1dcada9fba5631c65595:

  vhost: correct misleading printing information (2024-04-08 04:11:04 -0400)

----------------------------------------------------------------
virtio: bugfixes

Some small, obvious (in hindsight) bugfixes:

- new ioctl in vhost-vdpa has a wrong # - not too late to fix

- vhost has apparently been lacking an smp_rmb() -
  due to code duplication :( The duplication will be fixed in
  the next merge cycle, this is a minimal fix.

- an error message in vhost talks about guest moving used index -
  which of course never happens, guest only ever moves the
  available index.

- i2c-virtio didn't set the driver owner so it did not get
  refcounted correctly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gavin Shan (2):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()
      vhost: Add smp_rmb() in vhost_enable_notify()

Krzysztof Kozlowski (1):
      virtio: store owner from modules with register_virtio_driver()

Michael S. Tsirkin (1):
      vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE

Xianting Tian (1):
      vhost: correct misleading printing information

 .../driver-api/virtio/writing_virtio_drivers.rst   |  1 -
 drivers/vhost/vhost.c                              | 30 ++++++++++++++++++----
 drivers/virtio/virtio.c                            |  6 +++--
 include/linux/virtio.h                             |  7 +++--
 include/uapi/linux/vhost.h                         | 15 ++++++-----
 5 files changed, 42 insertions(+), 17 deletions(-)

