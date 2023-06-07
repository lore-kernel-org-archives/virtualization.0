Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188EFC7EE25
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 20:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72082400E1;
	Wed,  7 Jun 2023 20:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72082400E1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxZJvWw2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxYNmKVeBWbM; Wed,  7 Jun 2023 20:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA60D40185;
	Wed,  7 Jun 2023 20:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA60D40185
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9934BC007A;
	Wed,  7 Jun 2023 20:15:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20EF5C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E92A2610EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E92A2610EA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxZJvWw2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pZhwJ-teBfQk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38BA260FB6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38BA260FB6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686168920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
 b=FxZJvWw26KAjaeYQcgBdHs+5SLJ/zoKI5emM38WbCDMp4Wm08pD0gcFq3HA29ANdLxfJZP
 y1+26YUmhOuiJIw5oXTkSmtGslkPuSUG6sP3hGw1OimWVoV8MKId2mfevKsU/Cp7dhhikr
 JGxzdWaVh8Jco1K+itj4pPn3Molk840=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-cAfstn_VPHqsv1RUWkPJAQ-1; Wed, 07 Jun 2023 16:15:18 -0400
X-MC-Unique: cAfstn_VPHqsv1RUWkPJAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f612a1b0fdso46576495e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 13:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686168917; x=1688760917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
 b=bs7acOHgbeFdXdGW0NbqygCb6OLOPv3ElOf6H5gK83kN04DOeBAZRMkMOmOqf+7Yo/
 t/RJYMqH39gljKWTv517ynaMZ/9rOf9sssNepxKOLcJWSaNOVnjITQMB7bZny5yqHa4R
 kcOI5rprPvZyfwIRruvTx2M6XOk3Na2VXq/0PW/2SJm180V413tnsGR94wd3lLWgXDuQ
 FvJA9N02X0ho+6Q1E6inzo//qeh4fiPJNnCDL/MHzL8TXWJE5L/wpm8w2kHjcHATvF/O
 +m86nRIJbfFL1KVxj3iF3xpcMSOlJoljciq6faJcbW1NI4fW82YvkejnWmlYcrDLfbVB
 0uIg==
X-Gm-Message-State: AC+VfDzL4XZdmpAFFsAZuAQlvEcqttIoOY06n6jS2uO5Kv2n1zIhH4TH
 CixCy9zUqxa5QWOf9PtxzmwVB4d1ebYe9seGu0dSQNNoYapKEMPk0KoKP/tb166fnKaEp/6xCMX
 FlCAIHYs94zjYqLtkLb5sZ18mluLmuNVvPP1yuRmrjw==
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id
 t23-20020a1c7717000000b003f7eadb941dmr7565502wmi.19.1686168917316; 
 Wed, 07 Jun 2023 13:15:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BuNZENhGXmy7RykVEep93dqwtBJaN8D86qVbIP42EfYDXBC7+P61b2CTrPMue3++mbYka1g==
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id
 t23-20020a1c7717000000b003f7eadb941dmr7565477wmi.19.1686168916980; 
 Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 s17-20020a7bc391000000b003f727764b10sm3110831wmj.4.2023.06.07.13.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:15:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
Message-ID: <20230607161440-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602232902.446e1d71@kernel.org>
 <1685930301.215976-1-xuanzhuo@linux.alibaba.com>
 <ZICOl1hfsx5DwKff@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZICOl1hfsx5DwKff@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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

On Wed, Jun 07, 2023 at 07:05:11AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 05, 2023 at 09:58:21AM +0800, Xuan Zhuo wrote:
> > On Fri, 2 Jun 2023 23:29:02 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri,  2 Jun 2023 17:21:56 +0800 Xuan Zhuo wrote:
> > > > Thanks for the help from Christoph.
> > >
> > > That said you haven't CCed him on the series, isn't the general rule to
> > > CC anyone who was involved in previous discussions?
> > 
> > 
> > Sorry, I forgot to add cc after git format-patch.
> 
> So I've been looking for this series elsewhere, but it seems to include
> neither lkml nor the iommu list, so I can't find it.  Can you please
> repost it?

I bounced to lkml now - does this help?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
