Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC3158858
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523969; cv=none; b=u442btIul82fbMJICvCKm9qvcf0iApxzdOGRR1ysL9HiqDjzosDZUsbigJlAHf2foqtp5lcNQuaReOCgDo0jKSRps/8/h64ddBr1HhTl8MPh1jVwcD8n/C6os2zJJMQCZnZVy0KGxH6NE3y3Ft/cCTwP+LZt+U+PVFD1i+Tf7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523969; c=relaxed/simple;
	bh=BItnevYQftOCRFmTco7LyFoPZ4oUphW+9VYSudo+9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAFwv9I7GFH5ndN/hMcP6w8PxnmejzeMkDfIJJQQqnM1dithsIT6lnqJR4z9pvtBOCbUtXaIlwKD2xNpjbZnF+cgsTeq/uKtfgRK0HnMebUWlozasvgIRjfBsIyS/F+EqDn4UsZedFNVdsRWPF7Zlr67T0vhIXpDgM3A/d6Rr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwJxboEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwJxboEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
	b=hwJxboEwS17SCePyDCi8g0Dz69I5S6ce7PfZJZWjXdPIvWbizeVOn5RjJ5OHUh2aTpqVZa
	Vi2hOoiM1t77xCGwIlig030LeZW6KAmzvbHmmxrODJHIe/OcUYe04pkZ7D63dmm8u2w7sH
	wPN0R2amfr0JjJAd8Bz8Fe/a79jg0gg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-lRKtlo6JNRKr6KSy5VtADw-1; Tue, 09 Jul 2024 07:19:25 -0400
X-MC-Unique: lRKtlo6JNRKr6KSy5VtADw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee8b7eafffso52093811fa.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 04:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523964; x=1721128764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
        b=AM8uhdgrVYVaWQOcdM3qpdrB54hHXtZcJY4QY4OppRPTwheF2jlNawtb05UMMfRw9x
         XoO0R22+8ltQhK+xlQiPncK81BKu0EPrrlam5gEr+H+cxd0vXJ4eXQoJx7hrSsl16Fna
         2m/LwzzOxStlTrYFLRUY/kEBUp2Ie2PSvDH+x+08IGrXm37agiFTBDhCAUQM8XxS+0wo
         hVCxxbpsW9tnq8/MvaAjh7EKRc05t4Tlkj5A0KRsxGIAzkYBYcH5xV0CDL45rEHGeTnW
         ppknQEqsJfVbcWxxlkJToMlcOltUiycy2KXns1hRhfx3xTlViMXtoYdiERSKlJ+Gjbpv
         qWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWN/Te47+pvsARfIJtax94WHfYZwfKp5TpNeCNPPAQZZjsy/OCkD6Xy9QSFcLFjKrclz2j2tXKj2X4/e/8g1Om3E1i0/1UvAaO89bC1R+8=
X-Gm-Message-State: AOJu0YxctQ0T8PcUToFpfsSnS4uDu1K1JDAsXQjzy82IBX8p1I/qLgub
	SJW08/uCqGyI0flK1+2nFLyTh71HOyuFjtHfgWVMS1AjDsabim8LbbQ+vFSHOuiNDyMEl05HzDU
	Kuwl+sTjccK0cfdgaDIU+7uPADlUDMwagkFm4GSNxe+EnsC9iegHh7KsIaKKKH9kJ
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16104921fa.31.1720523964485;
        Tue, 09 Jul 2024 04:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFGxEpvT2wnJU72VkvZj7q8tuPCVpDDqG6kBc7TA4IZyQG8gcuy+uWDWNgH2hnWmFNmVBcCQ==
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16104291fa.31.1720523962911;
        Tue, 09 Jul 2024 04:19:22 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa078fsm2244778f8f.71.2024.07.09.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/2] virtio-fs: Add 'file' mount option
Date: Tue,  9 Jul 2024 13:19:16 +0200
Message-ID: <20240709111918.31233-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hi,

We want to be able to mount filesystems that just consist of one regular
file via virtio-fs, i.e. no root directory, just a file as the root
node.

While that is possible via FUSE itself (through the 'rootmode' mount
option, which is automatically set by the fusermount help program to
match the mount point's inode mode), there is no virtio-fs option yet
that would allow changing the rootmode from S_IFDIR to S_IFREG.

To do that, this series introduces a new 'file' mount option that does
precisely that.  Alternatively, we could provide the same 'rootmode'
option that FUSE has, but as laid out in patch 1's commit description,
that option is a bit cumbersome for virtio-fs (in a way that it is not
for FUSE), and its usefulness as a more general option is limited.


Hanna Czenczek (2):
  virtio-fs: Add 'file' mount option
  virtio-fs: Document 'file' mount option

 fs/fuse/virtio_fs.c                    | 9 ++++++++-
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.45.1

