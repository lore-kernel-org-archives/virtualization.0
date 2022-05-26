Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90637C433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 06:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B9464252F;
	Thu, 26 May 2022 06:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUk6vScJ_NYz; Thu, 26 May 2022 06:56:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74ABC42531;
	Thu, 26 May 2022 06:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 453F7C0039;
	Thu, 26 May 2022 06:56:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A053C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 06:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4797142534
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 06:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACqk8NaDz8NY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 06:56:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 398E24252C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 06:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653548194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fSmWl84XotlVVnrCywqRUyajUPmOb6IaEg27dR9dGY=;
 b=NbPPt9c/6kj1qInz0vOMS5Nb0unk8GFS/dvYvK9ECOxAt1RUio8h9/nVSzKU/y32qz/J+u
 akUhju5jlY5LPwPEXXs/QxyUYsa5bc9oiPnlsEfO1h4XbzdcId0HT7kSUkyqznaM4LlGuU
 WKB2HE3ZYSaDJjVFZC17sUq9XQXpDWc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-JJc03laiPGCsLRsy7sht5Q-1; Thu, 26 May 2022 02:56:31 -0400
X-MC-Unique: JJc03laiPGCsLRsy7sht5Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 y10-20020a2e95ca000000b00253d689f32fso115726ljh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 23:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6fSmWl84XotlVVnrCywqRUyajUPmOb6IaEg27dR9dGY=;
 b=r3sQWhhvX7N2ZYxwMi2wkOjeyv8BaSd8ejprhRjQQ13cBEfRl7LbdkSp5bRAXd2GWy
 nF0q0Huw6hI/vt19BTDwet5GFrCByZmSap8VmuQM1Oh6isNqC11HgJducHF5s87+H6sE
 2noM3iLPPVVDpyWao0nbXv4tXrf23ya6o9NpHMPvbzhtxBJMh74R/vmE6V2NrwfT5UHo
 ZbRe8nnGRhnpdsbvPgulp6mz1tkiZc5Wbiu6jVraBJ+ODl2JE1TpiShwAhGFXDdPyseZ
 47q3VjnKXB21zrTNr86dIB/J9jkLlG7OvpkRtftGR96QSjLQLIODxE4BGTyEABqOODqH
 sSmA==
X-Gm-Message-State: AOAM532pcWeeresOh4OTkpO3IO92JhU8+QtTd9y+fOtyS/kihs85SEos
 HK63zCNoQIXKg6y1Rrw1WIyz6936OTh0LRoiOcfJLPJd6UE/+yyVQC04vk8Qzwuh8ct0q4GU+rS
 vtGv+gr27x5ZLISW5aDRt1WQo2Y7K691IRH5ILYTQKPEZA/YhIVl82+mQMQ==
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr19549570lfu.98.1653548190279; 
 Wed, 25 May 2022 23:56:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Gi4ZSrMMOnRjE+RIPZ6lyKtkBCQkdHvHspNAZ316O2Xhf8EA2M7VBmvQmnvWg4HH588oEb9uJ5oNwpd0spY=
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr19549558lfu.98.1653548190070; Wed, 25
 May 2022 23:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
 <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
 <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
In-Reply-To: <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 May 2022 14:56:18 +0800
Message-ID: <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To: Andrew Melnichenko <andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="0000000000007d4a8d05dfe4b040"
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, Yan Vugenfirer <yan@daynix.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--0000000000007d4a8d05dfe4b040
Content-Type: text/plain; charset="UTF-8"

On Tue, May 24, 2022 at 7:07 PM Andrew Melnichenko <andrew@daynix.com> wrote:
>
> Hi all,
>
> The issue is that host segments packets between guests on the same host.
> Tests show that it happens because SKB_GSO_DODGY skb offload in
> virtio_net_hdr_from_skb().
> To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
> The solution with DODGY/PARTIAL offload looks like a dirty hack, so
> for now, I've lived it as it is for further investigation.

Ok, I managed to find the previous discussion. It looks to me the
reason is that __udp_gso_segment will segment dodgy packets
unconditionally.

I wonder if the attached patch works? (compile test only).

Thanks

>
>
> On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> > >
> > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > Technically they enable NETIF_F_GSO_UDP_L4
> > > (and only if USO4 & USO6 are set simultaneously).
> > > It allows to transmission of large UDP packets.
> > >
> > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > enable disable USO receives for IPv4 and IPv6 separately.
> > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > >
> > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > >
> > > New types for VirtioNet already on mailing:
> > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> > >
> > > Also, there is a known issue with transmitting packages between two guests.
> >
> > Could you explain this more? It looks like a bug. (Or any pointer to
> > the discussion)
> >
> > Thanks
> >
> > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > >
> > > Andrew (5):
> > >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> > >   driver/net/tun: Added features for USO.
> > >   uapi/linux/virtio_net.h: Added USO types.
> > >   linux/virtio_net.h: Support USO offload in vnet header.
> > >   drivers/net/virtio_net.c: Added USO support.
> > >
> > >  drivers/net/tap.c               | 10 ++++++++--
> > >  drivers/net/tun.c               |  8 +++++++-
> > >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> > >  include/linux/virtio_net.h      |  9 +++++++++
> > >  include/uapi/linux/if_tun.h     |  2 ++
> > >  include/uapi/linux/virtio_net.h |  4 ++++
> > >  6 files changed, 45 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.35.1
> > >
> >
>

--0000000000007d4a8d05dfe4b040
Content-Type: application/octet-stream; 
	name="0001-udp-allow-header-check-for-dodgy-GSO_UDP_L4-packets.patch"
Content-Disposition: attachment; 
	filename="0001-udp-allow-header-check-for-dodgy-GSO_UDP_L4-packets.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l3mnw1q30>
X-Attachment-Id: f_l3mnw1q30

RnJvbSA0Y2VkNmZmM2E4ZWExM2IwNjlkZDMwODdhYjIyZDI1MjY5NmUxZGVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBUaHUsIDI2IE1heSAyMDIyIDE0OjI5OjE3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gdWRwOiBh
bGxvdyBoZWFkZXIgY2hlY2sgZm9yIGRvZGd5IEdTT19VRFBfTDQgcGFja2V0cwpDb250ZW50LXR5
cGU6IHRleHQvcGxhaW4KClNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+Ci0tLQogbmV0L2lwdjQvdWRwX29mZmxvYWQuYyB8IDEwICsrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdWRwX29m
ZmxvYWQuYyBiL25ldC9pcHY0L3VkcF9vZmZsb2FkLmMKaW5kZXggNmQxYTRiZWMyNjE0Li45NTc5
ODg2Y2U1NTcgMTAwNjQ0Ci0tLSBhL25ldC9pcHY0L3VkcF9vZmZsb2FkLmMKKysrIGIvbmV0L2lw
djQvdWRwX29mZmxvYWQuYwpAQCAtMjgwLDYgKzI4MCwxNSBAQCBzdHJ1Y3Qgc2tfYnVmZiAqX191
ZHBfZ3NvX3NlZ21lbnQoc3RydWN0IHNrX2J1ZmYgKmdzb19za2IsCiAJaWYgKGdzb19za2ItPmxl
biA8PSBzaXplb2YoKnVoKSArIG1zcykKIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CiAKKwlp
ZiAoc2tiX2dzb19vayhnc29fc2tiLCBmZWF0dXJlcyB8IE5FVElGX0ZfR1NPX1JPQlVTVCkpIHsK
KwkJLyogUGFja2V0IGlzIGZyb20gYW4gdW50cnVzdGVkIHNvdXJjZSwgcmVzZXQgZ3NvX3NlZ3Mu
ICovCisKKwkJc2tiX3NoaW5mbyhnc29fc2tiKS0+Z3NvX3NlZ3MgPSBESVZfUk9VTkRfVVAoZ3Nv
X3NrYi0+bGVuLCBtc3MpOworCisJCXNlZ3MgPSBOVUxMOworCQlnb3RvIG91dDsKKwl9CisKIAlz
a2JfcHVsbChnc29fc2tiLCBzaXplb2YoKnVoKSk7CiAKIAkvKiBjbGVhciBkZXN0cnVjdG9yIHRv
IGF2b2lkIHNrYl9zZWdtZW50IGFzc2lnbmluZyBpdCB0byB0YWlsICovCkBAIC0zNjEsNiArMzcw
LDcgQEAgc3RydWN0IHNrX2J1ZmYgKl9fdWRwX2dzb19zZWdtZW50KHN0cnVjdCBza19idWZmICpn
c29fc2tiLAogCQllbHNlCiAJCQlXQVJOX09OX09OQ0UocmVmY291bnRfc3ViX2FuZF90ZXN0KC1k
ZWx0YSwgJnNrLT5za193bWVtX2FsbG9jKSk7CiAJfQorb3V0OgogCXJldHVybiBzZWdzOwogfQog
RVhQT1JUX1NZTUJPTF9HUEwoX191ZHBfZ3NvX3NlZ21lbnQpOwotLSAKMi4yNS4xCgo=
--0000000000007d4a8d05dfe4b040
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--0000000000007d4a8d05dfe4b040--

