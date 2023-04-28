Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB41C77B60
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 13:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EC05429F5;
	Fri, 28 Apr 2023 13:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EC05429F5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=lgHWYmqQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqD2q8o3-GOV; Fri, 28 Apr 2023 13:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 751CC40469;
	Fri, 28 Apr 2023 13:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 751CC40469
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A707C0037;
	Fri, 28 Apr 2023 13:56:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7AC3C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 13:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B1F461167
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 13:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B1F461167
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=lgHWYmqQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0I8cO6ICwUz5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 13:56:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B705560AFB
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B705560AFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 13:56:45 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-5ef524eaca1so92996d6.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682690204; x=1685282204;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lZNOvuxZAzbjpYfchXeKaB+I7zPF9dkZAdqgkYv8Ho=;
 b=lgHWYmqQiDhDj11Lqd4DHHsZ4s8tQii9QwdSJf9Mm0ETXBwwGu99pR+740afudCkZi
 VVlJ6WYsnq9YXogiw4AKu3hP5+e0E8K+QKe1u8GOL5rPcTSmxLEzJRi/U7eK2SXeBpe/
 CcdSN/lLEbkxU2xzYYGiBSRuBZG4mJP0FxDcQV8iJap4nCHkoUHUNlOCAdlUAwkXuov9
 aC2gqjSjY8BijoQCjUvwPFbUmJqdrhmvZQoveb8Fc5kMIEZGrf332OItmHkV+8nFswMY
 +yq4CnfFEvJ0dFl36FR1WdqAzIR3mNG7QCEc3qpeON3iNmN/97CMrXJub8kmX+WDtlyo
 ETew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682690204; x=1685282204;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/lZNOvuxZAzbjpYfchXeKaB+I7zPF9dkZAdqgkYv8Ho=;
 b=lkE3DyjSR/qqQjdGHCww75/LlsxPW6kv2JdnbjKJRxbLYgYtK4HE1wpJo0a2OJzt1B
 tlgbo0JUjx/zOeE1MdogOL3dYInUAC8DKXI+TFJ3UpJoy5q2NOZY2DlSMOVS4nvrI8nA
 +rgmvQ3HcEAPkQWxki/y65K2qTNcv3AqBjWxV67hPD8y9ukbTUv6QAc+ah+F+FtiX0/o
 aXek90z+mkxU6u4jGg4XgxUwQrT6/TbJrZahdf9JSZc77sscextVl2gmrFQhLn7dapCx
 mHyw4m4m0xJZpq5Xs37zyjnGBFfUdFd8I7o7my+QMeZMVKTadS0uXb9M1EclHRxWM6PQ
 pVyg==
X-Gm-Message-State: AC+VfDygW/Jcyq73e7X4aoBCt0a8ZNYhOZNDlI5SjsNBXdb4EF0uevfe
 28foOCsepFpj7Fe/v1N+pII=
X-Google-Smtp-Source: ACHHUZ6QPJNVSm7jJadTHqMP+cKkemRtJOCp+cou04qzwfFy0MgdI7ZsI9Ut9x1fI+DHsxjLb2ZM0g==
X-Received: by 2002:a05:6214:2244:b0:5ef:5e1b:a369 with SMTP id
 c4-20020a056214224400b005ef5e1ba369mr10143325qvc.13.1682690204526; 
 Fri, 28 Apr 2023 06:56:44 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com.
 [35.245.174.172]) by smtp.gmail.com with ESMTPSA id
 m14-20020a0c9d0e000000b0061665028dc2sm1843262qvf.28.2023.04.28.06.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Apr 2023 06:56:44 -0700 (PDT)
Date: Fri, 28 Apr 2023 09:56:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <644bd09bca7e5_29e48c29469@willemb.c.googlers.com.notmuch>
In-Reply-To: <32eb2826-6322-2f3e-9c48-7fd9afc33615@bytedance.com>
References: <20230427043433.2594960-1-wangwenliang.1995@bytedance.com>
 <1682576442.2203932-1-xuanzhuo@linux.alibaba.com>
 <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
 <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
 <20230427041206-mutt-send-email-mst@kernel.org>
 <1682583225.3180113-2-xuanzhuo@linux.alibaba.com>
 <20230427042259-mutt-send-email-mst@kernel.org>
 <32eb2826-6322-2f3e-9c48-7fd9afc33615@bytedance.com>
Subject: Re: [PATCH] virtio_net: suppress cpu stall when free_unused_bufs
Mime-Version: 1.0
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, Wenliang Wang <wangwenliang.1995@bytedance.com>,
 davem@davemloft.net
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

Qi Zheng wrote:
> 
> 
> On 2023/4/27 16:23, Michael S. Tsirkin wrote:
> > On Thu, Apr 27, 2023 at 04:13:45PM +0800, Xuan Zhuo wrote:
> >> On Thu, 27 Apr 2023 04:12:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>> On Thu, Apr 27, 2023 at 03:13:44PM +0800, Xuan Zhuo wrote:
> >>>> On Thu, 27 Apr 2023 15:02:26 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 4/27/23 2:20 PM, Xuan Zhuo wrote:
> >>>>>> On Thu, 27 Apr 2023 12:34:33 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> >>>>>>> For multi-queue and large rx-ring-size use case, the following error
> >>>>>>
> >>>>>> Cound you give we one number for example?
> >>>>>
> >>>>> 128 queues and 16K queue_size is typical.
> >>>>>
> >>>>>>
> >>>>>>> occurred when free_unused_bufs:
> >>>>>>> rcu: INFO: rcu_sched self-detected stall on CPU.
> >>>>>>>
> >>>>>>> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> >>>>>>> ---
> >>>>>>>    drivers/net/virtio_net.c | 1 +
> >>>>>>>    1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>>> index ea1bd4bb326d..21d8382fd2c7 100644
> >>>>>>> --- a/drivers/net/virtio_net.c
> >>>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>>> @@ -3565,6 +3565,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> >>>>>>>    		struct virtqueue *vq = vi->rq[i].vq;
> >>>>>>>    		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> >>>>>>>    			virtnet_rq_free_unused_buf(vq, buf);
> >>>>>>> +		schedule();
> >>>>>>
> >>>>>> Just for rq?
> >>>>>>
> >>>>>> Do we need to do the same thing for sq?
> >>>>> Rq buffers are pre-allocated, take seconds to free rq unused buffers.
> >>>>>
> >>>>> Sq unused buffers are much less, so do the same for sq is optional.
> >>>>
> >>>> I got.
> >>>>
> >>>> I think we should look for a way, compatible with the less queues or the smaller
> >>>> rings. Calling schedule() directly may be not a good way.
> >>>>
> >>>> Thanks.
> >>>
> >>> Why isn't it a good way?
> >>
> >> For the small ring, I don't think it is a good way, maybe we only deal with one
> >> buf, then call schedule().
> >>
> >> We can call the schedule() after processing a certain number of buffers,
> >> or check need_resched () first.
> >>
> >> Thanks.
> > 
> > 
> > Wenliang, does
> >              if (need_resched())
> >                      schedule();
> 
> Can we just use cond_resched()?

I believe that is preferred. But v2 still calls schedule directly.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
