Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A81DE2DC
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168634; cv=none; b=kVnituCmN3n88dR96qMfsEtxH5u1Fu+V+iS3qnzZLLI7OFtnfABUOmpO41txcNxd15hGCjKen8NKy5Terdkpd8whZ2hii7EFQRHNICI/5XOMBPx3TWMXqutlCoksknJ1zfZ2Rks2KVOG7MeNK2UkeaBOlGRUukMxlQ878fbIj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168634; c=relaxed/simple;
	bh=5FzrCibbxCCjjxTzx160tMVsayc7RC3gRwAItvJonj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ai4Ey/0VTE5P2CtiCBoqwVVZGtXSIVO88fR09M2iP3ppHDjoEh2YwyniRPBQ+fSx6+pMMDyXKQHfIEuqlNKN4E7yU6gl7Ve+vZz2qMZ19TUW1YZSWPHHg5BH7zF8cWbg7472mRGs2fNI1KCAYN7mwjJMBgTA8fpy0KGZb61QLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZXe2nTP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZXe2nTP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C4F0404CD
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxGMZ7SXA4tN for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jan 2025 16:37:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E1A48403CE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1A48403CE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZXe2nTP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1A48403CE
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738168629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LkXx8zondeyhUCYuhAz6Lfn3PToEuRq9ZqfAdwuz1YI=;
	b=PZXe2nTP5qYRgHkkl4B1PORF6eAREsUxJ4eTQ89xoCFnJcTYgZoj8Jy2pg2hEEt2DI65tV
	zJsCkuLMJykOQ7XwJB93/fMc4rhepBDmcT9nNm/zct/OKea8sVyZmR8BSxY88zbRmN5wH6
	zqabAdg4RomvZ0JmTXNBjI3o7CNuFkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-TkTm0KmhMBSGP9orpV9kAw-1; Wed, 29 Jan 2025 11:37:08 -0500
X-MC-Unique: TkTm0KmhMBSGP9orpV9kAw-1
X-Mimecast-MFC-AGG-ID: TkTm0KmhMBSGP9orpV9kAw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso2542775f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 08:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168626; x=1738773426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkXx8zondeyhUCYuhAz6Lfn3PToEuRq9ZqfAdwuz1YI=;
        b=rDi6wsl+ABssn3ejz+d/3FMfyZzlWvFtBYdIQG1HkfitwQuJ31pWn6dMru2fqDO0cq
         EZWFdGUV32z8+0t39ZP+aCMpFG32mPlVIZeLzFXlVSJEgATm3UlyaymWNOb/UxJtxT5r
         VBk14moOH4s86IP+9wciKPPBkulxC75s4o+kSp73ExKf1K0J2CW2xNGUbX4JjqTifCo0
         Jn95N6MIZbmI06wZbF1BtLUeXG52Mot1eZMXrnhl7g+uWH7kqfuA/jz9Q9c5OoQLUAn+
         DJOhoYpgS9asXksM+PVTCmpyg5VJ8ROaBBZ4KKYBya0di13wm5I23Y9e0CaDajXB2qYO
         LqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXCHh/MOF/Rau/Fr1bg3rd6gzswCtUSNQ7NNM3J501Z4GtNgg572p66/6DNkpB6Ii6dwp87+qmv6Mxk0cuaTQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzjXT8KuhDxq//LacU7fLawbBG4431A7rNXObDVqCDIr51RFlDy
	WlyZXaOQWhm5ZKjfzoeRxvPCJUrNs/at1j8S3B3WiSaCRfzXx0kbA5LMNftcnK2l1OMPs8GIWuV
	fT8DKCvXsG0PC+NfjvMVMitkYRWeJDnhQj5rIrtRMCs4BduFVSLNg30Tf87LIilPKoystoFClxu
	bYoj4=
X-Gm-Gg: ASbGncvUNTqXNCq/LDIoMzK6bwHDKBF4dyEQTyJQWk1YH9abTscUm9GuKVVTsgLdNeL
	phwbeGPdLyIcha2VpDMYXwIdYvtaNITXxUsGENclehlfUnNSTkXQvngvhhRosAsTuBlNcdzb84l
	MOgD07OsSVZDN21Ddmh521Zn0eXvcywWYZMWA/X0tE+pMfgHfXjOoQvYDqqALZmBMpXnYtIluNg
	amhhL9XHp2ZDP0pyGayIlpYGOZCvJl8f0P5Nf1NXueR5Lht1nw7wh0IGr+gijR0oCBLG+9ZWlsR
	liLsLWeIvQ==
X-Received: by 2002:a05:6000:11c9:b0:38c:1270:f961 with SMTP id ffacd0b85a97d-38c520b7c7fmr2898334f8f.46.1738168626379;
        Wed, 29 Jan 2025 08:37:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV791ilXycUmlk1W6LWWwVp4j08qk2gkhUmlRuX2mypnrRVCaHxya2CY5DPiZ2ukrU63mTLg==
X-Received: by 2002:a05:6000:11c9:b0:38c:1270:f961 with SMTP id ffacd0b85a97d-38c520b7c7fmr2898309f8f.46.1738168625742;
        Wed, 29 Jan 2025 08:37:05 -0800 (PST)
Received: from sgarzare-redhat ([185.121.209.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc24cefsm28319345e9.15.2025.01.29.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:37:05 -0800 (PST)
Date: Wed, 29 Jan 2025 17:36:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
	pbonzini@redhat.com, wh1sper@zju.edu.cn, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] vhost-scsi: Fix handling of multiple calls to
 vhost_scsi_set_endpoint
Message-ID: <bte2rkiy7tvefzanh6hsym3xawuyjznpcoevxcdifw7jqqep5r@vdanwnpihn27>
References: <20250121213125.140333-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250121213125.140333-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xqgHf94Nxnv-GaQtJS004eCMqSOzJxLX8_N21p3OfaY_1738168627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 21, 2025 at 03:31:25PM -0600, Mike Christie wrote:
>If vhost_scsi_set_endpoint is called multiple times without a
>vhost_scsi_clear_endpoint between them, we can hit multiple bugs
>found by Haoran Zhang:
>
>1. Use-after-free when no tpgs are found:
>
>This fixes a use after free that occurs when vhost_scsi_set_endpoint is
>called more than once and calls after the first call do not find any
>tpgs to add to the vs_tpg. When vhost_scsi_set_endpoint first finds
>tpgs to add to the vs_tpg array match=true, so we will do:
>
>vhost_vq_set_backend(vq, vs_tpg);
>...
>
>kfree(vs->vs_tpg);
>vs->vs_tpg = vs_tpg;
>
>If vhost_scsi_set_endpoint is called again and no tpgs are found
>match=false so we skip the vhost_vq_set_backend call leaving the
>pointer to the vs_tpg we then free via:
>
>kfree(vs->vs_tpg);
>vs->vs_tpg = vs_tpg;
>
>If a scsi request is then sent we do:
>
>vhost_scsi_handle_vq -> vhost_scsi_get_req -> vhost_vq_get_backend
>
>which sees the vs_tpg we just did a kfree on.
>
>2. Tpg dir removal hang:
>
>This patch fixes an issue where we cannot remove a LIO/target layer
>tpg (and structs above it like the target) dir due to the refcount
>dropping to -1.
>
>The problem is that if vhost_scsi_set_endpoint detects a tpg is already
>in the vs->vs_tpg array or if the tpg has been removed so
>target_depend_item fails, the undepend goto handler will do
>target_undepend_item on all tpgs in the vs_tpg array dropping their
>refcount to 0. At this time vs_tpg contains both the tpgs we have added
>in the current vhost_scsi_set_endpoint call as well as tpgs we added in
>previous calls which are also in vs->vs_tpg.
>
>Later, when vhost_scsi_clear_endpoint runs it will do
>target_undepend_item on all the tpgs in the vs->vs_tpg which will drop
>their refcount to -1. Userspace will then not be able to remove the tpg
>and will hang when it tries to do rmdir on the tpg dir.
>
>3. Tpg leak:
>
>This fixes a bug where we can leak tpgs and cause them to be
>un-removable because the target name is overwritten when
>vhost_scsi_set_endpoint is called multiple times but with different
>target names.
>
>The bug occurs if a user has called VHOST_SCSI_SET_ENDPOINT and setup
>a vhost-scsi device to target/tpg mapping, then calls
>VHOST_SCSI_SET_ENDPOINT again with a new target name that has tpgs we
>haven't seen before (target1 has tpg1 but target2 has tpg2). When this
>happens we don't teardown the old target tpg mapping and just overwrite
>the target name and the vs->vs_tpg array. Later when we do
>vhost_scsi_clear_endpoint, we are passed in either target1 or target2's
>name and we will only match that target's tpgs when we loop over the
>vs->vs_tpg. We will then return from the function without doing
>target_undepend_item on the tpgs.
>
>Because of all these bugs, it looks like being able to call
>vhost_scsi_set_endpoint multiple times was never supported. The major
>user, QEMU, already has checks to prevent this use case. So to fix the
>issues, this patch prevents vhost_scsi_set_endpoint from being called
>if it's already successfully added tpgs. To add, remove or change the
>tpg config or target name, you must do a vhost_scsi_clear_endpoint
>first.
>
>Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
>Fixes: 4f7f46d32c98 ("tcm_vhost: Use vq->private_data to indicate if the endpoint is setup")
>Reported-by: Haoran Zhang <wh1sper@zju.edu.cn>
>Closes: https://lore.kernel.org/virtualization/e418a5ee-45ca-4d18-9b5d-6f8b6b1add8e@oracle.com/T/#me6c0041ce376677419b9b2563494172a01487ecb
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/scsi.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>index 9a4cbdc607fa..6bb64f3be7db 100644
>--- a/drivers/vhost/scsi.c
>+++ b/drivers/vhost/scsi.c
>@@ -1828,14 +1828,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 		}
> 	}
>
>+	if (vs->vs_tpg) {
>+		pr_err("vhost-scsi endpoint already set for %s.\n",
>+		       vs->vs_vhost_wwpn);
>+		ret = -EEXIST;
>+		goto out;
>+	}
>+
> 	len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
> 	vs_tpg = kzalloc(len, GFP_KERNEL);
> 	if (!vs_tpg) {
> 		ret = -ENOMEM;
> 		goto out;
> 	}
>-	if (vs->vs_tpg)
>-		memcpy(vs_tpg, vs->vs_tpg, len);
>
> 	mutex_lock(&vhost_scsi_mutex);
> 	list_for_each_entry(tpg, &vhost_scsi_list, tv_tpg_list) {
>@@ -1851,12 +1856,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 		tv_tport = tpg->tport;
>
> 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
>-			if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
>-				mutex_unlock(&tpg->tv_tpg_mutex);
>-				mutex_unlock(&vhost_scsi_mutex);
>-				ret = -EEXIST;
>-				goto undepend;
>-			}
> 			/*
> 			 * In order to ensure individual vhost-scsi configfs
> 			 * groups cannot be removed while in use by vhost ioctl,
>@@ -1903,7 +1902,8 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 		}
> 		ret = 0;
> 	} else {
>-		ret = -EEXIST;
>+		ret = -ENODEV;
>+		goto free_tpg;
> 	}

After this block there this code:

>
> 	/*
	 * Act as synchronize_rcu to make sure access to
	 * old vs->vs_tpg is finished.
	 */
	vhost_scsi_flush(vs);
	kfree(vs->vs_tpg);
	vs->vs_tpg = vs_tpg;
	goto out;

Should we adapt also that code, removing the kfree() and updating the 
comment?

The rest LGTM!

Thanks,
Stefano


>@@ -1931,6 +1931,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
> 		}
> 	}
>+free_tpg:
> 	kfree(vs_tpg);
> out:
> 	mutex_unlock(&vs->dev.mutex);
>@@ -2033,6 +2034,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
> 	vhost_scsi_flush(vs);
> 	kfree(vs->vs_tpg);
> 	vs->vs_tpg = NULL;
>+	memset(vs->vs_vhost_wwpn, 0, sizeof(vs->vs_vhost_wwpn));
> 	WARN_ON(vs->vs_events_nr);
> 	mutex_unlock(&vs->dev.mutex);
> 	return 0;
>-- 
>2.43.0
>

