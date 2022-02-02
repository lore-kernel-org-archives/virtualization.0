Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CDC433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 13:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1429660FAD;
	Wed,  2 Feb 2022 13:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qw7DdGZ5lNvJ; Wed,  2 Feb 2022 13:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B50E60F96;
	Wed,  2 Feb 2022 13:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E84CC0011;
	Wed,  2 Feb 2022 13:53:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4121FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 13:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2911160FA6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 13:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWvIG7vs8wof
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 13:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FF6960F96
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643809987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzs3pmpsecqWwS28UKT/9n4YfyBZy50vlVYoCws6yUE=;
 b=Z1C4nylYj5BpS6MbkJffKjGwySKJMVJOh5lLnQiJWrOXZChxc47Famx5vV+MgjD3zsVyto
 N4CJzzOaTuCG2r1gifAanXvsRzcqLhoSKSG18TvjVfqhy9C8CGSH9TKS8aHcIRRtvKKZes
 enEth73mhdZb6K/nJf/NjpaZsoRU180=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-ArDCAnASPI2ppnIRqPr3Zw-1; Wed, 02 Feb 2022 08:53:06 -0500
X-MC-Unique: ArDCAnASPI2ppnIRqPr3Zw-1
Received: by mail-qt1-f200.google.com with SMTP id
 c15-20020ac87dcf000000b002d0a849c0beso15497684qte.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Feb 2022 05:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dzs3pmpsecqWwS28UKT/9n4YfyBZy50vlVYoCws6yUE=;
 b=JzMG0n7E3mWgXgDS7YcXP/vuBRnzjogtqEcz0ifOS+ckum+WV7OmdNur4UF2uiALNQ
 NwRsJElKbAAzUazy0OxifnEwzepBqm1PCDEezlDaH9nLkwKHpuOpF29Wov849h1dmGQU
 u2tLrXlp6tClJBzXMLsIc7DaIC5b/WeaBedsIua1AhmHoymEA5Y4xBYSiXs5yL0smYRe
 k+zfvZIYrJXsB9Tjkp/P1duR9yN3xn3cKh0o0mbKgYlUSu7zoHwTC/nm07rKzCaC1b0d
 S5Tdqkbu36RlLmWr48RWB1CroJt0lu7bQpJTIlAmz+d3atQfo8aAnplcRiQHWJo8mqVj
 2doQ==
X-Gm-Message-State: AOAM533xyxghzUpVFOu5RffqluyyQ5K/KOn2NdOZjZOhK+6LULeA67gs
 QB2l2eiXioMuKDO+EohbBPIfo6l72L3QmdwPWN6MQaN4/Qa+pFxEihCFS5rkHLnMr4X2W0Bk93b
 GExnNnf81V3VOSZnLdQA6YI619d5UUd5wQDg8h4Ddvw==
X-Received: by 2002:ad4:5dc4:: with SMTP id m4mr26516021qvh.17.1643809985996; 
 Wed, 02 Feb 2022 05:53:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy97PB6hOF6XRVh0laZSCO/T0ng/aOceXJMUfGN81RQHfwOdZhjN5x8YkGsaZRSWfCtenz6QA==
X-Received: by 2002:ad4:5dc4:: with SMTP id m4mr26516006qvh.17.1643809985739; 
 Wed, 02 Feb 2022 05:53:05 -0800 (PST)
Received: from steredhat (host-95-238-125-214.retail.telecomitalia.it.
 [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id c14sm10955065qtc.31.2022.02.02.05.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Feb 2022 05:53:05 -0800 (PST)
Date: Wed, 2 Feb 2022 14:53:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220202135300.5b366wk35ysqehgm@steredhat>
References: <20220128094129.40809-1-sgarzare@redhat.com>
 <Yfpnlv2GudpPFwok@stefanha-x1.localdomain>
 <20220202062340-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220202062340-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Feb 02, 2022 at 06:24:05AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 02, 2022 at 11:14:30AM +0000, Stefan Hajnoczi wrote:
>> On Fri, Jan 28, 2022 at 10:41:29AM +0100, Stefano Garzarella wrote:
>> > In vhost_enable_notify() we enable the notifications and we read
>> > the avail index to check if new buffers have become available in
>> > the meantime.
>> >
>> > We do not update the cached avail index value, so when the device
>> > will call vhost_get_vq_desc(), it will find the old value in the
>> > cache and it will read the avail index again.
>> >
>> > It would be better to refresh the cache every time we read avail
>> > index, so let's change vhost_enable_notify() caching the value in
>> > `avail_idx` and compare it with `last_avail_idx` to check if there
>> > are new buffers available.
>> >
>> > We don't expect a significant performance boost because
>> > the above path is not very common, indeed vhost_enable_notify()
>> > is often called with unlikely(), expecting that avail index has
>> > not been updated.
>> >
>> > We ran virtio-test/vhost-test and noticed minimal improvement as
>> > expected. To stress the patch more, we modified vhost_test.ko to
>> > call vhost_enable_notify()/vhost_disable_notify() on every cycle
>> > when calling vhost_get_vq_desc(); in this case we observed a more
>> > evident improvement, with a reduction of the test execution time
>> > of about 3.7%.
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > v3
>> > - reworded commit description [Stefan]
>> > ---
>> >  drivers/vhost/vhost.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > index 59edb5a1ffe2..07363dff559e 100644
>> > --- a/drivers/vhost/vhost.c
>> > +++ b/drivers/vhost/vhost.c
>> > @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>> >  		       &vq->avail->idx, r);
>> >  		return false;
>> >  	}
>> > +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> >
>> > -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
>> > +	return vq->avail_idx != vq->last_avail_idx;
>> >  }
>> >  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>>
>> This changes behavior (fixes a bug?): previously the function returned
>> false when called with avail buffers still pending (vq->last_avail_idx <
>> vq->avail_idx). Now it returns true because we compare against
>> vq->last_avail_idx and I think that's reasonable.

Good catch!

>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>I don't see the behaviour change... could you explain the
>scanario in more detail pls?

IIUC the behavior is different only when the device calls 
vhost_enable_notify() with pending buffers (vq->avail_idx != 
vq->last_avail_idx).

Let's suppose that driver has not added new available buffers, so value 
in cache (vq->avail_idx) is equal to the one we read back from the 
guest, but the device has not consumed all available buffers 
(vq->avail_idx != vq->last_avail_idx).

Now if the device call vhost_enable_notify(), before this patch it 
returned false, because there are no new buffers added (even if there 
are some pending), with this patch it returns true, because there are 
still some pending buffers (vq->avail_idx != vq->last_avail_idx).

IIUC the right behavior should be the one with the patch applied.
However this difference would be seen only if we call 
vhost_enable_notify() when vq->avail_idx != vq->last_avail_idx and 
checking vhost-net, vhost-scsi and vhost-vsock, we use the return value 
of vhost_enable_notify() only when there are not available buffers, so 
vq->avail_idx == vq->last_avail_idx.

So I think Stefan is right, but we should never experience the buggy 
scenario.

it seems that we used to check vq->last_avail_idx but we changed it 
since commit 8dd014adfea6 ("vhost-net: mergeable buffers support"), 
honestly I don't understand if it was intended or not.

Do you see any reason?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
