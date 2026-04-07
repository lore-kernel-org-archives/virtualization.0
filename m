Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6237A4BA
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595192; cv=none; b=BT+O/9pfUuSm3miGiAY2A52Pl4Z4lT9bjkpQ1rsgOsW1ZqiN0bn1Fq2Q8gE9IMkYU8Tm1XUt/NXsC07QlVYaLGSVNp66vh4550I4K8QbL2ECf+fQQ7rNIIpzJy7EG8X/hZvXSuUeHVNta98xY83EOH3IYI1GpYkVkt5pH2kuz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595192; c=relaxed/simple;
	bh=JrAU7dakT74/RxBFvUpjBWABLNs0Gv6eJdwYTd2qZ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E1MQd7SCOiFRfYaz616jlDAC4/3QocBRGXJcRqqf0hleZb6NKd+bh84OcfZxlgm8aRHP9tkHuaPJqPBA9UNMBKorgVJqC5XEtombDBaY+77bl1jTiPS4oNR0KroYxC2NwVlMVwO99hnpcWX9CbOd2dkt1dYD0FDPEubj7M3FwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJS8HiXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJS8HiXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775595190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmxjAVj/53olFpGs8rcAFZ32C/p8gfd88WtC5WIKDfI=;
	b=cJS8HiXQ3+15VoMn0xMlf74fzlkMerZ5fVtFCy5pYELA+0C3D57YNhlqJcUZZfUnme7KrS
	m5+FdkvivmS9L7L7Zv1fGXtmNNDHx2rZg1t5geBNRsapil8gXVJcn9wFMuM5ybQ9eBqnit
	9kObuZWkp5pRvQBnrWgK8Ar6qDz6aQs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-eTZVgIBwMqOfSoyrXeqfHg-1; Tue, 07 Apr 2026 16:53:09 -0400
X-MC-Unique: eTZVgIBwMqOfSoyrXeqfHg-1
X-Mimecast-MFC-AGG-ID: eTZVgIBwMqOfSoyrXeqfHg_1775595188
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a1d8b4bc90so8928356d6.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 13:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595188; x=1776199988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmxjAVj/53olFpGs8rcAFZ32C/p8gfd88WtC5WIKDfI=;
        b=Y2yMe31rGb3QKVl5xxkCxO0MVLpBvbF5uAw9xudepcc7hXpbLhLqIMt9mFaplRJdVp
         1yt9wv7q3o/XAATc5WMjFc12dkHJRoou4cleg4YBAvdnSw6nvx16ERuF189heeMHVpgn
         NawpCuElpv4CojjxSFrHSKL5UHGPEeTxA8EZgqJr5K3aTnT4DNqO6wrMAVtdYGwxB68o
         XDQt+MJV+BqOIRdobXGpHkN4Szu2FbtzZezZCax3k1X/zkkGwaMekphdzvEv5t3czUk2
         O81O7MKAgG6QTi/j2YBHAhWz4VvcvT8ObkperScUNY3XGlfpkMm8c/xv29UkudqlZrYL
         LtOw==
X-Forwarded-Encrypted: i=1; AJvYcCXkIlW+JoXyYRuv6chEycl5vybjzeLDIMkoF2fA4FDuCDPaBbOYbj6+fH7KMFs6Qlti71as88pebPMFXCbTkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz/0kpzjZdhjkZB1WF213Zg1HB280VnDnFEqyXn6qHqLgijWj2
	55u+l/BUjQPcV2sP+ur9BzGOouYT13wvjZsV6BEqFsV/eanSJ9B0HLseRQdDuMMf6BVXXRML760
	Eejv0APVFuD0zJ5tvGMExpMkQpCLtlLtiE48/uWDTqeHUhsxeVv2Z+IxmX+b93psRfbSZ
X-Gm-Gg: AeBDietJfGOb1fxphSl+N2Z1ucxyauflY51WlTO8PPYdh4PhgP49jbX7OatXKU8YjFB
	SBKet0qTzvNBiso9HXlv1TiHVptI4Tg/D4gLtCLCmMG7vNyYbi+l27lRYBK7zpISF+PqB43x5RA
	9P59aaq2JnmDeREqVwEsR+IWw22PIPDCJMvgPJFLeMmF0+ShtFcafLTNWYY0dsqsKDvFd+44uBw
	enr9ydN15RzVPhaRiYGyp0Aqi9wU8HYyxm1IKK6AtynckAyBVWUxiUipPcpV0us4B7O8OSuG1Bk
	KCOYAxTEXv5QZyhN5ao3jVVjpOEr2FxzQe7IF4hhm9Y4cuDBLfO6aow3MOEQnvFOFNCASNRc5oT
	ktABXC0GGCG9K
X-Received: by 2002:ad4:5e8f:0:b0:8a6:ee21:6587 with SMTP id 6a1803df08f44-8a703364a1amr262948826d6.6.1775595188387;
        Tue, 07 Apr 2026 13:53:08 -0700 (PDT)
X-Received: by 2002:ad4:5e8f:0:b0:8a6:ee21:6587 with SMTP id 6a1803df08f44-8a703364a1amr262948246d6.6.1775595187773;
        Tue, 07 Apr 2026 13:53:07 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a655sm155066226d6.29.2026.04.07.13.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:53:06 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:53:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 4/4] virtio_ring: preserve VIRTIO_F_RING_RESET in
 transport features
Message-ID: <20260407165211-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-5-astellman@stellman-greene.com>
 <20260407122025-mutt-send-email-mst@kernel.org>
 <CAChPuV92aD4BibJiGfMASQVQBHAoz+3OgzQS6Hb2Dw7JDcRJTQ@mail.gmail.com>
 <20260407140713-mutt-send-email-mst@kernel.org>
 <CAChPuV_D33D8t9wFNZB0pq9hfrAe_WKF4LX2VpEmF=npogx7gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAChPuV_D33D8t9wFNZB0pq9hfrAe_WKF4LX2VpEmF=npogx7gQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hJatH0k5wQOZDQsOHyKu1oYdL9pcWKLNrrszQZFfBb4_1775595188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 04:00:00PM -0400, Andrew Stellman wrote:
> No, sorry, I tested it, only with a unit test after finding it via static
> analysis, not the "real" way using the whole kernel build. (Also replied with
> the test for 0002.)
> 
> Found with static analysis, reproduced with a unit test (save attached file to
> drivers/virtio/test0004.c):
> 
> % cd drivers/virtio          
> % git checkout virtio_ring.c
> Updated 0 paths from the index
> % sed -n '/^void vring_transport_features/,/^}/p' virtio_ring.c > extracted.c &
> & gcc -Wall -Werror -o test0004 test0004.c && ./test0004
> FAIL: VIRTIO_F_RING_RESET cleared during negotiation
> % git apply 0004-virtio_ring-preserve-VIRTIO_F_RING_RESET-in-transpor.patch
> % sed -n '/^void vring_transport_features/,/^}/p' virtio_ring.c > extracted.c &
> & gcc -Wall -Werror -o test0004 test0004.c && ./test0004
> PASS: VIRTIO_F_RING_RESET preserved
> 
> If this doesn't work, feel free to ditch.

I want to know if there's a bug or not, and what does the patch achieve.
The current code does not make it clear at all.


> On Tue, Apr 7, 2026 at 2:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Apr 07, 2026 at 01:33:39PM -0400, Andrew Stellman wrote:
>     > Code analysis only — not observed in practice. And you're right that on
>     PCI it
>     > doesn't matter: vp_transport_features() re-sets the bit after
>     > vring_transport_features() clears it, so PCI never actually loses the
>     feature.
> 
>     Oh. please do test patches, or note they were not tested.
>     how were rest of patches here tested?
> 
>     >
>     > The gap is for transports that call vring_transport_features() without
>     > independently re-setting VIRTIO_F_RING_RESET afterward. Whether any
>     current
>     > transport hits this in practice I'm not sure — it may just be a whitelist
>     > consistency fix at this point.
>     >
>     > Happy to add a Fixes tag and resend, or drop it if you think the
>     PCI-level
>     > re-set makes it unnecessary.
>     >
>     > Fixes: 04ca0b0b16f1 ("virtio_pci: support VIRTIO_F_RING_RESET")
> 
> 
>     surely not this because pci is fine.
> 
>     > On Tue, Apr 7, 2026 at 12:22 PM Michael S. Tsirkin <mst@redhat.com>
>     wrote:
>     >
>     >     On Tue, Apr 07, 2026 at 08:39:04AM -0400, Andrew Stellman wrote:
>     >     > vring_transport_features() whitelists known transport feature bits
>     and
>     >     > clears the rest via __virtio_clear_bit(). VIRTIO_F_RING_RESET is
>     >     > missing from the whitelist, so it is unconditionally cleared during
>     >     > feature negotiation. Drivers that depend on ring reset capability
>     >     > silently lose the feature.
>     >
>     >     Hmm was this observed in practice or just from code analysis?
>     >     And on which transport?
>     >     Because
>     >
>     >
>     >     static void vp_transport_features(struct virtio_device *vdev, u64
>     features)
>     >     {               
>     >             struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>     >             struct pci_dev *pci_dev = vp_dev->pci_dev;
>     >
>     >             if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>     >                             pci_find_ext_capability(pci_dev,
>     >     PCI_EXT_CAP_ID_SRIOV))
>     >                     __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
>     >
>     >             if (features & BIT_ULL(VIRTIO_F_RING_RESET))
>     >                     __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
>     >
>     >
>     >     ...
>     >
>     >
>     >
>     >     }
>     >
>     >
>     >
>     >
>     >     > Add VIRTIO_F_RING_RESET to the switch statement, matching the other
>     >     > transport-level features.
>     >     >
>     >     > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
>     >     > ---
>     >     >  drivers/virtio/virtio_ring.c | 2 ++
>     >     >  1 file changed, 2 insertions(+)
>     >     >
>     >     > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/
>     virtio_ring.c
>     >     > index fbca7ce..2cb643f 100644
>     >     > --- a/drivers/virtio/virtio_ring.c
>     >     > +++ b/drivers/virtio/virtio_ring.c
>     >     > @@ -3524,6 +3524,8 @@ void vring_transport_features(struct
>     virtio_device
>     >     *vdev)
>     >     >                       break;
>     >     >               case VIRTIO_F_IN_ORDER:
>     >     >                       break;
>     >     > +             case VIRTIO_F_RING_RESET:
>     >     > +                     break;
>     >     >               default:
>     >     >                       /* We don't understand this bit. */
>     >     >                       __virtio_clear_bit(vdev, i);
>     >     > --
>     >     > 2.34.1
>     >
>     >
> 
> 


