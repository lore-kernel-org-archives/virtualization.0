Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B00C4332F
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87284841F4;
	Tue, 15 Mar 2022 08:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExKcxZh3sGVG; Tue, 15 Mar 2022 08:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE3B5841F2;
	Tue, 15 Mar 2022 08:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98BB2C001A;
	Tue, 15 Mar 2022 08:15:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA5F2C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0DE4415F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P6OQp-KHugbP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FA2C415EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647332129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCvl2VW1cmsTMiDGSIxoASCMFsGS7CwQX41mH9mi7og=;
 b=GLQ2QN3w2LMu/wbVMYfwVOcs6Z+0pket2OIHSSAUn4BPIRBRl5eCtPlwo94n4YgKQX9zri
 ccA9F4tSHJ/Yw7UrZ13ukStMY2NmGS2f4m3g1WRuBztqDuN+KHRGMHyzvRpxLeENpJKT5i
 /kpklsncn5YpFuOJBg9NvVDJ/Px+/D4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-s1Nx_NIJOr6M4aKVhQOioQ-1; Tue, 15 Mar 2022 04:15:27 -0400
X-MC-Unique: s1Nx_NIJOr6M4aKVhQOioQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 cb11-20020a05622a1f8b00b002e06f729debso13409560qtb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 01:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tCvl2VW1cmsTMiDGSIxoASCMFsGS7CwQX41mH9mi7og=;
 b=O35vfiZSIj1L1/rYkl1/9Kpr8CkQwmw+w/LMuJ0HGzrl8/Zuh6ig9iZy68Jqz+JkPc
 NoVP6S3sKTPS/TR/4//oOEah0w1V3QgXAcS1OHbiDsSpMloLLB8ut2x8hS/8L8dTvMOV
 7ZFCAphzjaMDEAuT3YEAJerGmhqTBtwNbTOYvvL1vrUkIe4BxrfXY7+/6BExkwuKzIbS
 p+2TLv/JDaTbhz/BcYnwF1PxNHCN79RWMsT5Pl75DBcBE1U1ZoJh+FGxxIe7ylNDifdC
 J4lvSCZosrSWiZHL1TwoDxXtf0wzVQvf70MDNXkDJKWOw3+S4cnDFyjPi5mkhavZaYVm
 bruQ==
X-Gm-Message-State: AOAM531H7TSGzadjenm41P7s8ba8w6n50c2m3cWsiybP2QubxAXhDk7D
 3Bx5QsGC7HHWTmne9ST/GO+iySUSRtT7tF1cgkWR/Ka+vQt0zf8sr177IdKUZtjGC0Ui6hSvov7
 sPYjDgOCrmH9xRL/V3iM9ORaPFVe0jJXvTYAZzG5LcA==
X-Received: by 2002:a05:620a:424e:b0:67d:3607:6b50 with SMTP id
 w14-20020a05620a424e00b0067d36076b50mr17091973qko.194.1647332127179; 
 Tue, 15 Mar 2022 01:15:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjgYb2HPocNtGnS6faY8OIC23ZTZlsPZ5W/DCuKMZo/aQnXkwFKl2eu1filb04x820ASXlIQ==
X-Received: by 2002:a05:620a:424e:b0:67d:3607:6b50 with SMTP id
 w14-20020a05620a424e00b0067d36076b50mr17091955qko.194.1647332126634; 
 Tue, 15 Mar 2022 01:15:26 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 b126-20020a376784000000b0067d21404704sm8982966qkc.131.2022.03.15.01.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 01:15:26 -0700 (PDT)
Date: Tue, 15 Mar 2022 09:15:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/3] af_vsock: SOCK_SEQPACKET receive timeout test
Message-ID: <20220315081517.m7rvlpintqipdu6i@sgarzare-redhat>
References: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
 <6981b132-4121-62d8-7172-dca28ad1e498@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <6981b132-4121-62d8-7172-dca28ad1e498@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Fri, Mar 11, 2022 at 10:55:42AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Test for receive timeout check: connection is established,
>receiver sets timeout, but sender does nothing. Receiver's
>'read()' call must return EAGAIN.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 49 ++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 2a3638c0a008..aa2de27d0f77 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -391,6 +391,50 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_seqpacket_timeout_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	struct timeval tv;
>+	char dummy;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tv.tv_sec = 1;
>+	tv.tv_usec = 0;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>+		perror("setsockopt 'SO_RCVTIMEO'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if ((read(fd, &dummy, sizeof(dummy)) != -1) ||
>+	    (errno != EAGAIN)) {
>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}

The patch LGTM, maybe the only thing I would add here is a check on the 
time spent in the read(), to see that it is approximately the timeout we 
have set.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
