Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB0AC433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:28:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AE36143C
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AE36143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4ED08403A5;
	Thu, 13 May 2021 16:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kj2ztTohOFeT; Thu, 13 May 2021 16:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00A7B40003;
	Thu, 13 May 2021 16:27:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF4BDC000D;
	Thu, 13 May 2021 16:27:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2555C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2688406A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZ840fMWuF_R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:27:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE9B740684
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620923275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuYp5/3obltv5r7eq8xKVUNYQlDv3pda6zIjqU9HN2U=;
 b=UqBI452hZXzByzSKlrLuLfiHJvJkZJtnVnklXn0YPMdVugQfwYiY+Cx5Tlc0AxRKN1o/+e
 bjlXhYnh0LLr1LgdE6abUlCA8lTWOuXha2QuMEFd3pAcWlaoJE4u5jTNYs5nfoPl0GSXEL
 Aj3vq+IfNyjZpKy1G6jvblGZkBBSAtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-YOsAi3fFNcaukYidOwfrtQ-1; Thu, 13 May 2021 12:27:53 -0400
X-MC-Unique: YOsAi3fFNcaukYidOwfrtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A08701922035;
 Thu, 13 May 2021 16:27:51 +0000 (UTC)
Received: from localhost (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1324C17264;
 Thu, 13 May 2021 16:27:46 +0000 (UTC)
Date: Thu, 13 May 2021 17:27:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
References: <20210423080942.2997-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210423080942.2997-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 mst@redhat.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com
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
Content-Type: multipart/mixed; boundary="===============0278332663430634273=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0278332663430634273==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kSjLBUWR7rqI1Fnp"
Content-Disposition: inline


--kSjLBUWR7rqI1Fnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> Sometimes, the driver doesn't trust the device. This is usually
> happens for the encrtpyed VM or VDUSE[1].

Thanks for doing this.

Can you describe the overall memory safety model that virtio drivers
must follow? For example:

- Driver-to-device buffers must be on dedicated pages to avoid
  information leaks.

- Driver-to-device buffers must be on dedicated pages to avoid memory
  corruption.

When I say "pages" I guess it's the IOMMU page size that matters?

What is the memory access granularity of VDUSE?

I'm asking these questions because there is driver code that exposes
kernel memory to the device and I'm not sure it's safe. For example:

  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
                  struct scatterlist *data_sg, bool have_data)
  {
          struct scatterlist hdr, status, *sgs[3];
          unsigned int num_out = 0, num_in = 0;

          sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
	                    ^^^^^^^^^^^^^
          sgs[num_out++] = &hdr;

          if (have_data) {
                  if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
                          sgs[num_out++] = data_sg;
                  else
                          sgs[num_out + num_in++] = data_sg;
          }

          sg_init_one(&status, &vbr->status, sizeof(vbr->status));
                               ^^^^^^^^^^^^
          sgs[num_out + num_in++] = &status;

          return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
  }

I guess the drivers don't need to be modified as long as swiotlb is used
to bounce the buffers through "insecure" memory so that the memory
surrounding the buffers is not exposed?

Stefan

--kSjLBUWR7rqI1Fnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCdU4EACgkQnKSrs4Gr
c8jIXQf/bDxDNATkynJc8tGJ7x7Bp5ZiiG3XuUvb5LEsvtzjs+2kmYIZyhESbHN6
pasUhocXLHhIiBmRf5XAHiSbQI+cdOgjgf/Owykd4xM5esusvzNOQy8I8oUCrbX/
yxPI+spnxLyM3U7f7He68vjS86KPn/5pvwbXiRNfFF9KPjk6qE7w+daSgZLOh/NP
BafdMFIW1E7csCnTPZjqEr2gw8WqHAAwD6vd2dkytBkoGfL1UHT4OwUpP1Ig5Vmb
ytJDZ/tx+mG2JVfBfzXAj0n1FOXosho5Md9BcUPMNw1yqwwzJrmzfg22wdJacPzQ
D+K0W3qs/r3YDv++4i/cJa96khB/ng==
=T94O
-----END PGP SIGNATURE-----

--kSjLBUWR7rqI1Fnp--


--===============0278332663430634273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0278332663430634273==--

