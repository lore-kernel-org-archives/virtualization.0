Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B5194A76
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766760649; cv=none; b=dQr8BKT+6A8tD78INWsf0sTcEF5ZoMdblO3TkEvD7tGMRX5sj51yUlubkKGq5bFfb9dwumrOR+bc/VMEpsvZoiPYgQZfWqz8nmicKkTuFpEmLGvRCkswvS1PfQu2r0TmUNQPqvOXbhA9PZrCVvm68+EO0J1orI/m2rDwSC5YKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766760649; c=relaxed/simple;
	bh=PKXRGzbxh1OlfF0T9/TV4KDNz94u0vtq7bXgSU6XVJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F4WHJSexQtaoTevgQt4hteUVL3+rzcKuYeB2KdUlPBM/nCjo9y8w/LqIpU4noYufVg8rK3SiqgKsBUiKj6sbpeTsiMSc+zpk6JytzRqbNmHGINthOUzLm4uIIZCntzsNkP4WWax/GIl1n2UhX7FYaVOf3wwJDGiuEAWdK5jt6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTAFdQBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTAFdQBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766760646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KQs8vvsCuYX4f4WNDWRFaCkEzOPPZG4H4J2HYQGAcg=;
	b=WTAFdQBN3oCJlv/bsrTK5NZb1/c/0bstaYlGeCFAjwNQ/FEPJ6+clqRtnkTYJUUV7PLk7J
	HTclUQWLRaVfnRPGY4G6bhSWrkZMYwg21QWrA7wAlB/mThpRN1g3S+YCf3VXiOVvfkbiI2
	u5FJGgOtWMaURp0UJ0LfyVVf72VwJ18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-F_s8R6FUNE6NDGUF6RSHKw-1; Fri, 26 Dec 2025 09:50:44 -0500
X-MC-Unique: F_s8R6FUNE6NDGUF6RSHKw-1
X-Mimecast-MFC-AGG-ID: F_s8R6FUNE6NDGUF6RSHKw_1766760644
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42fb1c2c403so4674952f8f.3
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 06:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766760643; x=1767365443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KQs8vvsCuYX4f4WNDWRFaCkEzOPPZG4H4J2HYQGAcg=;
        b=BuQRlTnlkdoH7deEH2PtNec+DFT7ZKlkX+tVkLa8WFnEhNnKpSmzhhoQRBq6obKKN/
         zzzDaAefKU0duADP5ZSjBZm0HeEIau1gDozl+lgDdsxsxfaPHDDnhXyz/9E5irDjGMgk
         16AXUCBNe+ojvJBnP/5zTgsJpabdSE8k50SjhkPaG9AcgujOiFnMLO+zK23AizwcQfO0
         U8zt5qXDKHrycIqyR8W7sGYs/vOSSqxMsUezGzeAnG6PFJjmAUl+tX4Zxaz3O9tQrPig
         P6SuiwXXTPCY8L4mX93cdN2DVfWEnEwEgSaRBo/cwvCMZJqFmkk22DbsA2p2+lvrsM6B
         PBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU02SDXNdc9WL8D/PsHY8BMzNEXkvRkE3/c3Cv1kiF99xHcBvNVpjdhxs6GTNOu7aBMatEhUyuGtqLQBFUNhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7gy4DfGO/T/jt9xglIxJLgYE/Bbsry8WvB0kmoWZk608bxrQi
	bOrWGyKyp2gPW7U+5F7iYnRaA4btEjlgwrLrLpcDhJTYTMjnqKtwo+fSBla81jlNEm25RY3w3vu
	B8v8d5kPJagnZDTg8UOac6w27GnkGEcaBQG/kWkwLArUAS1cGzIGK24Tbf0wwH3+5T+ak
X-Gm-Gg: AY/fxX5AlMwu1zkojwLK7qs8g9PdYvnb1ZNUUxX0Az00GnM4PtJDThgKzFFZYcsz0gb
	kHRlGBStGtr1mt+/MKjn53sUt5eI2KO+NhqZyrbzyTWEgXErfzL46DIkCK/yfrRYosW5RiChx77
	jTbi22ev4khP9b6lDYuM4gKmPZsvtQiGBDUGgJV6X0jV3VoWaIHNWwUrirhYjj67OsN+N6aGM0e
	JP/sayB2yWDWUC6NMVw9N/JLsrusogw1v7cy5fi6Je2SZJV8N7zjK3TPTyTp6cCquOdo6nyjg7H
	aumQsqcjv8y+z24WzbnnwC5yorOGokgV5xwYSsjefOvYu8N2FvqFBYBMNzBYRlPC8vXq5DDhlBU
	Ze+/YRXmFcR+4rhZCNz0fg86oRmUPw0pEEA==
X-Received: by 2002:a5d:4e46:0:b0:430:fe22:5f1c with SMTP id ffacd0b85a97d-4324e703af5mr20129793f8f.59.1766760643535;
        Fri, 26 Dec 2025 06:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMQ5W8XwHXEz0VCwLYh7DYgtWB1N+w4NhUInEUeh59gqlc2IFDP3VMltMmESqxQ1YzyY8Evg==
X-Received: by 2002:a5d:4e46:0:b0:430:fe22:5f1c with SMTP id ffacd0b85a97d-4324e703af5mr20129768f8f.59.1766760643060;
        Fri, 26 Dec 2025 06:50:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm46411703f8f.34.2025.12.26.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:50:42 -0800 (PST)
Date: Fri, 26 Dec 2025 09:50:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251226094933-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
 <20251125184936-mutt-send-email-mst@kernel.org>
 <4F24DF4D-7F5F-4BFC-B535-57C1AD66762D@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4F24DF4D-7F5F-4BFC-B535-57C1AD66762D@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 755NIAl0g72fhCpRG-1PrtyBaejtXn8ulKWiH8jzx5Y_1766760644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 26, 2025 at 04:49:11PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 25, 2025, at 6:50 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Tue, Nov 25, 2025 at 11:00:33AM -0700, Jon Kohler wrote:
> >> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> >> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> >> is called to flush done_idx and notify the guest if needed.
> >> 
> >> However, signaling the guest can take non-trivial time. During this
> >> window, additional RX payloads may arrive on rx_ring without further
> >> kicks. These new payloads will sit unprocessed until another kick
> >> arrives, increasing latency. In high-rate UDP RX workloads, this was
> >> observed to occur over 20k times per second.
> >> 
> >> To minimize this window and improve opportunities to process packets
> >> promptly, immediately call peek_head_len after signaling. If new packets
> >> are found, treat it as a busy poll interrupt and requeue handle_rx,
> >> improving fairness to TX handlers and other pending CPU work. This also
> >> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > 
> > Given this is supposed to be a performance improvement,
> > pls include info on the effect this has on performance. Thanks!
> 
> I had already mentioned we’re avoiding ~20k schedulers/IPIs in that
> example, but I can add more detail. Let’s resolve the other parts of
> the thread first and go from there?


the discussion seems to have died down.
I suggest reposting with perf data you have
(which test, how much improvement, what cpu usage)
collected in the commit log.

thanks!

> > 
> >> ---
> >> drivers/vhost/net.c | 21 +++++++++++++++++++++
> >> 1 file changed, 21 insertions(+)
> >> 
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 35ded4330431..04cb5f1dc6e4 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> >> struct vhost_virtqueue *tvq = &tnvq->vq;
> >> int len = peek_head_len(rnvq, sk);
> >> 
> >> + if (!len && rnvq->done_idx) {
> >> + /* When idle, flush signal first, which can take some
> >> + * time for ring management and guest notification.
> >> + * Afterwards, check one last time for work, as the ring
> >> + * may have received new work during the notification
> >> + * window.
> >> + */
> >> + vhost_net_signal_used(rnvq, *count);
> >> + *count = 0;
> >> + if (peek_head_len(rnvq, sk)) {
> >> + /* More work came in during the notification
> >> + * window. To be fair to the TX handler and other
> >> + * potentially pending work items, pretend like
> >> + * this was a busy poll interruption so that
> >> + * the RX handler will be rescheduled and try
> >> + * again.
> >> + */
> >> + *busyloop_intr = true;
> >> + }
> >> + }
> >> +
> >> if (!len && rvq->busyloop_timeout) {
> >> /* Flush batched heads first */
> >> vhost_net_signal_used(rnvq, *count);
> >> -- 
> >> 2.43.0
> > 
> 

