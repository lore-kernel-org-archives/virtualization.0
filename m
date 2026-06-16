Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD236C0C8
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620101; cv=none; b=qfTqeipRI7HT26LKkQJRFRh6L3HEmPmdngPhNWP0kDskf+B8Zv4pjiznEXiC4LtpYuve+nZZr9bhDZeXfiytL1DfxwxUVf8m80vfwmnWvMuDmECCUWuDSCBWPiMEGZAQltY6Ig9sgO1WWUJDtsC+BpZMiRWCwBeOy8f6ER01yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620101; c=relaxed/simple;
	bh=Mgo9D7i4SAm1ix+EblDUBSQHvAGRBPGGbt8S1ocsF40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sg+JgPbk8DWERiExQMogZtd7nSNHpe82wUSBqZg1XO/sDg91wd35CvUU4RhV3OhQvupVL51aoMrTL/W8uREP67GmulLtNpPI0JYbRVVccCumvm9vQE37VbAsTjTPMANR5xIq0oljj7RNzreWpLDOv6dLsYc07fWn8Hjyvn8JTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVgGzkTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVgGzkTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781620099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
	b=HVgGzkTmhHURXUO4qCbAe0LcvmHKJomiuv43Ciu6fm9LsUErRLq9fZ/BqTJcDVktvZZqQ1
	tcCDzvWlPeNImH0NtsuvHWwoELZK8AVF0B4KrpjbVUkfWvjznoY7cr5PKmpX+1xIjexTj+
	kLJqre1K3kiMCHWkIqZEMgch0j+pyCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Tz8KrkRHOr-8LlOKeBMj_Q-1; Tue, 16 Jun 2026 10:28:18 -0400
X-MC-Unique: Tz8KrkRHOr-8LlOKeBMj_Q-1
X-Mimecast-MFC-AGG-ID: Tz8KrkRHOr-8LlOKeBMj_Q_1781620097
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef4931de5so3399940f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620097; x=1782224897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
        b=Y5LCGQ7ao8hNrukLKC6ZBOfzX9MPfgasrZXyL5hgL0dShfl+KBF9vkXlqdyhLTRsQw
         nmrzPaYTPQvvh3O78//eLIxgF5W3U0oFyKv8BPy8BCDaWiZXx3kz4lmFv33D9/7D1ghG
         XN1MXPIrG3bMjTEAtlJb3FVu1v8IKDqR14LhdgsC2zPoxszgKWfY8voxxlKpWAGArPFA
         C5o5BKhwYlNA+HYdZGsIa5eAfRMQYDpgY1MCaKVhtgrrr9i8oJZ4fQQ+1RgIYIcWXPhC
         X2bmuCnCNN47O4AqNJ1bzT8CHMotVSI+Zsih3z9/ZvYc78NBssPW9+P06y6o4MEMm715
         tBbg==
X-Forwarded-Encrypted: i=1; AFNElJ9FIcDcP0RrpIrk6QCiR8hKMMoDRwO1evtI+rJnkiAR5N9Eoz1ae7Z1yTn6uQMwkq0RoIb4153kN9+HNy+2GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqsZ8f/COBfYHJ8QXniZr0C0tAfSVNY+ykNzGsws432QZrvL5k
	Prp6HWg849qWGZLCfqe1Z5jOfWgjrk/Skcxf53UzTtWUKsc/QxO6UIZBRp7KTtylfV0aUIztUv5
	BC6MqHprI8gHoxdaOapFHHrlRB1o4JLW8kEORZn7pMeVVnsQ3j9T70brv85NJ5HHfAMTZ
X-Gm-Gg: Acq92OF2TQF7uspP4hY7xTvN1efO/ezSvMjsXWHERN5NLXO/diAqtqsjfBfvhtnwpRb
	1/oy72EYix3jYwxG6j4+LMz5Igc65x5SG8Ac1RMdp8yrAsOS6QHERCPdfoTNc4VheQLwklZSk97
	gT5BV+sHZP2EBDAkb1Z/3TwsxIFEfYH57V13KuUFMzRoM1CwVtDXnSbTh/+M98huvxWhCmt2Hwr
	nZv1ZPNq+7kdNarRmSHliubG8HWLc7k/IPGayOxK+d18lDjQURcv+L1bsOI/uHY1SyrXXW+DkLm
	ej8UHChPqpP8/K8P8PPer3k+tdj5YGGLkEP2l6/DaryS5E8HU0OWZwPoyC3Ds8+AetXV0fG0vAl
	XP1Hm0J7bpAZOCbybZFn1TQVOgCXDnle1hexxPpAELmvEHrrdlad6Pf11g3zcyUBpqvFM7B8=
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47691455e9.0.1781620096497;
        Tue, 16 Jun 2026 07:28:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47690935e9.0.1781620095878;
        Tue, 16 Jun 2026 07:28:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9a399sm60380495e9.14.2026.06.16.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:28:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:28:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFdI921uj-nftA7@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <ajFLvKcT-A0wvLYW@sgarzare-redhat>
 <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9_8I3_nS1zZDhYEhlf4aEwOyXVQkH_E0-a5ZjXCNnDo_1781620097
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 16, 2026 at 05:01:34PM +0300, Andrey Drobyshev wrote:
>Hello Stefano,
>
>On 6/16/26 4:35 PM, Stefano Garzarella wrote:
>> Hi Andrey,
>> thanks for the series!
>>
>> On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>>> Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>>> outlive VM migration, since VM is moving to another host.  However
>>> there's a special case, which is QEMU live-update, or CPR
>>> (checkpoint-restore) migration.  In this case, VM remains on the same
>>> host, and we'd like such connections to persist.
>>
>> In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually
>> sent by the device after a migration.
>>
>> IIUC the specs don't say this has to be done all the time, so we don't
>> need to change anything in the specs, right?
>>
>> We just need to avoid sending it (which I think is what we're doing
>> here... I still need to look at the patches).
>>
>
>Sending this exact ioctl is guarded by one of my patches in the QEMU
>counterpart series:
>
>https://lore.kernel.org/qemu-devel/20260612165110.431376-6-andrey.drobyshev@virtuozzo.com/
>
>So we indeed avoid sending it on migration target in case of CPR migration.

Great, so we are aligned :-)

>
>>>
>>> For this to work, we need to be able to transfer device ownership from
>>> source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>>> issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>>> calling VHOST_SET_OWNER.
>>>
>>> Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>>> such implementation (patches 1-2).  Also fix regression introduced by
>>> the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).
>>
>> If it's a regression, should we fix it separately?
>>
>> Or is it related to this series?
>>
>
>Probably my wording wasn't quite correct.  I posted this patch here
>because we found the problem during testing this particular
>functionality, i.e. vsock data transfer + CPR migration.  And the
>problem was introduced by a recent commit, which is fine on its own, but
>breaks the CPR case.

Yeah, I figured out while reviewing the patch.
I'd avoid "regression" here and use just "issue", because at the end is 
just affecting this work that is not yet merged, so it can be a 
regression.

Thanks,
Stefano

