Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B819CC0E
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524716; cv=none; b=mL79iQLjmdga1JTajLHKsGr6s9WMbj1AQqfjcFz+kQm1v3+Ke5jYBl7vc3ei3lt+RsQbfcJ7QY2xuF9IHX/sHVSW+E/xj9+IOg/pyHomeXR3bdeM7lUbnDWQcFcFnxVlDswQTVj3bLDD8U/aFp6XfoavpV0CRTffwolJbWGlFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524716; c=relaxed/simple;
	bh=WAdidfifqCck/K5RDR49Wzv02UWwY6ooFoZfvj2xh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pL9JvWWUCFyRFG/YFdr8zE78ngTNisjj+lAcH23X4xuv8seOOXjhLrMMO9JI1L1Pxr79YLizPH0GRpJROqU3E5qNNoMNAvWtDbfTBTTgRd4ymw0tZrhQaMdG7QZnQCBLYUS6xZkZwEnUdC0+W9bu7HA1ipsIl1ojAzazy7KE8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=UgunIj99; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="UgunIj99"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd51285746so3841788a12.3
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1734524713; x=1735129513; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry1f8EH2vuZ78FOFS8afWTJPFj2kQaLGsja4DlOwPIU=;
        b=UgunIj99o0k5u3xeCxXZdxnMEJBOqwQsn7/F3mmRXTc2OthCpYotiWi/fg+DM9Ci67
         y6/5XFKug96nkxaWYIvgagUYxfD8X9RJ1xoqOAjJGEiPfCosHWLHqH6tDYGGe4tzU7Ur
         Gjh2cUzqVp8J5+wyGRyWqqzSw2bUEDow37mf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524713; x=1735129513;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry1f8EH2vuZ78FOFS8afWTJPFj2kQaLGsja4DlOwPIU=;
        b=VvAeQ5cfnhm5MHWDE2gv0p6nSG8nvbNpUBPkAKYYTy/kgKEzkcR0HWkWiwHqqlUSxU
         ueZeCeZbpGVFbicFzGu/0silTIZGd0q1PkdxAwlnyR+bDOZn8CmKovHIJIkRkdIEU1Q3
         GGD34iK/gk/oF4dnx+Hg4AE0EwjFN09SZPpYfavq+Pf+Ux9FtNP9iFHai3THsR+iFcL1
         t054aIH5hHrhrftfolyZH/5nV2HEZ63vflaBXKPAKbAN3dETeGFV4tRQNfVeIj0m9J+q
         GGjxoCpBOfeREnBMO3mfglRgUmZeIyBwLCvjrSSi0W52GYKT3Vz6CPA9laym1EW5sqHU
         YCEg==
X-Gm-Message-State: AOJu0YwEPpOhumepB65M9Z4YJEd7kZT3Du0MhuaB4QvPq8Ct/GXj0sLv
	WjJYaYxWgHDjPQ98zkOVeX0e/ixUnHeREHt5888cKyiTRP9DJve2IE+qSrcpEzo=
X-Gm-Gg: ASbGncsYjE9LRnfQKL8cWnvN5KKBF09iB2QvNcqPUmf6KSpFNWKmuUHYfMZ8hW5U1aX
	EMyAGnDZt4E9dxGYGxHylz/R/Pn/5f5pYLoXyJVIuf08bjv1LIpivRKyHdn4+KBQZdz4yy0VFx3
	+rd9U5VoV8epNqcn3wkuMRG+5iclVnmUnViqt61jj8JlxzPczMJGCjLX2QDFk8kSUu3iwkrl2kx
	YCNU1WAKWyTRLVpEiP5wogjykaQyEPFrJcJeQw1ZAAZxC/NI9nNw7NHfHHzozk3MRDCUA==
X-Google-Smtp-Source: AGHT+IGiEpjydlEOeDKpnYMGuWBf7igzfRiDu6SwBhJlykAsoY8LX6DKzv9Bxwbl+1NeeAlcB8jGQg==
X-Received: by 2002:a17:90b:2742:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2f2e9302d14mr3697071a91.19.1734524713119;
        Wed, 18 Dec 2024 04:25:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd46sm1386521a91.36.2024.12.18.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:25:12 -0800 (PST)
Date: Wed, 18 Dec 2024 07:25:07 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	qwerty@theori.io, v4bel@theori.io, imv4bel@gmail.com
Subject: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When calling connect to change the CID of a vsock, the loopback
worker for the VIRTIO_VSOCK_OP_RST command is invoked.
During this process, vsock_stream_has_data() calls
vsk->transport->stream_has_data().
However, a null-ptr-deref occurs because vsk->transport was set
to NULL in vsock_deassign_transport().

                     cpu0                                                      cpu1

                                                               socket(A)

                                                               bind(A, VMADDR_CID_LOCAL)
                                                                 vsock_bind()

                                                               listen(A)
                                                                 vsock_listen()
  socket(B)

  connect(B, VMADDR_CID_LOCAL)

  connect(B, VMADDR_CID_HYPERVISOR)
    vsock_connect(B)
      lock_sock(sk);
      vsock_assign_transport()
        virtio_transport_release()
          virtio_transport_close()
            virtio_transport_shutdown()
              virtio_transport_send_pkt_info()
                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                  queue_work(vsock_loopback_work)
        vsock_deassign_transport()
          vsk->transport = NULL;
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                                                                   virtio_transport_recv_connected()
                                                                     virtio_transport_reset()
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
                                                                           queue_work(vsock_loopback_work)

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
								   virtio_transport_recv_disconnecting()
								     virtio_transport_do_close()
								       vsock_stream_has_data()
								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref

To resolve this issue, add a check for vsk->transport, similar to
functions like vsock_send_shutdown().

Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Wongi Lee <qwerty@theori.io>
---
 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..a0c008626798 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (!vsk->transport)
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
-- 
2.34.1

