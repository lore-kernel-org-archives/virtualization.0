Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96D1C84C0
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672805; cv=none; b=Qpg/mMs5kSrdTfO3U+XGC5JJC4hEXYiWUwhrd2Tg94XYVdQnWj/ixojyx7wmMsh/jUgfMx2fBTFhlxIFuczs/CvqIyX4yjG3/4zp3ZJvN1Hdj3RmafQSW2H23nGCex5mf8dxBCY3jipQC68MPDRJRi0zTTmZ0Wb+1srWfIeQ6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672805; c=relaxed/simple;
	bh=LH9g7+QOO+5iyOXAKlu6xac6HnVSx+io/5yzLBo5fnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SddwfO3HGzZBitK9Hf5feFr8Oal67MKI1VtWdS5BeIQocn0bMUSB7ueV4/hIOJiTp1qtaf7iA1t2AGsXsEjimzRIf3Q5TiNgtUFLkCsum5AEoxgNRXOuVxKj+rIQdiaMWYdAGLybUiMfmbOoQhIcs/iXslJ/lj+/Rb56IZB+Z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmJncrsy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmJncrsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743672802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sThZhr8FIHFH8ocyys2dja74pOa3boFKyAWA+JFfOI=;
	b=QmJncrsyu8I5xAklFuwWqm+L7MjOQlEUetltPFfO/9xWbT7J6H1tFqPUxgi49+t01E6NtO
	K9DRtsMOZFyUIk+buRmH6W5V3G2vFZYbtWoK/SdeJjYc3R6biQtHkLO0bhVSOsFALSxTvG
	6sWLdmUEF1mK7tPlVPfk1epi2EaUy8M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Ws8FZnW8MJmGl9ZchSFLZA-1; Thu, 03 Apr 2025 05:33:21 -0400
X-MC-Unique: Ws8FZnW8MJmGl9ZchSFLZA-1
X-Mimecast-MFC-AGG-ID: Ws8FZnW8MJmGl9ZchSFLZA_1743672800
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so299327f8f.2
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 02:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743672800; x=1744277600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sThZhr8FIHFH8ocyys2dja74pOa3boFKyAWA+JFfOI=;
        b=DaFDadG+kp8yhYRzI5TogYSfLlo0MHZ1rHErJm1+SgZxBTp7IdlV8LkNT8OQzRyrWu
         5zP3h01zevs9BnUZ3jqHbYi1OWSUTkImOOXnW3ZB3f7nqyiaUrrKzSGQLi+m6W55qcnd
         AysH5vCYijt+pYPpNVrq89qhacPOsouWu4a6xzzhcm2dD5xx056BWwF/S+ZC5cC79cVo
         0O2k5ItP1CDXXiOwO6bMa1x9zVcaa3QhnQYGSYQ59/1AE9xQ8g8Yyi4nKVxVQLjIhsuF
         a3/4x33Bw14NE1CL2Js6H5HFtY3J4rr/ucmC3qynNR44Z/kXyj/hAYr8pwhs765x8DeX
         dtiA==
X-Forwarded-Encrypted: i=1; AJvYcCWyxg5mjHeUtYeUXeLx0n/Fnj8sb4ApK3lMSMwdi7pbD+ICZzu6NzAtHa2EzwFSr4ZtiCYli/8vLS3pO37P0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBKLXznyQ7OBKQ9XUh+tAKsyig2IjPMzz+o7RxBaXpCbpI5Igr
	Ei1QVdAzvw8S2R73WynsQnU/5lzXYhwfJtuX+8svjoZg7Pt7+YHYqoaTwSav3LCbWNE8lAH9q61
	7nUSodI6CVocdoXByZPrjMDTImEhmhlVGGaV1CApA4OicS1dI4Cg+YFnQ4ydTKPmv
X-Gm-Gg: ASbGncu8KjD6KF3aNzijy+mL7X42dQxIiKaYt3+ZpehSI1SCiHsbdt0LnwXoRtSPQhp
	ryNfZ006knbVqg/c3Me99W6qkQFhctQ9xCjbhNEInRLqJmbKlit+lSz2ft3+uoy0imIojX+44mN
	HBiiCdqHmYvehSM5D8vQLvLc9IOUUGopnp45b+v2ZNt4+IVgXc7R6J4c3jILwUNorCfD/oznPnF
	N0/3LVhSpGizzBsLI6031CbNs8jYOwBqgIqT3LkRjTVrGhaomAmB6RCzVx54Tj9EB2iqLFtGHnL
	RgSwYbF02nQn5R8PhnC2q2YYgfmqf0rn0IA+FgwhQ4AcfwZuFj4hMBdEweI=
X-Received: by 2002:a5d:59a9:0:b0:397:8f09:600 with SMTP id ffacd0b85a97d-39c120dc885mr17363641f8f.13.1743672800203;
        Thu, 03 Apr 2025 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4vxZl4LLon5hCph3Xcs7lAFUmmbHfNQzzEHDWPTgxlqRHCfjkIkKq1EFJXLE6RtiycnXaaQ==
X-Received: by 2002:a5d:59a9:0:b0:397:8f09:600 with SMTP id ffacd0b85a97d-39c120dc885mr17363594f8f.13.1743672799604;
        Thu, 03 Apr 2025 02:33:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7586sm1307915f8f.38.2025.04.03.02.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 02:33:19 -0700 (PDT)
Date: Thu, 3 Apr 2025 11:33:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <4c2xz3xhpdjvb6jmdw7ctsebpza5lcs4gevr5wlwwyt64usr2i@o5qt2msfyvvw>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
 <Z-0BoF4vkC2IS1W4@redhat.com>
 <Z+23pbK9t5ckSmLl@devvm6277.cco0.facebook.com>
 <Z+26A3sslT+w+wOI@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z+26A3sslT+w+wOI@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zwhBuK5nUinfi45vegpWKHm1w1LX8uPpyz39vzgElV0_1743672800
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 02, 2025 at 03:28:19PM -0700, Bobby Eshleman wrote:
>On Wed, Apr 02, 2025 at 03:18:13PM -0700, Bobby Eshleman wrote:
>> On Wed, Apr 02, 2025 at 10:21:36AM +0100, Daniel P. Berrangé wrote:
>> > On Wed, Apr 02, 2025 at 10:13:43AM +0200, Stefano Garzarella wrote:
>> > > On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>> > > >
>> > > > I do like Stefano's suggestion to add a sysctl for a "strict" mode,
>> > > > Since it offers the best of both worlds, and still tends conservative in
>> > > > protecting existing applications... but I agree, the non-strict mode
>> > > > vsock would be unique WRT the usual concept of namespaces.
>> > >
>> > > Maybe we could do the opposite, enable strict mode by default (I think
>> > > it was similar to what I had tried to do with the kernel module in v1, I
>> > > was young I know xD)
>> > > And provide a way to disable it for those use cases where the user wants
>> > > backward compatibility, while paying the cost of less isolation.
>> >
>> > I think backwards compatible has to be the default behaviour, otherwise
>> > the change has too high risk of breaking existing deployments that are
>> > already using netns and relying on VSOCK being global. Breakage has to
>> > be opt in.
>> >
>> > > I was thinking two options (not sure if the second one can be done):
>> > >
>> > >   1. provide a global sysfs/sysctl that disables strict mode, but this
>> > >   then applies to all namespaces
>> > >
>> > >   2. provide something that allows disabling strict mode by namespace.
>> > >   Maybe when it is created there are options, or something that can be
>> > >   set later.
>> > >
>> > > 2 would be ideal, but that might be too much, so 1 might be enough. In
>> > > any case, 2 could also be a next step.
>> > >
>> > > WDYT?
>> >
>> > It occured to me that the problem we face with the CID space usage is
>> > somewhat similar to the UID/GID space usage for user namespaces.
>> >
>> > In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
>> > allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.
>> >
>> > At the risk of being overkill, is it worth trying a similar kind of
>> > approach for the vsock CID space ?
>> >
>> > A simple variant would be a /proc/net/vsock_cid_outside specifying a set
>> > of CIDs which are exclusively referencing /dev/vhost-vsock associations
>> > created outside the namespace. Anything not listed would be exclusively
>> > referencing associations created inside the namespace.
>> >
>> > A more complex variant would be to allow a full remapping of CIDs as is
>> > done with userns, via a /proc/net/vsock_cid_map, which the same three
>> > parameters, so that CID=15 association outside the namespace could be
>> > remapped to CID=9015 inside the namespace, allow the inside namespace
>> > to define its out association for CID=15 without clashing.
>> >
>> > IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
>> > associations created outside namespace, while unmapped CIDs would be
>> > exclusively referencing /dev/vhost-vsock associations inside the
>> > namespace.
>> >
>> > A likely benefit of relying on a kernel defined mapping/partition of
>> > the CID space is that apps like QEMU don't need changing, as there's
>> > no need to invent a new /dev/vhost-vsock-netns device node.
>> >
>> > Both approaches give the desirable security protection whereby the
>> > inside namespace can be prevented from accessing certain CIDs that
>> > were associated outside the namespace.
>> >
>> > Some rule would need to be defined for updating the /proc/net/vsock_cid_map
>> > file as it is the security control mechanism. If it is write-once then
>> > if the container mgmt app initializes it, nothing later could change
>> > it.
>> >
>> > A key question is do we need the "first come, first served" behaviour
>> > for CIDs where a CID can be arbitrarily used by outside or inside namespace
>> > according to whatever tries to associate a CID first ?
>>
>> I think with /proc/net/vsock_cid_outside, instead of disallowing the CID
>> from being used, this could be solved by disallowing remapping the CID
>> while in use?
>>
>> The thing I like about this is that users can check
>> /proc/net/vsock_cid_outside to figure out what might be going on,
>> instead of trying to check lsof or ps to figure out if the VMM processes
>> have used /dev/vhost-vsock vs /dev/vhost-vsock-netns.

Yes, although the user in theory should not care about this information,
right?
I mean I don't even know if it makes sense to expose the contents of
/proc/net/vsock_cid_outside in the namespace.

>>
>> Just to check I am following... I suppose we would have a few typical
>> configurations for /proc/net/vsock_cid_outside. Following uid_map file
>> format of:
>> 	"<local cid start>		<global cid start>		<range size>"

This seems to relate more to /proc/net/vsock_cid_map, for
/proc/net/vsock_cid_outside I think 2 parameters are enough
(CID, range), right?

>>
>> 	1. Identity mapping, current namespace CID is global CID (default
>> 	setting for new namespaces):
>>
>> 		# empty file
>>
>> 				OR
>>
>> 		0    0    4294967295
>>
>> 	2. Complete isolation from global space (initialized, but no mappings):
>>
>> 		0    0    0
>>
>> 	3. Mapping in ranges of global CIDs
>>
>> 	For example, global CID space starts at 7000, up to 32-bit max:
>>
>> 		7000    0    4294960295
>> 	
>> 	Or for multiple mappings (0-100 map to 7000-7100, 1000-1100 map to
>> 	8000-8100) :
>>
>> 		7000    0       100
>> 		8000    1000    100
>>
>>
>> One thing I don't love is that option 3 seems to not be addressing a
>> known use case. It doesn't necessarily hurt to have, but it will add
>> complexity to CID handling that might never get used?

Yes, as I also mentioned in the previous email, we could also do a
step-by-step thing.

IMHO we can define /proc/net/vsock_cid_map (with the structure you just
defined), but for now only support 1-1 mapping (with the ranges of
course, I mean the first two parameters should always be the same) and
then add option 3 in the future.

>>
>> Since options 1/2 could also be represented by a boolean (yes/no
>> "current ns shares CID with global"), I wonder if we could either A)
>> only support the first two options at first, or B) add just
>> /proc/net/vsock_ns_mode at first, which supports only "global" and
>> "local", and later add a "mapped" mode plus /proc/net/vsock_cid_outside
>> or the full mapping if the need arises?

I think option A is the same as I meant above :-)

>>
>> This could also be how we support Option 2 from Stefano's last email of
>> supporting per-namespace opt-in/opt-out.

Hmm, how can we do it by namespace? Isn't that global?

>>
>> Any thoughts on this?
>>
>
>Stefano,
>
>Would only supporting 1/2 still support the Kata use case?

I think so, actually I was thinking something similar in the message I 
just sent.

By default (if the file is empty), nothing should change, so that's fine 
IMO. As Paolo suggested, we absolutely have to have tests to verify 
these things.

Thanks,
Stefano

