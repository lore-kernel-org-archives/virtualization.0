Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EF17BD6
	for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079489; cv=none; b=oFlEXURLbsq4I0Pa4GeMC2JmDGvjtnxy4IDy2Jm5aAfaCntyMBUa1YcMlc1gWFA8NArViXHSsSb+IlDcmsOltOBz73CwzXJQZYz3SsOkH8WVmlgpPejDs6a4aihRZin5yYRGA2DtorOvpnrFDyYBrHlilwEA/XKa5fsKC9Rmi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079489; c=relaxed/simple;
	bh=i5JQm9DqrSRQ96Mfvrlb1RwHHX8YBXcxQ9y8zq+dgJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=BXLs9W/s3MBWkYiwwhMAhkBzGCmQx2BYXnUSYomym864yQNZqitYLzApvTJwhzUdPUfNrg7/U9bxxMGGPCc/rvPQq++UYLglj/iD/kiQ8AZeNhuJFv60oiVqET3IqtZTkmeTOVbW2YizlIK1mnpKKj+OcwBU0BJGG3gfS5TNtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egkWhmYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egkWhmYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743079486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kfyheL9jEG9357hLbmic+IF7J8U9ykncYZ9iUVWBbFY=;
	b=egkWhmYf/5XuOGUsvAY10OIPbF3oayCASY/sUN+zRQO1Ck7qiq18Ofrc9YLcQrHrSMUSlW
	yG6rhXs/1AhhyovF7L42DKzPaLUHA6zHLVfLW0TQ5elvAQdbtKIb0ncD+yi44+/SP16zoR
	q7R85Emf/7zB0GC9vM3HiLTY5Oz3c34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-ZENOb-nbMP2Vyc5jBxfKCg-1; Thu, 27 Mar 2025 08:44:44 -0400
X-MC-Unique: ZENOb-nbMP2Vyc5jBxfKCg-1
X-Mimecast-MFC-AGG-ID: ZENOb-nbMP2Vyc5jBxfKCg_1743079484
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471ddso745280f8f.0
        for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 05:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079484; x=1743684284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfyheL9jEG9357hLbmic+IF7J8U9ykncYZ9iUVWBbFY=;
        b=NZqF16PPSQzXbub0Uppnd1ugQgv+hj4yZLh+vdzO3mdGXinoF9Tvyxl3qHmmsXQpUs
         M08uqZmMHEMcx0W20Pa/bN1JyyvSd/s5gwFOhD276HS3bHV0Kd1Yme2raCpHc0rQIZtV
         aZC9FhFZhYwPsmMDD4y2H2VMVlIg9/vcP2KIPHL+dqWzBo/CvNqA8zv7e3p7Mg5B9zov
         GS8p5GReTiyCtVArfQo4BeCEBdrWDGlLHtS1k31BXhCSmKf8P/bdi1L96uUA2DlDr1T2
         SJEd/Ph3KPAZjOyaMHNMYNa0OQeAl0OqMCSzLaVEYJixnxEj32Bob7DxL70wd8RrFDlz
         N0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUdd81u5AVCChSK1i1h/o89Z1CMjqdmLtA4NDTWd7yZz1Di9lTdlE66eebjw1PvVxA/W1Senpzr7CNq46DnKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGQ8Qj2lcO1YNIYMYVIN8UPU3uSjUHoZfE52QrEttp4vbQRyct
	mpSGkVQOHt80hXOCfqsr3geBkeY4BYlrcBbCDtX3Tvht6y7A7b8cAUO28Vbo4DQRizT0tQZbzEB
	L5m5ZDj59PnH1hVU5OLG158wIiPflEwMVtx/Fl+fL54cffGfHkrtRZzHRzb9Tkj4D
X-Gm-Gg: ASbGncu1WQAcQZdmDqiCUIypaUFPFA6dfuyDeYjfxrSA890OlQeVSf0OpCh2qsXRnS9
	QvMCVg9uyM6xY5AzPj8JZbGyqZMOe0gA64DPiniyCqEbSk8OrfvNFj5mlVkBVpzpvx6cQ/CImU+
	719ffQ9zmg/pkhUpytXW1Mcp1rIfivLNIcZo4s0e6BNK0oaoZOc5w4rvVqbTtgMj8F+NNhkGzCb
	x7Q5jgSXifHUunl3VUN3bFeGraT2TaFft+ZCYow9TKxn25/7Xh/wtENcgVi+/7bJ/+jRX55liwU
	yqKTEAgVHRsDpOlJ+8Bm1apIVorJVLb6G263M0ivKo5CPwSpdXkxY6rHBqCp/mxQ6g==
X-Received: by 2002:a5d:6c6c:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39ad17845f7mr3077943f8f.37.1743079483841;
        Thu, 27 Mar 2025 05:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlm4s0EdoS5CN0bcv1wS4l/Yn0TLs2QyE9bGxPtaa+Rs3z5qIUN6VRMhNwAZdWNibUqtu8qg==
X-Received: by 2002:a5d:6c6c:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39ad17845f7mr3077908f8f.37.1743079483197;
        Thu, 27 Mar 2025 05:44:43 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f76sm19986612f8f.37.2025.03.27.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:44:42 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com
Cc: Mike Christie <michael.christie@oracle.com>,
	netdev@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost_task: fix vhost_task_create() documentation
Date: Thu, 27 Mar 2025 13:44:35 +0100
Message-ID: <20250327124435.142831-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rXwmnxbA6ByhAZVJ60aWTem5KBGK-1k7dckv-QjfE98_1743079484
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
changed the return value of vhost_task_create(), but did not update the
documentation.

Reflect the change in the documentation: on an error, vhost_task_create()
returns an ERR_PTR() and no longer NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 2ef2e1b80091..2f844c279a3e 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
  * @arg: data to be passed to fn and handled_kill
  * @name: the thread's name
  *
- * This returns a specialized task for use by the vhost layer or NULL on
+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-- 
2.49.0

