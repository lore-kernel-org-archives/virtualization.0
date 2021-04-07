Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB7C43460
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:38:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F606139E
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F606139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E49460BDA;
	Wed,  7 Apr 2021 07:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OzDnV5koLvBs; Wed,  7 Apr 2021 07:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03BC460633;
	Wed,  7 Apr 2021 07:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBBABC000C;
	Wed,  7 Apr 2021 07:38:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEAE6C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91E47405B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1_ER2ZAfLDR6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:38:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0DF9400BF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617781107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3F/RC/fvqCURdl1YYUj40I8I1hZvQBl3Hi/4LGAyDow=;
 b=c2ximdUace7Dn+vcQVwgn43tAO4gOG8+eRsynxCym4SDulEw/xqcLv0LHZ/S83dG5ZlrA0
 hUlMufPWOqJpXvcUtnRd2YgQhIoqCV+sl2EJchR26EkqLq3H25X6b8v/QTn7Aq7kiMt79B
 ZqNq2CAEl5jyJin8wkqdU5GJ4GO1cMw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-NKAmyXBkMueMVudRINXlVw-1; Wed, 07 Apr 2021 03:38:24 -0400
X-MC-Unique: NKAmyXBkMueMVudRINXlVw-1
Received: by mail-ej1-f71.google.com with SMTP id bn26so6506892ejb.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 00:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=3F/RC/fvqCURdl1YYUj40I8I1hZvQBl3Hi/4LGAyDow=;
 b=TQdjbu4PBzQFQFohpKzNOBtk0qtr4rz4JJKQ9OFEQoS9RzrYSAQED5KM4QzuYx1c+g
 Tp9vNvDlyfqESFLdjPIQ2NjBwz1BvkkyIZf/S9N8odgP5Mb/QbRRaf3YW9GUZJcfnX2S
 /6yN7+W8sT4qkCTPuD9kNoX4H+kuH99jVRMOYB4K5pIh5hEOC5AJWrnWQ0cN7+xnHO9v
 Eqbr/6X2/UCk93r0SGU5jrxZsq+6zWI3PiM1c0TqokpEBXBVUxB80/rhb5H9yzTuH30x
 5YaH0OgVFl22ocv22PY1JNWBkksV0PoWd0RsS0oq8yRST4hAw0dIAtZKmwuFwpO5Mr6n
 afpA==
X-Gm-Message-State: AOAM530xodfBD7yemp4X+PpBTEBICnNlPV+tWjVeMupz1nyPAzpRxLcZ
 vC7MnpFexMf2AuYLsXGj8iuHDwp2GvMdHmGlIvgbMEF4llP8uzcMVIZe1qne9nkOAFf/3Evd2aa
 w0tfJy4yATjB2zoH8+q9hm4mHHSmhQyUpC+4tOdZubg==
X-Received: by 2002:a17:907:9611:: with SMTP id
 gb17mr2237668ejc.325.1617781102975; 
 Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWJdCKOu9XXc7E7scSIAweJhXQCEIOBw2LgfiKIY6UeG+NZrHwNBKvBNLJ+ltcbeg03BcDgQ==
X-Received: by 2002:a17:907:9611:: with SMTP id
 gb17mr2237651ejc.325.1617781102784; 
 Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id bo19sm8418004edb.17.2021.04.07.00.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
Date: Wed, 07 Apr 2021 09:38:21 +0200
Message-ID: <87eefmczo2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.liu@kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 sunilmut@microsoft.com, virtualization@lists.linux-foundation.org,
 viremana@linux.microsoft.com, ligrassi@microsoft.com
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

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> On 3/5/2021 1:18 AM, Vitaly Kuznetsov wrote:
>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>> 
>>> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
>>>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>>>>
>> ...
>>>>> +
>>>>> +3.1 MSHV_REQUEST_VERSION
>>>>> +------------------------
>>>>> +:Type: /dev/mshv ioctl
>>>>> +:Parameters: pointer to a u32
>>>>> +:Returns: 0 on success
>>>>> +
>>>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
>>>>> +establish the interface version with the kernel module.
>>>>> +
>>>>> +The caller should pass the MSHV_VERSION as an argument.
>>>>> +
>>>>> +The kernel module will check which interface versions it supports and return 0
>>>>> +if one of them matches.
>>>>> +
>>>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>>>> +it is open - this ioctl can only be called once per open.
>>>>> +
>>>>
>>>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
>>>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
>>>> instead.
>>>>
>>>
>>> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
>>> When we add new features/ioctls beyond the core we can use an extension/capability
>>> approach like KVM.
>>>
>> 
>> Driver versions is a very bad idea from distribution/stable kernel point
>> of view as it presumes that the history is linear. It is not.
>> 
>> Imagine you have the following history upstream:
>> 
>> MSHV_REQUEST_VERSION = 1
>> <100 commits with features/fixes>
>> MSHV_REQUEST_VERSION = 2
>> <another 100 commits with features/fixes>
>> MSHV_REQUEST_VERSION = 2
>> 
>> Now I'm a linux distribution / stable kernel maintainer. My kernel is at
>> MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
>> VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
>> history now looks like
>> 
>> MSHV_REQUEST_VERSION = 1
>> <5 commits from between VER=1 and VER=2>
>>    Which version should I declare here???? 
>> <5 commits from between VER=2 and VER=3>
>>    Which version should I declare here???? 
>> 
>> If I keep VER=1 then userspace will think that I don't have any extra
>> features added and just won't use them. If I change VER to 2/3, it'll
>> think I have *all* features from between these versions.
>> 
>> The only reasonable way to manage this is to attach a "capability" to
>> every ABI change and expose this capability *in the same commit which
>> introduces the change to the ABI*. This way userspace will now exactly
>> which ioctls are available and what are their interfaces.
>> 
>> Also, trying to define "core set" is hard but you don't really need
>> to.
>> 
>
> We've had some internal discussion on this.
>
> There is bound to be some iteration before this ABI is stable, since even the
> underlying Microsoft hypervisor interfaces aren't stable just yet.
>
> It might make more sense to just have an IOCTL to check if the API is stable yet.
> This would be analogous to checking if kVM_GET_API_VERSION returns 12.
>
> How does this sound as a proposal?
> An MSHV_CHECK_EXTENSION ioctl to query extensions to the core /dev/mshv API.
>
> It takes a single argument, an integer named MSHV_CAP_* corresponding to
> the extension to check the existence of.
>
> The ioctl will return 0 if the extension is unsupported, or a positive integer
> if supported.
>
> We can initially include a capability called MSHV_CAP_CORE_API_STABLE.
> If supported, the core APIs are stable.

This sounds reasonable, I'd suggest you reserve MSHV_CAP_CORE_API_STABLE
right away but don't expose it yet so it's clear the API is not yet
stable. Test userspace you have may always assume it's running with the
latest kernel.

Also, please be clear about the fact that /dev/mshv doesn't
provide a stable API yet so nobody builds an application on top of
it.

One more though: it is probably a good idea to introduce selftests for
/dev/mshv (similar to KVM's selftests in
/tools/testing/selftests/kvm). Selftests don't really need a stable ABI
as they live in the same linux.git and can be updated in the same patch
series which changes /dev/mshv behavior. Selftests are very useful for
checking there are no regressions, especially in the situation when
there's no publicly available userspace for /dev/mshv.

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
