Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1508C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 12:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66CB24020C;
	Tue, 25 Apr 2023 12:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66CB24020C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CgCU3XBo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlQtz1jjETaU; Tue, 25 Apr 2023 12:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 63E06400FC;
	Tue, 25 Apr 2023 12:45:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63E06400FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38395C0036;
	Tue, 25 Apr 2023 12:45:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4506FC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C2EB405F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C2EB405F4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CgCU3XBo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Evc5RmKZ-sXv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:45:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22D4440529
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22D4440529
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682426732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krc+SiJhBUwO2ug/XwTx3KTJqkkR2CFS+eg5Dz5ylJc=;
 b=CgCU3XBoShcQmruR1d+CCdinhapd2mFzXbwbRt1A5MY8MPKF44WNeUxRfe8+bqHwoILl3t
 1bD1g21OURwsQHaq4J94ud9fYTXHijNlSga0ZBgPTdqjnFSDqmG6pzSOfnd0Gnc+vlSdFI
 3JGMO23C+ZQPMuw1lyyaNawXWuTVHMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-uo2_MMGLPnC03MLzAWGY3Q-1; Tue, 25 Apr 2023 08:45:30 -0400
X-MC-Unique: uo2_MMGLPnC03MLzAWGY3Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f1912ed0daso17396635e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 05:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682426728; x=1685018728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krc+SiJhBUwO2ug/XwTx3KTJqkkR2CFS+eg5Dz5ylJc=;
 b=PJlAu97QZXULw6OMQC2plBuK08Hex1wcAKQoo8FY/FZhYGB6gsNGz68KvVPEvArSe1
 y4iytbgXL2llJxg6Nblju7Esd4YlnOkwN16H8LQx3CRBSXxRiV5PG36JMtKLZCxO3wUL
 wD6bOGQxIXGziDqCMW6GqJIfsSBbG3dwLq2IbYy6DO7EHpK9aoESeo3ORanru/yEx9r+
 6MpKr2gqfwAUecCU+7iNP7Hp2Cvm8ZvfS4VUo7uA5gn23vx/0PYyPqiy7S2AZJcukhCo
 wrVYS/XXpWzTWsU083aVAdtdL+hPt3xlM+VoB+aiaQOiSg62APEh7kkUyny9VfFKxk2Q
 XWpw==
X-Gm-Message-State: AAQBX9eYtKDiGcwJ69OtXedDbA1sJ6R+Zc6LunwTIQcAm5DOXqND9uVZ
 j2YHzrfJMJSmMYaySXOojM5OmPIyDftXkrmgSUtylyC93rmClhpkDJk6dKYBBQNBvhOQO+prKR4
 UHFHEOjgTOvdmG4MxiZYhT9+pH0o5PwppmwbnpWU+OA==
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id
 z20-20020a05600c221400b003f1987b7a28mr7195378wml.29.1682426728235; 
 Tue, 25 Apr 2023 05:45:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIPgn166ZA/wJ8PFmg9nFmKKBjNCYwRGQ/sI+aE3t+loxoVTTzjiSf9BdLyfiT4aA9pr1zIA==
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id
 z20-20020a05600c221400b003f1987b7a28mr7195359wml.29.1682426727867; 
 Tue, 25 Apr 2023 05:45:27 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 o2-20020a05600c4fc200b003f1738e64c0sm18301465wmq.20.2023.04.25.05.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 05:45:27 -0700 (PDT)
Date: Tue, 25 Apr 2023 08:45:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: virtio-can: cleanups
Message-ID: <20230425084503-mutt-send-email-mst@kernel.org>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
 <20230424170901-mutt-send-email-mst@kernel.org>
 <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, Paolo Abeni <pabeni@redhat.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S . Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>
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

On Tue, Apr 25, 2023 at 11:17:20AM +0200, Marc Kleine-Budde wrote:
> On 24.04.2023 17:09:23, Michael S. Tsirkin wrote:
> > On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> > > Address the topics raised in
> > > 
> > > https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de
> > > 
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > given base patch is rfc this should be too?
> 
> This is an incremental patch that fixes the topics I raised in the
> review of "[RFC PATCH v2] can: virtio: Initial virtio CAN driver.", see
> linked discussion thread.
> 
> regards,
> Marc

and that's fine, just pls put RFC in the subject.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
