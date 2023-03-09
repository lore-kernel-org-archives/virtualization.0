Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121C3C64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 08:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F12D82042;
	Thu,  9 Mar 2023 08:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F12D82042
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R0JJHIO+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkTl2b-NEynu; Thu,  9 Mar 2023 08:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFF8681EFD;
	Thu,  9 Mar 2023 08:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFF8681EFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C392C0035;
	Thu,  9 Mar 2023 08:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE089C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8D0F416D0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8D0F416D0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R0JJHIO+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7BntHv6v5uQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C49F4087E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C49F4087E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678351772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XxVpP4I6etF/R+Wh1vjQAaCt3ds5sZTWni+6rnd9Rk=;
 b=R0JJHIO+2ns2sJoI7sU9KK/jgwKPaoZXccgwKJ6+FG+Vw6He/IAsU75Y+hcjCnOJPy8Psa
 2pqUkED2UbH1z4secxJ+ikZvfDNSGgMEMLhFKDM5J3RVuSFfWN+dGIYUp+ucT30yWmzxCW
 lUw1RtPYo91+/gX+uCDoIHGrWhlwRd8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316--yDMYvtIOWyBEXt3RzzXkg-1; Thu, 09 Mar 2023 03:49:29 -0500
X-MC-Unique: -yDMYvtIOWyBEXt3RzzXkg-1
Received: by mail-qt1-f198.google.com with SMTP id
 i24-20020ac84f58000000b003bfe3358691so706371qtw.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 00:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678351768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XxVpP4I6etF/R+Wh1vjQAaCt3ds5sZTWni+6rnd9Rk=;
 b=MbTNxdb8RMR//yHZxGNfrL2ZVHz8CEkZVU+iXjCYay/sD13NF5Ug34jVkSGrVJTYQV
 5iBrOWcUG3Tw7j/DEgluOWWDtpzP0nfaSj2VAm8IAYfLQd2DA5NTu2IO0wlZyoifgmWO
 iHEzhArDVaweSiw/2seBy+OwUtojUEsntq3XXdmKbe41WxAhtjepBQWq0AbGlE1pr8ui
 GObdNWF8H4bR24hnfnkfa3Jce4FbymZvbkLnccw0akZBLFqpOIZ5oR2ah9qGlZA65Cm6
 ev2SMBmuMgqnz7J9XEtV3nFXYnbfhy5Xkg4EfuyBnYZKyaij+qQ2pjZrxxxe2LLtBdOw
 /FUA==
X-Gm-Message-State: AO0yUKX6UjTt2RFDUwrSnMP8Cxd146W1Pq/GEGZmrWBrJ4pj5aX1vYM1
 krSbbutGnUwhwzdHkznkBK145ZBfI196ATMtwZTFHv04YomnKauaChFfaTWvu+sf1NsuXG7M1UP
 YhT78l/gGZOPLRGGL7SnIqQz3VCK5iO/GcgWWKPz0eA==
X-Received: by 2002:a05:6214:2681:b0:56e:a9c6:d2c6 with SMTP id
 gm1-20020a056214268100b0056ea9c6d2c6mr36835530qvb.6.1678351768658; 
 Thu, 09 Mar 2023 00:49:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/thTK4EUAQWBzgsfLcQMoo2cMp3slVR0A8J9Dzj1kqFjwA7/OGlmJSuV6MuuTmFXXxDQbdYw==
X-Received: by 2002:a05:6214:2681:b0:56e:a9c6:d2c6 with SMTP id
 gm1-20020a056214268100b0056ea9c6d2c6mr36835518qvb.6.1678351768410; 
 Thu, 09 Mar 2023 00:49:28 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 29-20020a05620a041d00b0073b8745fd39sm4523932qkp.110.2023.03.09.00.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 00:49:27 -0800 (PST)
Date: Thu, 9 Mar 2023 09:49:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH v2] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
References: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Mar 09, 2023 at 04:42:50PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
>v2: help(): exit with a value different from 0 (e.g. 2).
>v1: https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
>---
> tools/virtio/virtio_test.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..33e17307441f 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -327,7 +327,7 @@ const struct option longopts[] = {
> 	}
> };
>
>-static void help(void)
>+static void help(int status)
> {
> 	fprintf(stderr, "Usage: virtio_test [--help]"
> 		" [--no-indirect]"
>@@ -337,6 +337,8 @@ static void help(void)
> 		" [--batch=random/N]"
> 		" [--reset=N]"
> 		"\n");
>+
>+	exit(status);

Sorry, I meant you can put exit(2) here, and remove the `int status` 
parameter of help().

> }
>
> int main(int argc, char **argv)
>@@ -354,14 +356,12 @@ int main(int argc, char **argv)
> 		case -1:
> 			goto done;
> 		case '?':
>-			help();
>-			exit(2);
>+			help(2);

Here you can use help()

> 		case 'e':
> 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> 			break;
> 		case 'h':
>-			help();
>-			goto done;
>+			help(0);

And also here you can use help()

I'm sure you're learning the process, so as a suggestion for the future,
if some thing is not clear, better to ask before sending another
version.

Thanks,
Stefano

> 		case 'i':
> 			features &= ~(1ULL << 
> 			VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
