Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4E8C7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 08:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16E1C8224B;
	Mon,  5 Jun 2023 08:27:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16E1C8224B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZC7P/pVt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ooGrZzyVlao; Mon,  5 Jun 2023 08:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E9F38217D;
	Mon,  5 Jun 2023 08:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E9F38217D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765A0C007A;
	Mon,  5 Jun 2023 08:27:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C2E1C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB2FF8219C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:27:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB2FF8219C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id goIDh8RKU61m
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:27:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CB678217D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CB678217D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685953620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8at3jyLYspjW7I0pCXUj/ZCT3YmM7eGZSNtKBL6MtI=;
 b=ZC7P/pVtDCPvndICFSArghp24mpRlh8fIJ3JU8ug9Jg0xUPa7FIhsJhRj5Qm8oZIuzAuZR
 GlBvUloe4lJBVpnB2dO4FRx4vcnzWZPm5sKOIdJn2yS1Qu9FaT3GTGLlSJfgogPcQJtzlc
 fektKEu6cYz39uv0isaKoZSQQ1m7JSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Iw1r41RfNfaH5RUAVG1NOA-1; Mon, 05 Jun 2023 04:26:58 -0400
X-MC-Unique: Iw1r41RfNfaH5RUAVG1NOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f611d31577so23544325e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 01:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685953617; x=1688545617;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8at3jyLYspjW7I0pCXUj/ZCT3YmM7eGZSNtKBL6MtI=;
 b=B/UlBaG8V6bSA89voj8SZVJvPURUolYBbTwnSgpQIUzSFyhfC8NkkNga5ybw4WH3YQ
 5u32VXK4wa5zL73pQ/GQNQb0AF3/ldylyZ3hLkKvLACURo1BU7TN3r6nbkDYeiaaMA4c
 VF86loQiKJAqhS5Qi7xDlYy3E4OaBLMnsjoQIK1PSSKphkSX3V1gEC2bYjabl652WGRr
 TFPFJQJ6QTwcRfLgUHO1Rq2JluDlMtEcHDSddEGgDL/PQSyUzF+mxQwXn17KXXLUuQvw
 Jb+sObaqKKkCsPq8iFNYgRTWma9ww65KJQZPOsvkJ6z8MrFZexHMWNo4997aUBnLTLND
 j9QA==
X-Gm-Message-State: AC+VfDwwESDGQRMPgG0VB3yS7CYffcbgduTEuGb4jDCBBLTbTfhyravD
 iOdMLY/zMLBZMe+p0BsZ3dATWyRqxBMrhHQ8/uQHywcq769MT7sOTeRAJ/R7sSzAWO/mqpr4qQV
 lXV93JUtF02lJTNBUBcxiMBxEcheI3/d0c/OIW/tKhw==
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id
 p24-20020a05600c1d9800b003f7367a38cbmr3232793wms.2.1685953617683; 
 Mon, 05 Jun 2023 01:26:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VE8iVjNCuqsNoEIKvM2en0FHwV2THTF/MEveUKF9yun03XpX+3wMK7X0sxFjbHVuiakb1jg==
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id
 p24-20020a05600c1d9800b003f7367a38cbmr3232772wms.2.1685953617428; 
 Mon, 05 Jun 2023 01:26:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfd085000000b003095bd71159sm9123063wrh.7.2023.06.05.01.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:26:56 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:26:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <4rqrebfglyif4d7i4ufdnj2uqnubvljkeciqmelvotti5iu5ja@fryxznjicgn6>
References: <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
 <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
 <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
 <43f67549-fe4d-e3ca-fbb0-33bea6e2b534@oracle.com>
 <bbe697b6-dd9e-5a8d-21c5-315ab59f0456@oracle.com>
 <7vk2uizpmf4fi54tmmopnbwwb7fs2xg6vae6ynrcvs26hjmshb@hpjzu4jfj35i>
 <b5a845e9-1fa0-ea36-98c4-b5da989c44c6@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b5a845e9-1fa0-ea36-98c4-b5da989c44c6@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Thu, Jun 01, 2023 at 11:33:09AM -0500, Mike Christie wrote:
>On 6/1/23 2:47 AM, Stefano Garzarella wrote:
>>>
>>> static void vhost_worker_free(struct vhost_dev *dev)
>>> {
>>> -=A0=A0=A0 struct vhost_worker *worker =3D dev->worker;
>>> +=A0=A0=A0 struct vhost_task *vtsk =3D READ_ONCE(dev->worker.vtsk);
>>>
>>> -=A0=A0=A0 if (!worker)
>>> +=A0=A0=A0 if (!vtsk)
>>> =A0=A0=A0=A0=A0=A0=A0 return;
>>>
>>> -=A0=A0=A0 dev->worker =3D NULL;
>>> -=A0=A0=A0 WARN_ON(!llist_empty(&worker->work_list));
>>> -=A0=A0=A0 vhost_task_stop(worker->vtsk);
>>> -=A0=A0=A0 kfree(worker);
>>> +=A0=A0=A0 vhost_task_stop(vtsk);
>>> +=A0=A0=A0 WARN_ON(!llist_empty(&dev->worker.work_list));
>>> +=A0=A0=A0 WRITE_ONCE(dev->worker.vtsk, NULL);
>>
>> The patch LGTM, I just wonder if we should set dev->worker to zero here,
>
>We might want to just set kcov_handle to zero for now.
>
>In 6.3 and older, I think we could do:
>
>1. vhost_dev_set_owner could successfully set dev->worker.
>2. vhost_transport_send_pkt runs vhost_work_queue and sees worker
>is set and adds the vhost_work to the work_list.
>3. vhost_dev_set_owner fails in vhost_attach_cgroups, so we stop
>the worker before the work can be run and set worker to NULL.
>4. We clear kcov_handle and return.
>
>We leave the work on the work_list.
>
>5. Userspace can then retry vhost_dev_set_owner. If that works, then the
>work gets executed ok eventually.
>
>OR
>
>Userspace can just close the device. vhost_vsock_dev_release would
>eventually call vhost_dev_cleanup (vhost_dev_flush won't see a worker
>so will just return), and that will hit the WARN_ON but we would
>proceed ok.
>
>If I do a memset of the worker, then if userspace were to retry
>VHOST_SET_OWNER, we would lose the queued work since the work_list would
>get zero'd. I think it's unlikely this ever happens, but you know best
>so let me know if this a real issue.
>

I don't think it's a problem, though, you're right, we could hide the =

warning and thus future bugs, better as you proposed.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
