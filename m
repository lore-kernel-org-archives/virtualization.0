Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E56AC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 13:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F3DA829DC;
	Mon, 26 Sep 2022 13:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F3DA829DC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sib5IscL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vvqu-ja1bJc; Mon, 26 Sep 2022 13:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E395682437;
	Mon, 26 Sep 2022 13:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E395682437
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC12FC0033;
	Mon, 26 Sep 2022 13:22:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02429C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0C5E40B7F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0C5E40B7F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sib5IscL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8xggcAzvtYF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAB1240B00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAB1240B00
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664198517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7qiiLpBZNt2KOcykqgJFQ/WQh3oxgQ6inHkaKhb85Y=;
 b=Sib5IscLwkCJpCzcQaahJfuUkB+6APQqt7D9cK3QqMhKpRvl9R0sd2E7Vr32vnF54Y6Mqs
 NRsh1h0qhngx7v85HvPJvlk78oWntcR9BUlf5JofTuS6g/6SPwhMztaV/z4rB94eNtXErY
 w+xF1y9lcBIFY9wTR68yon9xlbaS+Yw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-a2BxxRYfOoWCDicpSmAcow-1; Mon, 26 Sep 2022 09:21:56 -0400
X-MC-Unique: a2BxxRYfOoWCDicpSmAcow-1
Received: by mail-qk1-f197.google.com with SMTP id
 az15-20020a05620a170f00b006cece4cd0beso4941028qkb.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=i7qiiLpBZNt2KOcykqgJFQ/WQh3oxgQ6inHkaKhb85Y=;
 b=Cv5DRkgG0eCxajn7fFz7BXhrvDQunK0uq1Hab2FNey8YVDRz2C9hEs7QmN98qTkL0F
 C9EOdobtZBN1MwX/+YbMjXSOFVMkpy0FRHh6fdFDN/NErr2TW8Blv3WSyOpSuciPRNcR
 Jng4680951CERbQKSnrq/MJp5HkTtk4iv5u277fMZPHw/Vhg+dOCcXFeyJNPtqRa8fiN
 AnFI/ez4LXvvMyVKVlyjfonKiRivnxa6PbFkmgcEO90iQsdbRfr+zphHRo0jt5FoUkh5
 3x4s1rj+tx1SaX/4c46OnHJbyLKxIyHDos5jfQU/n91fg3DCUhdFvsR4DSbniApt6zHt
 xsPA==
X-Gm-Message-State: ACrzQf3bGj2Ll/Qp/UpQi8Uc8vTrm500YpVj50MYUuwsOFQ2UaQjm7KM
 JPK8+5ii9cIMGBoOhV6FQEe6R5Zv2K+8WLez9rFk+t+7Vt/DKRgSqdpm4thl/zACsvr1ahaKTAr
 m1FwRpRpjQ4M64l60+daHe6sffjagGZ2XsgxeJ5GjmA==
X-Received: by 2002:a05:620a:424c:b0:6be:78d5:ec73 with SMTP id
 w12-20020a05620a424c00b006be78d5ec73mr13912687qko.579.1664198516071; 
 Mon, 26 Sep 2022 06:21:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NrkIGne8y/GZLW9JHXe3yOUbh+JzzdSUUNw9PrzRz4UIl+C1M5V42BCPhQxA5Z5E+K1+G3w==
X-Received: by 2002:a05:620a:424c:b0:6be:78d5:ec73 with SMTP id
 w12-20020a05620a424c00b006be78d5ec73mr13912666qko.579.1664198515834; 
 Mon, 26 Sep 2022 06:21:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05620a450e00b006cbcdc6efedsm11986040qkp.41.2022.09.26.06.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 06:21:55 -0700 (PDT)
Date: Mon, 26 Sep 2022 15:21:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 2/6] vsock: return errors other than -ENOMEM to socket
Message-ID: <20220926132145.utv2rzswhejhxrvb@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hyperv@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 15, 2022 at 10:56:05AM -0700, Bobby Eshleman wrote:
>This commit allows vsock implementations to return errors
>to the socket layer other than -ENOMEM. One immediate effect
>of this is that upon the sk_sndbuf threshold being reached -EAGAIN
>will be returned and userspace may throttle appropriately.
>
>Resultingly, a known issue with uperf is resolved[1].
>
>Additionally, to preserve legacy behavior for non-virtio
>implementations, hyperv/vmci force errors to be -ENOMEM so that behavior
>is unchanged.
>
>[1]: https://gitlab.com/vsock/vsock/-/issues/1
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> include/linux/virtio_vsock.h            | 3 +++
> net/vmw_vsock/af_vsock.c                | 3 ++-
> net/vmw_vsock/hyperv_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 3 ---
> net/vmw_vsock/vmci_transport.c          | 9 ++++++++-
> 5 files changed, 14 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 17ed01466875..9a37eddbb87a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -8,6 +8,9 @@
> #include <net/sock.h>
> #include <net/af_vsock.h>
>
>+/* Threshold for detecting small packets to copy */
>+#define GOOD_COPY_LEN  128
>+

This change seems unrelated.

Please move it in the patch where you need this.
Maybe it's better to add a prefix if we move it in an header file (e.g.  
VIRTIO_VSOCK_...).

Thanks,
Stefano

> enum virtio_vsock_metadata_flags {
> 	VIRTIO_VSOCK_METADATA_FLAGS_REPLY		= BIT(0),
> 	VIRTIO_VSOCK_METADATA_FLAGS_TAP_DELIVERED	= BIT(1),
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index e348b2d09eac..1893f8aafa48 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1844,8 +1844,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			written = transport->stream_enqueue(vsk,
> 					msg, len - total_written);
> 		}
>+
> 		if (written < 0) {
>-			err = -ENOMEM;
>+			err = written;
> 			goto out_err;
> 		}
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index fd98229e3db3..e99aea571f6f 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -687,7 +687,7 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> 	if (bytes_written)
> 		ret = bytes_written;
> 	kfree(send_buf);
>-	return ret;
>+	return ret < 0 ? -ENOMEM : ret;
> }
>
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 920578597bb9..d5780599fe93 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -23,9 +23,6 @@
> /* How long to wait for graceful shutdown of a connection */
> #define VSOCK_CLOSE_TIMEOUT (8 * HZ)
>
>-/* Threshold for detecting small packets to copy */
>-#define GOOD_COPY_LEN  128
>-
> static const struct virtio_transport *
> virtio_transport_get_ops(struct vsock_sock *vsk)
> {
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b14f0ed7427b..c927a90dc859 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1838,7 +1838,14 @@ static ssize_t vmci_transport_stream_enqueue(
> 	struct msghdr *msg,
> 	size_t len)
> {
>-	return vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+	int err;
>+
>+	err = vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+
>+	if (err < 0)
>+		err = -ENOMEM;
>+
>+	return err;
> }
>
> static s64 vmci_transport_stream_has_data(struct vsock_sock *vsk)
>-- 
>2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
