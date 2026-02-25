Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33CB3AE6E1
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021905; cv=none; b=Ndyi9TUN8b1Y6XMIJD37165XNp0OLemY7TI1UxyQgpBjjr8QPP2cVnynLfHhdcTL4i6twijJeknMHJtnlLISAQO4nhbJUgyrQ8Hr4yW3Qkk8LCx7J3keGfa+ALwVoAUCbAqCI0g3NOWp11oqOB0goulovQd3Df4qY+XZZBL3Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021905; c=relaxed/simple;
	bh=+IvlZv4NYJan3tCgqGs5gfqQQiOlBruLqq2DMpw10Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IgT5KN5dv5SSxJj5LDma/3u8yVjABry5p21D2OZucCsgAS8rifWhyNE8ZC4E3K4T6ngICxlnDN+QmRku3nPR0GwhKFxmJepfn+tp4PABUwZTzyIg+W7JfLNyLKwpG9tncXemZffplUYod8E5E1MWdBpv8cDy1Rj6tP5ORfPg9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiZ+J6Kl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiZ+J6Kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772021903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s51WxFF04UegQjwCkS2I0W0zutiovtpKD1GDKaSV2FM=;
	b=IiZ+J6KlroWromxo1MLtUca3XhAcBDADRvQKbU9ICERyiKB02Y684FBKfD7jrNgQV0/70h
	4Suf6R58j4HGTUJuCBAd2S1hNCVVxsMLE9DAf93nA8NTvWPOX+RjeniKt89fv5/WqVdojM
	YsnYOBQGj1nwnLWKQCT3vXZ/QwSrU4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XLaIpq-5MSe1_18_V8COMA-1; Wed, 25 Feb 2026 07:18:20 -0500
X-MC-Unique: XLaIpq-5MSe1_18_V8COMA-1
X-Mimecast-MFC-AGG-ID: XLaIpq-5MSe1_18_V8COMA_1772021899
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43993fea282so115335f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 04:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021899; x=1772626699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s51WxFF04UegQjwCkS2I0W0zutiovtpKD1GDKaSV2FM=;
        b=wgPB60NjsxfLjYQCtEeozWY9ppyjjuYC1C0EgwAcZAkeXdc7O57h/gwjKiQP1A3SUI
         6LtufdVU9YF2bWxFZQr0TljzBxaNwo05GT2P6YIhAzU12JMGlVNr0ZevUuLOLPKhzy7I
         jUjNxVKjXA/ESApEt/T47wkGDO070iH8TxXMttpdvN9kpKlsPaEUIQ0n7hov6/PIZPM+
         dvFaucGOL8lAF9D8f5RePJDINU+P7ftgDVcBh4OMm1aE30imeZ5vwMV5VYM+D70rSXEN
         G2rnoTpNf0VaqrGT/UaITkOl6LYaqRMfEY1RhXhyurWUfD0sB2Rg0bWw2+j2dfRjszbG
         rtuA==
X-Forwarded-Encrypted: i=1; AJvYcCWDARHZQXigxZSF8tWX5dnw/0tHW9oNB6yhm4Mlu/xmeWsKrObRyIcKC4/Knhv/rwzFvlHzcLLoJwApd4MTYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrOQLgvfRMdbl7gFG20JPEyvcmFY7lJOAxBJrD1CsnaWtsVfWe
	SPxa/WAKKxrgEjqNZoB64r8t9uiPyHugbD0nwBLLEMtVZu7kUxUjygrIDDiG05J71uoIIdFbdEp
	PI0MQKfMlCq84nKvWxt+jnucJL/0rh5SlI3PIwBKe3y/8sgdDgPnKcfpqtU+jkCznBfDp
X-Gm-Gg: ATEYQzwkpP1W0bR1TCgFJ8B9CpBLxxuNLiDkvW+pe8bfxi0BssUPjESIDlLtOxI6lGR
	8FATyaXZPfOxmUp+HYiT8+6KuIOJj7/LdSy/rrDPLVxa/8Y3EP8aZGGJtNJonlJzFRSWTTdUonW
	lDy47kXjFr2PbhJu7QXbc2uUzAePKreQZEZCz3Jo2R0ofvA0mX43/s+/dLSmQqdTuNl+b6xmPKw
	M2aeo4oQkigAMughdhIHe2zL3GjHDL98uuJg+/cNznI9Ssyrt4o8+9ZCFK03rt84kmDW3oS9K2B
	oASCv+eM0957gS7tO3ErrnySLKQiA2r1WDKysWmOHN8nv2HnWUUvHAHRNsvPQTxLmjssgLoBx7U
	mTnI1ZCzLOrnmtPy0gkLmogIU0fCdMVwCd13S23+4Mv9Iyw==
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr4041559f8f.1.1772021898597;
        Wed, 25 Feb 2026 04:18:18 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr4041492f8f.1.1772021897994;
        Wed, 25 Feb 2026 04:18:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm34011308f8f.5.2026.02.25.04.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:18:17 -0800 (PST)
Date: Wed, 25 Feb 2026 07:18:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Message-ID: <20260225071659-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
 <20260225050441-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 98gVucJMJHJGwxl2f7YzbZKRRgWGREXAduzxWKAYQFs_1772021899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 12:13:01PM +0000, Srujana Challa wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 25, 2026 3:35 PM
> > To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: Srujana Challa <schalla@marvell.com>; pabeni@redhat.com;
> > jasowang@redhat.com; eperezma@redhat.com; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; Nithin Kumar Dabilpuram
> > <ndabilpuram@marvell.com>; Shiva Shankar Kommula
> > <kshankar@marvell.com>; netdev@vger.kernel.org;
> > virtualization@lists.linux.dev
> > Subject: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key size
> > max check with BUILD_BUG_ON
> > 
> > On Wed, Feb 25, 2026 at 05: 52: 29PM +0800, Xuan Zhuo wrote: > On Wed,
> > 25 Feb 2026 04: 47: 22 -0500, "Michael S. Tsirkin" <mst@ redhat. com> wrote:
> > > > On Wed, Feb 25, 2026 at 05: 36: 06PM +0800, Xuan Zhuo wrote: > > > On
> > Wed, ZjQcmQRYFpfptBannerStart Prioritize security for external emails:
> > Confirm sender and content safety before clicking links or opening
> > attachments <https://us-phishalarm-
> > ewt.proofpoint.com/EWT/v1/CRVmXkqW!tc3Z1f8UYnWatK-
> > 8Gd3a7iLAAhjzwNasdLDRrDCP-M_xUEAECz9j2fwxWlWq3EugFfzY8uKAhQ-
> > Q2XIdQs89ldnlzrpsl9A$>
> > Report Suspicious
> > 
> > ZjQcmQRYFpfptBannerEnd
> > On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin"
> > <mst@redhat.com> wrote:
> > > > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa
> > <schalla@marvell.com> wrote:
> > > > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in
> > > > > > > > > > net-next, use BUILD_BUG_ON to enforce the limit at
> > > > > > > > > > compile time and remove the redundant runtime max check.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > > > > b/drivers/net/virtio_net.c index
> > > > > > > > > > eeefe8abc122..768ad5523dfa 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct
> > virtio_device *vdev)
> > > > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > > >  			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > > >  		}
> > > > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > > > -				 "rss_max_key_size=%u exceeds driver
> > limit %u, disabling RSS\n",
> > > > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > > > -			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > > > -		}
> > > > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >=
> > NETDEV_RSS_KEY_LEN);
> > > > > > > > >
> > > > > > > > > Do we really need this check?
> > > > > > > > >
> > > > > > > > > If I understand correctly, the intention is to cap key_sz
> > > > > > > > > at 256. However, since key_sz is of type u8, its maximum
> > > > > > > > > value is inherently 255, making this check redundant. This
> > > > > > > > > is not only limited by this kernel code, the virtio-net spec defines
> > this.
> > > > > > > >
> > > > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > > > >
> > > > > > > > We never *need* BUILD_BUG_ON by definition, what this does
> > > > > > > > is document the assumption.
> > > > > > > >
> > > > > > > >
> > > > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value
> > > > > > > > > smaller than 256 in the future, this check would no longer enforce
> > the intended limit correctly.
> > > > > > > >
> > > > > > > > then it would fail build.
> > > > > > >
> > > > > > > So, does this mean we don't need to account for the case where
> > > > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is
> > 64?
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > >
> > > > > > yes.
> > > > >
> > > > > Why?
> > > > >
> > > > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of
> > > > > 64, does this violate the spec?
> > > >
> > > > not the value of key_sz. If type of key_sz
> > > >
> > > >
> > > > i actually do not understand the question. this is not what
> > > > BUILD_BUG_ON checks.
> > >
> > > So this is the issue. Originally, the code checked whether the value
> > > of key_sz was less than NETDEV_RSS_KEY_LEN. However, switching to a
> > > type_max check means it no longer covers the scenario I described.
> > > Therefore, I think this is unreasonable.
> > >
> > > Thanks
> > 
> > 
> > patch 1 is unreasonable i think.
> 
> Patch 1 is targeted for net, addressing an issue where VIRTIO_NET_RSS_MAX_KEY_SIZE is fixed at 40, 
> which is only the minimum required by the spec. This led to virtio‑net probe failures when devices
> reported an RSS key size greater than 40. However, the driver also cannot handle keys larger than
> NETDEV_RSS_KEY_LEN (previously 52) due to the BUG_ON(len > sizeof(netdev_rss_key)) in 
> netdev_rss_key_fill. To resolve both issues, VIRTIO_NET_RSS_MAX_KEY_SIZE has been replaced
> with NETDEV_RSS_KEY_LEN.

but where would driver *get* keys larger than sizeof(netdev_rss_key),
even if device supports more.



> Patch 2 is added as per your suggestion to address following warning in net-next after  NETDEV_RSS_KEY_LEN
> was increased to 256.
> +../drivers/net/virtio_net.c:6642:14: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
> + 6642 |                 if (key_sz > NETDEV_RSS_KEY_LEN) {
> +      |                     ~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
> +1 warning generated.
> Sorry, I forgot the cover page.
> 
> Thanks! 
> > 
> > which is why patchsets should have a cover letter btw so one can reply to just
> > patch 1.
> > 
> > 
> > > >
> > > > > > the code makes assumptions but it documents them and not just
> > > > > > documents them, build will fail if they are violated.
> > > > >
> > > > > About this, I am ok.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Moreover, you should add a cover letter.
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >  	}
> > > > > > > > > >
> > > > > > > > > >  	return 0;
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> 

