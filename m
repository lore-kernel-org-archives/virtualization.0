Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A58AFA3740
	for <virtualization@archiver.kernel.org>; Mon, 31 Oct 2022 08:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ACF540179;
	Mon, 31 Oct 2022 08:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ACF540179
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGI4VNil
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qR2A9BBcFJx; Mon, 31 Oct 2022 08:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 259A9400F2;
	Mon, 31 Oct 2022 08:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 259A9400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3E60C0033;
	Mon, 31 Oct 2022 08:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 012A5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D04D480DBF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:43:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D04D480DBF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGI4VNil
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMeGu9dZIcPB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 222E980DA8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 222E980DA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667205816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cVx55tetrN0slfUGsIN9YfNlhQLUs9MTDiVMp3ty/0=;
 b=SGI4VNil8RVAftZ+wgybY7Zdq4VvltZOXteAvdYXAsikaVVk/bollOMcbonjsEXJd9HgTq
 hb7cJ0q+HmiB2oghEsIU7+YkOTGeWDS/mEbzam1kIuJIQKLmK1TPjMuj+LghkQ8GkicN04
 ssbz35S2Q1nGWnQubDeVKIoLmpCqnwU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-UXXdg-6WMRu0wTBAHaT6HA-1; Mon, 31 Oct 2022 04:43:33 -0400
X-MC-Unique: UXXdg-6WMRu0wTBAHaT6HA-1
Received: by mail-ed1-f71.google.com with SMTP id
 s15-20020a056402520f00b0046321fff42dso2256300edd.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 01:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cVx55tetrN0slfUGsIN9YfNlhQLUs9MTDiVMp3ty/0=;
 b=Y4eqWcj8S2/g3KSvswsyT+onvD9z1UeZ5f0L4hcB/slu35hxtjnx4pKB222IpA2ukl
 pz3rqOwoamaEDEfqF2qmiCesbK1pEouvdsV3sXJtTi0DxunokY6oT6sdQrZM+C9uehqf
 ICbZHqf+Ab5r2oiNWjhpmDVPhkO1Lq2EtGCZ1QvucwHJ6x2M12ZiqjT8igngskrJ1EdH
 jLCSvf4z5yUMCcHHdXo04lpG474LVH/IZ81lDOKrUWW5Kc6fRaPcKoTx6dg9CPxHxDRS
 jXWngQlyjoIklCJ64Ccn6PkcC+GSKJqd4rSp9zTA3OV8Bu2Jx0KMALmKXpYegE2Yg5p3
 4sDQ==
X-Gm-Message-State: ACrzQf2VmWk4SPf9DBI3v9rJUa3zNtQWWrFAsLwVXNodZdJYXLsGJjKk
 nE5Mw5U/yaAMjWvzRdLlKb4NP6wI+wOY2aJiN0Q5k3L8g7NgLkbE7rd3XEBdxXsuXOV/ESCAcQO
 +Nbjs+kNVhdgqaiFte2funK1kuavFDm0gRRXUDiWIgg==
X-Received: by 2002:a17:907:9609:b0:7ad:d7de:6090 with SMTP id
 gb9-20020a170907960900b007add7de6090mr2357878ejc.705.1667205812195; 
 Mon, 31 Oct 2022 01:43:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78kesRA+qFkC4xT0N1dTMkPq+EZe+uIxAjrrmBRYnA8hqY50buMcYsM3zFLwBQ3G0S2t+fkg==
X-Received: by 2002:a17:907:9609:b0:7ad:d7de:6090 with SMTP id
 gb9-20020a170907960900b007add7de6090mr2357859ejc.705.1667205811954; 
 Mon, 31 Oct 2022 01:43:31 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m24-20020aa7c2d8000000b0044dbecdcd29sm2914807edp.12.2022.10.31.01.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 01:43:31 -0700 (PDT)
Date: Mon, 31 Oct 2022 09:43:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
MIME-Version: 1.0
In-Reply-To: <20221028205646.28084-3-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Fri, Oct 28, 2022 at 01:56:46PM -0700, Dexuan Cui wrote:
>Currently vsock_connectible_has_data() may miss a wakeup operation
>between vsock_connectible_has_data() == 0 and the prepare_to_wait().
>
>Fix the race by adding the process to the wait qeuue before checking

s/qeuue/queue

>vsock_connectible_has_data().
>
>Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/af_vsock.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d258fd43092e..03a6b5bc6ba7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1905,8 +1905,11 @@ static int vsock_connectible_wait_data(struct sock *sk,
> 	err = 0;
> 	transport = vsk->transport;
>
>-	while ((data = vsock_connectible_has_data(vsk)) == 0) {
>+	while (1) {
> 		prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
>+		data = vsock_connectible_has_data(vsk);
>+		if (data != 0)
>+			break;
>
> 		if (sk->sk_err != 0 ||
> 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>@@ -1937,6 +1940,8 @@ static int vsock_connectible_wait_data(struct sock *sk,
> 			err = -EAGAIN;
> 			break;
> 		}
>+
>+		finish_wait(sk_sleep(sk), wait);

Since we are going to call again prepare_to_wait() on top of the loop, 
is finish_wait() call here really needed?

What about following what we do in vsock_accept and vsock_connect?

     prepare_to_wait()

     while (condition) {
         ...
         prepare_to_wait();
     }

     finish_wait()

I find it a little more readable, but your solution is fine too.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
