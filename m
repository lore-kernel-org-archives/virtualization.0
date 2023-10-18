Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2B3CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 08:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DF89417E9;
	Wed, 18 Oct 2023 08:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DF89417E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Osg+yyzm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKjieotQr6wS; Wed, 18 Oct 2023 08:02:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B73E417FD;
	Wed, 18 Oct 2023 08:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B73E417FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0533C0071;
	Wed, 18 Oct 2023 08:02:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8679AC0071
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BDE61317
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42BDE61317
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Osg+yyzm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f1ZyL3ZlbTDP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:59:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A27A36144B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A27A36144B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697615952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/RuX7PEGAER5VWHTAgQGINHue7Pa6HBkkP2SfD/G/8=;
 b=Osg+yyzmBUa3I/gTiU+X703MH+bG84ZDlVRVD0Hn+DVfht12YeHJtje4uPlXoiMXt4bPws
 S6G7QqEhLOZQyC73gKKCCL7u47HNbVRCpRLEdnzeKk4/WWW2d3Lw4evNaDQMTID+UNsjG7
 wA0C6jNHOeXgSzYHdcoZvM+KQbMtWgk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-QhWLdGLqPkOvbsImBPcKMQ-1; Wed, 18 Oct 2023 03:59:11 -0400
X-MC-Unique: QhWLdGLqPkOvbsImBPcKMQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-521da4c99d4so4995828a12.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 00:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697615950; x=1698220750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/RuX7PEGAER5VWHTAgQGINHue7Pa6HBkkP2SfD/G/8=;
 b=uotCiSEQI76pdB/b71I5x1gG4dSpzM1qpOP45zLEWW7KIAGbzjR3cu7Nc0/TlRRJcl
 X8qX0DA1gnDkfiryFpiBIm8W+teLk0qlbZeIzQta73etHBZfv88uQjRolE/eje680m9u
 m/W5szViLIA8UjKYKwxFeZKcQoaMgOACDkskD2J592UO31qUe3koRh6CRWrZdpR02gV/
 AbuJsSjpAQ0UzpUChuy7hAV9KsLmToY3oszckiz4fqJZXhdRZYnz5AHNQh2HXns0TdC/
 St23I8r6FsRO/hJKPcAHnk1CR7tvomDr1du5N/KuITqoII3nWVb+8Pgq0nJZIZxHepW4
 0L9g==
X-Gm-Message-State: AOJu0YyuVQ4hG1bLKHORRz6fuFiKs86f0Acm6pggRlkYf/D1Njd8TtK3
 QmFV8UWYCJ2M4zotH53FtuHDFtM6MfQKEZhV7QygYMi7u6OsUBfIMpFXt+hBBVdcDHapPZXiXIu
 tlhnABGUl491Df5CZ3G0hV11k5aqoJxrQqb8h7+zs4w==
X-Received: by 2002:a05:6402:518d:b0:52d:212d:78ee with SMTP id
 q13-20020a056402518d00b0052d212d78eemr3681712edd.25.1697615949943; 
 Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWa90MygBLIZW4CwgrTQDTiga7S0LJQ7NKa0AEFJwcbizxjymr8txFWZM0Exp5aJmHG3yWYA==
X-Received: by 2002:a05:6402:518d:b0:52d:212d:78ee with SMTP id
 q13-20020a056402518d00b0052d212d78eemr3681693edd.25.1697615949647; 
 Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
Received: from redhat.com ([193.142.201.34]) by smtp.gmail.com with ESMTPSA id
 j30-20020a508a9e000000b0053f11e3c019sm2389384edj.90.2023.10.18.00.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
Date: Wed, 18 Oct 2023 03:59:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018035751-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> Hi Michael,
> 
> Do you think it's appropriate to push the first two patches of this patch set to
> linux 6.6?
> 
> Thanks.

I generally treat patchsets as a whole unless someone asks me to do
otherwise. Why do you want this?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
