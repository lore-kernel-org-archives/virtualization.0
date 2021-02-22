Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72343C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8C564D9A
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C564D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A0C283868;
	Mon, 22 Feb 2021 08:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4TrGicXYm21; Mon, 22 Feb 2021 08:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1EF88384B;
	Mon, 22 Feb 2021 08:45:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2208C000B;
	Mon, 22 Feb 2021 08:45:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1198EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F077D870D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYhGClVw7BJl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:45:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7711687031
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613983508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SrtOil1ush87CJH7mNAfYeoy9cbROV4RHIY2T5IFu1k=;
 b=Qp7XJLgW0FSjAHUXBA8u5vV99BHzib1cO7cSH0ibw4zdSV9xfmTc9x2Mi4uWhjDkwzkf/T
 o1N+9yCdj7rWDQ6+9FvM8N3FncN/3K2mqcFO13G/fAiPJOjMjTUWJTCPL/NRs+nqp0Qqhx
 Q+kOdeV9pSjEdZsFnSsuTAkGlGkRIxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-xLppStFmOUOT2emgZTkfJA-1; Mon, 22 Feb 2021 03:45:02 -0500
X-MC-Unique: xLppStFmOUOT2emgZTkfJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFF8110CE783;
 Mon, 22 Feb 2021 08:45:00 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-244.pek2.redhat.com
 [10.72.12.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0714F5D9CC;
 Mon, 22 Feb 2021 08:44:53 +0000 (UTC)
Subject: Re: Kernel panic with vhost-vdpa
To: Gautam Dawar <gdawar.xilinx@gmail.com>
References: <CAJ-rMYoK9k=z0q7Dv9pJTDUxGJL5UiKhy1RERqCiTSL-qsFNHw@mail.gmail.com>
 <f5028d5b-bbdf-b548-9d0e-939ee549c695@redhat.com>
 <CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <33402945-5871-3045-1196-da67a6a47a39@redhat.com>
Date: Mon, 22 Feb 2021 16:44:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: martinh@xilinx.com, hanand@xilinx.com, mst@redhat.com, gdawar@xilinx.com,
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
Content-Type: multipart/mixed; boundary="===============3978342373511937860=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============3978342373511937860==
Content-Type: multipart/alternative;
 boundary="------------471C0B5386535DC49C10196D"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------471C0B5386535DC49C10196D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021/2/18 11:15 下午, Gautam Dawar wrote:
> Hi Jason,
>
> Thanks for your response.
>
> On Thu, 18 Feb 2021 at 14:18, Jason Wang <jasowang@redhat.com 
> <mailto:jasowang@redhat.com>> wrote:
>
>     Hi Gautam:
>
>     On 2021/2/15 9:01 下午, Gautam Dawar wrote:
>>
>>     Hi Jason/Michael,
>>
>>     I observed a kernel panic while testing vhost-vdpa with Xilinx
>>     adapters. Here are the details for your review:
>>
>>     Problem statement:
>>
>>     When qemu with vhost-vdpa netdevice is run for the first time, it
>>     works well. But after the VM is powered off, next qemu run causes
>>     kernel panic due to a NULL pointer dereference in
>>     irq_bypass_register_producer().
>>
>>     Root cause analysis:
>>
>>     When the VM is powered off, vhost_dev_stop() is invoked which in
>>     turn calls vhost_vdpa_reset_device() causing the irq_bypass
>>     producers to be unregistered.
>>
>>     On the next run, when qemu opens the vhost device, the
>>     vhost_vdpa_open() file operation calls vhost_dev_init(). Here,
>>     call_ctx->producer memory is cleared in vhost_vring_call_reset().
>>
>>     Further, when the virtqueues are initialized by
>>     vhost_virtqueue_init(), vhost_vdpa_setup_vq_irq() again registers
>>     the irq_bypass producer for each virtqueue. As the node member of
>>     struct irq_bypass_producer is also initialized to zero, traversal
>>     on the producers list causes crash due to NULL pointer dereference.
>>
>
>     Thanks a lot for reporting this issue.
>
>
>>     Fix details:
>>
>>     I think that this issue can be fixed by invoking
>>     vhost_vdpa_setup_vq_irq() only when vhost_vdpa_set_status()
>>     includes VIRTIO_CONFIG_S_DRIVER_OK in the new status value. This
>>     way, there won’t be any stale nodes in the irqbypass  module’s
>>     producers list which are reset in vhost_vring_call_reset().
>>
>>     Patch:
>>
>>     diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
>>     62a9bb0efc55..fdad94e2fbf9 100644
>>
>>     --- a/drivers/vhost/vdpa.c
>>
>>     +++ b/drivers/vhost/vdpa.c
>>
>>     @@ -409,7 +409,6 @@ static long vhost_vdpa_vring_ioctl(struct
>>     vhost_vdpa *v, unsigned int cmd,
>>
>>     cb.private = NULL;
>>
>>     }
>>
>>     ops->set_vq_cb(vdpa, idx, &cb);
>>
>>     - vhost_vdpa_setup_vq_irq(v, idx);
>>
>>     break;
>>
>>     case VHOST_SET_VRING_NUM:
>>
>>     We can also track this issue in Bugzilla ticket 21171
>>     (https://bugzilla.kernel.org/show_bug.cgi?id=211711
>>     <https://bugzilla.kernel.org/show_bug.cgi?id=211711>) and the
>>     complete patch is attached with this email.
>>
>
>     So vhost supports to remove or switch eventfd through
>     vhost_vdpa_vring_ioctl(). So if userspace want to switch to
>     another eventfd, we should re-do the register and unregister.
>
> GD>>  This makes sense. I missed the use case where userspace may want 
> to switch to a different eventfd.


This can happen when interrupt needs to be disabled for some reason (e.g 
MSI-X is masked).


>
>     I think we need to deal this issue in another way. Can we check
>     whether or not the producer is initialized before?
>
>     Thanks
>
> GD>> Initialization path is fine but the actual problem lies in the 
> clean-up part.
> I think the following check is the cause of this issue:
>
> static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
> if (vq->call_ctx.producer.irq)
> irq_bypass_unregister_producer(&vq->call_ctx.producer);
> The above if condition will prevent the de-initialization of the 
> producer nodes corresponding to irq 0 but 
> irq_bypass_unregister_producer() should be called for all valid irq 
> values including zero.
>
> Accordingly, following patch is required to fix this issue:
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62a9bb0efc55..d1c3a33c6239 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
>
>         for (i = 0; i < v->nvqs; i++) {
>                 vq = &v->vqs[i];
> -               if (vq->call_ctx.producer.irq)
> +               if (vq->call_ctx.producer.irq >= 0)
> irq_bypass_unregister_producer(&vq->call_ctx.producer);
>         }
>  }


It should work, please post a formal patch for this.

I will give more thought in the meanwhile since I spot some other 
defects on codes for irqbyass usage in vdpa.

Thanks


>
> The revised patch (bug211711_fix.patch) is also attached with this email.
>
>>     Regards,
>>
>>     Gautam Dawar
>>

--------------471C0B5386535DC49C10196D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/2/18 11:15 下午, Gautam Dawar
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Hi Jason,</div>
        <div><br>
        </div>
        <div>
          <div>Thanks for your response.</div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Thu, 18 Feb 2021 at
            14:18, Jason Wang &lt;<a href="mailto:jasowang@redhat.com"
              moz-do-not-send="true">jasowang@redhat.com</a>&gt; wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <p>Hi Gautam:<br>
              </p>
              <div>On 2021/2/15 9:01 下午, Gautam Dawar wrote:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Hi
                    Jason/Michael,</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">I
                    observed a kernel panic while testing vhost-vdpa
                    with Xilinx adapters. Here are the details for your
                    review:</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Problem
                    statement: </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">When
                    qemu with vhost-vdpa netdevice is run for the first
                    time, it works well. But after the VM is powered
                    off, next qemu run causes kernel panic due to a NULL
                    pointer dereference in
                    irq_bypass_register_producer().</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Root
                    cause analysis:</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">When
                    the VM is powered off, vhost_dev_stop() is invoked
                    which in turn calls vhost_vdpa_reset_device()
                    causing the irq_bypass producers to be unregistered.</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">On
                    the next run, when qemu opens the vhost device, the
                    vhost_vdpa_open() file operation calls
                    vhost_dev_init(). Here, call_ctx-&gt;producer memory
                    is cleared in vhost_vring_call_reset().</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Further,
                    when the virtqueues are initialized by
                    vhost_virtqueue_init(), vhost_vdpa_setup_vq_irq()
                    again registers the irq_bypass producer for each
                    virtqueue. As the node member of struct
                    irq_bypass_producer is also initialized to zero,
                    traversal on the producers list causes crash due to
                    NULL pointer dereference.</p>
                </div>
              </blockquote>
              <p><br>
              </p>
              <p>Thanks a lot for reporting this issue.<br>
              </p>
              <p><br>
              </p>
              <blockquote type="cite">
                <div dir="ltr">
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Fix
                    details:</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">I
                    think that this issue can be fixed by invoking
                    vhost_vdpa_setup_vq_irq() only when
                    vhost_vdpa_set_status() includes
                    VIRTIO_CONFIG_S_DRIVER_OK in the new status value.
                    This way, there won’t be any stale nodes in the
                    irqbypass  module’s producers list which are reset
                    in vhost_vring_call_reset().</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Patch:</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">diff
                    --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
                    index 62a9bb0efc55..fdad94e2fbf9 100644</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">---
                    a/drivers/vhost/vdpa.c</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">+++
                    b/drivers/vhost/vdpa.c</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">@@
                    -409,7 +409,6 @@ static long
                    vhost_vdpa_vring_ioctl(struct vhost_vdpa *v,
                    unsigned int cmd,</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">                       
                    cb.private = NULL;</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">               
                    }</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">               
                    ops-&gt;set_vq_cb(vdpa, idx, &amp;cb);</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">-              
                    vhost_vdpa_setup_vq_irq(v, idx);</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">               
                    break;</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">       
                    case VHOST_SET_VRING_NUM: </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">We
                    can also track this issue in Bugzilla ticket 21171 (<a
href="https://bugzilla.kernel.org/show_bug.cgi?id=211711"
                      style="color:rgb(5,99,193)" target="_blank"
                      moz-do-not-send="true">https://bugzilla.kernel.org/show_bug.cgi?id=211711</a>) 
                    and the complete patch is attached with this email.</p>
                </div>
              </blockquote>
              <p><br>
              </p>
              <p>So vhost supports to remove or switch eventfd through
                vhost_vdpa_vring_ioctl(). So if userspace want to switch
                to another eventfd, we should re-do the register and
                unregister.</p>
            </div>
          </blockquote>
          <div>GD&gt;&gt;  This makes sense. I missed the use case where
            userspace may want to switch to a different eventfd.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This can happen when interrupt needs to be disabled for some
      reason (e.g MSI-X is masked).<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <p>I think we need to deal this issue in another way. Can
                we check whether or not the producer is initialized
                before?</p>
              <p>Thanks</p>
            </div>
          </blockquote>
          <div>GD&gt;&gt; Initialization path is fine but the actual
            problem lies in the clean-up part.</div>
          <div>I think the following check is the cause of this issue:</div>
          <div><br>
          </div>
          <div>static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)</div>
          <div>                <font color="#ff0000">if
              (vq-&gt;call_ctx.producer.irq)</font><br>
                                   
            irq_bypass_unregister_producer(&amp;vq-&gt;call_ctx.producer);<br>
          </div>
          <div> </div>
          <div>The above if condition will prevent the de-initialization
            of the producer nodes corresponding to irq 0 but 
            irq_bypass_unregister_producer() should be called for all
            valid irq values including zero.</div>
          <div><br>
          </div>
          <div>Accordingly, following patch is required to fix this
            issue:</div>
          <div><br>
          </div>
          <div>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
            index 62a9bb0efc55..d1c3a33c6239 100644<br>
            --- a/drivers/vhost/vdpa.c<br>
            +++ b/drivers/vhost/vdpa.c<br>
            @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct
            vhost_vdpa *v)<br>
            <br>
                    for (i = 0; i &lt; v-&gt;nvqs; i++) {<br>
                            vq = &amp;v-&gt;vqs[i];<br>
            -               if (vq-&gt;call_ctx.producer.irq)<br>
            +               if (vq-&gt;call_ctx.producer.irq &gt;= 0)<br>
                                   
            irq_bypass_unregister_producer(&amp;vq-&gt;call_ctx.producer);<br>
                    }<br>
             }<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>It should work, please post a formal patch for this.</p>
    <p>I will give more thought in the meanwhile since I spot some other
      defects on codes for irqbyass usage in vdpa.</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>The revised patch (bug211711_fix.patch) is also attached
            with this email.</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <blockquote type="cite">
                <div dir="ltr">
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"> </p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Regards,</p>
                  <p style="margin:0in 0in
                    0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Gautam
                    Dawar</p>
                </div>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------471C0B5386535DC49C10196D--


--===============3978342373511937860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3978342373511937860==--

