Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082782FC41
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJaHkYX4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 800F441F23
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 800F441F23
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jJaHkYX4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zg1DUxow9NjB
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 15:05:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C5CF41F0E
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:05:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C5CF41F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702479947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IALMnPT1Pn+mCAgvupcIeg/euyf0UU0goFir4mrBYA0=;
	b=jJaHkYX4wMgf9YZG/4+CO3WMXmN1PWTuiELI9VKesGTGqsVfPjohezNSAj7UEy3yo97DCY
	SAcAaVbLy+jlvtFuXwxlr+ZbA3iGXy/1MLLhdohsNGe1PX0kmAxvmXC3wyAuL3ILkYXnVM
	Fum10CT9kzdfllyzpmjxdzhsR7zRkbg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Mn-QzqbDM3OnWWMRIcTLtA-1; Wed, 13 Dec 2023 10:05:45 -0500
X-MC-Unique: Mn-QzqbDM3OnWWMRIcTLtA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d03a03bc9so393423066b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 07:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479944; x=1703084744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IALMnPT1Pn+mCAgvupcIeg/euyf0UU0goFir4mrBYA0=;
        b=kX5tnuZ/vYYM7TAW5+acalMLH9GbW4+CpB/gypRkPX3T6u/+N1sbvZ04gOHCN8bLhC
         h/LSh80oSGO3nrl2fwamrs7+oaCWdmMTVXOPnvThE9DslBzpG1812ddMvRK03y264WFL
         ZZEYBJ8xpgXAMtGGyzhyL3cPbx8DjsdSmMW6CerMHftNgJlynCEJjdWZg8zj/7jdNmN9
         50cHVtnUzKT17cLTUsbF76wqEk8bUA/OUE3jYPYrG2QZviHCZ1Uz1YAoknUdUIdJdVqa
         p4ygSxuwei+WbC4pIUDm7IOfkFS/VgEF5TIx3vWp9Ips4kUGOAH4lUQiqiJhEtJqbVKh
         Lrqg==
X-Gm-Message-State: AOJu0YwUvZbmSHY5ZZw+kP344cRFHS821nH8yxurEO531//BpT8n9htU
	AwbAi1zBfPEZj9OFxt2MgGnGFhXfWASjQ5fv+j4btciLh5l11AJlUs6znsYoiZ5HxAjGJFM+pXW
	AktEWhkx+PBmYsgTubUwpY2UU43XdzSncm/X1VWu0Iw==
X-Received: by 2002:a17:907:bcf:b0:a19:a19b:789f with SMTP id ez15-20020a1709070bcf00b00a19a19b789fmr3597387ejc.98.1702479944247;
        Wed, 13 Dec 2023 07:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZkaTVx2I2WnVbfMFnlq6Ewpkn6ejNgpIAppfp1qF9bmTmBolwTuhqkmoUq1qGvz3Weq6q9g==
X-Received: by 2002:a17:907:bcf:b0:a19:a19b:789f with SMTP id ez15-20020a1709070bcf00b00a19a19b789fmr3597373ejc.98.1702479943907;
        Wed, 13 Dec 2023 07:05:43 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a1caa9dd507sm7941199ejd.52.2023.12.13.07.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:05:42 -0800 (PST)
Date: Wed, 13 Dec 2023 10:05:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <20231213100518-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 13.12.2023 11:43, Stefano Garzarella wrote:
> > On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> >>
> >>
> >> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> >>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> >>>>
> >>>>
> >>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> >>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>>                                DESCRIPTION
> >>>>>>
> >>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> >>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> >>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> >>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> >>>>>
> >>>>>
> >>>>> Patchset:
> >>>>>
> >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>
> >>>> Thanks!
> >>>>
> >>>>>
> >>>>>
> >>>>> But I worry whether we actually need 3/8 in net not in net-next.
> >>>>
> >>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> >>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> >>>> have strong opinion. I guess @Stefano knows better.
> >>>>
> >>>> Thanks, Arseniy
> >>>
> >>> Fixes means "if you have that other commit then you need this commit
> >>> too". I think as a minimum you need to rearrange patches to make the
> >>> fix go in first. We don't want a regression followed by a fix.
> >>
> >> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> >> patch fixes problem that is not related with the new patches from this patchset.
> > 
> > I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> > I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> > for every bytes we read, so we should not have this problem, right?
> 
> Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> 
> Thanks, Arseniy


hmm why not net-next?

> > 
> > So, maybe all the series could be "net".
> > 
> > Thanks,
> > Stefano
> > 

