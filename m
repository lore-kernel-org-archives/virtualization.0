Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A62C05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8992B81FE2;
	Fri, 20 Jan 2023 13:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8992B81FE2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gT5hzLcK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UimZ6yXeStKp; Fri, 20 Jan 2023 13:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF32181EA9;
	Fri, 20 Jan 2023 13:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF32181EA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F234C0033;
	Fri, 20 Jan 2023 13:02:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12B44C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAE2641199
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAE2641199
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gT5hzLcK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bwBqsxF9v0mp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 031CD408DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 031CD408DA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674219720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7wBVjsJdeTQ+WNvN3DH4I2K8ExSDoZ538kq0KcWHf4=;
 b=gT5hzLcKPrlcwgjQ2Dm0e1/nEg0RRjbiIlmMSjGCBjFhM5WIsUmD0JXqKsrB+KhpLF2GYZ
 JT9WCGjQGR6T94R8oFS315SxaijzfbEQpNNtNkN0TZcP2r6OWuPt/MUd0X4LYk9dV4i8c9
 ZpD8LVQlqAbomxD02VD7yEJu1W+yAA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-0Vh0lfUCN92Yff-DsSUhxw-1; Fri, 20 Jan 2023 08:01:59 -0500
X-MC-Unique: 0Vh0lfUCN92Yff-DsSUhxw-1
Received: by mail-wm1-f72.google.com with SMTP id
 m10-20020a05600c3b0a00b003dafe7451deso2992221wms.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 05:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7wBVjsJdeTQ+WNvN3DH4I2K8ExSDoZ538kq0KcWHf4=;
 b=0oZFo1et8hhY5+vlpm6oLl6KArVd0QAOOl6QMSiTIUgCliAIy5i4k8y+Mn3q5YHdyl
 1DwlW3FsaECNmnKgKzcOkp7adLEIAxVeYbCRoAvLseRKS26/kDZ+3KPp2OupYamuljDm
 lxzf8baVIDNuBGz/6iIK7atzw7WtNA9CPdVzdOwgfArFDa9lrQg730ZJ+zOA/u3O1iCz
 eS2A5QiUofSFDAba5bTyZueS9WMnN0C9o0kTVgzQdAjNpYwnrRt4dfRNlkFgCRDbrjPs
 31cTCdkKJjGj/mI7gsWow4uFTRx+qJeTxOHJneHERzyv3315nRKNDlOGVTXcp8S1o8uY
 5arA==
X-Gm-Message-State: AFqh2kqeZphgqLzQkouYtRMCGbx/IuKdwZoh1MPveNEZG11sWiBHN/xd
 jJxXI53uHMy06Wx0WZtk3m48+IwNoOtwsILyHnBzKLMkqPwVvN81DgIUCgEeIpB64rBE2QYZ3jC
 IlZA6NyazZA55TTbKitA53r/kbzsvBMIGUeXbcTHkNg==
X-Received: by 2002:adf:a31e:0:b0:2be:5cff:5d00 with SMTP id
 c30-20020adfa31e000000b002be5cff5d00mr1661016wrb.70.1674219718236; 
 Fri, 20 Jan 2023 05:01:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAFTj3ASCRpytlHara8uZNPHYOknLCkK+Sp90nWm9UfQI1VggsDul6y0CDGx+uH0kt54hfdw==
X-Received: by 2002:adf:a31e:0:b0:2be:5cff:5d00 with SMTP id
 c30-20020adfa31e000000b002be5cff5d00mr1660988wrb.70.1674219717939; 
 Fri, 20 Jan 2023 05:01:57 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 k18-20020adfb352000000b00241fab5a296sm36619113wrd.40.2023.01.20.05.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 05:01:57 -0800 (PST)
Date: Fri, 20 Jan 2023 08:01:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <20230120080130-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> It's possible for the host to set the multiport flag, but pass in
> 0 multiports, which results in:
> 
> BUG: KASAN: slab-out-of-bounds in init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
> Write of size 8 at addr ffff888001cc24a0 by task swapper/1
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc1-140273-gaab0bb9fbaa1-dirty #588
> Call Trace:
>  init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
>  virtcons_probe+0x1a3/0x5b0 drivers/char/virtio_console.c:2042
>  virtio_dev_probe+0x2b9/0x500 drivers/virtio/virtio.c:263
>  call_driver_probe drivers/base/dd.c:515
>  really_probe+0x1c9/0x5b0 drivers/base/dd.c:601
>  really_probe_debug drivers/base/dd.c:694
>  __driver_probe_device+0x10d/0x1f0 drivers/base/dd.c:754
>  driver_probe_device+0x68/0x150 drivers/base/dd.c:786
>  __driver_attach+0xca/0x200 drivers/base/dd.c:1145
>  bus_for_each_dev+0x108/0x190 drivers/base/bus.c:301
>  driver_attach+0x30/0x40 drivers/base/dd.c:1162
>  bus_add_driver+0x325/0x3c0 drivers/base/bus.c:618
>  driver_register+0xf3/0x1d0 drivers/base/driver.c:171
> ...
> 
> Add a suitable sanity check.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..f4fd5fe7cd3a 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
>  	int err;
>  
>  	nr_ports = portdev->max_nr_ports;
> +	if (use_multiport(portdev) && nr_ports < 1)
> +		return -EINVAL;
> +
>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
>  
>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);

Weird.  Don't we already check for that?

        /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
        if (!is_rproc_serial(vdev) &&
            virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
                                 struct virtio_console_config, max_nr_ports,
                                 &portdev->max_nr_ports) == 0) {
                if (portdev->max_nr_ports == 0 ||
                    portdev->max_nr_ports > VIRTCONS_MAX_PORTS) {
                        dev_err(&vdev->dev,
                                "Invalidate max_nr_ports %d",
                                portdev->max_nr_ports);
                        err = -EINVAL;
                        goto free;
                }
                multiport = true;
        }




> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
