Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC8C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 11:13:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D7A613CD
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 11:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D7A613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BA9C6073D;
	Wed,  5 May 2021 11:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eEcskrowDq3T; Wed,  5 May 2021 11:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED12460750;
	Wed,  5 May 2021 11:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B181C000E;
	Wed,  5 May 2021 11:13:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E47BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 11:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44FDA846D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 11:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sNM8Ow9Ikzj3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 11:13:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B658846CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620213190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPALnr89GrrNPipFf70hI/gT3uVKeV7eDIU5NDFn3Kw=;
 b=edda5GvaS23OkvBLou0Xeog/G/422UtYE+xQpJ7rU8DeKwwODmqq5nKHJwdZYelUhjQutM
 +O3/4t1tiJXURCEoIbKl0Y0rlmI/Zymdrrc+BXm9tZzNpGQRaF6Nx+ngRRX82nDWeN8r+Z
 ePJ+hb3ukC9roU9YqJSjYTvdWNZuANg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Gf41Cu9RO2u3N4SUL3osKw-1; Wed, 05 May 2021 07:13:08 -0400
X-MC-Unique: Gf41Cu9RO2u3N4SUL3osKw-1
Received: by mail-ej1-f72.google.com with SMTP id
 ji8-20020a1709079808b029037c921a9ea0so312793ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 04:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XPALnr89GrrNPipFf70hI/gT3uVKeV7eDIU5NDFn3Kw=;
 b=Cm46bAcW7wn4GdM0i7yezE8KLBD68mUkkdsaxFWv8rqejkFFYPZFwEIgMOgMiT7WcU
 /Pz4fVy5TMYehXu6WBQmCdmLtg6TeH7Kw3o0VqRwx5IUbD7X5yXJMuOqLMvoKz+Y1r5w
 BmmZa8+4Fh19BXMtQAieBEpU/PExA4IcegKxqdWIPAaoJMF98zyyCks+Fjj4c5SPWuF2
 xlnIjr0EXWpZH0vB0nFycewCrQkIIjP2nJGBU+ujmKjUvMi6Oh6Gds179karKj++UlRx
 dB74d3O17z6KfB3RTQv23Ag0sWryGKAMsxarjrwDpljdJjeGlI4xgXTPiGTc29XpEG85
 Hz/w==
X-Gm-Message-State: AOAM533nY5NYRvECnfL8Upz3iDya/a7wq7t1vrOJif8pNpmpmQvnJk6U
 n2lPwgcaLKvv3YxRdnQT4J35oR/3Fgb/6PG9U38G9dpobv8ctIn7fhoB1ROQ1dETH6KAkom/Nq2
 g3W5Ix5PfyhMgB2oSH6bYEIHL0cs3nFTRKtx50IgcHg==
X-Received: by 2002:a05:6402:1c0d:: with SMTP id
 ck13mr31718139edb.170.1620213187291; 
 Wed, 05 May 2021 04:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpv+gNja7lGzyufRem7wffB1L2yHnjivsLAL3Qpoe+z836cNGONrIIbxWmWM/0TD5MZrB3hw==
X-Received: by 2002:a05:6402:1c0d:: with SMTP id
 ck13mr31718113edb.170.1620213187057; 
 Wed, 05 May 2021 04:13:07 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id nd36sm2623101ejc.21.2021.05.05.04.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 04:13:06 -0700 (PDT)
Date: Wed, 5 May 2021 13:13:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH RFC 00/14] vhost: multiple worker support
Message-ID: <20210505111304.mwjj4pxteqctunws@steredhat>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210504155606.mlkg7ydwbli56xqu@steredhat>
 <4208135d-f95a-3df6-0d8a-51dbdee0bd0b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4208135d-f95a-3df6-0d8a-51dbdee0bd0b@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

On Tue, May 04, 2021 at 03:11:37PM -0500, Mike Christie wrote:
>On 5/4/21 10:56 AM, Stefano Garzarella wrote:
>> Hi Mike,
>>
>> On Wed, Apr 28, 2021 at 05:36:59PM -0500, Mike Christie wrote:
>>> The following patches apply over mst's vhost branch and were tested
>>> againt that branch and also mkp's 5.13 branch which has some vhost-scsi
>>> changes.
>>>
>>> These patches allow us to support multiple vhost workers per device. I
>>> ended up just doing Stefan's original idea where userspace has the
>>> kernel create a worker and we pass back the pid. This has the benefit
>>> over the workqueue and userspace thread approach where we only have
>>> one'ish code path in the kernel.
>>>
>>> The kernel patches here allow us to then do N workers device and also
>>> share workers across devices.
>>
>> I took a first look and left a few comments.
>>
>> In general it looks good to me, I'm just worried if it's okay to use the kthread pid directly or it's better to use an internal id.
>>
>> For example I think if this can be affected by the pid namespaces or 
>> some security issues.
>> I admit I don't know much about this topic, so this might be silly.
>>
>
>Ah yeah, that was my other TODO. I did the lazy loop and left the
>"hash on pid" TODO in patch 11 because I was not sure. I thought it
>was ok, because only the userspace process that does the
>VHOST_SET_OWNER call can do the other ioctls.

Oh I see.

>
>I can do pid or use a xarray/ida/idr type if struct and pass that
>id between user/kernel space if it's preferred.
>

Let's see what others say, it was just a doubt I had while looking at 
the patches.

>
>>>
>>> I included a patch for qemu so you can get an idea of how it works.
>>>
>>> TODO:
>>> -----
>>> - polling
>>> - Allow sharing workers across devices. Kernel support is added and I
>>> hacked up userspace to test, but I'm still working on a sane way to
>>> manage it in userspace.
>>> - Bind to specific CPUs. Commands like "virsh emulatorpin" work with
>>> these patches and allow us to set the group of vhost threads to different
>>> CPUs. But we can also set a specific vq's worker to run on a CPU.
>>> - I'm handling old kernel by just checking for EPERM. Does this require
>>> a feature?
>>
>> Do you mean when the new ioctls are not available? We do not return ENOIOCTLCMD?
>vhost_vring_ioctl returns -ENOIOCTLCMD but that does not get propagated to the app.
>Check out the comment in include/linux/errno.h and 
>fs/ioctl.c:vfs_ioctl() where
>-ENOIOCTLCMD is caught and -ENOTTY is returned.

Ah right!

>
>To make this reply a little complicated note that at the time when I wrote the code
>I thought something was translating -ENOTTY to -EPERM but then after posting I
>realized that ioctl() always returns -1 on error (I thought the -1 was a -EPERM
>from the kernel). errno is set to -ENOTTY as expected when a ioctl is not
>implemented, so the -EPERM references should be errno and -ENOTTY.
>

Thanks for the clarification.

However looking better maybe it would make sense to add a new 
VHOST_BACKEND_F_* feature bit for this functionality since we are adding 
2 new ioctls to use together.

I saw that we used the VHOST_BACKEND_F_* only for the new IOTLB 
features, so maybe for this functionality the error returned by ioctl() 
could be enough. Let's see what others think.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
