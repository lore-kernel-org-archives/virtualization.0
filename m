Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E011E7C1F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973823; cv=none; b=lxQUYQFwYxF6/q8JvNwYKvrRjAtIdg5DacZWeFVeXrRdaqXIJQEm7YBhYk/dtJW3wtPA2Fnt4L3HY6TrBhlLIRDu3vUExM0XjwMYP/kh8lFXpxYrAkfm64RFeSFs4mMF9tMgmvK4vIPZQ7RzQl7AgbySu5oNT0qvB9Xs0yCpZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973823; c=relaxed/simple;
	bh=2+Yutr5Xglcz8V8+xc221L3KYuAq5uCZTnAUQj8Hv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NjKSozxrgjKY66+1FVqJkcDCLHzuvNkOjfRDkFQK4vUzlxnEuF3ti7F0C0vQG78dYdwKK9DdrCtCOXt8oBeLJv+1du9Ul02WxZufQTasL81CjAdGT0sgMQ6RvTh4BGbaAosB4gIHyfqmKUsppIrwENA8qyCJhD2EyYgQaUb+u1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaPNvfr6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaPNvfr6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B82E84137
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2f3NoBDugAo for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 10:03:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0C22A84131
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C22A84131
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GaPNvfr6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C22A84131
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730973819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An3BH6XKuTAnMBgKcn0eA2Zh2Rap4I/isdV3TdHYfCA=;
	b=GaPNvfr6bCOO6tgu0QmO2gcaKXTssX0jdrDW8eEAsorXTybrXxSPE+xtmQNWhnpTlKdNQh
	wmRs0oy8Rn5yKEiNzhEJgJPd4s+zTe+uC+IeR1YmZx5Hoh84FK1lTjcJ8zaEuOnvznrzby
	0pbMyy/ZFA7oqBw3cS/KSZkHPVnx5Jc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-_6x_Ow68Obq8Y4fY8Tn10Q-1; Thu, 07 Nov 2024 05:03:37 -0500
X-MC-Unique: _6x_Ow68Obq8Y4fY8Tn10Q-1
X-Mimecast-MFC-AGG-ID: _6x_Ow68Obq8Y4fY8Tn10Q
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e600565aa1so846095b6e.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Nov 2024 02:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973816; x=1731578616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An3BH6XKuTAnMBgKcn0eA2Zh2Rap4I/isdV3TdHYfCA=;
        b=qSahrHQbqB75HkTj9eNxS15gL553YXrKo5nbhjyONcgRatcgVA2Qt4fQL28hF4+EDt
         B2qQrwKxyR4jEtAIPdvo1cIw2lfGvNYd7YMw26jC/Rbd3a6/HILM+QZkY65mg8d3V5YM
         8baSdSGQ3DLjLO+MM0DWy9R5SBdYcMGwA/qcrWMImNFv/xH1Qz2tef8Y1GigABdqrO3b
         8oKyDUbJb7+KIfMwPKjIDBMAywqOGqbusr90Hqv7dHFPR5HI5DTT6CJXcBMQ/FNu4ZLX
         yl0K5Hwfixa0gXbAIrk2qKxwcdCuUJCHMfo7NqR7D9G/iVdafMN71N07nZXic3g7t7ym
         u1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0W7PRFAIwzPrcBZ5QufQiJ0QU3RZH647cZjXJs3OXDKu41P3Q7feZtUJFL2oxx/caGmP43JoUpnbvOzxRPg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwTKPIVCbsudBca8Y3iRhphw2eU9Xb89SMDvIC+ZwmHLu9xuca6
	BlwvQTtjI2Men1UCsUcKLoybJUemNKDkl5QpuyDgiMGUfbQddeSDPCkxJAs/Q1wwmCIDb4OWezV
	QUHVYFkGoY1TrOoQ/Z3GyE9RoWG6Tu5XqEhUeyVU3aqXy806aPi47Rs4Od9vw1RmuNUtL2/Kn7z
	7cJEU=
X-Received: by 2002:a05:6808:1587:b0:3e6:61ed:d62 with SMTP id 5614622812f47-3e78fc71ebfmr482173b6e.6.1730973816632;
        Thu, 07 Nov 2024 02:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh9cwaUN0Ba6FgiawQwL1+eLsqHmCIJp1Eq590jb/9RX+uJ0m1Iu3AL2UUAklxiLKOlF6EEw==
X-Received: by 2002:a05:6808:1587:b0:3e6:61ed:d62 with SMTP id 5614622812f47-3e78fc71ebfmr482139b6e.6.1730973816142;
        Thu, 07 Nov 2024 02:03:36 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396637613sm5750286d6.116.2024.11.07.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:03:35 -0800 (PST)
Date: Thu, 7 Nov 2024 11:03:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <zkamzruq5e3diahm7vyjansnaowkw42toh5evwgq6vqal7h4pk@3w4e47ggogyr>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
 <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
 <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o3tESnarVwOlx6hIMN1PXn9R4i0llLAf1H6scdXm_Eo_1730973817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 07, 2024 at 03:12:49PM +0800, Cindy Lu wrote:
>On Tue, Nov 5, 2024 at 6:32 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
>> >Add a new UAPI to enable setting the vhost device to task mode.
>> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>> >to configure the mode if necessary.
>> >This setting must be applied before VHOST_SET_OWNER, as the worker
>> >will be created in the VHOST_SET_OWNER function
>> >
>> >Signed-off-by: Cindy Lu <lulu@redhat.com>
>> >---
>> > drivers/vhost/vhost.c      | 15 ++++++++++++++-
>> > include/uapi/linux/vhost.h |  2 ++
>> > 2 files changed, 16 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> >index c17dc01febcc..70c793b63905 100644
>> >--- a/drivers/vhost/vhost.c
>> >+++ b/drivers/vhost/vhost.c
>> >@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>> > {
>> >       struct eventfd_ctx *ctx;
>> >       u64 p;
>> >-      long r;
>> >+      long r = 0;
>>
>> I don't know if something is missing in this patch, but I am confused:
>>
>> `r` is set few lines below...
>>
>> >       int i, fd;
>> >+      bool inherit_owner;
>> >
>> >       /* If you are not the owner, you can become one */
>> >       if (ioctl == VHOST_SET_OWNER) {
>> ...
>>
>>         /* You must be the owner to do anything else */
>>         r = vhost_dev_check_owner(d);
>>         if (r)
>>                 goto done;
>>
>> So, why we are now initializing it to 0?
>>
>r = 0 mean return successfully here.
>Therefore, in the case VHOST_SET_INHERIT_FROM_OWNER function, I don't
>need to set it again and can simply return.
>....
>    if (vhost_dev_has_owner(d))
>       break;
>.....

Okay, but vhost_dev_check_owner() already set it to 0, so we can avoid 
that, no?

>> >@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>> >               if (ctx)
>> >                       eventfd_ctx_put(ctx);
>> >               break;
>> >+      case VHOST_SET_INHERIT_FROM_OWNER:
>> >+              /*inherit_owner can only be modified before owner is set*/
>> >+              if (vhost_dev_has_owner(d))
>>
>> And here, how this check can be false, if at the beginning of the
>> function we call vhost_dev_check_owner()?
>>
>> Maybe your intention was to add this code before the
>> `vhost_dev_check_owner()` call, so this should explain why initialize
>> `r` to 0, but I'm not sure.
>>
>Yes, in the function beginning, the code is
>if (ioctl == VHOST_SET_OWNER) {
>r = vhost_dev_set_owner(d);
>goto done;
>}
>if the ioctl is not VHOST_SET_OWNER,  then the  code will not run the
>function vhost_dev_set_owner.

Sorry, I meant vhost_dev_check_owner(), not vhost_dev_set_owner().

I'll try to explain again.

After applying this series we have this code:

long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
{
	struct eventfd_ctx *ctx;
	u64 p;
	long r = 0;
	int i, fd;
	bool inherit_owner;

	/* If you are not the owner, you can become one */
	if (ioctl == VHOST_SET_OWNER) {
		r = vhost_dev_set_owner(d);
		goto done;
	}

	/* You must be the owner to do anything else */
	r = vhost_dev_check_owner(d);
	if (r)
		goto done;

	switch (ioctl) {
	...
     	case VHOST_SET_INHERIT_FROM_OWNER:
		/*inherit_owner can only be modified before owner is 
		 * set*/
		if (vhost_dev_has_owner(d))
			break;

IIUC this check is always true, so we always call `break` because at
the beginning of this function we call vhost_dev_check_owner() which
if `dev->mm != current->mm` (so it can't be null I guess) jumps directly
into `done`, returning an error.

So I still don't understand in which condition we can run the code after
this check.

Thanks,
Stefano

		if (copy_from_user(&inherit_owner, argp,
				   sizeof(inherit_owner))) {
			r = -EFAULT;
			break;
		}
		d->inherit_owner = inherit_owner;
		break;


>This ioctl is used by userspace applications, so we cannot be certain
>of the type and sequence of their calls; therefore, I added this
>check.
>
>> >+                      break;
>>
>> Should we return an error (e.g. -EPERM) in this case?
>>
>sure，will add this back
>thanks
>Cindy
>> >+
>> >+              if (copy_from_user(&inherit_owner, argp,
>> >+                                 sizeof(inherit_owner))) {
>> >+                      r = -EFAULT;
>> >+                      break;
>> >+              }
>> >+              d->inherit_owner = inherit_owner;
>> >+              break;
>> >       default:
>> >               r = -ENOIOCTLCMD;
>> >               break;
>> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> >index b95dd84eef2d..1e192038633d 100644
>> >--- a/include/uapi/linux/vhost.h
>> >+++ b/include/uapi/linux/vhost.h
>> >@@ -235,4 +235,6 @@
>> >  */
>> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
>> >                                             struct vhost_vring_state)
>> >+
>>
>> Please add a documentation here, this is UAPI, so the user should
>> know what this ioctl does based on the parameter.
>>
>> Thanks,
>> Stefano
>>
>> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
>> > #endif
>> >--
>> >2.45.0
>> >
>>
>

