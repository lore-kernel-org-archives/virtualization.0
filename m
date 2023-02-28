Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE4DC64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 10:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6208A61114;
	Tue, 28 Feb 2023 10:26:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6208A61114
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTuSDd+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ys6470F4xTxu; Tue, 28 Feb 2023 10:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F05C60709;
	Tue, 28 Feb 2023 10:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F05C60709
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67BA4C0032;
	Tue, 28 Feb 2023 10:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A874C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBEDA61100
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:26:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBEDA61100
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8ipyMprRnC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D73FA60709
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D73FA60709
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677579986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDfMtxXzFQrOJbPCiOn60FjJ4o5RbbkA4AqIa3ieAbM=;
 b=PTuSDd+3av7ZJv0pnzExkB98gb09JS+2fvrdsRQ05wTO+kG8X0IRwrLy++JgMIo8iScLpU
 EuXw1CdBUph9b65EJsqVRffGCUhHP7s6mmJGwKdFs85v4HoLXme2GyubLy46kDzhnjxRxS
 JdfjBCB1Wc7SC3QKrw45R7DNvCUbL+o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-2slIFaMsM2-_xqCkJ6zneQ-1; Tue, 28 Feb 2023 05:26:25 -0500
X-MC-Unique: 2slIFaMsM2-_xqCkJ6zneQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 u5-20020a5d6da5000000b002cd82373455so343870wrs.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDfMtxXzFQrOJbPCiOn60FjJ4o5RbbkA4AqIa3ieAbM=;
 b=6RAk0ofKiBbLpkZiq4P68uzDr96l4WZ+QoAY84tSP6W6OYBDbu45E5w5Q2U9KbPDzK
 9xYy1/P5ieIUXu9q9Kf2fSTqacjvQwwxP30ncN7OiMDrlLeEFsHHaQmQ1J60NCDNlU/U
 yWtB0ymQEr5lM5/1AW3bA5m37mc9G/CxbtYI0qibyXqRQZm/c3INncw8Mpgc1XQnutZy
 bQ+3cZSMNJcyag+DhTXtdLbvWZQ4kxiyxiQ5miZ5/9Qgw3SpMX6rQ0yBiyUoS8cdTI+J
 ovADlXZC9d9FcV3EW78EQvXeC5UArat6z7gNgGBLaEat89I/PeUwImzC/0Ae8GDS3oJ8
 Cvow==
X-Gm-Message-State: AO0yUKWH2Nu9286iFN1y1J9Df08248yY47HxC46RkH3b4Fr2zSF3FMhk
 yqeY6fehMnQaqwuzPnkIHsTjhm/wDr1wicxgG6seJAIkltJAyNqt7hXVNetraDTdKhYvwfWzNs2
 RKSNWHzOigT+35coMUmQyV9iiojhjvL4i00geBm+qzg==
X-Received: by 2002:a05:600c:4b28:b0:3eb:39e7:35fe with SMTP id
 i40-20020a05600c4b2800b003eb39e735femr1619722wmp.30.1677579984450; 
 Tue, 28 Feb 2023 02:26:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/C6MKWw0xixGzqMyKbw92PptZzuISaOIFG9J8ILfyAAEOfPLXJ9kl34y318rcejVMrMLMjgw==
X-Received: by 2002:a05:600c:4b28:b0:3eb:39e7:35fe with SMTP id
 i40-20020a05600c4b2800b003eb39e735femr1619707wmp.30.1677579984138; 
 Tue, 28 Feb 2023 02:26:24 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b003e20fa01a86sm12877242wms.13.2023.02.28.02.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 02:26:23 -0800 (PST)
Date: Tue, 28 Feb 2023 11:26:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 07/12] vsock/virtio: MGS_ZEROCOPY flag support
Message-ID: <20230228102619.yevqfgx2vj5aeyn4@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <716333a1-d6d1-3dde-d04a-365d4a361bfe@sberdevices.ru>
 <20230216151622.xu5jhha3wvc3us2b@sgarzare-redhat>
 <f76705ca-f20a-3286-3c61-46a953518991@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f76705ca-f20a-3286-3c61-46a953518991@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 20, 2023 at 09:04:04AM +0000, Krasnov Arseniy wrote:
>On 16.02.2023 18:16, Stefano Garzarella wrote:
>> On Mon, Feb 06, 2023 at 07:00:35AM +0000, Arseniy Krasnov wrote:
>>> This adds main logic of MSG_ZEROCOPY flag processing for packet
>>> creation. When this flag is set and user's iov iterator fits for
>>> zerocopy transmission, call 'get_user_pages()' and add returned
>>> pages to the newly created skb.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 212 ++++++++++++++++++++++--
>>> 1 file changed, 195 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
>>> index 05ce97b967ad..69e37f8a68a6 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -37,6 +37,169 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
>>> =A0=A0=A0=A0return container_of(t, struct virtio_transport, transport);
>>> }
>>>
>>
>> I'd use bool if we don't need to return an error value in the following
>> new functions.
>>
>>> +static int virtio_transport_can_zcopy(struct iov_iter *iov_iter,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t=
 free_space)
>>> +{
>>> +=A0=A0=A0 size_t pages;
>>> +=A0=A0=A0 int i;
>>> +
>>> +=A0=A0=A0 if (!iter_is_iovec(iov_iter))
>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0 if (iov_iter->iov_offset)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0 /* We can't send whole iov. */
>>> +=A0=A0=A0 if (free_space < iov_iter->count)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0 for (pages =3D 0, i =3D 0; i < iov_iter->nr_segs; i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0 const struct iovec *iovec;
>>> +=A0=A0=A0=A0=A0=A0=A0 int pages_in_elem;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 iovec =3D &iov_iter->iov[i];
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Base must be page aligned. */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (offset_in_page(iovec->iov_base))
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Only last element could have not page aligned=
 size.=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i !=3D (iov_iter->nr_segs - 1)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (offset_in_page(iovec->iov_len))
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pages_in_elem =3D iovec->iov_len >> =
PAGE_SHIFT;
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pages_in_elem =3D round_up(iovec->io=
v_len, PAGE_SIZE);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pages_in_elem >>=3D PAGE_SHIFT;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* In case of user's pages - one page is one fra=
g. */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (pages + pages_in_elem > MAX_SKB_FRAGS)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 pages +=3D pages_in_elem;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 str=
uct sk_buff *skb,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 str=
uct iov_iter *iter,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 boo=
l zerocopy)
>>> +{
>>> +=A0=A0=A0 struct ubuf_info_msgzc *uarg_zc;
>>> +=A0=A0=A0 struct ubuf_info *uarg;
>>> +
>>> +=A0=A0=A0 uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iov_length(i=
ter->iov, iter->nr_segs),
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);
>>> +
>>> +=A0=A0=A0 if (!uarg)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +
>>> +=A0=A0=A0 uarg_zc =3D uarg_to_msgzc(uarg);
>>> +=A0=A0=A0 uarg_zc->zerocopy =3D zerocopy ? 1 : 0;
>>> +
>>> +=A0=A0=A0 skb_zcopy_init(skb, uarg);
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static int virtio_transport_fill_nonlinear_skb(struct sk_buff *skb,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct vsock_sock *vsk,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct virtio_vsock_pkt_info *info)
>>> +{
>>> +=A0=A0=A0 struct iov_iter *iter;
>>> +=A0=A0=A0 int frag_idx;
>>> +=A0=A0=A0 int seg_idx;
>>> +
>>> +=A0=A0=A0 iter =3D &info->msg->msg_iter;
>>> +=A0=A0=A0 frag_idx =3D 0;
>>> +=A0=A0=A0 VIRTIO_VSOCK_SKB_CB(skb)->curr_frag =3D 0;
>>> +=A0=A0=A0 VIRTIO_VSOCK_SKB_CB(skb)->frag_off =3D 0;
>>> +
>>> +=A0=A0=A0 /* At this moment:
>>> +=A0=A0=A0=A0 * 1) 'iov_offset' is zero.
>>> +=A0=A0=A0=A0 * 2) Every 'iov_base' and 'iov_len' are also page aligned
>>> +=A0=A0=A0=A0 *=A0=A0=A0 (except length of the last element).
>>> +=A0=A0=A0=A0 * 3) Number of pages in this iov <=3D MAX_SKB_FRAGS.
>>> +=A0=A0=A0=A0 * 4) Length of the data fits in current credit space.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 for (seg_idx =3D 0; seg_idx < iter->nr_segs; seg_idx++) {
>>> +=A0=A0=A0=A0=A0=A0=A0 struct page *user_pages[MAX_SKB_FRAGS];
>>> +=A0=A0=A0=A0=A0=A0=A0 const struct iovec *iovec;
>>> +=A0=A0=A0=A0=A0=A0=A0 size_t last_frag_len;
>>> +=A0=A0=A0=A0=A0=A0=A0 size_t pages_in_seg;
>>> +=A0=A0=A0=A0=A0=A0=A0 int page_idx;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 iovec =3D &iter->iov[seg_idx];
>>> +=A0=A0=A0=A0=A0=A0=A0 pages_in_seg =3D iovec->iov_len >> PAGE_SHIFT;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (iovec->iov_len % PAGE_SIZE) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 last_frag_len =3D iovec->iov_len % P=
AGE_SIZE;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pages_in_seg++;
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 last_frag_len =3D PAGE_SIZE;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (get_user_pages((unsigned long)iovec->iov_bas=
e,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pages_in_seg, F=
OLL_GET, user_pages,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL) !=3D page=
s_in_seg)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>
>> Reading the get_user_pages() documentation, this should pin the user
>> pages, so we should be fine if we then expose them in the virtqueue.
>>
>> But reading Documentation/core-api/pin_user_pages.rst it seems that
>> drivers should use "pin_user_pages*() for DMA-pinned pages", so I'm not
>> sure what we should do.
>>
>That is really interesting question for me too. IIUC 'pin_user_pages()'
>sets special value to ref counter of page, so we can distinguish such
>pages from the others. I've grepped for pinned pages check and found,
>the it is used in mm/vmscan.c by calling 'folio_maybe_dma_pinned()' during
>page lists processing. Seems 'pin_user_pages()' is more strict version of
>'get_user_pages()' and it is recommended to use 'pin_' when data on these
>pages will be accessed.
>I think, i'll check which API is used in the TCP implementation for zeroco=
py
>transmission.
>
>> Additional advice would be great!
>>
>> Anyway, when we are done using the pages, we should call put_page() or
>> unpin_user_page() depending on how we pin them.
>>
>In case of 'get_user_pages()' everything is ok here: when such skb
>will be released, 'put_page()' will be called for every frag page
>of it, so there is no page leak.

Got it!

>But in case of 'pin_user_pages()',
>i will need to unpin in manually before calling 'consume_skb()'
>after it is processed by virtio device. But anyway - it is not a
>problem.

Yep.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
