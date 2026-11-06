Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968769;
	b=Zuvqt6+cPB9ZXMPtw/8g/XO/P3hqzS5whMZ7IlgIcOWD8KeIKRHbgkx7XADFDuGxPuH/
	 iuo3pKm0g2iFuNnUj4oYp8g/cTHSccCdxXYAWeYQ9vVxS54j4bJJ4VxJYYlbDsICbza9A
	 NPFd015t1wEt1k9kSpBpL+JR0eHuROn9AJB7Nn6vJOyXXzytD8gp9HvaY9WpBrzfWPMNl
	 gF6ftFiuDgLhzlrB4bZK51AQGHkg4gMReFIxl4WFw9ZaVE3KeCVja+yxg78sumS/Saib9
	 bhthhOLBK6wbA7AnVK2prGDf+G2+qYyKFfDeEDsS78FFSyxN1PcGR2JmnJCSwMehDjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
	b=z1ePn/fVnXvCIfdpu5RDacGdnCfhqhtEefvqRp6tiCffGJ+IWeJi2KU8ui01Kaxnuwpa
	 Th22h5L3vUcRF4mEz7oyY1lnzxGpWydYJIWluNtB0BJu3DIgOmtCSNDRU/1uUdumepEBn
	 fIX6c9hHYqK77mKdqhU53QeGu3VJxKxZW5KTSpt7UrWIFcZ5nYCyA16Po1fi+fOUkBj1b
	 KjpltkQQrY/ndm6Rs/qG6W6XqXtg4ydtsGfzifrS37X1rMoyz54MqdxnAX8TA1w66S4yh
	 0vdkIUL1XmwKGt/z7my1QGRONkT+5imykTHU37nCDI2ML0CGAczF+N4+EdVPXse15Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bqvvb5qw;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A2606A32C
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 12:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042A2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bqvvb5qw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so7310985e9.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968767; x=1794573567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=Bqvvb5qwfnUuK+sYOh0TME89OTKzmfN/9+uqlnteOu6YnPwkjZQcEAkBPLEkaqd0Cq
         ZtZmQQN7XL48hz1z9nVAWTRuW5Bn+Gj8XWLc5TLWaNiEuvF5NLdV5X6BU54R1Fp1VHoE
         S73tv5SLRyQE6TwVTwWw4tdcelBCdDwWRiZZmXlXLBw0kuxMlAhnQ+RSdiWeEYiAgZTG
         9BE8YnFlnNUTODnM6qH0Y+Twzp33J5hCRyJ7Dq62eWLCOok6ex89w9OG88a65sY6k5iR
         pFPCwOdAkUT2wv2TcFuckGWs7NBCvcNIUFGeKQV37QfxQIXJ2VyEjcaGEXXI8ZOJJlIr
         Xd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968767; x=1794573567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=UC74bXUjVNA3IiGU7hF8qFbwXXkrQigGf4iHsb9dvMC2Gy3fNuBm2MJZSEyX2gzeJf
         WtZ0rgz9q7QEKezHoYPS3C918SypzmkNnp0rM4VN3J0Bam663eHWX0b+wPFQWWd7Xzaq
         uG+7Jd9KOv7oxHwLEm5xAXAtr1YnDvwfIwZ2BX/UzzFq/c5pNR70BXC3ge74mmvqsMq/
         +gXklNaHfeY4x8sd2Zoi7Oik4UsKDGwMigCMbqw4+2lzCvgOQnn1rGSpmzosYN1q64O+
         TXbyTwuk1RdX6bf9DRnec+eO7CVvte6dEGfe2Yirvh6YslSnxOIl1iNZlzGrmHkKfbJ/
         2ggA==
X-Forwarded-Encrypted: i=1; AL+hErEGkcbCKd4W3wM7+AK3vWmj8OF3B8KXBr8QQ0C4P14ClPxkfm1xuK/gOFXWC0myz14jc1fnkXVBoKOrVIhy2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3mvEo4CbwkscAMCAq0ONGjBzrnscSCAm1b45/WddLwkPJep7M
	or/VLD1YMhJGSOv88x6ypt+YCLyG1/e27Qf/jbPEX0kFn9iYd81QXe0y
X-Gm-Gg: AYBFou0CmJa3+pFleRwTFGEgVF9MWphzyL/dj7iDBoB8gPs4IOW4N6aRh+OIWRRvWZo
	MjYIpQbcFNbNBIB3yn64cq679Pjr3iTMRJdVhyj/NMa8JtTiBvOITOvRiwDV8nFonIm+14qkmht
	QpiZ4HcZU8CzMwe/9vhLfBJ0rbYO7tC/QPkV/r3FArSMRt/mEnKH3DXu6kb7Vfes+njcwR0Dzf2
	OugOPTy2NSMhZg1CIaFXL0gYHvqEQy7uvrygP/rxyf8bUzdd/U6ZC2M81LmBIn9TWPJe3tPKFDO
	+AyhAg5sml1Ibwh0TzBJMhDMbzMq8rVP8GKv/1X+Yl/xRLzzyX/sqBt/kc+gms8peZpOzdWoztm
	P+G2To/xdrBUqliqTeEF5PNCJBH6rSwhIPOQnLLIq7zDoFhWbHVvqu8Vet6oj2fz3p1C2vC/0os
	4mTnamloDLgyEj6d1OsCUr1rEPetAm0rkG6TPy/ilgcZMDa/fxJzJiZZDSQH7cJ1Z3EXZpFqYQu
	iGw9fnePVpZRBcNZcbKUCZSu1q1KvKIyeVR2fclx0ewVEoNw3JQRVbAR4tMCc5OZ3dERC1MafN3
	iDLHT7Nlt/0PUMByjRHfIUCq1rtjhwEEmOWf4L73Nb2Ps1Wwq/DHZThZxLjhBGgzGXmrks3f5wn
	k0eHYq3ZmSMoS820eezM9P151xTLc
X-Received: by 2002:a5d:59c1:0:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-49273e5b29fmr5340663f8f.6.1793968767067;
        Fri, 06 Nov 2026 04:39:27 -0800 (PST)
Received: from andreayoga.localdomain ([151.37.255.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3776938f8f.11.2026.11.06.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:39:26 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_sock: Report no unread data before a channel is available
Date: Fri,  6 Nov 2026 13:39:18 +0100
Message-ID: <20261106123920.162131-1-parri.andrea@gmail.com>
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

The Hyper-V transport is assigned before the asynchronous VMBus channel
offer completes.  Its zero-initialized hvsock therefore has a NULL chan
until hvs_open_connection() associates the channel with the socket.

SIOCINQ can query the assigned transport while the socket is connecting,
or after connect() fails once the transport has been assigned.  Unlike
poll(), that path does not check stream_is_active() before calling the
transport's stream_has_data callback.  hvs_stream_has_data() then passes
the NULL channel to hvs_channel_readable_payload(), and any user in the
guest can trigger an oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000178
  RIP: 0010:hvs_stream_has_data+0x23/0x120
  Call Trace:
   <TASK>
   ? vsock_ioctl+0x74/0xf0
   sock_do_ioctl+0x42/0xf0
   sock_ioctl+0x27d/0x310
   do_vfs_ioctl+0x700/0x810
   __x64_sys_ioctl+0x7d/0xf0

Return zero unread bytes when no channel is available, before accessing
the receive state or ring.  Leave the existing channel-backed receive
handling unchanged.

The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
guest with a small user-space program, available on request.  With this
patch, the program reports zero unread bytes and the kernel logs nothing.
Other vsock_test cases were not run, as most of them need a host-side
peer.

AI assistance was used to identify the issue and develop the fix.

Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
An alternative is to check stream_is_active() in vsock_do_ioctl(), as
vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
limit it to the crash, and can send the generic check separately for
net-next.

The reproducer is a new vsock_test case.  I have not posted it, as
Documentation/process/security-bugs.rst asks for reproducers of bugs
found with AI assistance.  I can send it privately, and will post it
once this fix is merged.

 net/vmw_vsock/hyperv_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 855b15971c359..551eabe690144 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -697,6 +697,9 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 	struct hvsock *hvs = vsk->trans;
 	s64 ret;
 
+	if (!hvs->chan)
+		return 0;
+
 	if (hvs->recv_data_len > 0)
 		return hvs->recv_data_len;
 

base-commit: 475ff14ba558bb8857bca878f1d593784ccc4f0f
-- 
2.53.0

