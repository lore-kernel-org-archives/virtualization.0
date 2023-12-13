Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A942FE24
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeC1Cg86"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BB6B4056B
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BB6B4056B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PeC1Cg86
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oy7Gtpnj4haA
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 15:13:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43F314046F
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 15:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43F314046F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702480407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
	b=PeC1Cg86T813cTyTKLQh38RDl9q1rmAVFG9Tv9pA1wAG2X78hQh+uBkfbkGig06Ma9fgi7
	orJN6Z9sBo/pGVT6tuXdqxz12eW2j0iA+C3Z4IXVmxRCwBoDCo+5vp8RFN8rBASiln3k6T
	5s8uLnw+DV3Y86Dy1KqfVkXbnIa1020=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-u3gI5Bz1O_WvE6Zn3_S7TA-1; Wed, 13 Dec 2023 10:13:25 -0500
X-MC-Unique: u3gI5Bz1O_WvE6Zn3_S7TA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1da829c653so426239966b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 07:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480404; x=1703085204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
        b=Zt3+21DM7AE1NabPS9lZNv00LUcT22nafO+5dZzXgJD2d7EV6WD2I3F/zj5ZXqWdYc
         /xnIP2gpG96SXKZgxHE6OrCq6WEG+EolZUZr6OrXItv1Q5wwyyxGSCY540PVCY00MYS2
         lrtWvgOhrtdXxEyuSO9etQRIS0KCJCH9bxlyKWIiuvA8cVhgvlHC52xEcQqEFk1RREI9
         Lt96FGBBMyxwz/NI9Zo1Nptp4xa0YTDxJuF7jUSK480wfom2QdDETvjKToeHs5AewXlU
         RcIdDoOlQvMHm35MyavlmAo3f15NnF7DognupU7z1mZHDcvDYyyCsFDuaBYAm4a77tX9
         z3gw==
X-Gm-Message-State: AOJu0Yydm+95hU/djOQVmhfFpzkf3w4xdDWmg3eFHLVNkGsFZKtE/mjZ
	A6Oj34LBYpm6FY8+wuG5+l1Kdw/HyLmqYHd01d5FspzGD1qPQ/IGTi8f0VTxOOGeB5KCIGTXIx8
	iGW7wpgoy/sJYCnp4ZFQd6/UGNAr/qKo21n6kpp6Alw==
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353772ejd.5.1702480404099;
        Wed, 13 Dec 2023 07:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVEHNhpEpNkKjGAhK/XWOUUTGGv28PciIr/kdbCXWcbETJTEaPRgwgaTCSAZtVYbJ3/DARkA==
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353768ejd.5.1702480403779;
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a1e27e584c7sm7934486ejn.69.2023.12.13.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Date: Wed, 13 Dec 2023 10:13:15 -0500
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
Message-ID: <20231213100957-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231213100518-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> > 
> > 
> > On 13.12.2023 11:43, Stefano Garzarella wrote:
> > > On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> > >>
> > >>
> > >> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> > >>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> > >>>>
> > >>>>
> > >>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > >>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>>                                DESCRIPTION
> > >>>>>>
> > >>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> > >>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> > >>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> > >>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> > >>>>>
> > >>>>>
> > >>>>> Patchset:
> > >>>>>
> > >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > >>>>
> > >>>> Thanks!
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> But I worry whether we actually need 3/8 in net not in net-next.
> > >>>>
> > >>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> > >>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> > >>>> have strong opinion. I guess @Stefano knows better.
> > >>>>
> > >>>> Thanks, Arseniy
> > >>>
> > >>> Fixes means "if you have that other commit then you need this commit
> > >>> too". I think as a minimum you need to rearrange patches to make the
> > >>> fix go in first. We don't want a regression followed by a fix.
> > >>
> > >> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> > >> patch fixes problem that is not related with the new patches from this patchset.
> > > 
> > > I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> > > I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> > > for every bytes we read, so we should not have this problem, right?
> > 
> > Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> > 
> > Thanks, Arseniy
> 
> 
> hmm why not net-next?

Oh I missed your previous discussion. I think everything in net-next is
safer.  Having said that, I won't nack it net, either.

> > > 
> > > So, maybe all the series could be "net".
> > > 
> > > Thanks,
> > > Stefano
> > > 

