Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B5324B19
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686242; cv=none; b=dDRxrldTFt+p4BNXXNOsrftjZUplb9VRPmUfgkfStEt+2YMLH+/tqVTxaX3amwVFhvyHYRkWp7UhUFymoMCmMKsmhGWfToY6aiEDBFdmzgTb1G94HxWma75mlecnf7lMP/aVWZaqR5nPiJh6PayFe9DICU9ufsZbjkKAGWce2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686242; c=relaxed/simple;
	bh=2dfXE3T5FZ6K7+lqEmh5QGLTAful/RxL5/OXaLyX+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DgLClPIwrLwZaGe2QNMcEjOcespq4mwP/tsjiDjbW3EEciWhK3vCgr2Ixhl5iyCYYaBdShkh58aLlS2isFnI8ZHTMI4+VUkXT/dAPpO9bebNlpgPwlPognp431PIBbpfsOY2bPBg+CNuYTpp3iXjeGSbVOT0ayQV2RXgnuuB78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw29zZzF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw29zZzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767686240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4TYkMIrp7AW9u8pmueM8oRPi406uK0ebNKTuLEzFRw=;
	b=Jw29zZzFglG919JgI7i0xklQ2oObYZyc5leVLnIfHti9CJweJNPNRzG8C5PabdVmP4/3fY
	M+7UoQk0lJjSmBkBb7s9m1F/B8AYBTpQLUP/nNuyP4dtnrpMhO1TRrPHTSZfGnUDm1nqke
	v82l+dtoQG1lYYlghba+tsFch4GvB/Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-f31WUT15OgGzj1083f4m5A-1; Tue, 06 Jan 2026 02:57:19 -0500
X-MC-Unique: f31WUT15OgGzj1083f4m5A-1
X-Mimecast-MFC-AGG-ID: f31WUT15OgGzj1083f4m5A_1767686238
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43065ad16a8so338581f8f.1
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 23:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686238; x=1768291038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4TYkMIrp7AW9u8pmueM8oRPi406uK0ebNKTuLEzFRw=;
        b=W8I4KxYZeIzwPxhAxp5CNFFCXGGxGJzfdKbwKhHjSwkgOsJdIwmOWvXQYod+WB0kjw
         ck2LKFZARXxLJ0OD9keLiiy8TqLrrICPlxw/xr5Hy7zyod8n2YYUlVCj422yt2Ujsr6b
         kLlXrsG8LgNeb8oad2myZtYyjR7BNGchK2BNKW9Q8dT7clXURwi8q6Rnu+8pXvDQYlLn
         7Fjq/m9HaXg5L+tnT3g5ep4kEEUvnvvU89h6NMln/FBkb4zEBBBPninWtda4GzvI9gCg
         0+4QelXHF8zGufs581e3Zh05uPryJPeV59mzIkNj2CP/HMxxNVKXzpqVNebf9EVkNbiV
         nAow==
X-Forwarded-Encrypted: i=1; AJvYcCXyEMmf8GYi1kjq7EoZUQhEBgiUZPJy3DqY6xh90M1OhmkPxnkDo9leMMgfiV0mJM8QFBVvV2L0cfGqS5fc4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6UQwR1cXp7KMHnRbH3UFyzlsKdQSRGtxTb0eE2Kk5eRtWIbxn
	HqMfTEa3qEAN/ke+e2lBMchuIzSQJaY5/W12MunEauN0fSBj5WU86yh8XWxsWucJP9RSLRhA7Fr
	GexJeN93Z+oRdmrbZ0a3GaLW7CE3BoaNFzKOEDSo0PDUIll326cUoZG2k9DULjozjs/ao
X-Gm-Gg: AY/fxX6Q8sJFn78+9wawH+jSqMZWAVS54tDxfVueqUkzLRH97luHvwZKzOhvftP0ab8
	swMS/zw/bmwjjk+p0JXUpvtwjCAK413u5ONuWZSOaFb5HXwW7F0uZz30EbGCcj3mLFI+t5O6CL+
	j+U5QZ2mjB1ujcy0h9MxKCbXFor3aJr7EieYjH4zJG8LRijYsZFzCzuLGvwTF5QJqwEhyYlHW09
	yoaNgYucGeVdnp5DpuXsyutUQsRIuNDLJ0uK2KnllStdvwHtwCdJ9H1n8AD0HCVDvp1b4IFQQ6v
	5ovHw1UXFwSUt5/nVg19vEGOI2TtF6KRkYG7a8sLpO5v96qqYON3WdbgPZtxTkaPDflbSbt3jhK
	lw2hxYS5j8gejkGjHyGf8gGc/HBC03907ew==
X-Received: by 2002:a05:600c:444d:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-47d7f09ca36mr23148355e9.22.1767686237773;
        Mon, 05 Jan 2026 23:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOtxCvNvgEtYJhHLldkg64fSo56Dqfda5jX1IeA0WMV+CtMRCrIRIjLAWwju8ZN5FopMEIQ==
X-Received: by 2002:a05:600c:444d:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-47d7f09ca36mr23148085e9.22.1767686237184;
        Mon, 05 Jan 2026 23:57:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm28518895e9.12.2026.01.05.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:57:16 -0800 (PST)
Date: Tue, 6 Jan 2026 02:57:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+a9528028ab4ca83e8bac@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] INFO: task hung in vhost_worker_killed (2)
Message-ID: <20260106024033-mutt-send-email-mst@kernel.org>
References: <695b796e.050a0220.1c9965.002a.GAE@google.com>
 <20260106014632.2007-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260106014632.2007-1-hdanton@sina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Etq1kkZmkKYaq72A20jcQOlt322lfFOl410uOTQ2ijg_1767686238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 09:46:30AM +0800, Hillf Danton wrote:
> > taking vq mutex in a kill handler is probably not wise.
> > we should have a separate lock just for handling worker
> > assignment.
> > 
> Better not before showing us the root cause of the hung to
> avoid adding a blind lock.

Well I think it's pretty clear but the issue is that just another lock
is not enough, we have bigger problems with this mutex.

It's held around userspace accesses so if the vhost thread gets into
uninterruptible sleep holding that, a userspace thread trying to take it
with mutex_lock will be uninterruptible.

So it propagates the uninterruptible status between vhost and a
userspace thread.

It's not a new issue but the new(ish) thread management APIs make
it more visible.

Here it's the kill handler that got hung but it's not really limited
to that, any ioctl can do that, and I do not want to add another
lock on data path.

-- 
MST

