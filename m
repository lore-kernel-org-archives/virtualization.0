Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7A16130C
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708469; cv=none; b=eKFHc+1KYfS+UNI5AumGIlI5MxtN5lzpzmxflQaQ018ZmpvrBCLNthrUaOiJ0mdfkJ7SpbtZMGCooXarREyNos9UH4TEeLh9otUXREAt4rX5xLouMdqsFLDMr+okaYq/WCIRPg2pijfHts2b3CMqdSAXOiNIX5rKiHec2hg2Ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708469; c=relaxed/simple;
	bh=+uj/tTAq4TA7NjaayLC8BtNVkrmTjLc5am/0QT0gO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFpXnoH++Xz5qW61BXsZiw1PEdUid5kg72Hvarx2H4kIyoz6EPSID0D1PRTSxFiujpTt9b4OX5sShmcELA+znXtIByeG3HQz1VxuUSLLZRj7QvPnvG3MowwpjHH8aGrW/iB1Yfm42Nl+rOqNJ+hUk0i8VqN4W01nUxucrSFUOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XXtnkQ7r; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XXtnkQ7r"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso1089674276.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720708466; x=1721313266; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Isnu2P2XZ4vyjhu09NFK9mxLGYDcc9SLvRNtCtPllw=;
        b=XXtnkQ7rXfsfNtlpGJ9QKoZvCbQ/jtq2DyYVJIgLdfRsHXvW3ETaanrpotItcS1ElD
         cwWXyaAryXcW873LSJ1iSu585zeNd0yDEnAIM20HfipR7iKZ2j0pSQPanjRmY/Qw2j82
         rOBHWgTo4CP2Z7EgSavwu9MOOhbggh10RtD5B8fllRNY38veS9rtyxNrY/7GEsagXfmm
         6H2N2Ay0Tvh0HX9u02cFYYkzOXk+/cO1OD08hYk9tiaM8dstcTyL5lvB2263IT+9kq85
         OSnXxMftk22ZLFdqBd7YyA3IJkb+WVkxjuP9mDXIhHVIEf42GXogOQniZ630K8O9/UR5
         fQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708466; x=1721313266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Isnu2P2XZ4vyjhu09NFK9mxLGYDcc9SLvRNtCtPllw=;
        b=jn1dkK3An89CNWQJtYN0++Ua/GOnYDVmhrKkcpE7XV1I4zQqShUOKWLYlNq4BzJWNs
         H27Tclwz5HbveCtXmogzZftMdUCFtyESFJO6dbtNkU2RhNLMDTpWSF/6uPHSWOEKFqZ6
         INEzUFUcVPzYwdo6huItZpYq6W0+8nUZf4+AfbMTVsBfTzXdgeuG0mwd8qEvtulcDuMl
         46OjMvFLytXShGwhVo2uMpj2k7tWJyFfB51iKOx95HNz0QBxvFOxnM9V/vi0gXv9YuxP
         uvO6TNEzbkCxIDB2plAtqVe354M6VCYQbC1iN5ldkQQ/tvjV30VWYbGF22SPWButGljx
         OGxA==
X-Forwarded-Encrypted: i=1; AJvYcCUz6MeQrdMmglvjfa7bxeppAzQkOV5qdm+lC3q9igC+wkLvabLFGjXJOCzusxm+a2fCzvrY/KKOuj0x3VfZDC111q+8SffpeLiNz/dg1LA=
X-Gm-Message-State: AOJu0Yz0mMui2pIVKV6Y4MQAoG1ZX6d8fc/XEj1OlVK5R6u9nR28KHQx
	RHI9TgeylooG8EDufUz6ilkoiu5RY0bLYaTmGmVTy8YW+YMI5qblqxb4NIQo7ds=
X-Google-Smtp-Source: AGHT+IHoDuERbfhsAd+ku6w/nNTteOIDJ8Hw6KBq9ZuJ4kA+BHwmpNrzHWd6szaaePbvGqJyOdH8hQ==
X-Received: by 2002:a5b:605:0:b0:e03:645f:2099 with SMTP id 3f1490d57ef6-e041b043182mr9883441276.8.1720708466582;
        Thu, 11 Jul 2024 07:34:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a8aca8csm979701276.10.2024.07.11.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:34:26 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:34:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
Message-ID: <20240711143425.GA1235314@perftesting>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>

On Thu, Jul 11, 2024 at 10:21:35AM +0200, Hanna Czenczek wrote:
> On 10.07.24 20:42, Josef Bacik wrote:
> > On Wed, Jul 10, 2024 at 09:28:08AM +0200, Hanna Czenczek wrote:
> > > On 09.07.24 19:56, Josef Bacik wrote:
> > > > On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
> > > > > Hi,
> > > > > 
> > > > > We want to be able to mount filesystems that just consist of one regular
> > > > > file via virtio-fs, i.e. no root directory, just a file as the root
> > > > > node.
> > > > > 
> > > > > While that is possible via FUSE itself (through the 'rootmode' mount
> > > > > option, which is automatically set by the fusermount help program to
> > > > > match the mount point's inode mode), there is no virtio-fs option yet
> > > > > that would allow changing the rootmode from S_IFDIR to S_IFREG.
> > > > > 
> > > > > To do that, this series introduces a new 'file' mount option that does
> > > > > precisely that.  Alternatively, we could provide the same 'rootmode'
> > > > > option that FUSE has, but as laid out in patch 1's commit description,
> > > > > that option is a bit cumbersome for virtio-fs (in a way that it is not
> > > > > for FUSE), and its usefulness as a more general option is limited.
> > > > > 
> > > > All this does is make file an alias for something a little easier for users to
> > > > read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
> > > > 'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
> > > > necessary to do this in the kernel.  Thanks,
> > > This series is not about normal FUSE filesystems (file_system_type
> > > fuse_fs_type, “fuse”), but about virtio-fs (file_system_type virtio_fs_type,
> > > “virtiofs”), i.e. a case where libfuse and fusermount are not involved at
> > > all.  As far as I’m aware, mounting a virtio-fs filesystem with a
> > > non-directory root inode is currently not possible at all.
> > Ok so I think I had it backwards in my head, my apologies.
> > 
> > That being said I still don't understand why this requires a change to virtiofs
> > at all.
> > 
> > I have a virtiofs thing attached to my VM.  Inside the vm I do
> > 
> > mount -t virtiofs <name of thing I've attached to the vm> /directory
> > 
> > and then on the host machine, virtiofsd is a "normal" FUSE driver, except it's
> > talking over the socket you setup between the guest and the host.  I assume this
> > is all correct?
> > 
> > So then the question is, why does it matter what virtiofsd is exposing?  I guess
> > that's the better question.  The guest shouldn't have to care if it's a
> > directory or a file right?  The mountpoint is going to be a directory, whatever
> > is backing it shouldn't matter.  Could you describe the exact thing you're
> > trying to accomplish?  Thanks,
> 
> The mount point needs to be of the same mode as the root node of the mounted
> filesystem, or it’ll be inaccessible after mounting[1].  In this case, I
> want to export a regular file as the root node, so the root node must be a
> regular file, too:
> 
> host$ echo foo > /tmp/bar
> 
> host$ virtiofsd --shared-dir /tmp/bar --socket-path /tmp/viofsd.sock
> --sandbox none
> 
> 
> guest# mkdir /tmp/mnt-dir
> 
> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-dir
> 
> guest# stat /tmp/mnt-dir
> stat: cannot statx '/tmp/mnt-dir': Input/output error
> 
> guest# cat /tmp/mnt-dir
> cat: /tmp/mnt-dir: Input/output error
> 
> guest# ls /tmp/mnt-dir
> ls: cannot access '/tmp/mnt-dir': Input/output error
> 
> guest# umount /tmp/mnt-dir
> 
> (following with this series applied)
> 
> guest# touch /tmp/mnt-file
> 
> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-file -o file
> 
> guest# stat /tmp/mnt-file
>   File: /tmp/mnt-file
>   Size: 4               Blocks: 8          IO Block: 4096   regular file
> [...]
> 
> guest# cat /tmp/mnt-file
> foo
> 
> guest# ls --file-type /tmp/mnt-file
> /tmp/mnt-file
> 
> guest# ls --file-type /tmp
> mnt-dir/
> mnt-file
> [...]
> 

Got it, this makes sense, thanks for explaining it to me.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
