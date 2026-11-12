Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498577;
	b=pz+F/ag/aA8X/rDB1dmXSssnkoDvhN68sU0IsRg+xZZGuBWExDu4g6MS+Dc9l7oV6yeq
	 6MzpfK3sgZZgOri8+gXat0S6xV+G3/nZahfkIS2qeAKu6nK6RkaFVd2EH8n+gIPJhMzWa
	 zmnT/+OQ7b6HCkthOFfbCw6d4+vgLxAQDXrdC+RkwpCO/pxsq0c6YuFtyFwyhvXxOCx93
	 YnYJJgNi4kfolnhgqrUenmD2nuduLQpm4LEFdsUKCj35Mg1C1J+cwn+bj4PKxcNJioqcx
	 6tCLrzxAoEb3mgEFRKuI5b67xx0GZGgPa/c4tBTsErD6+z5rM2l2C6Gr6ccRBTUckzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PGUpMcemVyfBVbieZwrWHkk4i4jDJi9m3gXexw58z8w=;
	b=UhQ3phfgKteB2zi2kCJOl7t+iUMHEb/zbZWt2VdTQnPwmS0htskflwS2ruHoeFdcpEAN
	 jk3j1tJYbhNLT38DG6L2tLTLZsEEDDhp1ZE3+KCkVsEepaj9yWpSMBPJYb9nPuj8mv0he
	 UpGU4fu6lrf0K4s3PV0X9s5z81VxzeShwhicIBqHeMUOGLx3H8/nY60Lwnb+G4SSXnsAY
	 TBK9exWjU/KkdeWz+A3Cd6/VVis/5SocKKpkYS2sB2WEUqxZAQgYpY9gZJzorCI9KqRTM
	 79u5qQ/Nlo1WynWAim5g+SrKtMeqc/AASQs2VPrJzuFfTI3KoXKIqY9FCxN3CBVtNCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av0t7Rmi;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CF606A337
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA8CF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av0t7Rmi
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so12430375e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 07:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498575; x=1795103375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGUpMcemVyfBVbieZwrWHkk4i4jDJi9m3gXexw58z8w=;
        b=Av0t7RmijdNnedHFbMc/gQ47tWOERGOWWp5cwbCgM7AKIHWcxqvel+4MRdkuRHwnFn
         4BgdlpN3aqargyRCDskYZhEa1XFDo3sXXa8yRpc/53OhIz85yRjnjG0sF1tSVq+rMxf+
         SjSzz5csMns9nM0YrbatiC6und8VUlFIDsW6vOWF9Sp8uDzMOqfREE7cREXI9s5pkVUc
         qUUlioCb7OA8oi01SlKOUEQqEGkX7pdmzYw4kACj4YOR0JMnPjz+v37NGKYGQcVwxtP8
         PU0UBLWbiDQw8SrhVoOzUeQznABMnFLMLd7Q8pMHpZO3sR3j0ar1XghBNOWx3vptxLLy
         Cb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498575; x=1795103375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGUpMcemVyfBVbieZwrWHkk4i4jDJi9m3gXexw58z8w=;
        b=OZPFdW1uYFGiwhIZ2MmLAw9zRKWzH77KX4j5x9kGVpaWEue+2lVmmgzip8cjUdXZai
         t0X9412amnkg161qKf7Y8vIMFnRE/+Cdk/WfL+7N7VgD967Uh49s7Cy8EirC7dLMDI2i
         ufnmlo+cAfRUmk8kq1lytF/u6BIqHve+Ugct/t3trsbWTYAdT8Ltwq17CLkc1B9U34Qr
         baDPBicm2tq2+iEUpJWLCBzoXpkY1VH9ApbgJ27hqsqKcoZSSyvSdCGnDW7QadCyqfEe
         Gq1wEBC/eklg7k3hIpj81pu78x+xonvV6W/Cvj62CfMHHHbFqjKlIoxKsRWGAPcyngDT
         RS6A==
X-Forwarded-Encrypted: i=1; AL+hErH4IyJ5px+lOf0ibMVYg9Xs5R/C+KTbVlJws7Fem2m3w+h+i6pJ28FVhbBKXDl9ByYsuusHaZe9Dn+nVW7VzA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9mdiXSuCFYjaAyrvlqcOYwLXaWZpn3o1UuZb7fNgFQn/KH5Yyj
	41t61dhqfAKXBabD/IC9J57ihdcbrgKQS4lqCWPq2GG9/oXkIxZCooeE
X-Gm-Gg: AYBFou3i1ZTY6RhPBkWj+KBYuilFOnD/VRIEQ+hKldooBChpqpLYeh5SQBfgHWvzc7S
	KxRNEgzq703OGTmzsACXUAmU/+aHXcjJl67+BxAuhpmGeh+II3SSjJJTnQosCBOQ+1OgfoLMqs9
	0w/WBMlXxYc2i0Ok3klQzH+KGCKiJ9xL9XspvDexy7ce8rlOacWGxIwbypWFgD46kzDDMfc41I6
	KL0djS4+JOPAEM0eQJws9HLfBZD4HJOJSIN0Ps9Wel4zBef7aRjLzJkcS2woou626YGkhLriaYd
	nWRz5jEa3zRfskjxwz4VZjzb2jkQDkDjs5VBts/0Sd2DyRGcNzP6bgjkT/ef2WW7M2zAvZ7wJr5
	q4hwirCvpVCl7yp7FHCZgd8m1BdGaOQxahNG9nad07jgvzu5iD3+pmuHCpVOCW/aQFrMpV3ttYV
	qY8iMSK9EIn8sA3BGR1EBOWla+Eb1EBYJ7zDRCXUbAW25GRnxdZVtLKREEcfSZSlr7nbG5C/Kks
	adlcy9vBUXkIOn6Yd3PMa3kQnOr2K4amnroHo1s9WpL7GNzPrNvZttbeiKDPRMeapjJiqyK7DUw
	O5o3IIHQTarBafBwPF/fkGxe1gNcd7I8G8B08uifPKUucQOvZq535xRM0q80IsU98YaIq5lkakc
	=
X-Received: by 2002:a05:600c:6219:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb4e27995amr53713365e9.5.1794498575107;
        Thu, 12 Nov 2026 07:49:35 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:4868:f22e:b51d:7cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm139337155e9.1.2026.11.12.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:49:34 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Francesco Valla <francesco@valla.it>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] virtio_ring: reject a split ring size that is not a power of two again
Date: Thu, 12 Nov 2026 16:49:15 +0100
Message-ID: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The split ring indexes its rings with num - 1 as a mask, so its size
must be a power of two. vring_new_virtqueue() lost that check in v4.6,
with commit 2a2d1382fe9d ("virtio: Add improved queue allocation API"),
and remoteproc passes it a ring size taken from firmware. A firmware
that asks for, e.g. 100 entries gets a ring on which the driver and
the device disagree on where the buffers are, so the device can read
the wrong ones. The only thing remoteproc checks is that ring size
and alignment are not zero. The other caller, mlxbf-tmfifo, uses a
hardcoded size of 1024, so it is not affected unless that value is
changed.

Patch 1 puts the check back; patch 2 adds a vringh_test case for it.

Tested in userspace with tools/virtio only, not on remoteproc hardware.

Changes in v2:
- Patch 1: log with dev_err() rather than dev_warn(), and say in the
  message why the length is bad (Francesco)
- Patch 2: commit message updated for the new message text

v1: https://lore.kernel.org/r/20261111172947.3579982-1-stjepan.poljak@gmail.com

Stjepan Poljak (2):
  virtio_ring: reject a split ring size that is not a power of two again
  tools/virtio: vringh_test: check that a split ring must be a power of
    two

 drivers/virtio/virtio_ring.c |  7 +++++++
 tools/virtio/vringh_test.c   | 11 +++++++++++
 2 files changed, 18 insertions(+)


base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0

