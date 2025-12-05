Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAD2BEC2E
	for <virtualization@lists.linux.dev>; Fri,  5 Dec 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958017; cv=none; b=DpciQ7/ZvOOevH7voDNdjXIguUQbSVCW6q7TB5u/S5hIiV6wCHEgjiI2NIKQXckxqKa9UZy+IIt/2V0tb5VBSD+WkTF6bh10VdmquAePPcm62k9X5whIlLQ7KDFiOmv/5fpOzF/s28VdQVkeOGyH1oGslNcwJAISpeDym4RxyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958017; c=relaxed/simple;
	bh=0PQxiO8yXBkRzyEEQcMge/R0bQ+15Du7eQVaAWbnzu0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LtsQLUg3JB7ETBIM+JD+qDuVidq3NRmkqdg3mhCV5sKZj4x31Pax3QAnTtsfKL1pL/QTqUVTDmYPShxy+WkM1vTNBWsrMuPH62P+cFWan+uqfE9yoLSLKnJMQsaJHb/Km1CLV1CcxsuWfDEmGn4TZ6xEoeKbe2EsG2qetrYi1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=fcEwnNcc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="fcEwnNcc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so2275650f8f.1
        for <virtualization@lists.linux.dev>; Fri, 05 Dec 2025 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1764958013; x=1765562813; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8W81HKYgtnxSK/jeCC9tCd/4H+x35ZH/rbQQcXkQvBE=;
        b=fcEwnNccKtOWt0iMtMs6mZ8T7xirJqcHi2QTTK/q4A3e2hitx7FXV2vPtOSQXMjVzH
         p2ye6qp7sr6omvVglfc2VKASc5D5fJK48tiONcqLY5pV+h+dqkyv6/mjmxzfe9HahpNf
         IPjeW4EwTqaR9tu7KibOM0hvzJJPbAn+6Ans/kGuy+SFGeq4e+xgvNv70vmpATf1zDML
         80RZQT1gssYP77CMK2p2QfM2oJIhu7Wgm18d8l7q5cSl4jN9bUx1+IJRpUPkkOpeGM0q
         p6lm37jm1QoaZRJO0gXWCb11ID3jEaHNuR+92FUzPpY9n32WqRZEmby4nUjfiXGKiJ4v
         lwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764958013; x=1765562813;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8W81HKYgtnxSK/jeCC9tCd/4H+x35ZH/rbQQcXkQvBE=;
        b=XpJNNDUeOu7CI2Awqo2uhetHG3NCF6JeVd4DGUeHWAbXBrPqnlJW8ZIoXZGG7waYf4
         Qv5TeI7AyjKqfdiz0umnqXleUuMLczIWPk6fGV/lQR4aQyeYyPgPx2CSpykp5aufHkRL
         ipn0UW508Hm7L+Z3J2HSj22vM3NBbiUQMB7QHZII95Q5EpEyJf+9r4EqzUI5iODtjg+V
         dBBURjvjqY0YasekJPDbM4NfCYRDHGUUre/hjuzQAAXN58+jftNHHj1ry5lBxfq6YB4d
         e1NAyBx0QgT37ylxkzpfgXj6yxqcE5q1Q9m53fKXfPssJTkIHqYyP57nrdtreunurhqm
         earw==
X-Forwarded-Encrypted: i=1; AJvYcCWTC3bL4Wao6/lQZR5HIcxdRym3eDbKpD0zX4pkITr70V4IMTR0FIKlf/fsKQbV3iSqjSYWPM5NxS0ek2i+QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx970v4kfmri8z0om8R4roUmdeUD431PUFNNbzdtoFLzR5lwScW
	bLWylHGRCKwl3oZ1jHPmfdx19eD8kPHXL3AuFJJ5hcymtzhNKUr7TAaG8zP7egXtiiJuoN6Ex8j
	a4vrvmoouDIB90OJDhnvGkcxxbMhUYM4QKf9dLVxBOZmTzwQwCKXhwes=
X-Gm-Gg: ASbGncsi5hqq5jn9javnF8vHWQ5Q9mr5ZtsrBuWBb3orchw7PbbAaJ8+vd9q1jJeLTA
	itK+fKuqBPWgrmDgJrVQKp8jrkx9g0mZ/nq8qw036Azs7ZZvkI5Tn0W1n3bj24cbWneYV8zTaUM
	Lu2IP/q6RyYcEG0xcs2wA7uf5xleegDTSvCHy4OR4gYjJHRV2bviR0cAhansgmxB1cyM57baSaI
	EpEtZrAOyatySpeXld7/LktKjZnvLyPPCopKIrCMYeUDcZ1XAOMZkr1mxGwvnw66KeDZRWmhdPW
	0ZQlyZyH
X-Google-Smtp-Source: AGHT+IFa9ljvRR5WUvUCaZfTLm7hMbr0s0gXY4Z8xyd4G3hJOoM33q/AgBVXBpVrjXnBNwqp4SvDMzk2kj+5SzisC3w=
X-Received: by 2002:a5d:5849:0:b0:42b:3108:5671 with SMTP id
 ffacd0b85a97d-42f78896c0bmr9257554f8f.29.1764958012763; Fri, 05 Dec 2025
 10:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 5 Dec 2025 18:06:41 +0000
X-Gm-Features: AQt7F2olyW0xN9Ns7uKzoZ8dEB8-EAV_B4TM-wor1XALAnT9pr9H9_dIptj-utQ
Message-ID: <CAN+4W8hLrR1B1pNdDXiVuzoJ1q8Ta1kjV0v8vKVEZeHdRFKGcg@mail.gmail.com>
Subject: virtio_console: lost wakeup due to race between port_fops_poll() and vring_interrupt()
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been chasing a bug when using virtio console to exchange data
between guest and host. It manifests in a process inside the guest
getting stuck while writing to the serial port:

    [<0>] wait_port_writable+0x139/0x2d0
    [<0>] port_fops_write+0x88/0x130
    [<0>] vfs_write+0xf3/0x450
    [<0>] ksys_write+0x6d/0xe0
    [<0>] do_syscall_64+0x9e/0x1a0
    [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7

I managed to track this down to a race in virtio_console.c. The driver
doesn't properly account for a port that receives blocking writes and
is polled at the same time. I suspect that a similar problem exists in
port_fops_read().

Here is how it goes. We need two threads inside the guest, A and B.

- Thread A writes to the serial port until the virtqueue fills up.
- Thread A invokes port_fops_write() which calls wait_port_writable().
There are no used buffers to reclaim and the thread is suspended,
waiting on port->waitqueue.
- The host side of the device makes some progress, marks some buffers
as consumed / used and  sends an interrupt to the guest.
- Before the guest can service the interrupt, thread B executes
port_fops_poll(). This calls into
  reclaim_consumed_buffers() via will_write_block(), which removes all
used buffers.
- The interrupt gets serviced, calling into vring_interrupt(). Here
the check for more_used() returns false because the poll just went
through all the work. The handler returns without waking
port->waitqueue.
- port_fops_write() never returns.

I'm not exactly sure how to best fix this. Maybe it's enough to only
check outvq_full in poll? It'd also be nice to fix this on the read
side as well.

I only have a reproducer which requires a Go toolchain unfortunately:
https://github.com/lmb/vimto/issues/29

Best
Lorenz
