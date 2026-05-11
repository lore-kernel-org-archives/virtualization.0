Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBD3E558D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505496; cv=none; b=VTyPSyQ/bOeg3ROUca5vEWpiq1Hp5kyDgZkD15vaenzM9BTgNZRcbak0WQ4l7HJinwGcY824xLQEeOV7SfCeMpD5VZF0fV8qppV5Q1rOowHZaI3OnuVb8ymdLibA3MoOBUiH7XnO8H8iORC9J1d/0ACup+prVZ/pyKqakvRZMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505496; c=relaxed/simple;
	bh=8m538UYatqrcDeaeCf1K8yM2CBjU8sYXskeMrAupKZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eG0f4Wip3yFjeZQ6fqefS+YGlqkdKsvn9a7JodBK39UAYYb7hiIcjwFK3QyNt14YkhW5EVTfjN/DANvr96mEzkaEa9o5QT0QMZBselUt/6FS2cc/Y0k/gQcKJ74YtPwrfkxV2eawFiozHgcP5uYVAiZIP6w9iUyK6mdKWXsa6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjS9q8Hh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjS9q8Hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778505494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
	b=IjS9q8HhlX7tlZjQri7Zg2vjhv/yr0Feg9D/rv3jYMvF4ouKurWdkLJ4lPDqr2Ogj1pzC3
	5NrU5Ivx4Dhme1ZUPrpyaYQaNpTBLOPnTw8YvEwWWawsskVSwz9nJ4V7Y1WXL/5CrzEgcT
	T4JJtzuabmDIkMb/Xg4IK8x5uKc0MRM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-iXrAn0NcMs6eREJb1CBW8g-1; Mon, 11 May 2026 09:18:11 -0400
X-MC-Unique: iXrAn0NcMs6eREJb1CBW8g-1
X-Mimecast-MFC-AGG-ID: iXrAn0NcMs6eREJb1CBW8g_1778505491
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bf0b47d2e2so90443537b3.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 06:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505491; x=1779110291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        b=U4cJyj9QSj6ooMZL72DUZX7pNgHaYrNFreJN3YcEl6MC9gNDWeG0OZHSbtvrcDvfbh
         NyNk6FfuQ6b2g4fC4GrY9rlvna1P+Gu3hYjGgIT55l/qvmo6hQz1qCNuXh8AvXvlyKzp
         FUlY9tY2r3aIodKatn0F7x6pN+y7nKBood0jOKGGa1xRR9uuTkxemvvzBtMZ2Cuu5rMs
         yYybcpYBnq3eS1kiaO36GJsID/2VXj00aC1rzoDgUSMEtVPBISAXsE8ErIIcYtyGsPyZ
         JE4iEqrPcnvJgQzyHoCubfwHxUeOWr0G1SyCVWUN8rj8jtC+x4EJICCLDPrsbQZAJVej
         SLcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f6AZKsYlsj22gzE50wbqbZoSZcwEkQhDTCdj0Yccm9D1ujr31HQxfTIcM/cOzzVA1EBz1xn02sGvOmjLuyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHt6Dss4uHTQeBy5vEfgICvxbXt5SmaEbJPVooyF/KEuB9UJkm
	z7hIhUa0kv2VXfuhWhQm68Mvm4NE10lG832uaX5tDV4RDlvSaRCoHdkGr+0s/G7XNu0hC2zu1rd
	2KVbxFCEtwzdYOP/kqbD5SJVNgAi1xO3dHXUQFJouV2YfUHo/apaNDJng35GaQXk/xtKBjvixaX
	V7P1kpg4mwEc2dSjVFl4Z4wd4xHWVc8Z1yqWl77e/V5eI=
X-Gm-Gg: Acq92OH3whdaThkO2qQEVMk2qbS0IJSDd8nl0BoBa8aQRgkO4SVWuShELL3W0NdRj8g
	bm+GVIThb0GvhdPLhiNkcJ2ekxeR5Y04YuxabdiyLM+Vo0qmEdn9RMVsgRQ8b7i4pZu3mF4zmtH
	VCCsrYrRzHc5oSK9okXseKvsOzlS+4gQ3dN2JlzopTCi/BGbO+lAQRRotmqrzJlBjtamsOVObyu
	FbPgxMLPPlsSikn
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7bdf5e02b03mr239670697b3.15.1778505490920;
        Mon, 11 May 2026 06:18:10 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id
 00721157ae682-7bdf5e02b03mr239670197b3.15.1778505490349; Mon, 11 May 2026
 06:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260508092330.69690-1-sgarzare@redhat.com> <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat> <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat> <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
 <20260511084551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260511084551-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 11 May 2026 15:17:56 +0200
X-Gm-Features: AVHnY4L6LnZli-Ox_nOVNet2zhzvaOzPcipKZYQZqFtNKms-_nGPKvzOHkJ7hsQ
Message-ID: <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve
 full buf_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vF69EioZFmeVLjCS5mvqxaDprgUQDeNGHR8MuHPJ-YU_1778505491
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 14:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> > On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com>
> > wrote:
> > >
> > > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >> > >
> > > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > >> > > effective receive buffer below what the user configured via
> > > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > >> > > silently dropped and applications that rely on the full buffer size
> > > >> > > to deadlock.
> > > >> > >
> > > >> > > Also, the reduced space is not communicated to the remote peer, so
> > > >> > > its credit calculation accounts more credit than the receiver will
> > > >> > > actually accept, causing data loss (there is no retransmission).
> > > >> > >
> > > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > >> > >
> > > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > > >> > >     Resource temporarily unavailable
> > > >> > >
> > > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > > >> > > check, the advertised buf_alloc, and the credit update decision.
> > > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > >> > > The function returns buf_alloc as long as overhead fits within the
> > > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > > >> > > slow down.
> > > >> > >
> > > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >> >
> > > >> >
> > > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > > >> > it helps.
> > > >>
> > > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > > >>
> > > >> >
> > > >> > a spec violation because the spec says:
> > > >> > Only payload bytes are counted and header bytes are not
> > > >> > included
> > > >> >
> > > >> > and the implication is that a side can not reduce its own buf_alloc.
> > > >> >
> > > >> > no guarantee because the other side is not required to process your
> > > >> > packets, so it might not see your buf alloc reduction.
> > > >> >
> > > >> > as designed in the current spec, you can only increase your buf alloc,
> > > >> > not decrease it.
> > > >>
> > > >> We never enforced this, currently an user can reduce it by
> > > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > > >> introduced, should we update the spec?
> > > >
> > > >
> > > >it's not that we need to enforce it, it's that all synchronization
> > > >assumes this. as in, anyone can use an old copy until they run out
> > > >of credits.
> > > >
> > > >
> > > >> >
> > > >> > what can be done:
> > > >> > - more efficient storage for small packets (poc i posted)
> > > >> > - reduce buf alloc ahead of the time
> > > >>
> > > >> That's basically what I'm doing here: I'm using twice the size of
> > > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > > >> the other peer just `buf_alloc`.
> > > >>
> > > >> But then, somehow, we have to let the other person know that we're running
> > > >> out of space. With this patch that only happens when the other peer isn't
> > > >> behaving properly, sending so many small packets that the overhead exceeds
> > > >> `buf_alloc`.
> > > >>
> > > >> Stefano
> > > >
> > > >what is "not proper" here, it is up to the application what to send.
> > >
> > > Sure, but here we're just slowing down the application by telling it we
> > > don't have any more space.
> > >
> > > Again, without this patch we are just dropping data, which IMO is even
> > > worse.
> > >
> > > So I think we should merge this for now, while we handle better the EOM.
> > > If you prefer, I can drop the part where we reduce the buf_alloc
> > > advertised to the other peer, but at least we should drop data after
> > > `buf_alloc * 2` IMO.
> >
> > Okay, I thought it over over the weekend, and I agree that this patch
> > still doesn't solve the problem and would still result in packet loss.
> > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
> > coming to stable, I'd like to rework this patch so that we only start
> > dropping packets when the overhead plus the queued bytes exceeds
> > `buf_alloc * 2`.
> > Removing the other changes to reduce the buf_alloc advertised, but
> > terminating the connection so that both peers are aware that something
> > went wrong.
> >
> > Any objections?
> >
> > Stefano
>
> Let's try to first fix it upstream properly please. Discuss backporting
> later.

Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue") is already in Linus tree and will land soon on stable. Which
issue do you see on having a patch on top of that to close the
connection instead of losing data and breaking our test suite?

IMO we need that change in any case, because the previous code also
discarded packets without any notification, whereas breaking the
connection would be better in that case.

Stefano

