Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231876;
	b=Yqx4ky4jF6k5B7ISLFLSx8qluKm/LwcJnGtrTkgWeypamelgBE4E6WdLZyf58+UiciZm
	 kSeprPHLTn2B+7JIqLBATI55v+IPkTBcva5i8wxNCjWf1zy8+hHkVCpw4VbRN58yn/ip6
	 bvtzxCMzu4li49CCmCxOFZwl4EuweO/CWKTM3uwBnCe9shx1IjbygWTrB3vO9Kw3GPaqO
	 KhGZNFdp3sKCmEgUZED0LdyynLPucmObuxZ/PFdM1s8nF/tObO4wEx9H17bZfPnqcL7FV
	 kwBSgAqOh6p+FwTnptR6mgPnDprmvSPmA+2no0to9lFOx7iGZBTse1qeYKTEOiqdNrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231876;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
	b=zEqPTyislARCVB/OuI5FFNEiBF4hUA6IAtFSe7BIe+yi0kGZz/iLJ89xBERPhZrYriZa
	 3inusSINwFPE6wAK3hTUHeTkIfmK1yVTCC/VZ/mXAfLf4p0c/+jZwrRkumKAa0riEhD9Q
	 e6C6c6ROgWjmyGFxh1TsFAqB++QkBCd3LYhBP+JGL9TTr6zL0aWZkKcpYlNLVpFvKY+R/
	 14OHvp3gd16S0yAauSAMSjhJjJUzh5hqELxlXMY+bhj5bS+HYhl4jrgQ5fWnpY6X7oYS+
	 5aktOfonCAh6NxLpEyW19pwQ7cdgwlAGOKDeZ3SuANvsZuWbjC2o8FY7tiYEhzeJCKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="P/mE4Thg";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C0606D832
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 13:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5C0606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/mE4Thg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794231874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
	b=P/mE4ThgSArpSm522y0c7dkmQFX4oB7KC564ySEL4om9ejOGpeQzkI5nPVuDnAri0yDxFT
	BeqnEIPutaZbIW9YmEvHlWARh2zszUbRgkFMBvQn5gaIPxsgHaR0wI0QjIWC4BSADIYpJ9
	xF9sEPPt7Kw+I9dKsQn7X8RWNUevR20=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-rdZG5GnrPfiad8bc1FcR9Q-1; Mon, 09 Nov 2026 08:44:31 -0500
X-MC-Unique: rdZG5GnrPfiad8bc1FcR9Q-1
X-Mimecast-MFC-AGG-ID: rdZG5GnrPfiad8bc1FcR9Q_1794231871
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-843c6807307so984700a34.3
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 05:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231871; x=1794836671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
        b=b0yzCLZMT9KLBIGLCx/AsZEK4dd6dzjuMpTkKMAi43qinb+2E4h/hAHzP3MxGFLuyu
         +3rZZal7oQa/7P2hPc1ZWrA81v1NvM7lvPriIqNjLg9G00/dBwjX6f/mLiq8AdxCldlk
         x9QPC1cmFWkkZY6Q5Q9yPAvVh58td55H/XvO9PloQYBRHSjod8thbrIlYxo/V3Y6drRp
         nOEAzSN2LEtznYdkRZ37m9AEfnpS2VwgInf+CYX2/Pib6Z9XU7QzH00FEE97gPQ9lXQz
         k7TklHYB8lFCeKjL6Vzink9mdAWZVjwOFWnSGwenQFvobTOxCm2ikCdFLzwQ4U9DZavV
         zwTg==
X-Forwarded-Encrypted: i=1; AL+hErHZ5ST0761V0Dol9I+SJFoc5FSZ9JtMFYxTc5ZpEfHUIVTTQuuIYyY76l8Nl7obFnlfgW5p+H0mCsGMcDHomA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RanPX5O3dFmHIphg4SnrpnjK6I2w3VYEuSr06Ay1iwhyuVS8a
	/qZ++XcR6bzy6FXa+HCnom/5UtKMqJB9ebA5fCyZjSwZS2jN6b/GWRN1DS4pv1Qr5Lx1FeT3wco
	vYzbvLkNplkpb4LPyRqW5B42dhV6yXqCJN0bbr17nu7kP67ADdiLoKF+MPulcca+PFq1El0lTa0
	v4LYwDsXKc+RftBJUwqfEwzZKt9921GwbTEOYITUEOut8=
X-Gm-Gg: AYBFou28FyOWESfiLERlWeBEFHL9HBApMltvnwu5crGsN+C1x3YQDXSjgFCNImgoQXw
	q+okzC5O4F5V6Litwobz2DjiPtlWMzK/Xalhr1ALODt4wG/XUXRJ+h5ds0qZhB3k1NhR1GCSYXy
	qdW0IBS6iW7+hbPZS2HSI0M33lhsl7SKUAkIRVaGu4FU+GntzumOYt4rtB
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-56814022659mr2709785b6e.9.1794231870746;
        Mon, 09 Nov 2026 05:44:30 -0800 (PST)
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-56814022659mr2709756b6e.9.1794231870169; Mon, 09 Nov 2026
 05:44:30 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev> <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com> <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
 <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
In-Reply-To: <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Nov 2026 14:44:17 +0100
X-Gm-Features: AclHuK-kxgj3T37bjFOZ7HtSClpdxsaDMPyjW53dccz7zE1_ZSRFcURRmSZwzSI
Message-ID: <CADSE00L3AfcnfcboK1TdPQiW7ZW1KpxG70b1oyWFqpLciOG6ng@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, 
	dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com, 
	jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org, 
	vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KGizFTQTfoPBg-ikYUw8KRy7dgYjR1SrgAnQPvTLk8U_1794231871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/6/26 18:25, T.J. Mercier wrote:
> > On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 11/6/26 14:18, Tao Cui wrote:
> >>> From: Tao Cui <cuitao@kylinos.cn>
> >>>
> >>> udmabuf pins the pages of a memfd and hands them out as a dma-buf.  T=
he
> >>> data pages keep the accounting of the memfd they were instantiated in=
,
> >>> but the bookkeeping around them does not: the page pointer array and
> >>> the pinned_folios array, both sized by the buffer page count, plus th=
e
> >>> transient folios array sized by the memfd folio count, are plain
> >>> GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> >>> memory, and size_limit_mb defaults to INT_MAX.
> >>>
> >>> Charge the three kvmalloc allocations so the creator pays for the
> >>> metadata it induces.  The system heap in the same subsystem already
> >>> accounts its buffer allocation;
> >
> > Only if the mem_accounting param is set to true. We (Android)
> > currently depend on it being disabled because system heap buffers
> > don't have a single owner for their entire lifetime (ownership often
> > changes immediately after they are allocated), and the kernel doesn't
> > have the ability to switch who is charged for the buffer memory quite
> > yet. Albert is working hard on it at the moment.
>
> Good point, making sure that Albert is on CC as well.
>
> So basically we not only need to charge the backing store of a DMA-buf to=
 somebody else, but also the housekeeping overhead.

For system heaps the housekeeping size is fixed at creation so it
kindof fits the reservation model nicely. We'd only need it to account
for the overhead (as part of the MEMCG_DMABUF stat probably).

>
> Mhm, this here also complicates the charge transfer Albert is working on.

The transfer would just move the charge as a single unit. But yeah,
the complexity will come from lazy exporters or any other exporter
where the bookkeeping grows or changes.

>
> @Albert not something we need to take care about now, but please keep tha=
t in mind while working on that stuff.

Noted. The issue already exists so my series does not make it worse. I
will note this for a follow up series.

Thanks for tagging me!

BR,
Albert

>
> Regards,
> Christian.
>
> >
> > Could you update the message to note the mem_accounting param pls?
> >
> >>> the data pages here stay with the
> >>> memfd.
> >
> > memfd / udmabuf is a little special because it uses shmem for the
> > backing store, which is already tracked by memcg under all conditions
> > (except hugetlb). We don't currently use udmabuf, so the lack of memcg
> > charge transfer for udmabuf is not an issue. But once we get charge
> > transfer working for the system heap it'd be good to follow up with
> > udmabuf.
> >
> >> T.J. needs to take a look here, but I fear that this might break uAPI.
> >
> > Thanks for looping me in Christian. The buffer allocations cost
> > gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
> > so I don't expect charging them to break anyone. Leaving them
> > uncharged is an accounting gap though, since someone could spam many
> > udmabufs from the same memfd and only pay for the memfd pages once. So
> > this change is ok with me.
> >
> >> A lot of the DMA-buf resources are intentionally not charged against m=
emcg.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >
> > With the commit message updated to mention the mem_accounting param:
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
>

