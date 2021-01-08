Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B00C433DB
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 10:34:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEBF23770
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 10:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEBF23770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A38387327;
	Fri,  8 Jan 2021 10:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAajOGyitj04; Fri,  8 Jan 2021 10:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E9DEE87103;
	Fri,  8 Jan 2021 10:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D946EC0891;
	Fri,  8 Jan 2021 10:34:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED28FC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C8DB287510
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1wt4Ll-UwKc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:34:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE25387506
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610102044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9jaCobpp/gjZ1BrAW63KVqKbg+WZam2J/wlrqVXlE/U=;
 b=ghcrC3UCWwDg8xTsnlYcASBkPKYaACDGXX89cgFbJP4cuVgKnByX6Oz5xpuFhRJbrhDBh8
 hq5zl3Tm5uFQ457VmrS4ahTZsUOE8juq0wo0OIAQ3Y+J3bn0KNAcJpus9Ebt2R9zunMg3P
 CTGG9h8IZM6roCBVBcEVCt+yfeKTXd4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gFqEU6_tO8iFbJdOwkjG_A-1; Fri, 08 Jan 2021 05:34:00 -0500
X-MC-Unique: gFqEU6_tO8iFbJdOwkjG_A-1
Received: by mail-wr1-f72.google.com with SMTP id u3so3916344wri.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Jan 2021 02:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9jaCobpp/gjZ1BrAW63KVqKbg+WZam2J/wlrqVXlE/U=;
 b=jezkBKQ2IxHfqZE+3Pnvr8O5/pMO/7IROy1bLmoxesFtow5InNkn3V5Z+19FIgSRmd
 7jsv9NMTyxsAvz/R1u72FVXGb4CZC1bbVM0y/MFRNKHImoG6kgT6nOU4kYTF8TLUP0g7
 hDR+w/gctW595Z0+AqMmn6cccfe7GwTNsHwTjflX5AS4lkMoWCUtE+6Va4htnkVGmDFw
 CgQEwM1Cg5TA/rgBsGW/YISWXcdhIjTLVlxBYMTkENuyhnlD3ONkJPk8zPJ+qyxke+Cz
 CaroCJi8zSpGKw/vrBB0wxWcmC7MUgMN4rTsnNnvK8eDbX5NSlOtlxRomL0Eb9VCIXip
 sbyg==
X-Gm-Message-State: AOAM531F/DOrjBdVWrae8+GZtwN9Wu7Gd9/zr8PbbfmQpxzkCtfIq9nS
 s7vC9DdzgPAdn6uO5AkqKMwVdWPvok1Arif820PZJqSRDEUQJ6vuQSEN1xDTkysAutZzGFUBN0t
 0+m2w2RG/lchg0yxv6iCTVjSJtcv9UGUOpxp+Vf6+fg==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr2905568wru.219.1610102039579; 
 Fri, 08 Jan 2021 02:33:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/cYGRiEYoK1vucKO1euIdsck18nMG94piouLVJf/5RHsxZEuyqqUoFQjJC0gMXLBgDrQOUQ==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr2905551wru.219.1610102039359; 
 Fri, 08 Jan 2021 02:33:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s25sm13327280wrs.49.2021.01.08.02.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 02:33:58 -0800 (PST)
Date: Fri, 8 Jan 2021 11:33:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH 0/5] virtio/vsock: introduce SOCK_SEQPACKET support.
Message-ID: <20210108103335.iabhzk4r6fpsiopt@steredhat>
References: <20210103195454.1954169-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210103195454.1954169-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Andra Paraschiv <andraprs@amazon.com>
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

Hi Arseny,

On Sun, Jan 03, 2021 at 10:54:52PM +0300, Arseny Krasnov wrote:
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, new packet operation was added: it marks start of record (with
>record length in header). To send record, packet with start marker is
>sent first, then all data is transmitted as 'RW' packets. On receiver's
>side, length of record is known from packet with start record marker.
>Now as  packets of one socket are not reordered neither on vsock nor on
>vhost transport layers, these marker allows to restore original record
>on receiver's side. When each 'RW' packet is inserted to rx queue of
>receiver, user is woken up, data is copied to user's buffer and credit
>update message is sent. If there is no user waiting for data, credit
>won't be updated and sender will wait. Also,  if user's buffer is full,
>and record is bigger, all unneeded data will be dropped (with sending of
>credit update message).
>	'MSG_EOR' flag is implemented with special value of 'flags' field
>in packet header. When record is received with such flags, 'MSG_EOR' is
>set in 'recvmsg()' flags. 'MSG_TRUNC' flag is also supported.
>	In this implementation maximum length of datagram is not limited
>as in stream socket.

I did a a quick review. I like the idea of adding SOCK_SEQPACKET, but 
the series needs more work.
Some patches miss the SoB, the commit messages are very minimal.
Anyway I like that you shared your patches, but please use RFC tag if 
they are not ready to be merged.

Another suggestion is to move the patches that modify the core 
(af_vsock.c) before the transport modifications to make the review 
easier.

I'd also like to see new tests in tools/testing/vsock/vsock_test.c

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
