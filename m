Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F78C19F2D
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 06:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CF4941747;
	Thu,  4 Aug 2022 06:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CF4941747
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ATLFvBop
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4puGlAzrOeP; Thu,  4 Aug 2022 06:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EE23416E7;
	Thu,  4 Aug 2022 06:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EE23416E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65546C0033;
	Thu,  4 Aug 2022 06:39:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDE2FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA72281333
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA72281333
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ATLFvBop
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvNCCBU8g1lU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:39:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 024FA81331
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 024FA81331
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659595157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzJFqUFptmzBLAOZkpbZk/2bKIvrW3+QCnB0dMFjMm0=;
 b=ATLFvBophnjV2bZdwJ+POhiie+moa2OUKlJ+HpGE+Jg9osE7x6MAe/5EvxyfgfIrUqtOaw
 kgCUEsd+vlK+cm3WmOlXjuwUBrNfYs+62mW8bM+xZwLblGBn0MhKX34+JldHFi2QwPvDS2
 LELkClGV6ry2ItS6OtgpQw7PL85phXk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-eQDZ5ZBcOomKFmCWNP0NAw-1; Thu, 04 Aug 2022 02:39:15 -0400
X-MC-Unique: eQDZ5ZBcOomKFmCWNP0NAw-1
Received: by mail-ej1-f69.google.com with SMTP id
 go15-20020a1709070d8f00b00730ab9dd8c6so1405284ejc.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 23:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=dzJFqUFptmzBLAOZkpbZk/2bKIvrW3+QCnB0dMFjMm0=;
 b=Ir8UHmk/mi8kOA3APRlMPlg38+advtHqCMKOgGEC5+1LZssmzRQLfhkaYrYsi2x2u7
 KfaI8naIjbJ0RTGJzvv+VhKmuvVIo972OufAhd11ATkR/Q22R5veiVmhvcdC3TWXC63d
 s61NqZT9BNMazdUHaZzg8yuiavFoEJU90QW7bBRp2yQDapNgkOblA7VEl814VP0VZ6lg
 uzZOMZda0xYPs3NOPUBDDgG6OwnyBVkL05Rbol2Y4yuLLVyrSZ6VpUAL2BMWli3JltyA
 +AmtQblgyGidmVGhxyD0wLXDkAWEvfP5+T7F/5spMaE7XFId/Y+q/QUd6EKQujMFw1PO
 Z+xg==
X-Gm-Message-State: ACgBeo2+inAVktOkafo/XFQaD4Ubz0ugQhS8vF36xtIu/e3pYBigM4A8
 euFMm1lFWg8klng8eabPBkyez7c1zeZ8jp3I+kpbO5g+YHmxGsHhbQJuKi/QLKAYSQ+4JlNuFLU
 fO9TzHu+y6vMHJPPofL/gF83Qq3IEVrPSakGpiNzIsw==
X-Received: by 2002:a17:906:58d1:b0:72e:e049:cf00 with SMTP id
 e17-20020a17090658d100b0072ee049cf00mr303909ejs.361.1659595154799; 
 Wed, 03 Aug 2022 23:39:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ua492ME+yr+M+uCL9vZFBf9YzWUngYQNWbTr4yUxmffQpFePQ9NTUPrATFlQLBs3ZJz78hg==
X-Received: by 2002:a17:906:58d1:b0:72e:e049:cf00 with SMTP id
 e17-20020a17090658d100b0072ee049cf00mr303900ejs.361.1659595154598; 
 Wed, 03 Aug 2022 23:39:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 21-20020a170906301500b00730ad7c0d42sm1510490ejz.207.2022.08.03.23.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 23:39:14 -0700 (PDT)
Date: Thu, 4 Aug 2022 08:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: memory locking in vhost-vdpa
Message-ID: <20220804063911.c6w7f757yqnfep4u@sgarzare-redhat>
References: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
 <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
 virtualization <virtualization@lists.linux-foundation.org>, den@virtuozzo.com,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Aug 04, 2022 at 09:52:47AM +0800, Jason Wang wrote:
>On Thu, Aug 4, 2022 at 1:46 AM Andrey Zhadchenko
><andrey.zhadchenko@virtuozzo.com> wrote:
>>
>> Hi!
>>
>> Recently I sent vhost-blk patchset and Stefano suggested to instead join
>> efforts on developing vdpa-blk.
>> I played with it a bit and looks like vdpa itself pins the whole guest
>> memory. Is there a way to control it or reduce pinned amount to the
>> device pages?
>> Looks like even vdpa-sim requires all memory to be pinned [1]. Pinning
>> this much will surely impact guest density.
>
>It depends on the parent.
>
>When allocating the vDPA device, the parent can clams it supports
>virtual address then pinning is avoided:
>
>/**
> * __vdpa_alloc_device - allocate and initilaize a vDPA device
> * This allows driver to some prepartion after device is
> * initialized but before registered.
>...
> * @use_va: indicate whether virtual address must be used by this device
> */
>
>The only user so far is VDUSE which is a software parent in the
>userspace with a customized swiotlb for kernel drivers.
>
>Simulator came before this feature so we stick to the pinning method,

I based vdpa-blk PoC on the simulator and didn't realize this, maybe I 
should have used this.

>technically we can switch to use the va mode, but it might have some
>performance impact (mostly the copy_from|to_user()).

Would the cost be comparable to implementing a vhost-blk device? (IIRC 
vq in vhost uses copy_from/to_user, right?)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
