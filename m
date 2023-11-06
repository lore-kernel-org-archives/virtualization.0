Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C94C4167D
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5301482358;
	Mon,  6 Nov 2023 10:47:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5301482358
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LG1uB8Wu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xK4uJulEKlls; Mon,  6 Nov 2023 10:47:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A21DD82089;
	Mon,  6 Nov 2023 10:47:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A21DD82089
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 865BEC0039;
	Mon,  6 Nov 2023 10:47:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED0F9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D37DC41465
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D37DC41465
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LG1uB8Wu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hwfg59VSAJh6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:47:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B074841464
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:47:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B074841464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699267666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
 b=LG1uB8WuFH9su5K7aCgwzKvND5RWpE3E1Oc1lvsH/VIOHJ5OEl+lwEVqFUcWZAVrlxoIxS
 1D9w4t1/puoSqcQBms0o9XTk+/QDtLZi4mB3Hx4PDb3/UZ+PFK0nRQTaA0jgoDXvMJX0Pw
 FnPlh6Sot/CYNLIapd4v6xBiP4oF8hc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-ThTh0vCiM16xWZsBbMFlww-1; Mon, 06 Nov 2023 05:47:43 -0500
X-MC-Unique: ThTh0vCiM16xWZsBbMFlww-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41b83b8dbe1so50962091cf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267663; x=1699872463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
 b=YXo2a2p/D1wWuFP57nbz/RlXte/x/0ghBS/WBGHXkX7IKLloLoU19YJzD9TyJSZbxj
 gsMmQpnvrshjS8P/fTlbCdy19aZ6WIx6L0VvPFdO8ogDPGg1kM7xGaXV+u0FojM2mH6e
 VefbhP9JhmWeGysydlZmOc8guzBq1qwf23dOkVeFvo9lvhbl0GfM3Xt5RelfAW7jOsV3
 uWH2c68CfU+pgYXUbrakZTP0WS3lAuCpymNjjtPObpRHVJAFRtqfMldI0oLIn0cSkjc1
 vki2D9mZy61e1E+UMerTAQ2FhacA5lq8mKoTG8vuJFhIdw1vW05/CA8YtlWzlzMjRV2i
 z7Iw==
X-Gm-Message-State: AOJu0YzANDmlcPTLqxAiejiTinuQ433CkHxBKnR6PIu/qgqxYls+Ta/4
 UXnWMDpVnwP3SBZBKBpaIkJeh5dyqH1HzuXc5u2zF+qfb4V62pl+rV+JutMmMk7yr3+FEynunwa
 Y7/cZtqwEMUV+9L2/G0lS8CYZYJW+OyuIZEC12i2mwg==
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id
 u9-20020ac858c9000000b003fddab59430mr34239780qta.16.1699267663092; 
 Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjH5tsrv9EosQgCdf+Wk5X4APcmLon+ih9JbEw8zpkDnU51uS7si0Atvpc7KZve/mxRma74g==
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id
 u9-20020ac858c9000000b003fddab59430mr34239760qta.16.1699267662799; 
 Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 b10-20020ac8678a000000b00410a9dd3d88sm3253917qtp.68.2023.11.06.02.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Date: Mon, 6 Nov 2023 11:47:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Subject: Re: [PATCH net 3/4] test/vsock: refactor vsock_accept
Message-ID: <l2ng7ukyxj5ykzznogyescuufalhfvx2cvrykpht6gqyjrfoy3@ib6dag5o2qik>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-4-f.storniolo95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20231103175551.41025-4-f.storniolo95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 imbrenda@linux.vnet.ibm.com, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, asias@redhat.com, pabeni@redhat.com,
 luigi.leonardi@outlook.com, davem@davemloft.net
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

On Fri, Nov 03, 2023 at 06:55:50PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This is a preliminary patch to introduce SOCK_STREAM bind connect test.
>vsock_accept() is split into vsock_listen() and vsock_accept().
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 698b0b44a2ee..2fc96f29bdf2 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -136,11 +136,8 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
> 	return vsock_connect(cid, port, SOCK_SEQPACKET);
> }
>
>-/* Listen on <cid, port> and return the first incoming connection.  The remote
>- * address is stored to clientaddrp.  clientaddrp may be NULL.
>- */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+/* Listen on <cid, port> and return the file descriptor. */
>+static int vsock_listen(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -152,14 +149,7 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 			.svm_cid = cid,
> 		},
> 	};
>-	union {
>-		struct sockaddr sa;
>-		struct sockaddr_vm svm;
>-	} clientaddr;
>-	socklen_t clientaddr_len = sizeof(clientaddr.svm);
> 	int fd;
>-	int client_fd;
>-	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
> 	if (fd < 0) {
>@@ -177,6 +167,24 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 		exit(EXIT_FAILURE);
> 	}
>
>+	return fd;
>+}
>+
>+/* Listen on <cid, port> and return the first incoming connection.  The remote
>+ * address is stored to clientaddrp.  clientaddrp may be NULL.
>+ */
>+static int vsock_accept(unsigned int cid, unsigned int port,
>+			struct sockaddr_vm *clientaddrp, int type)
>+{
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} clientaddr;
>+	socklen_t clientaddr_len = sizeof(clientaddr.svm);
>+	int fd, client_fd, old_errno;
>+
>+	fd = vsock_listen(cid, port, type);
>+
> 	control_writeln("LISTENING");
>
> 	timeout_begin(TIMEOUT);
>-- 
>2.41.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
