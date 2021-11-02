Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8869C433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 13:03:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DA76108F
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 13:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72DA76108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 375F080D7A;
	Tue,  2 Nov 2021 13:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1SPHBUSYIaZ; Tue,  2 Nov 2021 13:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E584880D7B;
	Tue,  2 Nov 2021 13:03:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1AF6C0012;
	Tue,  2 Nov 2021 13:03:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43EFFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 13:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 202586058F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 13:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RmxObieTukbR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 13:03:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEBDF600B8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635858197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5n86OvPaV2H1NZKCrF2kbcvYUIActOIda1CNrZjv7E=;
 b=avDrz0uXCq9P1jGI/vRxGWDc/fa1XWyMMnYvtabXaWJfPzYzLgjIlm+IIuhCiAqeGqOHH8
 L/sn7a2gxPv3eknXGIoGQ5vjoWtcv6vGVj6pd3zNy/yWaSd4q0cCGDpHNCjqKWMNwrQKQQ
 T+DNYIiXMtVjtrw8FCAZE60ytszKjp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ZdzVCAWGMsOup90M0epPaw-1; Tue, 02 Nov 2021 09:03:14 -0400
X-MC-Unique: ZdzVCAWGMsOup90M0epPaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D358F100C666;
 Tue,  2 Nov 2021 13:03:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8021567846;
 Tue,  2 Nov 2021 13:03:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 69FBE180092D; Tue,  2 Nov 2021 14:03:08 +0100 (CET)
Date: Tue, 2 Nov 2021 14:03:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maksym Wezdecki <maksym.wezdecki@collabora.com>
Subject: Re: [PATCH] drm/virtio: delay pinning the pages till first use
Message-ID: <20211102130308.2s64ghmic5nhj6vu@sirius.home.kraxel.org>
References: <20211102113139.154140-1-maksym.wezdecki@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20211102113139.154140-1-maksym.wezdecki@collabora.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, mwezdeck <maksym.wezdecki@collabora.co.uk>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Tue, Nov 02, 2021 at 12:31:39PM +0100, Maksym Wezdecki wrote:
> From: mwezdeck <maksym.wezdecki@collabora.co.uk>
> 
> The idea behind the commit:
>   1. not pin the pages during resource_create ioctl
>   2. pin the pages on the first use during:
> 	- transfer_*_host ioctl
>         - map ioctl

i.e. basically lazy pinning.  Approach looks sane to me.

>   3. introduce new ioctl for pinning pages on demand

What is the use case for this ioctl?
In any case this should be a separate patch.

> +	struct virtio_gpu_object_array *objs;
> +	struct virtio_gpu_object *bo;
> +	struct virtio_gpu_object_shmem *shmem;
> +
> +	objs = virtio_gpu_array_from_handles(file, &virtio_gpu_map->handle, 1);
> +	if (objs == NULL)
> +		return -ENOENT;
> +
> +	bo = gem_to_virtio_gpu_obj(objs->objs[0]);
> +	if (bo == NULL)
> +		return -ENOENT;
> +	
> +	shmem = to_virtio_gpu_shmem(bo);
> +	if (shmem == NULL)
> +		return -ENOENT;
> +
> +	if (!shmem->pages) {
> +		virtio_gpu_object_pin(vgdev, objs, 1);
> +	}

Move this into virtio_gpu_object_pin(),
or create a helper function for it ...

> +	objs = virtio_gpu_array_from_handles(file, &virtio_gpu_pin->handle, 1);
> +	if (objs == NULL)
> +		return -ENOENT;
> +
> +	bo = gem_to_virtio_gpu_obj(objs->objs[0]);
> +	if (bo == NULL)
> +		return -ENOENT;
> +	
> +	shmem = to_virtio_gpu_shmem(bo);
> +	if (shmem == NULL)
> +		return -ENOENT;
> +
> +	if (!shmem->pages) {
> +		return virtio_gpu_object_pin(vgdev, objs, 1);
> +	}

... to avoid this code duplication?

> +int virtio_gpu_object_pin(struct virtio_gpu_device *vgdev,
> +			  struct virtio_gpu_object_array *objs,
> +			  int num_gem_objects)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < num_gem_objects; i++) {

> +		ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
> +		if (ret != 0) {
> +			return -EFAULT;
> +		}
> +
> +		virtio_gpu_object_attach(vgdev, bo, ents, nents);

I think it is enough to do the virtio_gpu_object_attach() call lazily.
virtio_gpu_object_shmem_init() should not actually allocate pages, that
only happens when virtio_gpu_object_attach() goes ask for a scatter
list.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
