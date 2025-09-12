Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EB30DD35
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692772; cv=none; b=jEhB3vjfPYungpvt6RCTE8C5WOuIUdwPTVrNK6yUPHnbYZ3WxtIcL2sZmkmQfrrLaDWhETdME6PFDSdubE9KUhDApkL49GqLcNEpabLCJYuYFB7j29d+EMYe1ukTyBZKSO805/wSLdn7N6QsqrUEaLLFq/GLb9XElLUwCufco3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692772; c=relaxed/simple;
	bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lVzFqFYu4duh+jJQw/7GmDKamsynlWglDqTk2E5TBLlYbSR80M2dMte2VFRYtPxUSBgwRC6TWgW4iv416JBkpCXnVOAsC8exCTh6TOfOwTSbLUAeGhbDJdnvOcTUjCtYQhZPlDHzp/Td1VROViQXOuwpE9tIdESzx2hyUnKrUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b043a33b060so314144666b.1
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692768; x=1758297568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EvLF922o6xh90k0jchOOI1hJMbi5YioNq3mzLJ5T5Y=;
        b=u2bLNw+zJDtvfePRBKhLdDclrArEitKI6rOn+jSyQl1oEN9arDIUsbx782tVvAW3U1
         PGysUaUv1msA5SYwwu1gOj+v8QbSBcPqAhv3LDIr/YEslVdesCXsZysaXHCFF1gVAcJA
         yisp/LDnF+SujnyhsaJENl/WE0C6/ILt+L9l7gcZAi6erITqcLJaAgWjb2xlkqMEL6IM
         F5RpAMNxfA0SJHEo90jII5nvDFTfSDJe5VCb5mkQZ4pxWbkiLuFbppT9VvnPvFO17GmF
         V37LBWTTydAP+Jf6t+DcxW8Jbxc+BNmOkGHJfzG0AF+BZQjiackZnl2uZJdhLgD9ZxCY
         dS4w==
X-Forwarded-Encrypted: i=1; AJvYcCXSgjAeU+SSui+H7zBZ0c+UM6I7N1n7L/MdmCYMmxewBPYjzmpCZXjVrkKpus19iV/Lg4kYcN0Qzi7gcZkjZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxypbPwJFOF+jLDX+SQ383xYF0457yEgs6JZRi0kbrcsb08jtiU
	qRNO5HWWgUJPiw0GrieHJ6NV+L/7w8v1dDIRFlU+ehsI5wc6JE4e1iw5
X-Gm-Gg: ASbGncuxcKUCV/ocuInDANRPpI/sNXEJxOgBZXKG0lVeP5K3BH09fVguCyDgtzvv6mg
	WrBh+cC8f4UMwHUrZcOGSvPD1UljWinBshWweNb8yKNr+ocsATCR48IuUmJh3JNZYhFrhZwNaQA
	+JOx/x9v41u/rb2Cb5EgQUtMYpXhstquT8Y6ga7oADSar8CScAeFDkVTxTmGTpxg5trT66X2dI/
	WJtU9hLZJkM8IwbR4e0lKpkm9KC4Nw2YO4AvbrlRU7RC7/9BdafSlUWcVgPwJ8Fil80crt++o41
	WWeg+borR9OeRZLdByaMSb3x4uM7z2ax92FR9RnGR5BU8NfLQTNm1GmBbNDOCiLKmxV8RHNA2JF
	97Rec2zFrLOz/BCh8Wz8SBQk=
X-Google-Smtp-Source: AGHT+IF7nXKfppCZg0T1oDeoByPuGMm7/AxQ/s4l0lUlv1p/sNnpirQWVObNtStv6YhQ7tnpMLjRBA==
X-Received: by 2002:a17:907:6e93:b0:b04:6045:f7ed with SMTP id a640c23a62f3a-b07c353f09cmr340005766b.10.1757692767750;
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da268sm391595466b.10.2025.09.12.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Fri, 12 Sep 2025 08:59:09 -0700
Message-Id: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5DxGgC/42NQQ6CMBAAv9LsmZqyFgRO/sN4qGVb9lJMSxoM4
 e8G4gHjxfNkZhZIFJkSdGKBSJkTjwE6gYUAO5jgSXIPnQBUWKlWVdLPkYNP0iBZRCI0ZKEQ8Iz
 keN5LNwg0yUDzBPdCwMBpGuNrX+Ry5z+1XEol20Y7qy+lw8Zde3qwCacx+q3+EdpvoT5rbNCp2
 lT6KGzXjMfTv+K6rm942q9+EwEAAA==
X-Change-ID: 20250905-gxrings-a2ec22ee2aec
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=leitao@debian.org;
 h=from:subject:message-id; bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdao+OCMI/V6R3A03GZZi2wJ2qZih+VI3HD
 OQAz4Oj/teJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 be4aD/4677eIqWjN+GaivFYOB2waQlJAdd5PtEqvoyZKzCciN2ZLwUv+CL3k+BAHdaTzo9ZMCLT
 VQOiK9vGWvS9zMoS0c+FbVzUle4Cc3QDLo3KnnY4CwTZ1cN3Moo+ZwI1RvXLvFzLPu8P4ROjCG8
 CE/JHoN90fusHc3X6hSHgzA4GyQvSQOGwU7EW6LYbdeKn/kA98CbgXEK0fJZ+jJ0dGJf9bpmO4O
 rS/Ko4VuvV9NqhHSIo2bVLc1c/JmGffxuPnPL3HOLOG8Wf4uu94ORR2l16wZjY0/j3coblw6fqD
 ISCD4jZo1OQcrGxhFCia/5sD5Sx1k/L6OWczduJWiIOMYwz3ttBD/bZKUX5WKod22ML7XBMqRJ9
 F5LSpqLdQ3Uet+TcpM2FycBnx9+0rAducmnxTMygeTdkc5teBTkXAXDH6Z1SL2Kp9Q45wPYaqad
 Vb5pWwznlWWIotZRFnIRtC1i2W+pdASKa3OLHBuT4yjCRggJ+AdSYFtFkwtwFipukrEYpoQeFzg
 xZ+lzTU68F+iGvT1zmq1zlCerOpG5W3JIM6Y7P89z2N8+0xaWVf4mugimFjg7YIghhSwAhNTglE
 rqpue1RtBDxjV6Js1Z84KmjPwafCdWs94F+rd9lNz0s09ZmCGeY9erBMGPOGfR5L3hRi5edoraQ
 nkmjP+G5wvxICMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rx_ring_count, which enables drivers to provide the number of RX
rings directly, improving efficiency and clarity in RX ring queries and
RSS configuration.

Number of drivers implements .get_rxnfc callback just to report the ring
count, so, having a proper callback makes sense and simplify .get_rxnfc
(in some cases remove it completely).

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Lei Yang <leiyang@redhat.com>
---
Changes in v2:
- rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
- initialize struct ethtool_rxnfc() (Jakub)
- Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a54@debian.org
---
Changes v1 from RFC:
- Renaming and changing the return type of .get_rxrings() callback (Jakub)
- Add the docstring format for the new callback (Simon)
- Remove the unecessary WARN_ONCE() (Jakub)
- Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f28f@debian.org

---
Breno Leitao (7):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++-------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/ioctl.c      | 81 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 68 insertions(+), 30 deletions(-)
---
base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>

