Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11043C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:33:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72D26124F
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B72D26124F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B90461B66;
	Mon,  4 Oct 2021 14:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73FzNSE5HoPq; Mon,  4 Oct 2021 14:33:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E32061B79;
	Mon,  4 Oct 2021 14:33:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F67C000F;
	Mon,  4 Oct 2021 14:33:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED3FC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BB0784BD4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r6fIE-YNzWwp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6576F84BC7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633358013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkFXR+Ar045yOW1Qn+SywsZzwu6VhSEtfZbFfXfqIlo=;
 b=ebImG0O/aJ4zuNGds6wg2zhvdNjPTHeKrA8e4djGHP99k4tnjoP4gNryTL9LpFtzKM0/QI
 I0fWZJZUX/Awwz51hIo/DE5LsRzGwPtGURmVgBeJWYujE2jxhKLuDwQ8iaHX4PD2sTC3M6
 CsRrXnmvs5LgSuNEJHTWTzsSflziLpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-nNKntssOPQqiw5sEur7mCA-1; Mon, 04 Oct 2021 10:33:31 -0400
X-MC-Unique: nNKntssOPQqiw5sEur7mCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4893B835DE2;
 Mon,  4 Oct 2021 14:33:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7DA0100238C;
 Mon,  4 Oct 2021 14:33:22 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004090018-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 04 Oct 2021 16:33:21 +0200
Message-ID: <875yuc3ln2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, Xie Yongji <xieyongji@bytedance.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
>> 
>> [cc:qemu-devel]
>> 
>> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
>> >> On Thu, 30 Sep 2021 07:12:21 -0400
>> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
>> >> > > This patch fixes a regression introduced by commit 82e89ea077b9
>> >> > > ("virtio-blk: Add validation for block size in config space") and
>> >> > > enables similar checks in verify() on big endian platforms.
>> >> > > 
>> >> > > The problem with checking multi-byte config fields in the verify
>> >> > > callback, on big endian platforms, and with a possibly transitional
>> >> > > device is the following. The verify() callback is called between
>> >> > > config->get_features() and virtio_finalize_features(). That we have a
>> >> > > device that offered F_VERSION_1 then we have the following options
>> >> > > either the device is transitional, and then it has to present the legacy
>> >> > > interface, i.e. a big endian config space until F_VERSION_1 is
>> >> > > negotiated, or we have a non-transitional device, which makes
>> >> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
>> >> > > thus presents a little endian config space. Because at this point we
>> >> > > can't know if the device is transitional or non-transitional, we can't
>> >> > > know do we need to byte swap or not.  
>> >> > 
>> >> > Hmm which transport does this refer to?
>> >> 
>> >> It is the same with virtio-ccw and virtio-pci. I see the same problem
>> >> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
>> >> yet (have to figure out how to do that with libvirt) for pci I used
>> >> virtio-blk-pci.
>> >> 
>> >> > Distinguishing between legacy and modern drivers is transport
>> >> > specific.  PCI presents
>> >> > legacy and modern at separate addresses so distinguishing
>> >> > between these two should be no trouble.
>> >> 
>> >> You mean the device id? Yes that is bolted down in the spec, but
>> >> currently we don't exploit that information. Furthermore there
>> >> is a fat chance that with QEMU even the allegedly non-transitional
>> >> devices only present a little endian config space after VERSION_1
>> >> was negotiated. Namely get_config for virtio-blk is implemented in
>> >> virtio_blk_update_config() which does virtio_stl_p(vdev,
>> >> &blkcfg.blk_size, blk_size) and in there we don't care
>> >> about transitional or not:
>> >> 
>> >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>> >> {
>> >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>> >>     return virtio_is_big_endian(vdev);
>> >> #elif defined(TARGET_WORDS_BIGENDIAN)
>> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>> >>         return false;
>> >>     }
>> >>     return true;
>> >> #else
>> >>     return false;
>> >> #endif
>> >> }
>> >> 
>> >
>> > ok so that's a QEMU bug. Any virtio 1.0 and up
>> > compatible device must use LE.
>> > It can also present a legacy config space where the
>> > endian depends on the guest.
>> 
>> So, how is the virtio core supposed to determine this? A
>> transport-specific callback?
>
> I'd say a field in VirtIODevice is easiest.

The transport needs to set this as soon as it has figured out whether
we're using legacy or not. I guess we also need to fence off any
accesses respectively error out the device if the driver tries any
read/write operations that would depend on that knowledge?

And using a field in VirtIODevice would probably need some care when
migrating. Hm...

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
