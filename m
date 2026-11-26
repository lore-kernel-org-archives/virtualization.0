Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693003;
	b=eDf0hdO5ziCpR/ZhXHFNjbj2H16i7K/sEG4atQeS7Wr2HuSDdAxOVszvqXLAo6TbbtnE
	 nzPHiCyj8mz8pE1mP9dkhVhV6gZL8y1k+UqkWO1MhZegZJ+LwB/IPOxSGQBfHWn5UmO1m
	 fsAkPKX8ylcIuDdFUkvJlZvGuVqPwdslIgdUJLqZ2XgcT+CaAZK/zV1FKmD4pHF3mwzEz
	 2ObwYgW6jx4eMuI8XpO4Kj2BLxfMbFZQIDgDmQiVhGmzW8k7sYk84rUQgNuuggGIRmPl0
	 Wy4Mp/gzrVVh+6kzFvEdccbb8EXSNBaDZtaINT2Tc2f+lOz7gqJb+Lao6cD4G3rBqog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693003;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=9cm9TssSFcd/T/fzJzte/dC81TuD/7P4C6B/7ghFyYg=;
	b=YeRMrP36VaZdphqR5/iDzK5K1mqXx3GB/i2bi2oXzEAmrW8oy4p+z/7J48Kt03S8M4UX
	 LtY1MdhtaDiKE5n9Q/3Szni+eCnNzhK/WSSke4SW7wUM1JPtvpud0Eb4nE7x4NdWz4Isp
	 r8wkbL3p21QOTM7SxorTthTehTva2n1b93JoVNg/Bm3iIzMZe7qbPTTgn+L0nlTE8Kfz8
	 1k7glIarGAE0TdVNvP/CVuja7ZwxvQe4e3kf18MFj8RJgcb9Ehlzy+pjWjO/T+PQJKqEy
	 ZeaOzN4jGbDC56u7DDxN0S+DJ72UYa+R1w6sOKk3JMr/EpZaVmrKWKsxOgj7Pzq2Ihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DK3BdzwM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBD606A31E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 11:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDBD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DK3BdzwM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795693002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cm9TssSFcd/T/fzJzte/dC81TuD/7P4C6B/7ghFyYg=;
	b=DK3BdzwMgwJJJ/ewgVr2YlzL5/sziibyNgqT7qV73XCXgqrSSWyzUN9v0MUww3rGybJqcl
	RNKsGOOMb4nyq5ovoyLJLsl/07/6mahco56eHotJzznvtBXbm7kg2kAV7k6W0+o8ZapFei
	jNYPokOBWGhp4Axp7+DbNg8QqZPtF+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-1Pw1yDgIN0OsLNa570qrxw-1; Thu, 26 Nov 2026 11:36:35 +0000
X-MC-Unique: 1Pw1yDgIN0OsLNa570qrxw-1
X-Mimecast-MFC-AGG-ID: 1Pw1yDgIN0OsLNa570qrxw_1795692994
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49febef74e3so53569395e9.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 03:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692994; x=1796297794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cm9TssSFcd/T/fzJzte/dC81TuD/7P4C6B/7ghFyYg=;
        b=MBpHylGHDnUFGtzKlbM4t1DS/jaOf3krgGBf73DfjgL5E9IzxT8r1A4kfGbr8bLCwn
         yUR9vYtuuVip24TzOyJbtAwZBW7fysgeRoqyTfkE6tKT/kZQsgqi3C5zsgAUmQfjHe2V
         +DDqLrclknNbgsp/LDXd4Ajt294mEDHTTkjkbgl+B0oAIGIIcwzUfPhSop8fPW9LBPQ3
         SEQ1bYx8AcHNZXDDdzkPd3EXgfTSTA7E3MgC+9vPcU72eHgKE/gKZ36pzLTa1thPl4H5
         ysnOjVHjYGa55iPPvl7hf78tRB5sb0C5mAZr/p9F4CIdagAbEOxk5B5nuI1a9NJjVl3w
         Hq8w==
X-Forwarded-Encrypted: i=1; AL+hErGLew2GklU3BAwtuWri6vnEfUHlQRkGQjn8JDZTf3tcqc9bMa/Xk4e331/tYNjmBDG3BAiA8NldUQNAARCuCg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+O5snSMU7aMuFPzn+S7BBJFIX9qkY0rw2lz7qhqHRhhf2QME81
	agdLu6eekOjTtF/2MdMzi9MhQ6ge2tUz1CFTuOwqnBKqHSg5jiTAwX0T6gBQON9C0SzdaZB21lh
	dREXq2jbNE0B/qxzovcfW/gxCTde+Ins8I6CKpava6u/qZzjtmoMz1+C94nuLswWYQfWq
X-Gm-Gg: AZFdTZcWtMj8Zo3WKMic5kes/D0npfl3IwFaz8ANYtNHMUuDjji18idRWDuHFORTzPm
	ju6Czc7qa1NaH9KguciUhxCHme2aQxdbSX9aWe3SuqqXc3QAqJVpHgALxADyIhlP6qmf3N6VsyI
	3GYrhKkBZ94uhCLbOCl9oNywz6aIeG3kP4oMhol298ltVti012307To5YH10oLyRg12oXwFgCZK
	ABAkzdCTGcQBeNHMyWoSjmgw3/04FZru96jReDI6AXVGEjOawDdQSEZwReDvpi1kwbWN6bQ9lbS
	KOscwBHeo0i4iubC6hIocoF3J1/TuqTG4638iolCMmA+7/HPQMCpJGDArvDxssRXe7izOAyZmHm
	SVJFo31rR3PaZWXc9pWL/ZItIgfLCnZRtZx+lYTnCkMI=
X-Received: by 2002:a05:600c:468b:b0:4bb:5fd1:92aa with SMTP id 5b1f17b1804b1-4bb888160c2mr438382165e9.15.1795692993722;
        Thu, 26 Nov 2026 03:36:33 -0800 (PST)
X-Received: by 2002:a05:600c:468b:b0:4bb:5fd1:92aa with SMTP id 5b1f17b1804b1-4bb888160c2mr438381435e9.15.1795692993239;
        Thu, 26 Nov 2026 03:36:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm817222235e9.13.2026.11.26.03.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:36:32 -0800 (PST)
Date: Thu, 26 Nov 2026 06:36:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Seojin An <love09010224@uos.ac.kr>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, security@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Message-ID: <20261126063555-mutt-send-email-mst@kernel.org>
References: <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
 <20261126112410.3485471-1-love09010224@uos.ac.kr>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261126112410.3485471-1-love09010224@uos.ac.kr>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T2k3KsTS9cMBE9ve03U9DLvIDXL__Q7quWwqR_8Src0_1795692994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2026 at 08:24:10PM +0900, Seojin An wrote:
> Thanks. Before I post v2, I want to confirm how broadly the core should
> enforce this.
> 
> One option is a common check that rejects total_sg greater than Queue Size
> for both split and packed queues. That would catch cases where a driver misses
> the check, but it may also reject requests that existing drivers issue today.
> 
> The other option is the narrower split representation guard from my v1. My
> original check used total_sg > 65536, but it needs to reject exactly 65536 as
> well. At that count the split cleanup cursor wraps to zero, so a failure while
> mapping the indirect table leaves the data SG mappings behind. Packed
> indirect tables do not use that cursor.
> 
> If you have a different core-side approach in mind, please let me know.
> 
> The current virtio-gpu v2 draft enforces Queue Size in the driver
> independently. For the core, would you prefer the common split-and-packed
> Queue-Size check, the narrow split guard, or no core change for now? Once
> that is clear, I will post the corresponding core v2.

Let's go with no core change for now.

-- 
MST

