Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF53C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 15:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A89F81E19;
	Tue, 13 Dec 2022 15:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A89F81E19
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f2Nv6mr/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNzJKSeROzi6; Tue, 13 Dec 2022 15:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 93388813A1;
	Tue, 13 Dec 2022 15:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93388813A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59866C0032;
	Tue, 13 Dec 2022 15:43:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A85C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ED5A81E19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6ED5A81E19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDdpLSZCE30v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAC98813A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAC98813A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670946192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ta5qJGL6TYgTS7WdcfK/NhG2rVIgkTUOeHGwN5QJWEY=;
 b=f2Nv6mr/CealrBMGHCbN/yvFh70HP5uaI+aj8A8vdLBpqAgNgKEbUsrsHwpSC5BeFP6cac
 S6t58XZphfM0anHxVvizlDqGGrXuza23B81g2wbzsCCDHaOP0jlPvlg5broqhRyh1xHLUT
 p2spaqwvtWpnFZs6jfPNoUScn3cgvUs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-4OSs57yQOZae845QZaHB0w-1; Tue, 13 Dec 2022 10:43:11 -0500
X-MC-Unique: 4OSs57yQOZae845QZaHB0w-1
Received: by mail-wm1-f69.google.com with SMTP id
 bi19-20020a05600c3d9300b003cf9d6c4016so5802446wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ta5qJGL6TYgTS7WdcfK/NhG2rVIgkTUOeHGwN5QJWEY=;
 b=ELN16lXHVWONCpEHqwDsoTkUdZ0YBD/FkQog0HhsvSkQXuNdCrE6fgS5lpLcH/CpMO
 WWWKkDgNoKfEqw++6YZwWpfpIaWioyKQnXQ39pSvWaVY/FLu3BqvsnxmXJSEu9l72vok
 p1i5bDDUBlAqI6yEXPf5sXucMMq4GSFdij7JwHuQLMNxU3ju/TBnl++xPlYWMbat8LJm
 YVLUo/W3LcETFye5sZlWw8W1+GyTNp3g0IUrH9g/RMf9IS9sB700VqDSw63nJcjolBZn
 CWgWVXScZZvkXfyam/NS+xgLoorYOMqjFQM4t7NTmvPiP/HBrqeY0RNGzJCUTgMMeHHz
 qIog==
X-Gm-Message-State: ANoB5pny2y2rgDTDT8YmlaEFnLo3BUPHUXM2AjGhYOZ6qQLFXPH2lHx9
 ot6NBw3VDUWQgxnP2pQiaq2Ve/mhWHEw0BMk5xyDed8Vaf826C7gdMPw4u8alUIz3+HA8BVe1zy
 rIJYIYC5FtSooI608TaABjLGat6KUf5eTtIaWIemdiA==
X-Received: by 2002:a05:6000:550:b0:242:880:20ce with SMTP id
 b16-20020a056000055000b00242088020cemr13771061wrf.47.1670946190491; 
 Tue, 13 Dec 2022 07:43:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Fome2UWsPehy6lJdurAxcXv7sPgyHhsfgJzvy5rYv8HZ777S+ULuoF2cVj9aNlQvSN3jKBA==
X-Received: by 2002:a05:6000:550:b0:242:880:20ce with SMTP id
 b16-20020a056000055000b00242088020cemr13771047wrf.47.1670946190282; 
 Tue, 13 Dec 2022 07:43:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d564e000000b0024165454262sm135347wrw.11.2022.12.13.07.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 07:43:09 -0800 (PST)
Date: Tue, 13 Dec 2022 16:43:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v6] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221213154304.rjrwzbv6jywkrpxq@sgarzare-redhat>
References: <20221213072549.1997724-1-bobby.eshleman@bytedance.com>
 <20221213102232.n2mc3y7ietabncax@sgarzare-redhat>
 <20221213100510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221213100510-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 13, 2022 at 10:06:23AM -0500, Michael S. Tsirkin wrote:
>On Tue, Dec 13, 2022 at 11:22:32AM +0100, Stefano Garzarella wrote:
>> > +	if (len <= GOOD_COPY_LEN && !skb_queue_empty_lockless(&vvs->rx_queue)) {
>>
>> Same here.
>>
>> If there are no major changes to be made, I think the next version is the
>> final ones, though we are now in the merge window, so net-next is closed
>> [1], only RFCs can be sent [2].
>>
>> I suggest you wait until the merge window is over (two weeks usually) to
>> send the next version.
>
>Nah, you never know, could be more comments. And depending on the timing
>I might be able to merge it.

Right, in the end these changes are only to virtio-vsock transport, so 
they can go smoothly even with your tree.

@Bobby, so if you can fix the remaining small things, we can try to 
merge it :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
