Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75F28981F
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623356; cv=none; b=sKUQ80BVTAYQxWwd7z0eOnWIM6TD9itkC1Pd2Zl18XXZUnPmlSw1iB8sW7/6T7iOCMmqSmd88BOPL6jquH95xNFZ5KGHQnVuZ5W5p4wfc9W86xxUjHIfy6R6iFYsR+NygmE+AaZ01QOE50sTuKWXiLiawrxzMfbuXDZ6BDEf6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623356; c=relaxed/simple;
	bh=PCMX2Cr+uQWKx3vKDgl51jkFcRXqKV/9DGQU2RgRS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uz/yecZ2yDKXsvr5e/FMyTWkStEUG+gmvI2iwcfgfA+UaP1W8hUgVN86SlGeB6/ILNg/jKof/Gw7Vv8UOBNg3X0hShYYVq27L6VqAaNFkrK/PNbUWE5DhLYKtjkQfOWEve0zkN0KrQNP67l7pvdhmHjOL/yYYLV5CIKPa9UCRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1o3vvCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1o3vvCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746623353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAtnwiXcU1op8DM9QOzo0SnMVizQr1PVYLn+9+GejxY=;
	b=M1o3vvCno5QdcRM5uhRCZd8spQNizlH3oCfLFbsn5ng+lNzupVkRLMNGmQEnCbc5uRRt6e
	E12LbNKHpNfe9k+BKSEDYx4mdHIuwIjo+Dm2B4pFVKVDyKS2Ju4biVTVKGsISnFUjspwB8
	kfasLJty4WvlVU6i8jvwG+niI7lRxVw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-KrFaLs0KNwqWxh0VzsyYSQ-1; Wed, 07 May 2025 09:09:12 -0400
X-MC-Unique: KrFaLs0KNwqWxh0VzsyYSQ-1
X-Mimecast-MFC-AGG-ID: KrFaLs0KNwqWxh0VzsyYSQ_1746623351
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5fbf5fce18dso608590a12.0
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 06:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623350; x=1747228150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAtnwiXcU1op8DM9QOzo0SnMVizQr1PVYLn+9+GejxY=;
        b=NYt1wn/mzmeKNQpUwzW3l3Zg6NvDLc2WHlT9ZHH/bLTJRdEtgPiPI1AO/nT6zLP1nh
         YMUZa70XU+J25Zl7B7MYX2mosCtOKMZLjVduRbQHoHDOt1aJ9PS3muJuOQyxLSvJ0N9n
         yP0XC7SlMg5zNsq/SBObc8ymj1rNl6iuEZHKUgjCsmIvug5lYAVCdyHr1tzIhWmmLLJF
         yEibKCn28yOhJfp1JgfVt4Ub5VivOPCgdQWGVrtpBEKX5U11OMOx8X102r952D/d83Cs
         /1/BeT9jRhE603MUtFOehfakC5ORqVwswzWPnyF7NNJ+47koRTbYI8TFo0CjgMW+ZNPa
         sQTA==
X-Gm-Message-State: AOJu0Yxr9L/sR+Jefipf0k7KDgwvOQ7RoYZ/MJrK+/73rWVRm1ladMNt
	G0kFD+nb6CRpmVo9x+oKd6faxjKZgDxln569vvtvUyBzSbMobSf+rxw3WQZ7kGuj1k9hHrPHae+
	NpPJvom1sgD26WGD45qZNNilD6AkwC4of2Lrs2ygFJZVrxsWgtRVbIS3ShMdEDM+Y7WAHNdZ+
X-Gm-Gg: ASbGnctuNjvHo5d0Nr1rTdaMXZwZFaSbNu7CXUkxeNNQDZzCthjDlOb99oRxNkxzyoR
	fV3Ivg5NC28fW9STuLqeA0unAGM/v2cjrz7gTEE+GAYe4/1ciqpKEwstc1V0Smew9+T3UMZTnE8
	IHr13WS44hX770tkSGNOkSduxrICG3Hc7wwmCAv6VBOBY3/CBUUJMStfuWTNJI+9atpvkDo7CMq
	JJp7PtikbBvBfNM4ZY80C4/OewNX8allkJPk0kAufzSWkGwl88CrOjnsTllXaD+ov7y3JedXa2l
	doxk3uJCi5n0nzm3
X-Received: by 2002:a05:6402:524b:b0:5f6:59e5:5c6e with SMTP id 4fb4d7f45d1cf-5fbe9f42f24mr2380769a12.26.1746623339688;
        Wed, 07 May 2025 06:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwA872SvBWeTpMMj+/e7mYjU25+jDDfjv4mDrfoJ39gjkjiqHaiiL4tGqlCQGwX9860akxCA==
X-Received: by 2002:a05:6402:35c4:b0:5f4:9017:c6a1 with SMTP id 4fb4d7f45d1cf-5fbe9f46c84mr3009014a12.25.1746623324960;
        Wed, 07 May 2025 06:08:44 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.183.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm9371316a12.51.2025.05.07.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:08:43 -0700 (PDT)
Date: Wed, 7 May 2025 15:08:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net] vsock/test: Fix occasional failure in SIOCOUTQ tests
Message-ID: <sqee4iqviojcht4s42dke3mnsq4f4si6oislu77bm3nqwlowim@oz6voimaqw4m>
References: <20250507114833.2503676-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250507114833.2503676-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kkRzNxhv26hz-LSkT9VG6Dh7-Ltj43KmvhNSHUaatkc_1746623351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 07, 2025 at 06:48:33AM -0500, Konstantin Shkolnyy wrote:
>These tests:
>    "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>    "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
>output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>
>They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
>have been received by the other side. However, sometimes there is a delay
>in updating this "unsent bytes" counter, and the test fails even though
>the counter properly goes to 0 several milliseconds later.
>
>The delay occurs in the kernel because the used buffer notification
>callback virtio_vsock_tx_done(), called upon receipt of the data by the
>other side, doesn't update the counter itself. It delegates that to
>a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
>more than the test expects.
>
>Change the test to try SIOCOUTQ several times with small delays in between.
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++----------
> 1 file changed, 16 insertions(+), 10 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72..143f1cba2d18 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1264,21 +1264,27 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> 	control_expectln("RECEIVED");
>
>-	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>-	if (ret < 0) {
>-		if (errno == EOPNOTSUPP) {
>-			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>-		} else {
>+	/* SIOCOUTQ isn't guaranteed to instantly track sent data */
>+	for (int i = 0; i < 10; i++) {
>+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		if (ret == 0 && sock_bytes_unsent == 0)
>+			goto success;
>+
>+		if (ret < 0) {
>+			if (errno == EOPNOTSUPP) {
>+				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+				goto success;
>+			}
> 			perror("ioctl");
> 			exit(EXIT_FAILURE);
> 		}
>-	} else if (ret == 0 && sock_bytes_unsent != 0) {
>-		fprintf(stderr,
>-			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>-			sock_bytes_unsent);
>-		exit(EXIT_FAILURE);
>+		usleep(10 * 1000);
> 	}
>
>+	fprintf(stderr, "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+		sock_bytes_unsent);
>+	exit(EXIT_FAILURE);
>+success:
> 	close(fd);

I worked on something similar but I didn't yet send it.

I like the delay you put, but I prefer to use the timeout stuff we have
to retry, like I did here:

@@ -1264,20 +1270,25 @@ static void test_unsent_bytes_client(const struct test_opts *op
ts, int type)
         send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
         control_expectln("RECEIVED");

-       ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
-       if (ret < 0) {
-               if (errno == EOPNOTSUPP) {
-                       fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-               } else {
-                       perror("ioctl");
-                       exit(EXIT_FAILURE);
+       /* Although we have a control message, we are not sure that the vsock
+        * transport has sent us notification that the buffer has been copied
+        * and cleared, so in some cases we may still see unsent bytes.
+        * Better to do a few iterations to be sure.
+        */
+       timeout_begin(TIMEOUT);
+       do {
+               ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+               if (ret < 0) {
+                       if (errno == EOPNOTSUPP) {
+                               fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+                               break;
+                       } else {
+                               perror("ioctl");
+                               exit(EXIT_FAILURE);
+                       }
                 }
-       } else if (ret == 0 && sock_bytes_unsent != 0) {
-               fprintf(stderr,
-                       "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
-                       sock_bytes_unsent);
-               exit(EXIT_FAILURE);
-       }
+       } while (sock_bytes_unsent != 0);
+       timeout_end();


What about combining the two?

Thanks,
Stefano

