Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE71AC64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 20:29:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C49206ED
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUCbwcOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C49206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6EB1F236B5;
	Mon, 30 Nov 2020 20:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPUfMI8H-28Y; Mon, 30 Nov 2020 20:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0366523492;
	Mon, 30 Nov 2020 20:29:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC36BC163C;
	Mon, 30 Nov 2020 20:29:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ACFCC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 20:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3D21A234BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 20:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5GjRRjfU0v+C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 20:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B859272E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606768147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEMeF3AMNMcYI65aSQplkoFbo+sAWz3Tjmr7jvdlwP0=;
 b=QUCbwcOhQXqqFINSTELUhxXduDK9UrBhN6UxFJByEmQgIJwGxDKhvMadorz1AT1edjQhnH
 FSqP/dHfeySKzb2lEIc3KBF1tkbtknwou7xrDN/0QaU2iUVd0m0YQhige7RwB8lwJR+sdH
 3zBGUGbXKT849AFEJQWukZvJVNCqKxc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-B4BrVkjEOGmKBzowHkWIJA-1; Mon, 30 Nov 2020 15:29:05 -0500
X-MC-Unique: B4BrVkjEOGmKBzowHkWIJA-1
Received: by mail-ed1-f69.google.com with SMTP id x71so4132443ede.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 12:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dEMeF3AMNMcYI65aSQplkoFbo+sAWz3Tjmr7jvdlwP0=;
 b=kN7v2wgXNAXfi5ngFmjn7QW2i3Adz4yWMykiFS8WgLRDR9RTj3v+97XhQKdbr2fPLb
 okPD5t6fdbUThnTqgGWO20t3zk1RvQ7oRVqD4HDgTHLluLOtviZjNwWeIEvs5cUYs6dh
 efjcOwvK7aX+7iHdhvzmzHX67q8RDoYWFrF83iWCoWaPa5/wadF6KcPweStEfZ6Lr9Yo
 V7PXyll9gfqa4FLGeEm3t6P+OJPv9cb94mppBbMi0YKNEDlowhu97h9CyyQ+hWIwzycv
 oYZG7I7r3Nm2eWjzOtKlFlF7DupqkQ0TFLZD35KMwP/nNqrH09Dzom7UUc+su1OkZt9K
 qL2Q==
X-Gm-Message-State: AOAM530MC5gAPeQD2eYkmTVuJfqy8NJbR+rRGBmNspAJ+RwKPq+LkkO6
 oTl4QHQDEOuYhgyRuWM2m7ElE60nAAOgj/I53TZIfVUqyIluFA9/Z2yCuP+piRxu24DnaT67Jjo
 /s3MQWdbn9Fvf2pEMQWJVcHGcKyDbva9zf8TCmuVjtw==
X-Received: by 2002:a05:6402:2070:: with SMTP id
 bd16mr11170007edb.107.1606768144693; 
 Mon, 30 Nov 2020 12:29:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg9IglFIMQ0ZSm6k1KLj+p3mu5WZxF5QG0J+89nlaTxpR4umWpnoGsGHhv67ElcSjdL8GU8g==
X-Received: by 2002:a05:6402:2070:: with SMTP id
 bd16mr11169987edb.107.1606768144486; 
 Mon, 30 Nov 2020 12:29:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id a13sm2400959edb.76.2020.11.30.12.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 12:29:03 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Mike Christie <michael.christie@oracle.com>,
 Sasha Levin <sashal@kernel.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
 <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
 <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c1b2bc7-cf50-4dcd-bfd4-be07e515de2a@redhat.com>
Date: Mon, 30 Nov 2020 21:29:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On 30/11/20 20:44, Mike Christie wrote:
> I have never seen a public/open-source vhost-scsi testsuite.
> 
> For patch 23 (the one that adds the lun reset support which is built on
> patch 22), we can't add it to stable right now if you wanted to, because
> it has a bug in it. Michael T, sent the fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=b4fffc177fad3c99ee049611a508ca9561bb6871
> 
> to Linus today.

Ok, so at least it was only a close call and anyway not for something 
that most people would be running on their machines.  But it still seems 
to me that the state of CI in Linux is abysmal compared to what is 
needed to arbitrarily(*) pick up patches and commit them to "stable" trees.

Paolo

(*) A ML bot is an arbitrary choice as far as we are concerned since we 
cannot know how it makes a decision.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
