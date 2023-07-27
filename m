Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224D5C001E0
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 07:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9507C41F2A;
	Thu, 27 Jul 2023 07:48:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9507C41F2A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAfH3eZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hT-bTh8-119w; Thu, 27 Jul 2023 07:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B100741F0D;
	Thu, 27 Jul 2023 07:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B100741F0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B623C0072;
	Thu, 27 Jul 2023 07:48:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D69FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60AC560BCE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60AC560BCE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAfH3eZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ESW7ate0y526
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:48:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 129DF607B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 129DF607B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690444111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
 b=BAfH3eZZvfwnJ81BopGYpP+k8GjtSQzt79eEbkVEr2cVjPdLpQmwhB4yTswajYRZ6B+NFY
 fnfDIP4z5sl/B+tKOj4oqLqDwYTAdYRIMFU4jI42pyT3K469KCFzWOCfcsqF3klvqX6pqw
 hW/6iJzApCwFccZ6IjdClK7JPKCvBdw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600--h8dC_XMM_OiT9KxqCFlaQ-1; Thu, 27 Jul 2023 03:48:30 -0400
X-MC-Unique: -h8dC_XMM_OiT9KxqCFlaQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-997d069a914so36094666b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 00:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690444109; x=1691048909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
 b=D1475WlF+hfrRYcq3MnAreu/UdoDPnbSxc8PRwXV/srBfcM216PDZ4w3RDXUB+QEUN
 xomJRd5niswwAbiMgHsfXBY6nU8Q0MNc+LvilHaTEHqO0YE11K/OMBzCu5AwPw2zxN54
 cXVdjuCuArGBKimNhMWNBDnxYlNlQBPjD5gQesRx8urzWEtaM7iYmiITB5gNNejPd4eL
 79apwoNS1Ou/4qSK8le0iwr3v9Py2c3VYxSpdGYcczODC3YsH2BBYSaqyRkOmUqEoDdl
 uVhodovz1dWknG4rChfD6fMj/BcunhgkCz5VrXzzqrXXCj4CuYUGvznrgaF/DXvyytWR
 dPZg==
X-Gm-Message-State: ABy/qLaix4j/fJBrGKwF9S2Q/cGYlrg7idyPTzNyeQ/1aT1xCWDdRCie
 ycsdlM0PiPQJ31/UIBqe2L/6lmYCwkwWvvDn0TV2i3RdiPImbcNmDBf4J/h4ffU1VBaNi7oJ3U4
 pZNnX3T85RpSxRBnCRUV8L9JEzqibTl+YZa8PfVU7OQ==
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id
 ia8-20020a170907a06800b0098931480e9amr1273085ejc.41.1690444108916; 
 Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE55JyhKwJyB8qUe+lq1MkQNb4GdgSPTG/st46k7wZpyOLVvAygT9RNqVELeE+FBejRoktCsg==
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id
 ia8-20020a170907a06800b0098931480e9amr1273068ejc.41.1690444108579; 
 Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.102])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a170906075000b00993a9a951fasm467215ejb.11.2023.07.27.00.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:48:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230726143736-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, Jiang Wang <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
>> This commit adds a feature bit for virtio vsock to support datagrams.
>>
>> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> ---
>>  include/uapi/linux/virtio_vsock.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 331be28b1d30..27b4b2b8bf13 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -40,6 +40,7 @@
>>
>>  /* The feature bitmap for virtio vsock */
>>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>>
>>  struct virtio_vsock_config {
>>  	__le64 guest_cid;
>
>pls do not add interface without first getting it accepted in the
>virtio spec.

Yep, fortunatelly this series is still RFC.
I think by now we've seen that the implementation is doable, so we
should discuss the changes to the specification ASAP. Then we can
merge the series.

@Bobby can you start the discussion about spec changes?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
