Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7862EBDC7
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930548; cv=none; b=abHb0GAW32it3LD8gLfgEmbQ+PXWad0IS3wKMB3+kcQ6G9HSNizlQoGiYmL0sfRZFQfzxig7fCG1Zt5bueZryAxOAyvB/UTKauzb2WMy4uQNeDuxpU86rylBMRyz7DYdirIjuYAmpvaFMkPBkMaMrRc7q8SRnrPNxRQoUttc468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930548; c=relaxed/simple;
	bh=fzE8vjOCqgEdVLGviLFQQ/if3C/Y0MI6EzENTGjvUpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ty0bSviALbSoSgbsIhhAHTa1PwCl5DMnENcs+0x3/7Uni014tpt/eejickLBvWJ0W5CvX2EXMpHYzBxj+s/pjOQZ5C4acGKg+NAOR7RZUv80PeGRfitxKcp+MVQ3CUOFQB6SW55YFq5Pz3i6Ept8Xslg9101/cFfaMNzPyt21aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqFWEfYr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqFWEfYr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso412737b3a.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930542; x=1763535342; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sY1ws7TASlscml7aUd7HPBk1tWYzYKHf5oRjRrX7GME=;
        b=UqFWEfYrhB15idBfT0g2BW+PEmstWiaBWtGfZOY8NWYAyChr5kT3hWqLdHc/iwoiLU
         cE2K1yVo2BpIontcEaVO4YOsN/VxddkfIfiZLavf1uoWpcK8Da4l4gT/bXe6sutsWshK
         itNw5mXlXXLyU0VQW6jQ6yHsCV0EoIuBIFiq/fq6VwpPnBwar1U/ZlrcwV45q6ziLIbn
         9VIPiu6xKo6/rou/9naaQzPz/88RqI8RxMQjY+xNvj/BAAvFitV5MGaA5+y+yVynzJg2
         KwLhLgsKsofWijbsnYJZ442FIbdpqLKDA6Gp0j4iFcdcHlAarnK4vVPx0+ijMCQoQo7B
         uT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930542; x=1763535342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sY1ws7TASlscml7aUd7HPBk1tWYzYKHf5oRjRrX7GME=;
        b=i59srahPuwRSVrwK21bkmAvS/lb6iJgp0Fh4pDN+txKXVUs7CSGRVwqq6e0+4VZ4K6
         oUmEXLEpD3G8Aya702PxDto56zGDGjD0MVIQ3Kioyk+0UZlxxsyPJ7tshcrybVaM467/
         taiovubYRXegy2yPwBB0Y45l/okAp7dLr7OMMHOjG16rNULdxCSKZ1GtOSkfANG0yqEo
         WoNO63Tm8nkQEosNXp8fLZo9NMLsuvfaDQVFGg42xsdhqdRjArqrHBTyo7UfB2eIsduI
         d5iwzSBO/LsmoSbUlIsKJ1BdDo1ms985+M2o1llTpmtFfldMtAfddVMoZk/ue/sGUaOx
         jQ5g==
X-Gm-Message-State: AOJu0YxsuC3zTGTl57hTJkbKPh2Fm7fwmj94TgxrQO9W+fmg7octEZ8Q
	2Y2eT3V5q/qe3CZS3oDDEF+3XkZQ3yaZyqg6AKN3AAcZa3tMSvftwX2E
X-Gm-Gg: ASbGncs1jeDJITTaQsGSHMhdW6so2qqXf++vzdtLwbmI3hYDXmeY/o96vhuBj8koB+I
	BRPL6V8MSmlYH+RW5zsZ8jdbDZhY98jSsKBX79gadA74lf/AaAhNkt6EzrTRUcSFsiJyk2lnHyz
	dq18kxXXD0vfXEMv07P+XukYg2PClmnwpsIwwjDM6fTg2otDH0GV+zEjcoxGiu55YaTdL9E1dr0
	wCSif1cU65tBQ0NQUJ9itJlp5JDAg+BViZcGHQdIgFJsqEveFCUxmUSxSMdOyeSYni4F/QL5u2a
	rOZ0SxTykDKm8qpjMvWwDEgUX5Vpg69DEErOk6HS5ZmwEIvgSQm44/ILEFjfJr9q7WjluRCmJGS
	fZ3jOkuy2nJmg8XUm2u9mwL1LsBdjA9Xs/zU9sUrJ6ixoYGzkUUhqWC+rYVQcIAUQbKuwf7/wJg
	==
X-Google-Smtp-Source: AGHT+IELhzgnizTiqKz1cTk9BoLnvpdIuZr/u1AmUOgJ4ajaUaegLKsYPXo9c/uRPcWaVRaXIBlchQ==
X-Received: by 2002:a05:6a00:4f85:b0:7ab:2896:bfb with SMTP id d2e1a72fcca58-7b7a2d8f209mr2120012b3a.13.1762930542332;
        Tue, 11 Nov 2025 22:55:42 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd4edc3sm17522079b3a.66.2025.11.11.22.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:42 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:50 -0800
Subject: [PATCH net-next v9 08/14] vsock: reject bad VSOCK_NET_MODE_LOCAL
 configuration for G2H
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-8-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
is operational. Additionally, reject G2H transport registration if there
already exists a namespace in local mode.

G2H sockets break in local mode because the G2H transports don't support
namespacing yet. The current approach is to coerce packets coming out of
G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
to coerce sockets in the same way because it cannot be deduced which
transport will be used by the socket. Specifically, when bound to
VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
until a packet is received and matched to the bound socket that we
assign the transport. This presents a chicken-and-egg problem, because
we need the namespace to lookup the socket and resolve the transport,
but we need the transport to know how to use the namespace during
lookup.

For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
used on systems that support G2H, even nested systems that also have H2G
transports.

Local mode is blocked based on detecting the presence of G2H devices
(when possible, as hyperv is special). This means that a host kernel
with G2H support compiled in (or has the module loaded), will still
support local mode because there is no G2H (e.g., virtio-vsock) device
detected. This enables using the same kernel in the host and in the
guest, as we do in kselftest.

Systems with only namespace-aware transports (vhost-vsock, loopback) can
still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
intended.

The hyperv transport must be treated specially. Other G2H transports can
can report presence of a device using get_local_cid(). When a device is
present it returns a valid CID; otherwise, it returns VMADDR_CID_ANY.
THe hyperv transport's get_local_cid() always returns VMADDR_CID_ANY,
however, even when a device is present.

For that reason, this patch adds an always_block_local_mode flag to
struct vsock_transport. When set to true, VSOCK_NET_MODE_LOCAL is
blocked unconditionally whenever the transport is registered, regardless
of device presence. When false, LOCAL mode is only blocked when
get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).

The hyperv transport sets this flag to true to unconditionally block
local mode. Other G2H transports (virtio-vsock, vmci-vsock) leave it
false and continue using device detection via get_local_cid() to block
local mode.

These restrictions can be lifted in a future patch series when G2H
transports gain namespace support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h           |  8 +++++++
 net/vmw_vsock/af_vsock.c         | 45 +++++++++++++++++++++++++++++++++++++---
 net/vmw_vsock/hyperv_transport.c |  1 +
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index cfd121bb5ab7..089c61105dda 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -108,6 +108,14 @@ struct vsock_transport_send_notify_data {
 
 struct vsock_transport {
 	struct module *module;
+	/* If true, block VSOCK_NET_MODE_LOCAL unconditionally when this G2H
+	 * transport is registered. If false, only block LOCAL mode when
+	 * get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).
+	 * Hyperv sets this true because it doesn't offer a callback that
+	 * detects device presence. This only applies to G2H transports; H2G
+	 * transports are unaffected.
+	 */
+	bool always_block_local_mode;
 
 	/* Initialize/tear-down socket. */
 	int (*init)(struct vsock_sock *, struct vsock_sock *);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c0b5946bdc95..a2da1810b802 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -91,6 +91,11 @@
  *   and locked down by a namespace manager. The default is "global". The mode
  *   is set per-namespace.
  *
+ *   Note: LOCAL mode is only supported when using namespace-aware transports
+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
+ *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
+ *   with EOPNOTSUPP, as these transports do not support per-namespace isolation.
+ *
  *   The modes affect the allocation and accessibility of CIDs as follows:
  *
  *   - global - access and allocation are all system-wide
@@ -2757,12 +2762,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
 		if (*lenp >= sizeof(data))
 			return -EINVAL;
 
-		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
+		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
 			mode = VSOCK_NET_MODE_GLOBAL;
-		else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
+		} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
+			/* LOCAL mode is not supported when G2H transports
+			 * (virtio-vsock, hyperv, vmci) are active, because
+			 * these transports don't support namespaces. We must
+			 * stay in GLOBAL mode to avoid bind/lookup mismatches.
+			 *
+			 * Check if G2H transport is present and either:
+			 * 1. Has always_block_local_mode set (hyperv), OR
+			 * 2. Has an actual device present (get_local_cid() != VMADDR_CID_ANY)
+			 */
+			mutex_lock(&vsock_register_mutex);
+			if (transport_g2h &&
+			    (transport_g2h->always_block_local_mode ||
+			     transport_g2h->get_local_cid() != VMADDR_CID_ANY)) {
+				mutex_unlock(&vsock_register_mutex);
+				return -EOPNOTSUPP;
+			}
+			mutex_unlock(&vsock_register_mutex);
 			mode = VSOCK_NET_MODE_LOCAL;
-		else
+		} else {
 			return -EINVAL;
+		}
 
 		if (!vsock_net_write_mode(net, mode))
 			return -EPERM;
@@ -2909,6 +2932,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 {
 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
+	struct net *net;
 
 	if (err)
 		return err;
@@ -2931,6 +2955,21 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 			err = -EBUSY;
 			goto err_busy;
 		}
+
+		/* G2H sockets break in LOCAL mode namespaces because G2H transports
+		 * don't support them yet. Block registering new G2H transports if we
+		 * already have local mode namespaces on the system.
+		 */
+		rcu_read_lock();
+		for_each_net_rcu(net) {
+			if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL) {
+				rcu_read_unlock();
+				err = -EOPNOTSUPP;
+				goto err_busy;
+			}
+		}
+		rcu_read_unlock();
+
 		t_g2h = t;
 	}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..ed48dd1ff19b 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -835,6 +835,7 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
 
 static struct vsock_transport hvs_transport = {
 	.module                   = THIS_MODULE,
+	.always_block_local_mode  = true,
 
 	.get_local_cid            = hvs_get_local_cid,
 

-- 
2.47.3

