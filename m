Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC60C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 04:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCF2481268;
	Mon, 28 Nov 2022 04:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCF2481268
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AeNsj1pK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WGa8i-EG6nK; Mon, 28 Nov 2022 04:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5598180E36;
	Mon, 28 Nov 2022 04:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5598180E36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23774C0032;
	Mon, 28 Nov 2022 04:13:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A25C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EF5F81025
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:13:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EF5F81025
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52-IOlzDg22Y
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:13:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 389EE80E36
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 389EE80E36
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:13:45 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id v1so14805405wrt.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 20:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8biN610IG6cF6/xqgfdvBvEZJr3V5lZ2u/iXOKMw25c=;
 b=AeNsj1pKPeyg+SIWcMQHhoM7PKtpOOXUa96TqSseSpngwrapTAoI9AXE2sl0ZVS9KX
 Q4FGkmNiPGcJr2K1wujtY2fUpGZv9LaoNgLf82WJEq0yf0wJK9fvfWficshG0H7SMP0N
 4CFleZlpLnlbdf5y1qUG4wxp9IMamIdyytYZxA8ExoSLJxvi7RoT5SDvBSarapYlX7nJ
 6Gu1PQLYRsuagB7wI88QEi1cTqrhl9lJnJVG+br8OcktvvY5AcivvwVzChd9uLbXZiOH
 3oiMX4RAkWh0Sa0ATRvVVENmkJv3Kv+zdij5owWKmxxIdkxw2PcBFbqPtvSMxyjcLI/e
 an5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8biN610IG6cF6/xqgfdvBvEZJr3V5lZ2u/iXOKMw25c=;
 b=CiXoo6VA/HjlaycIlu/l332F/A4GiYGiZQ4y+mCAdSlbQEQjh24LJgtPdA3mF4PicY
 uKKdOU5dmCqVb1mhk6T2FoJ3kJCtySZHbUA+byYBKnAe3/p/MiWJXwSQpCqWnH+Q9ME2
 kUcRRrZL6LJHAxARlFJBpqEOCN/reHzxQLTADlBiVOSXzhqvwqMNqvm8xmIKN68q0ruw
 St7CcXDKgM7zp+DDeT13XU5LDn4kuRNFPRdErQbAAUgUa+HbOpyJJd5BOE0IftVOpNEZ
 egzG4pOmKzuQd/y7GWMpKeGVIsHNG3pVJkwz1BdjSD1N9gYFsUV+WlxtXgjgss6TYNt+
 SKKg==
X-Gm-Message-State: ANoB5pkxaHfD9oEhhGuBvgkO4emseR6holbKAMfuM4lGDQQjU8TgkZz5
 GuJw2Vso9X+Yz5kkZ/ED5AU=
X-Google-Smtp-Source: AA0mqf6afd5S1XwVgpfCa/MZ2Ep0V6C9/AcwP41bJVg6WfRl46ndbc0RXBKKXsMofcHeHt9kYPgn4w==
X-Received: by 2002:adf:fb0e:0:b0:241:87cb:6e0c with SMTP id
 c14-20020adffb0e000000b0024187cb6e0cmr19497534wrr.166.1669608824229; 
 Sun, 27 Nov 2022 20:13:44 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 j2-20020a5d6e42000000b0024194bba380sm9495337wrz.22.2022.11.27.20.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Nov 2022 20:13:43 -0800 (PST)
Date: Mon, 28 Nov 2022 07:13:40 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <Y4Q1dOgAY3fWuZBn@kadam>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
 <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
 <20221127113416-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221127113416-mutt-send-email-mst@kernel.org>
Cc: Guanjun <guanjun@linux.alibaba.com>, harshit.m.mogalapalli@gmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

Btw, after you add the check to vduse_validate_config() you can test
that it silences the Smatch warning by doing:

kchecker --info drivers/vdpa/vdpa_user/vduse_dev.c | tee out
~/smatch/smatch_data/db/reload_partial.sh out
kchecker drivers/vdpa/vdpa_user/vduse_dev.c

You might need to do a second --info and reload for the changes to
propagate.

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
