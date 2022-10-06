Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD36C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Oct 2022 07:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D064B41795;
	Thu,  6 Oct 2022 07:34:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D064B41795
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G61PdCeb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46RQyS25bqCH; Thu,  6 Oct 2022 07:34:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 11FDE417BD;
	Thu,  6 Oct 2022 07:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11FDE417BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6F98C0032;
	Thu,  6 Oct 2022 07:34:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C3CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 07:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BA15417BD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 07:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BA15417BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wInHttRhCIAf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 07:34:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1525B41795
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1525B41795
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665041658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fUwy6V31dk1BCOu7dbLezKne5qwi/4FkmWkd7lla4qc=;
 b=G61PdCeb+7BbtYnNlLEwgWbpXOxBca7fEC1xrhkbiX1AU9qB0j4O/JEmBa8OMO5neFD5yE
 f+iINeF/+NB2xC0VwjNS+IZA6VfmrOmMTC56ILq/3nWCocIljMBxNyuvrU/X1Xjlcy+0DS
 oEDpnKkoUGw+YTg8ruKqFNgGOtgNj4M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-D3c6wnynMPmD-B0tOD_G-Q-1; Thu, 06 Oct 2022 03:34:17 -0400
X-MC-Unique: D3c6wnynMPmD-B0tOD_G-Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 7-20020a170906328700b007838b96bf70so693684ejw.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Oct 2022 00:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUwy6V31dk1BCOu7dbLezKne5qwi/4FkmWkd7lla4qc=;
 b=Ck+QQ6AtP5Xq6XtFWCWYoS9B9bdiBAKq5pWqyYAkEx5/s7twuKwbYGpVAZTZxWV0lG
 Pputi/gr5GdwukymfH63dzRDymFpnPJTxOwqvCfdC0628UQlyLf4fnj+Mm4j8VTjdCtB
 kTKuF2ywqS9PZ7INZbsFB0qGANrVvfBYV+zRaAFnn8rw37ixGUQJ8Xm1uXjr7Xk2HBME
 IT8LgkEE1IGjSKXD+yADFnOJ1yx8tQs1g0nkpKrLIdn/4Xrt+IsnQfnCaOJwrxn4SPue
 jFTWH/MaTEG5I4CtgbLzzIqCi3ohBGAm+GDYuNTWJb5L54giiec8y8dzDZgpDDRfPDxi
 ba6g==
X-Gm-Message-State: ACrzQf2gFy4sdKGnPSdG84g53/JRrrMD+/TuA4FlAqO5Plx+/R+X3pUC
 kMpuZyM672uEZnbxlCUL+/MOtiVdx0t2aziU7l8O0t/F5L40+q7Byy7ddcWjQ10/8EXscvu8qig
 sm+vYhT3N8SJEG0EcpZ9P1x82CivVdqysoBwA41BvRA==
X-Received: by 2002:a17:907:724a:b0:782:405f:8115 with SMTP id
 ds10-20020a170907724a00b00782405f8115mr2910896ejc.147.1665041655390; 
 Thu, 06 Oct 2022 00:34:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM44T4zWyGulJH+j/LpDdqknk09HMNxHTcvIsE5Med56cxQZCnSdeQcKPGt1dPA9kjuGiw7FWw==
X-Received: by 2002:a17:907:724a:b0:782:405f:8115 with SMTP id
 ds10-20020a170907724a00b00782405f8115mr2910870ejc.147.1665041655098; 
 Thu, 06 Oct 2022 00:34:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 g25-20020a056402321900b004542e65337asm5307845eda.51.2022.10.06.00.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Oct 2022 00:34:14 -0700 (PDT)
Date: Thu, 6 Oct 2022 09:34:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH v2] vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221006073410.ahhqhlhah4lo47o7@sgarzare-redhat>
References: <20221006011946.85130-1-bobby.eshleman@bytedance.com>
 <20221006025956-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221006025956-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
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

On Thu, Oct 06, 2022 at 03:08:12AM -0400, Michael S. Tsirkin wrote:
>On Wed, Oct 05, 2022 at 06:19:44PM -0700, Bobby Eshleman wrote:
>> This patch replaces the struct virtio_vsock_pkt with struct sk_buff.
>>
>> Using sk_buff in vsock benefits it by a) allowing vsock to be extended
>> for socket-related features like sockmap, b) vsock may in the future
>> use other sk_buff-dependent kernel capabilities, and c) vsock shares
>> commonality with other socket types.
>>
>> This patch is taken from the original series found here:
>> https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>>
>> Small-sized packet throughput improved by ~5% (from 18.53 Mb/s to 19.51
>> Mb/s). Tested using uperf, 16B payloads, 64 threads, 100s, averaged from
>> 10 test runs (n=10). This improvement is likely due to packet merging.
>>
>> Large-sized packet throughput decreases ~9% (from 27.25 Gb/s to 25.04
>> Gb/s). Tested using uperf, 64KB payloads, 64 threads, 100s, averaged
>> from 10 test runs (n=10).
>>
>> Medium-sized packet throughput decreases ~5% (from 4.0 Gb/s to 3.81
>> Gb/s). Tested using uperf, 4k to 8k payload sizes picked randomly
>> according to normal distribution, 64 threads, 100s, averaged from 10
>> test runs (n=10).
>
>It is surprizing to me that the original vsock code managed to outperform
>the new one, given that to my knowledge we did not focus on optimizing it.

Yeah mee to.

 From this numbers maybe the allocation cost has been reduced as it 
performs better with small packets. But with medium to large packets we 
perform worse, perhaps because previously we were allocating a 
contiguous buffer up to 64k?
Instead alloc_skb() could allocate non-contiguous pages ? (which would 
solve the problems we saw a few days ago)

@Bobby Are these numbers for guest -> host communication? Can we try the 
reverse path as well?

I will review the patch in the next few days!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
