Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F183C0015E
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 16:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D8FD40646;
	Tue,  1 Aug 2023 16:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D8FD40646
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SlNIaGO0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKoHTMTqAs9W; Tue,  1 Aug 2023 16:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C320940547;
	Tue,  1 Aug 2023 16:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C320940547
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF5EC0071;
	Tue,  1 Aug 2023 16:04:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79B4CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 514D1401B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 514D1401B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ibGcXX3E4U0z
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:04:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8600D4055E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8600D4055E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690905895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZTW9cojqSQW2bZi6sZ+IdoqRlKJXkCjqyxPfvTXPbg=;
 b=SlNIaGO0K/NxKj6sl82UmEsODdXrIg0BcudxS4Js8fPWMk00hWkBG/ub8/ogzdp88SLqnF
 7kmjmay1OkGBbssdgBSZ1s1o99em6a9PMn6cPU5a7fviYvuGSUyBqmsDsGYLxONiM1X3/u
 nxw5jexS/m0ZehKhVu1FbSRjLnxSyfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-wMx-_0OuN4OadTO-Pt-_HQ-1; Tue, 01 Aug 2023 12:04:51 -0400
X-MC-Unique: wMx-_0OuN4OadTO-Pt-_HQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe13881511so19741905e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690905890; x=1691510690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZTW9cojqSQW2bZi6sZ+IdoqRlKJXkCjqyxPfvTXPbg=;
 b=jotgcXCv+EfqrietPECpimJ5vg11Pp6JLpBwKSxAGYKoLomABBADo1ItX0zNSHSg/e
 cHv+XYDx+/BYw/0oZnYBFX71jS7fPZOQwrFkmY2/RRSAIlMyox1QbhOc0U4pjincmhDQ
 3tlbl++Dnfi1p5h0swLtEw3e6Ij5Oq+4Kp9bVfRQ7JSgvixGTeo9AH1MJMC2ejkPBHMp
 RBKgH8nvsT77Qk0BtHXnBnCe/v/EC2FfZSTF9/WIKmL4H60C5T3YoD1p4R/CrmX7hp8e
 8HivB3SGRAz9v8JlxEWbCrzWyRCp2XLnmj4QcByLbVHtqVAz2U0LEMTa3hZQNdpW1TjT
 txww==
X-Gm-Message-State: ABy/qLZI9/1jE9wKymyvMIguyLziewUMfh9Ousr5ro8cfEUOfcQ5uZGE
 agN2xInEEw946W9/mzoOE5FXd4qGOw16Y7DcxKwXP8NBFgalGzUqNCnqx3TkRpboTAaksAkzZiD
 eAL3DZocmA0dG72tf230xlH8K26G29oIyEahd8yFvsg==
X-Received: by 2002:a1c:7310:0:b0:3fb:e189:3532 with SMTP id
 d16-20020a1c7310000000b003fbe1893532mr2701254wmb.20.1690905890720; 
 Tue, 01 Aug 2023 09:04:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNvxPggY+ulCpxWm153ryyCBd6qp7Nemz78JW1jh60aRTALT7If6+aYqQcQ/iizAk261YnOw==
X-Received: by 2002:a1c:7310:0:b0:3fb:e189:3532 with SMTP id
 d16-20020a1c7310000000b003fbe1893532mr2701225wmb.20.1690905890321; 
 Tue, 01 Aug 2023 09:04:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfe2c7000000b00317ac0642b0sm3078341wrj.27.2023.08.01.09.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:04:49 -0700 (PDT)
Date: Tue, 1 Aug 2023 18:04:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <nnftjp3ek3hpiqlvz6ajbxcjswraclrayei2wi2qwgxzi7gpl6@yxdcz5eknofy>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
 <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
 <ZMiKXh173b/3Pj1L@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZMiKXh173b/3Pj1L@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Tue, Aug 01, 2023 at 04:30:22AM +0000, Bobby Eshleman wrote:
>On Thu, Jul 27, 2023 at 09:48:21AM +0200, Stefano Garzarella wrote:
>> On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
>> > > This commit adds a feature bit for virtio vsock to support datagrams.
>> > >
>> > > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > >  include/uapi/linux/virtio_vsock.h | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> > > index 331be28b1d30..27b4b2b8bf13 100644
>> > > --- a/include/uapi/linux/virtio_vsock.h
>> > > +++ b/include/uapi/linux/virtio_vsock.h
>> > > @@ -40,6 +40,7 @@
>> > >
>> > >  /* The feature bitmap for virtio vsock */
>> > >  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>> > > +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>> > >
>> > >  struct virtio_vsock_config {
>> > >  	__le64 guest_cid;
>> >
>> > pls do not add interface without first getting it accepted in the
>> > virtio spec.
>>
>> Yep, fortunatelly this series is still RFC.
>> I think by now we've seen that the implementation is doable, so we
>> should discuss the changes to the specification ASAP. Then we can
>> merge the series.
>>
>> @Bobby can you start the discussion about spec changes?
>>
>
>No problem at all. Am I right to assume that a new patch to the spec is
>the standard starting point for discussion?

Yep, I think so!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
