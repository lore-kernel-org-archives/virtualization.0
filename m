Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FD1E531
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710263; cv=none; b=A9j9Ea0xuURxHAdIS7m3/v1AZTQ558V2KIQrM6+1tuRGuz8BrsjnP556eM6WC9Bqe28uEhnO5KKq4Tp8rmzsj1ozvEiuy6WLID+dhlYMA9v/vl/Igjw8D0eLWF0/mWP7A/FUFFR9+DON2vROAgLF8aM+APzQxHw9zwCM7M50OMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710263; c=relaxed/simple;
	bh=RIhfOzVcXIy7+AwNsdNPGSuaq68Hqj9Gr8kJENzAlEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEqymoral4Dm3uZEkLIft8w4iApMOs10GBxgr9uqZZ1B9nnoB3WQAUsGNd8waji2YXaM6/10zOhnclP0luOZ8RaiJON5B7JTAu7Gz5goz+RxawO1SUfwS5cUMdyfrDcZonYYmJgE53nOO5gCJLyReou5DM3/ONyVuCrkShAXQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyyHk6nK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyyHk6nK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
	b=ZyyHk6nKqLBrpjlf2RZmBI+H/oayek+7lixLSWlgscLGV7ktcJiNwhKk/CihL6MRAnH1zh
	YtIe4e1IIMAyg9Cr8nXqYcj0dwUto8TFG9hAqs4QJsjomQ7btEk5xIO3ew2xKKdmAJuoOw
	TXPhlAPn1Fe+SVRLrwUcCuibsTYLBHA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Agj4_OLHP5SEiJLBL5HnNA-1; Thu, 11 Jul 2024 11:04:18 -0400
X-MC-Unique: Agj4_OLHP5SEiJLBL5HnNA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea96517a6so1227795e87.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710257; x=1721315057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
        b=wAFwY/nqVtbwFL5PddzW32nNI+UAPGexGzQy42VN20k1MAhsty3zGp4+xIQ+eIlfD+
         UwC7S8tdWus/5BeWW8O8tIZH0SIhL8+Xw108KnclJEg7pa/lx5JECJviuDpTnDxkXAX+
         CQIVFhGTg5HZggVkx6H4Fvi9YOQpRomsPRBySnDX5mVN+tXoJOYTGIgforvJSpv2JfqD
         owOs01XobuMCfQPY79Hnghr/tqTxzDtQwkho7X/8/wrUQzvCaveklDeMFi01cHV6dXWv
         tE8gwVtjYcfAVZGKxQ7GjASKdFwZN/Q+EF/VpkYyVBHftVr+/f2K0abdCwRHBM0T1leT
         pCGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo2hCkV7Cmqqzmp+YOrl363ePQ7qu28iWWPdZWv89N/eavQa0nmrvjSJMaMn+/VGCGeVN9IOZVQwSPLTPzQ3/havFYmvtxQFOEEbEZQB4=
X-Gm-Message-State: AOJu0Yz2vG+hoC7j7020nesEUC99CZ7KIt1+4zYLm2D3aMmvoCPJ32Zq
	YBgFU3vM8ol2ljOyoXdWf6uekqCT7WYWxq1FrSzNhonF1mwSTaq3jI5K2S2IjK7r4pD9ysHFJJD
	RCuIDLgXZPM8CcmT/wwpOXcSsUqj0SEYtJU/+ghgqTNydOwXBeodAEoD/s58vg/sy
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550986e87.65.1720710256759;
        Thu, 11 Jul 2024 08:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZslfRADh61h2K4U2I0v8TWlsmuDejSX07DbIntDk5o01Hp5GIPBHFAcNOq0qN0Q3YbDMbqA==
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550931e87.65.1720710255957;
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74462esm118919565e9.48.2024.07.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Message-ID: <90f0cdd6-379f-49a0-9bb2-ba86c3e8ccce@redhat.com>
Date: Thu, 11 Jul 2024 17:04:13 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
 <20240711143425.GA1235314@perftesting>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240711143425.GA1235314@perftesting>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 16:34, Josef Bacik wrote:
> On Thu, Jul 11, 2024 at 10:21:35AM +0200, Hanna Czenczek wrote:
>> On 10.07.24 20:42, Josef Bacik wrote:
>>> On Wed, Jul 10, 2024 at 09:28:08AM +0200, Hanna Czenczek wrote:
>>>> On 09.07.24 19:56, Josef Bacik wrote:
>>>>> On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We want to be able to mount filesystems that just consist of one regular
>>>>>> file via virtio-fs, i.e. no root directory, just a file as the root
>>>>>> node.
>>>>>>
>>>>>> While that is possible via FUSE itself (through the 'rootmode' mount
>>>>>> option, which is automatically set by the fusermount help program to
>>>>>> match the mount point's inode mode), there is no virtio-fs option yet
>>>>>> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>>>>>>
>>>>>> To do that, this series introduces a new 'file' mount option that does
>>>>>> precisely that.  Alternatively, we could provide the same 'rootmode'
>>>>>> option that FUSE has, but as laid out in patch 1's commit description,
>>>>>> that option is a bit cumbersome for virtio-fs (in a way that it is not
>>>>>> for FUSE), and its usefulness as a more general option is limited.
>>>>>>
>>>>> All this does is make file an alias for something a little easier for users to
>>>>> read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
>>>>> 'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
>>>>> necessary to do this in the kernel.  Thanks,
>>>> This series is not about normal FUSE filesystems (file_system_type
>>>> fuse_fs_type, “fuse”), but about virtio-fs (file_system_type virtio_fs_type,
>>>> “virtiofs”), i.e. a case where libfuse and fusermount are not involved at
>>>> all.  As far as I’m aware, mounting a virtio-fs filesystem with a
>>>> non-directory root inode is currently not possible at all.
>>> Ok so I think I had it backwards in my head, my apologies.
>>>
>>> That being said I still don't understand why this requires a change to virtiofs
>>> at all.
>>>
>>> I have a virtiofs thing attached to my VM.  Inside the vm I do
>>>
>>> mount -t virtiofs <name of thing I've attached to the vm> /directory
>>>
>>> and then on the host machine, virtiofsd is a "normal" FUSE driver, except it's
>>> talking over the socket you setup between the guest and the host.  I assume this
>>> is all correct?
>>>
>>> So then the question is, why does it matter what virtiofsd is exposing?  I guess
>>> that's the better question.  The guest shouldn't have to care if it's a
>>> directory or a file right?  The mountpoint is going to be a directory, whatever
>>> is backing it shouldn't matter.  Could you describe the exact thing you're
>>> trying to accomplish?  Thanks,
>> The mount point needs to be of the same mode as the root node of the mounted
>> filesystem, or it’ll be inaccessible after mounting[1].  In this case, I
>> want to export a regular file as the root node, so the root node must be a
>> regular file, too:
>>
>> host$ echo foo > /tmp/bar
>>
>> host$ virtiofsd --shared-dir /tmp/bar --socket-path /tmp/viofsd.sock
>> --sandbox none
>>
>>
>> guest# mkdir /tmp/mnt-dir
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-dir
>>
>> guest# stat /tmp/mnt-dir
>> stat: cannot statx '/tmp/mnt-dir': Input/output error
>>
>> guest# cat /tmp/mnt-dir
>> cat: /tmp/mnt-dir: Input/output error
>>
>> guest# ls /tmp/mnt-dir
>> ls: cannot access '/tmp/mnt-dir': Input/output error
>>
>> guest# umount /tmp/mnt-dir
>>
>> (following with this series applied)
>>
>> guest# touch /tmp/mnt-file
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-file -o file
>>
>> guest# stat /tmp/mnt-file
>>    File: /tmp/mnt-file
>>    Size: 4               Blocks: 8          IO Block: 4096   regular file
>> [...]
>>
>> guest# cat /tmp/mnt-file
>> foo
>>
>> guest# ls --file-type /tmp/mnt-file
>> /tmp/mnt-file
>>
>> guest# ls --file-type /tmp
>> mnt-dir/
>> mnt-file
>> [...]
>>
> Got it, this makes sense, thanks for explaining it to me.  You can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Hanna

