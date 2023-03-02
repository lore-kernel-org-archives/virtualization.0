Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A0C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5431260C12;
	Thu,  2 Mar 2023 15:48:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5431260C12
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGZmsXDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk-RuSnihlnI; Thu,  2 Mar 2023 15:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A98A460BAC;
	Thu,  2 Mar 2023 15:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A98A460BAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC4FC0035;
	Thu,  2 Mar 2023 15:48:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA5AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 15:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1304541045
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 15:48:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1304541045
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGZmsXDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Dj2-Z1-6QhL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 15:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20EF440352
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20EF440352
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677772099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07sLndxtEbNcERZvee6i0lRr3/Y/p7RWfWIjrJTakUw=;
 b=DGZmsXDFAlzQVeozyjSTr27NJVcys46eUQg3WM+r2gMQCC8DyQqG46pjIzFL8FnVxkT97f
 87yMZ7q1TuLZuH1vw/sreJUyDlV2laE9QWlbnnkOv7yHo4qpV4+8Ej/gWHz91G933Bsdvm
 XWScgiVB3+BsfyeKbOT6aBpTjwr0sk0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-GDjEi8WdOXyC0FqBnGLfuQ-1; Thu, 02 Mar 2023 10:48:13 -0500
X-MC-Unique: GDjEi8WdOXyC0FqBnGLfuQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 m15-20020adfa3cf000000b002be0eb97f4fso3284236wrb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 07:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677772084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07sLndxtEbNcERZvee6i0lRr3/Y/p7RWfWIjrJTakUw=;
 b=VgP5G4mCxWRxBmePRH+N2GhtAxOGkOCKkaNw/U0XJ7tKb75tPyxODXkdLfSmrToLNt
 pV8HDPSgSiAo4ULU2HG8hAocsqjL6Lbmatd8NkeuUaniyEGSj9ON/ViZiMwkjMWtEVMq
 CqY6sU4pQW9V8+GN6l29BNhkDVuMLxWhdfZtpXFSC4GeHoDRXI9cd1tiVpAawvHOgCfs
 +qfJrJAaIHyRG2XJCpz72JVJqKnNw/7TQPCCe9+zkvyFrkilQNUHd9Z7TLTnWM6hOomi
 0Rbz8OLzONLZ+sPJpH3B/k209so1f+6qpLLCJbgLpX0ZMAyWdksokE7qWOfIQWv5AIz7
 JQDw==
X-Gm-Message-State: AO0yUKVkiARHlg8xWXadKWHwKgZ2p7OkVBPMTSPXVHiXID976UfcVfFa
 uLdfvNv0xut/XiH7XcK/owvrIXrDU6lnrCFIJ6mep1U3TtIgWEH+rTwQG17x1Byj5PLXOQZJV/E
 +SNgqSRyB97mC0Pr+/jhWza2sMeu+G0LxwgHzsMYAyw==
X-Received: by 2002:a05:6000:1a42:b0:2c3:be89:7c2a with SMTP id
 t2-20020a0560001a4200b002c3be897c2amr1809000wry.13.1677772084120; 
 Thu, 02 Mar 2023 07:48:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/EzktI0OlHucSuQTWKTKC3fqx8GzoJhXbuJEu5Rqstra/4hZCkq7D6l1IWXwedBvmq/luXbw==
X-Received: by 2002:a05:6000:1a42:b0:2c3:be89:7c2a with SMTP id
 t2-20020a0560001a4200b002c3be897c2amr1808989wry.13.1677772083843; 
 Thu, 02 Mar 2023 07:48:03 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a7bc392000000b003eb20d4d4a8sm3202128wmj.44.2023.03.02.07.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 07:48:03 -0800 (PST)
Date: Thu, 2 Mar 2023 16:48:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 6/8] vdpa_sim: use kthread worker
Message-ID: <20230302154800.z3i4fpjlvtb74efu@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-7-sgarzare@redhat.com>
 <ZADA/GgpbDoi+SzU@corigine.com>
MIME-Version: 1.0
In-Reply-To: <ZADA/GgpbDoi+SzU@corigine.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

On Thu, Mar 02, 2023 at 04:30:04PM +0100, Simon Horman wrote:
>On Thu, Mar 02, 2023 at 12:34:19PM +0100, Stefano Garzarella wrote:
>> Let's use our own kthread to run device jobs.
>> This allows us more flexibility, especially we can attach the kthread
>> to the user address space when vDPA uses user's VA.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 ++++++++++++-----
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> index acee20faaf6a..ce83f9130a5d 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> @@ -57,7 +57,8 @@ struct vdpasim_dev_attr {
>>  struct vdpasim {
>>  	struct vdpa_device vdpa;
>>  	struct vdpasim_virtqueue *vqs;
>> -	struct work_struct work;
>> +	struct kthread_worker *worker;
>> +	struct kthread_work work;
>>  	struct vdpasim_dev_attr dev_attr;
>>  	/* spinlock to synchronize virtqueue state */
>>  	spinlock_t lock;
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index a6ee830efc38..6feb29726c2a 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -11,8 +11,8 @@
>>  #include <linux/module.h>
>>  #include <linux/device.h>
>>  #include <linux/kernel.h>
>> +#include <linux/kthread.h>
>>  #include <linux/slab.h>
>> -#include <linux/sched.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/vringh.h>
>>  #include <linux/vdpa.h>
>> @@ -116,7 +116,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
>>  static const struct vdpa_config_ops vdpasim_config_ops;
>>  static const struct vdpa_config_ops vdpasim_batch_config_ops;
>>
>> -static void vdpasim_work_fn(struct work_struct *work)
>> +static void vdpasim_work_fn(struct kthread_work *work)
>>  {
>>  	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>>
>> @@ -159,7 +159,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>>
>>  	vdpasim = vdpa_to_sim(vdpa);
>>  	vdpasim->dev_attr = *dev_attr;
>> -	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
>> +
>> +	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
>> +	vdpasim->worker = kthread_create_worker(0, "vDPA sim worker: %s",
>> +						dev_attr->name);
>> +	if (IS_ERR(vdpasim->worker))
>> +		goto err_iommu;
>
>Branching to err_iommu will result in a call to put_device(dev)...

Good catch!

>
>> +
>>  	spin_lock_init(&vdpasim->lock);
>>  	spin_lock_init(&vdpasim->iommu_lock);
>
>... but dev is not initialised until the line following this hunk,
>which is:
>
>	dev = &vdpasim->vdpa.dev;
>
>In order to avoid leaking dev I _think_ the correct approach
>is to move the initialisation of dev above the branch to
>err_iommu, perhaps above the call to kthread_init_work()
>is a good place.

Yep, I agree. I'll fix in v3.

Thanks,
Stefano

>
>This does move the assignment outside the locks above.
>But I _think_ that is ok.
>
>> @@ -212,7 +218,7 @@ EXPORT_SYMBOL_GPL(vdpasim_create);
>>
>>  void vdpasim_schedule_work(struct vdpasim *vdpasim)
>>  {
>> -	schedule_work(&vdpasim->work);
>> +	kthread_queue_work(vdpasim->worker, &vdpasim->work);
>>  }
>>  EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
>>
>> @@ -612,7 +618,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>  	int i;
>>
>> -	cancel_work_sync(&vdpasim->work);
>> +	kthread_cancel_work_sync(&vdpasim->work);
>> +	kthread_destroy_worker(vdpasim->worker);
>>
>>  	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
>>  		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
>> --
>> 2.39.2
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
