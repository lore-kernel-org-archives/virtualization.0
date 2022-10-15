Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD977C4332F
	for <virtualization@archiver.kernel.org>; Sat, 15 Oct 2022 19:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19B1060D75;
	Sat, 15 Oct 2022 19:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19B1060D75
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IO8WJ3hL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEbq3mm4hkDN; Sat, 15 Oct 2022 19:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 633E960BAC;
	Sat, 15 Oct 2022 19:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 633E960BAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20DF5C0032;
	Sat, 15 Oct 2022 19:50:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84724C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 19:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5087E60BAC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 19:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5087E60BAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqBmng08IiP9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 19:50:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0922960B96
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0922960B96
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 19:50:02 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id a18so4573042qko.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6oLVdw0cZuqaOKT9ROptKn3b8uDN0aCnLROazMdgeqk=;
 b=IO8WJ3hL5rwlhfbeUVUH8LrBsTDdTLyDy0tbu+HxxYzzKbU6/o7MukfZBWR0sztSP2
 H8myo6VAwPy5/zjB89Oq4p3oFHZKf+k/Fre09M6Zbnr25hz7BTtM825B/OAZJISKyGqz
 OvrWFaHBZmy8r34Ctve6/4mm6EV+2+2f64TETcoujZ/EkbLGxYFlDzpQEgdn5bx89351
 w5p60sX/z9TtaKq1x/o3RvIBaZYl9GuiV0Tpgu6BfTbPxekuzW5Kn4AOGtf7/XQ0HVDb
 fds/gbOHOXqEMtApIUz8AAV/R7IwqijrBPBH3h+zK1WOMWz4cLOE80nxV3KZWDUZAGdb
 npzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oLVdw0cZuqaOKT9ROptKn3b8uDN0aCnLROazMdgeqk=;
 b=YNgACkeCru2qHTnus7PLVxjh5gVl/7y/CISF7fdQNkF/uZvZSlzDLjT6+cWtI734ts
 9MvUB1QsFMtNTaM7LwKLK23amNE5BFY+ryLDdzjbBYHf1VMH3fH0E7F394EIkdWOfmtM
 8wjojnVkUtHJftsLAmEKEJPhEf9pAXmcwmiFHMadPFQcOGrJw58JjJMrxuFXba+8CEEQ
 ngcjWrWLE5ngMSvaKgOHE0mLVzVjeJA/4ldgxEXzei35V0ZAGAdLgxCOC0wOXfwKMMVA
 Jv9uE+/hRZwPa02eYw5sCKj8Wou8/j6sZp+onB5LXN5T4rDT9AsDtdXiyXGJjf3yIqPN
 Nd4Q==
X-Gm-Message-State: ACrzQf3S39x12PV8sntq64kRu8BRfuMjD6rUkcVQGtJIGzf5MKZ6S85M
 83WVAm454Qfp/NnXT+YHbwY=
X-Google-Smtp-Source: AMsMyM4WwiQfxwMrAO85WbcfHaH/QaOsu71JLPtcGxIY6207P2zl2kaMFx3KXXR9kW58X0SS0BrtGw==
X-Received: by 2002:a05:620a:1519:b0:6ee:af9e:9048 with SMTP id
 i25-20020a05620a151900b006eeaf9e9048mr2825542qkk.601.1665863401804; 
 Sat, 15 Oct 2022 12:50:01 -0700 (PDT)
Received: from localhost ([2600:1700:65a0:ab60:b8b9:b1cd:e6fc:2d50])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a05622a065400b0039853b7b771sm4707455qtb.80.2022.10.15.12.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Oct 2022 12:50:00 -0700 (PDT)
Date: Sat, 15 Oct 2022 12:49:59 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH v2] vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <Y0sO5yNqQkFQucjb@pop-os.localdomain>
References: <20221006011946.85130-1-bobby.eshleman@bytedance.com>
 <20221006025956-mutt-send-email-mst@kernel.org>
 <20221006073410.ahhqhlhah4lo47o7@sgarzare-redhat>
 <Yzoou4UwOv5lh0hE@bullseye>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yzoou4UwOv5lh0hE@bullseye>
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Oct 03, 2022 at 12:11:39AM +0000, Bobby Eshleman wrote:
> On Thu, Oct 06, 2022 at 09:34:10AM +0200, Stefano Garzarella wrote:
> > On Thu, Oct 06, 2022 at 03:08:12AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Oct 05, 2022 at 06:19:44PM -0700, Bobby Eshleman wrote:
> > > > This patch replaces the struct virtio_vsock_pkt with struct sk_buff.
> > > > 
> > > > Using sk_buff in vsock benefits it by a) allowing vsock to be extended
> > > > for socket-related features like sockmap, b) vsock may in the future
> > > > use other sk_buff-dependent kernel capabilities, and c) vsock shares
> > > > commonality with other socket types.
> > > > 
> > > > This patch is taken from the original series found here:
> > > > https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
> > > > 
> > > > Small-sized packet throughput improved by ~5% (from 18.53 Mb/s to 19.51
> > > > Mb/s). Tested using uperf, 16B payloads, 64 threads, 100s, averaged from
> > > > 10 test runs (n=10). This improvement is likely due to packet merging.
> > > > 
> > > > Large-sized packet throughput decreases ~9% (from 27.25 Gb/s to 25.04
> > > > Gb/s). Tested using uperf, 64KB payloads, 64 threads, 100s, averaged
> > > > from 10 test runs (n=10).
> > > > 
> > > > Medium-sized packet throughput decreases ~5% (from 4.0 Gb/s to 3.81
> > > > Gb/s). Tested using uperf, 4k to 8k payload sizes picked randomly
> > > > according to normal distribution, 64 threads, 100s, averaged from 10
> > > > test runs (n=10).
> > > 
> > > It is surprizing to me that the original vsock code managed to outperform
> > > the new one, given that to my knowledge we did not focus on optimizing it.
> > 
> > Yeah mee to.
> > 
> 
> Indeed.
> 
> > From this numbers maybe the allocation cost has been reduced as it performs
> > better with small packets. But with medium to large packets we perform
> > worse, perhaps because previously we were allocating a contiguous buffer up
> > to 64k?
> > Instead alloc_skb() could allocate non-contiguous pages ? (which would solve
> > the problems we saw a few days ago)
> > 
> 
> I think this would be the case with alloc_skb_with_frags(), but
> internally alloc_skb() uses kmalloc() for the payload and sk_buff_head
> slab allocations for the sk_buff itself (all the more confusing to me,
> as the prior allocator also uses two separate allocations per packet).

I think it is related to your implementation of
virtio_transport_add_to_queue(), where you introduced much more
complicated logic than before:

-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	list_add_tail(&pkt->list, &vsock->send_pkt_list);
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
-
+	virtio_transport_add_to_queue(&vsock->send_pkt_queue, skb);

A simple list_add_tail() is definitely faster than your
virtio_transport_skbs_can_merge() check. So, why do you have to merge
skb while we don't merge virtio_vsock_pkt?

_If_ you are trying to mimic TCP, I think you are doing it wrong, it can
be much more efficient if you could do the merge in sendmsg() before skb
is even allocated, see tcp_sendmsg_locked().

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
