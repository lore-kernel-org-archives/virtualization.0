Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EE9C49EA4
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D649B60FF2
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D649B60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A56026087E;
	Mon, 21 Jun 2021 17:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rbT9Ii2Cx_k; Mon, 21 Jun 2021 17:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B58D60791;
	Mon, 21 Jun 2021 17:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01EF8C0010;
	Mon, 21 Jun 2021 17:27:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D71CC000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25BC4401CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fufw-CCK4oo3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:27:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B1AF400DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:27:52 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 7-20020a9d0d070000b0290439abcef697so18512605oti.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WmGjGSnaoIjbfNbK6jg4Z58leTIpBSXXFk+GdaHK+O8=;
 b=IkafJuMXU1dxFooFT/Z7CDiyPl66XkMYfmNHgkZ7Zr9ROZgxDLuuLCItaGKVG+g3ei
 StPnLiq+x2oO47VLNdr3X8f2MNhdKMSBQivdUZebRFGoy+8PcRI5KnPzwKoGXDq0vAms
 uOKTDF1aPZqzzgWio3fYUV04SFgYxLlLuiGV0yHop2Fdw9SW3u5n5BFTJBU3vnd9WFvD
 Rimi7mod+IOXsJwod9l4B5e+z9QEueios+GMwLdNvEMPmTXIUsXGBP1I7DyrZPQQLIen
 dV6MBOQTH1MFJyB6tKOmOFlqEnXysxtjprh6XkRv1/cGvUFGMFih52BaeUDAlxYnQOsP
 I4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WmGjGSnaoIjbfNbK6jg4Z58leTIpBSXXFk+GdaHK+O8=;
 b=VWBogH93tjVGabFbWZfeCt30NMw1sb0G3yDbCOklP97IxdpWbHVnx4vWekh2qu4XN9
 6QQx4Uo0f5jDDs9wXfuc70lH5Aok+yu/2VJ40hGgRCJysJXGsPNiAvcwlGc0sC86mbEz
 Jv3WxbcUNtRaHFGxNh9KUBdcbXRc0CfIs2kuBoi98c2B4fRWlHtDvGPeTeOZNgcMjqAu
 IGhA5rS+sl/LKbKuhd1K1OrCzRE7fM65NK1xEHC4bUcQCKMWEKZkGwM4BQhr3s/7VwD7
 5r7TWNCTQTaEUnzT8xjXcYhrzNjneTYBKswjV9yQwLHbY2CVdlOmOKJ0PDRFisX9Fycq
 q6TA==
X-Gm-Message-State: AOAM533PtD5r7wyiE92N9rEMC302gK0NfZ/NzIGHMSa58qsNyr1lGUEQ
 CILDO/rhwm6GJvOqx4xsRGUVOgX7Nn2ISrLJF1YdMA==
X-Google-Smtp-Source: ABdhPJwi8uED1KtCHcgJosUou/U3YERsHdEZWa6Y4ITdxzqfoSrQyjLejdlRZ2O4PLdCBDaz+Bchb6q7YPN7hVIoEJI=
X-Received: by 2002:a05:6830:1dd5:: with SMTP id
 a21mr21512580otj.180.1624296471321; 
 Mon, 21 Jun 2021 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-7-jiang.wang@bytedance.com>
 <20210618100424.wfljrnycxxguwt3d@steredhat.lan>
In-Reply-To: <20210618100424.wfljrnycxxguwt3d@steredhat.lan>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 21 Jun 2021 10:27:40 -0700
Message-ID: <CAP_N_Z-U0_XP69iNLA1Ray9EEVWyXqb2f85bL-sG2oxjM5PaMA@mail.gmail.com>
Subject: Re: [External] Re: [RFC v1 6/6] virtio/vsock: add sysfs for rx buf
 len for dgram
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Lu Wei <luwei32@huawei.com>, cong.wang@bytedance.com,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Networking <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Popov <alex.popov@linux.com>
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

On Fri, Jun 18, 2021 at 3:04 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Jun 09, 2021 at 11:24:58PM +0000, Jiang Wang wrote:
> >Make rx buf len configurable via sysfs
> >
> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> >---
> > net/vmw_vsock/virtio_transport.c | 37 +++++++++++++++++++++++++++++++++++--
> > 1 file changed, 35 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >index cf47aadb0c34..2e4dd9c48472 100644
> >--- a/net/vmw_vsock/virtio_transport.c
> >+++ b/net/vmw_vsock/virtio_transport.c
> >@@ -29,6 +29,14 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
> > static struct virtio_vsock *the_virtio_vsock_dgram;
> > static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> >
> >+static int rx_buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> >+static struct kobject *kobj_ref;
> >+static ssize_t  sysfs_show(struct kobject *kobj,
> >+                      struct kobj_attribute *attr, char *buf);
> >+static ssize_t  sysfs_store(struct kobject *kobj,
> >+                      struct kobj_attribute *attr, const char *buf, size_t count);
> >+static struct kobj_attribute rxbuf_attr = __ATTR(rx_buf_value, 0660, sysfs_show, sysfs_store);
>
> Maybe better to use a 'dgram' prefix.

Sure.

> >+
> > struct virtio_vsock {
> >       struct virtio_device *vdev;
> >       struct virtqueue **vqs;
> >@@ -360,7 +368,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> >
> > static void virtio_vsock_rx_fill(struct virtio_vsock *vsock, bool is_dgram)
> > {
> >-      int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> >+      int buf_len = rx_buf_len;
> >       struct virtio_vsock_pkt *pkt;
> >       struct scatterlist hdr, buf, *sgs[2];
> >       struct virtqueue *vq;
> >@@ -1003,6 +1011,22 @@ static struct virtio_driver virtio_vsock_driver = {
> >       .remove = virtio_vsock_remove,
> > };
> >
> >+static ssize_t sysfs_show(struct kobject *kobj,
> >+              struct kobj_attribute *attr, char *buf)
> >+{
> >+      return sprintf(buf, "%d", rx_buf_len);
> >+}
> >+
> >+static ssize_t sysfs_store(struct kobject *kobj,
> >+              struct kobj_attribute *attr, const char *buf, size_t count)
> >+{
> >+      if (kstrtou32(buf, 0, &rx_buf_len) < 0)
> >+              return -EINVAL;
> >+      if (rx_buf_len < 1024)
> >+              rx_buf_len = 1024;
> >+      return count;
> >+}
> >+
> > static int __init virtio_vsock_init(void)
> > {
> >       int ret;
> >@@ -1020,8 +1044,17 @@ static int __init virtio_vsock_init(void)
> >       if (ret)
> >               goto out_vci;
> >
> >-      return 0;
> >+      kobj_ref = kobject_create_and_add("vsock", kernel_kobj);
>
> So, IIUC, the path will be /sys/vsock/rx_buf_value?
>
> I'm not sure if we need to add a `virtio` subdir (e.g.
> /sys/vsock/virtio/dgram_rx_buf_size)

I agree adding a virtio is better in case vmware or hyperv will
also have some settings.

> Thanks,
> Stefano
>
> >
> >+      /*Creating sysfs file for etx_value*/
> >+      ret = sysfs_create_file(kobj_ref, &rxbuf_attr.attr);
> >+      if (ret)
> >+              goto out_sysfs;
> >+
> >+      return 0;
> >+out_sysfs:
> >+      kobject_put(kobj_ref);
> >+      sysfs_remove_file(kernel_kobj, &rxbuf_attr.attr);
> > out_vci:
> >       vsock_core_unregister(&virtio_transport.transport);
> > out_wq:
> >--
> >2.11.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
