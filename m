Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE121C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 15:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00A3460FB2;
	Mon, 15 Aug 2022 15:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00A3460FB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XwMR1tjC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZl9vkRrjmZ8; Mon, 15 Aug 2022 15:41:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 78BCC60F9E;
	Mon, 15 Aug 2022 15:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78BCC60F9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32878C0033;
	Mon, 15 Aug 2022 15:41:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39C37C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E71C982443
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E71C982443
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XwMR1tjC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OEPAvTrHcW3J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:41:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7ED7782433
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7ED7782433
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660578069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UpOQ0S8xTyMJHmMY1t7J4us9+LjsWwhrGGsgao9tXgo=;
 b=XwMR1tjCvSmoYnMyY+3UU0W0rJ6pdf6orN/rI5foHs/pnmsxbL0ZPquVpdZBLNYtQVQvwE
 S12bN3ahpNZfB5QRbtgTgkcec/gYy1MuNIOgsfQqjW5rqyPdB5R27amRqM+cmZ4Wa+IEFd
 tUa7TyNT5Tzx95RtKhTvTOPf8OKr2R0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-xuq7OX4WN5axl_0PaGTJWQ-1; Mon, 15 Aug 2022 11:41:07 -0400
X-MC-Unique: xuq7OX4WN5axl_0PaGTJWQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 g8-20020a056402424800b0043e81c582a4so4969701edb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 08:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc;
 bh=UpOQ0S8xTyMJHmMY1t7J4us9+LjsWwhrGGsgao9tXgo=;
 b=8RMpb/LCONIMDLVSJMdIlydNdM1m3sTf8BFK8go23VclvDIyPvV4i4uMNXwtv147KY
 V3H9T8lKmNC6lVUuUKVq2CPntWlU3p5g3hcj/lNTOCdNwMQGZ1AQUlDhDkFPRAN5fcN8
 /00X3l/kTabnY+AlVvhjbMF3XkI2DLe4MTDk5Ut72zmAj+UajJYj9clLRs6eha/PsDg+
 PX11PRQvWDxb/U4TlM1avYDIn3JzZOpKkHwxcH8emwElkwBRwhw3ytmG1X/d/dNP9cxZ
 oTYzyjyL6OyFtjL7btbPomsi3JvMJHheYom0wdgZQRIceydQbmOxJZMlxxsmM+xyqQn1
 NFcA==
X-Gm-Message-State: ACgBeo1PNuA26ktjMLa3lEB9t0TkfBEvF4XrueINzIaEurWs+GBHCnMA
 goIIP79faWLxphytVVhXU2oelpXrrxiiemza3bGMSCE6i7W81P67pUMUL3bERvbx6jfkEuW9o55
 vmeairoMSS7l/uYViEOiIko4q6Fn5Yaebw1F1OKzdHQ==
X-Received: by 2002:a05:6402:254b:b0:43e:7c6a:f431 with SMTP id
 l11-20020a056402254b00b0043e7c6af431mr15419050edb.305.1660578066091; 
 Mon, 15 Aug 2022 08:41:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4PVgA9J2ZpHf31hYsuilIOkpf6wHT/MluCqOW9wn/BsA1BgRyyci7rxYWXC1uVkVknxAuBDQ==
X-Received: by 2002:a05:6402:254b:b0:43e:7c6a:f431 with SMTP id
 l11-20020a056402254b00b0043e7c6af431mr15419032edb.305.1660578065916; 
 Mon, 15 Aug 2022 08:41:05 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 kd1-20020a17090798c100b007262a1c8d20sm4248334ejc.19.2022.08.15.08.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 08:41:05 -0700 (PDT)
Date: Mon, 15 Aug 2022 11:40:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
 Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, c@redhat.com
Subject: Re: upstream kernel crashes
Message-ID: <20220815113729-mutt-send-email-mst@kernel.org>
References: <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
MIME-Version: 1.0
In-Reply-To: <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 15, 2022 at 01:34:41AM -0700, Andres Freund wrote:
> Hi, 
> 
> On August 15, 2022 1:28:29 AM PDT, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Mon, Aug 15, 2022 at 01:15:27AM -0700, Andres Freund wrote:
> >> Hi,
> >> 
> >> On 2022-08-15 03:51:34 -0400, Michael S. Tsirkin wrote:
> >> > It is possible that GCP gets confused if ring size is smaller than the
> >> > device maximum simply because no one did it in the past.
> >> > 
> >> > So I pushed just the revert of 762faee5a267 to the test branch.
> >> > Could you give it a spin?
> >> 
> >> Seems to fix the issue, at least to the extent I can determine at 1am... :)
> >> 
> >> Greetings,
> >> 
> >> Andres Freund
> >
> >So you tested this:
> >
> >commit 13df5a7eaeb22561d39354b576bc98a7e2c389f9 (HEAD, kernel.org/test)
> >Author: Michael S. Tsirkin <mst@redhat.com>
> >Date:   Mon Aug 15 03:44:38 2022 -0400
> >
> >    Revert "virtio_net: set the default max ring size by find_vqs()"
> >    
> >    This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> >    
> >    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >and it fixes both issues right? No crashes no networking issue?
> 
> Correct. I only did limited testing, but it's survived far longer / more reboots than anything since the commit.
> 
> Andres
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.


OK so this gives us a quick revert as a solution for now.
Next, I would appreciate it if you just try this simple hack.
If it crashes we either have a long standing problem in virtio
code or more likely a gcp bug where it can't handle smaller
rings than what device requestes.
Thanks!

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f7965c5dd36b..bdd5f481570b 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -314,6 +314,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!size || size > num)
 		size = num;
 
+	if (size > 1024)
+		size = 1024;
+
 	if (size & (size - 1)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", size);
 		return ERR_PTR(-EINVAL);


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
