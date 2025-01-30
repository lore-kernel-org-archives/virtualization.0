Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5C1AF0CA
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Jan 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226534; cv=none; b=f229FgWzwAnU1ZsW6ZLA1YG/ucpOWrxfZ5SugT7GNY7xjDLB28QS92D5Aa7msKAFz/YQNKOmhzT/RjFl0p9zLVXF7HN8WShb2sI4buSSWjehptKfopcUwIx2CfU5zOSrchnr7ABH7H2XReSZxA13tVdg5sTnlsppyI096/KdWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226534; c=relaxed/simple;
	bh=9gmO8CDtEcpkY4LusNsj4TrO4XZr0mPhLU2dTa2ir3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s/53ykfwZ2VMb94w1qSNHgus2tXXqkLA8koXeAVzb4fiLmF3cQJvaqFnFRJ9+elQPwbbwDhjwCrxycH6G3OYfPFNxlJKEi+iNQxLxIbSWEtvYkPS7aykH93GFZkUXdAUPMQ2cahJe4fknjb2GGxNS4Vs2ENxL3XLLzwhVjAyRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en4IMtc4; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en4IMtc4"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB7D382145
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Jan 2025 08:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJnnJ27wiB17 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jan 2025 08:42:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A18FF82132
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A18FF82132
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=en4IMtc4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A18FF82132
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Jan 2025 08:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738226528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guqZhT16hsfNEoj8uS9ayUKy3dG6Mjpn5UuFJY80H6Q=;
	b=en4IMtc40r0a/H1s3wrTP0P+0lp6XvsV09t9zX0vCpeB3sRxF8prnEDRgADHlGi0gr8QHk
	W63LBy0sOBbfXOJEBjMmzak3JbVKSkORRQAZQWqUrb+gVBR36G0YojO22sr/ciOo6fU9U7
	mlaBkdcZR22+wW92y4P9TPkPq3ia3to=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-cwV01TwzN4O5kRIpsrsT0A-1; Thu, 30 Jan 2025 03:42:07 -0500
X-MC-Unique: cwV01TwzN4O5kRIpsrsT0A-1
X-Mimecast-MFC-AGG-ID: cwV01TwzN4O5kRIpsrsT0A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a684a096eso195045f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Jan 2025 00:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738226525; x=1738831325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guqZhT16hsfNEoj8uS9ayUKy3dG6Mjpn5UuFJY80H6Q=;
        b=TkFzXwmOPTtHtn+jgAr66I38KStwALv3KKbFj+rEFNfp2Q+Bd5vDbSTItYy5sFZ9/8
         BFozkiLYFu73V96Si5VgEiJ3MMuXMGqk6vtcX6/WfBaeR4XKJGpV95kfS5iDSJTt+05B
         BTghAG2s6ObEqcRiQjp7A0BlfDcagxMsidTro50RfA/O6l6NVD+W1BT5jSawBVXfEam1
         AWoin2b2pYLX19jgUfxcF4Y84Aid2uqh330nePTUcPugaaaPq8Fkdak50mIb6mv3adfw
         xyzOdtBLB++LTaFek29wMINhhE6RdPLGmW2LkrblzkZMJBMomSobWWuHCNU1M/mlFa0f
         X5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUxuCf7Y5a1WleJIMXw+hSDeVociPvzbiD78rXdCYj+ITNFnOVfhQMr/v8DbiFuSR4pxxaeEd9WRIj3X1Gsag==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHXjPZP+ipBZ5Mc+ifW5IPm1CsLTtXtMkISHa2NUGpN3UY+z4M
	qMzW2UijPj/JCfhDuralV9f1anoD3ZjbLhBBSjAJOuq9WLJLJCzro8ULKCsnRShQYaQKxlOAMBa
	C55LOW0X4OQIkCXXgx8QzvI72l8BRun0uHe6+YHI+OdY7I5kTgWvhxULCLmS+JQP4BrqgUcpW42
	g/uSo=
X-Gm-Gg: ASbGncuc3+STV5+7mYnA+iLdcvJ3NeRNmTnMjygupXS7QVEtlA0gkpJxLbF/Z55RZ+o
	tZoHmSRBjAWkvigTghPxM7pKvdO7fm8KKjvwOZnYZNS7j+VriyTX+0Sfqm0sMLAOSl7wMUZrSn5
	eepRjrcBmCV9E2LQsYxfzDKiFgqcN1bewzu1ghpEtGJImEvR5zLnirPYK/eEjDe1ipww0cvaoUA
	NiF1Vmo6F1/8bpijjGkmrlgVaxT3SryIsFs8+9lkivzB+OIM73CzQHATCxAKCR3XCHBrdhZ7xN/
	naoYvGcNZg==
X-Received: by 2002:a5d:5850:0:b0:38a:88bc:aea4 with SMTP id ffacd0b85a97d-38c51b62994mr4595565f8f.30.1738226525093;
        Thu, 30 Jan 2025 00:42:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2/U673j8CFo/wZNkGIdj1W+vhpMDgatk8ebKnyt5tsvETOeI2KtLJSus/gfrXtSvMAfCq8g==
X-Received: by 2002:a5d:5850:0:b0:38a:88bc:aea4 with SMTP id ffacd0b85a97d-38c51b62994mr4595523f8f.30.1738226524335;
        Thu, 30 Jan 2025 00:42:04 -0800 (PST)
Received: from sgarzare-redhat ([185.121.209.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11b851sm1276897f8f.43.2025.01.30.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 00:42:03 -0800 (PST)
Date: Thu, 30 Jan 2025 09:41:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
	wh1sper@zju.edu.cn, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/1] vhost-scsi: Fix handling of multiple calls to
 vhost_scsi_set_endpoint
Message-ID: <lmwoe566uyhiylts6vwiklnwvvd5ewqonxoqe3frhuyexaodmm@uceco5u6n2qc>
References: <20250129210922.121533-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250129210922.121533-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KJci5ngohE9E7BZBbai7MVNxSxAb3srXXfItLt_tyOg_1738226526
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 29, 2025 at 03:09:22PM -0600, Mike Christie wrote:
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
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>v2
>- Drop kfree that's no longer needed.
>- Update comment.

Thanks for the fixes!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
> drivers/vhost/scsi.c | 25 +++++++++++++------------
> 1 file changed, 13 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>index 718fa4e0b31e..7aeff435c1d8 100644
>--- a/drivers/vhost/scsi.c
>+++ b/drivers/vhost/scsi.c
>@@ -1699,14 +1699,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
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
>@@ -1722,12 +1727,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
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
>@@ -1774,15 +1773,15 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 		}
> 		ret = 0;
> 	} else {
>-		ret = -EEXIST;
>+		ret = -ENODEV;
>+		goto free_tpg;
> 	}
>
> 	/*
>-	 * Act as synchronize_rcu to make sure access to
>-	 * old vs->vs_tpg is finished.
>+	 * Act as synchronize_rcu to make sure requests after this point
>+	 * see a fully setup device.
> 	 */
> 	vhost_scsi_flush(vs);
>-	kfree(vs->vs_tpg);
> 	vs->vs_tpg = vs_tpg;
> 	goto out;
>
>@@ -1802,6 +1801,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
> 		}
> 	}
>+free_tpg:
> 	kfree(vs_tpg);
> out:
> 	mutex_unlock(&vs->dev.mutex);
>@@ -1904,6 +1904,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
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

