Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935D5EB64DB
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 15:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3905461340;
	Tue, 20 Jun 2023 15:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3905461340
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RqtNAe1R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbGtZ6cjKS5c; Tue, 20 Jun 2023 15:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6F6B61342;
	Tue, 20 Jun 2023 15:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6F6B61342
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92708C0037;
	Tue, 20 Jun 2023 15:14:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31BE1C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 282CD41715
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 282CD41715
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RqtNAe1R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KUeBsIOsZFfd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F3154170B
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F3154170B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:09 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55380677566so2251179a12.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1687274049; x=1689866049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4+x+nHT/B45E7UNnOquSwSO/h9YI0Q8rRdwe69B63Q=;
 b=RqtNAe1RFUQMvzoORbX6DkZQi3UCv6ODu+PrzEzpYSbBftvYU2zYVD47PcImmkCIe7
 BKQM7uPqi2PLFoKjz6oKM07HnmCNSiGOM9BPK6LGvIHrdADRMqW3EA7bHIQlaSA4aCaH
 K4ZagfAuaP18sbIGdxUoH2jYTicucMLlHh5Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274049; x=1689866049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4+x+nHT/B45E7UNnOquSwSO/h9YI0Q8rRdwe69B63Q=;
 b=Ml0lstx0vfGbfCSW0b+g3evdLrbWrEHF1SiYts2MV6HUTFiU20OeRZDFAe+j9jOk/O
 OkcYK/uWJuW4cHYnrmiOen5EXYKmlKI6JtezddKMKYyg8fCM4Ktj0LgbHHrBDpx4wt86
 HFuVCr2NE/dh6rqD/nuGuBM4fOe7JLaHV8Mx/NvldHCv8i0Rd33DcEAaYlmrgDn021pF
 WVFMcT+Mjg+6SJhEic2K2dIAhxn4VzoyeyT8Nkmf0yU3PXYxJ3AKpVCV0fk9qqsHWgdA
 +k/M6J8k0AKa+Qpku/i6JcKnI6xydxAIAiQCaSFcLxDoJLh+ef/P1siVUSgAns7lW2ai
 85sQ==
X-Gm-Message-State: AC+VfDw1KEqJctKzkkKEkQ+hX/LDnaGFWzf7ZoSCfGgRuiUoxk1Gw+mJ
 fPtJaosugWyoVr5n/vtFPwGcUeL/QwYKcMZJHlw=
X-Google-Smtp-Source: ACHHUZ7Rq928JI13B91Bwvj3KipWu3jBQaQgSh0KVxwME+Q4LkNUZdGe807jnxk5uiZldi6heglgvQ==
X-Received: by 2002:a17:903:124e:b0:1b1:dfbd:a18c with SMTP id
 u14-20020a170903124e00b001b1dfbda18cmr8932980plh.39.1687274048672; 
 Tue, 20 Jun 2023 08:14:08 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com
 ([2401:fa00:8f:203:e87e:41e3:d762:f8a8])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a170902ec8900b001aaf370b1c7sm1731872plg.278.2023.06.20.08.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:14:08 -0700 (PDT)
From: Keiichi Watanabe <keiichiw@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] virtiofs: Add negative_dentry_timeout option
Date: Wed, 21 Jun 2023 00:13:16 +0900
Message-ID: <20230620151328.1637569-4-keiichiw@chromium.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230620151328.1637569-1-keiichiw@chromium.org>
References: <20230620151328.1637569-1-keiichiw@chromium.org>
MIME-Version: 1.0
Cc: uekawa@chromium.org, mhiramat@google.com, drosen@google.com,
 Jonathan Corbet <corbet@lwn.net>, sarthakkukreti@google.com,
 Miklos Szeredi <miklos@szeredi.hu>, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, takayas@chromium.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

Add negative_dentry_timeout mount option to virtiofs to caching negative
dentry on the guest side. When the host virito-fs device has an exclusive
access to the file system and the machine has enough memory, one can
specify a long time as the timeout.

This option saves ~1 second per 10,000 stat request for non-existing paths.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---

 Documentation/filesystems/virtiofs.rst | 4 ++++
 fs/fuse/virtio_fs.c                    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index fdec5a7840f7..b045ef2223de 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -48,6 +48,10 @@ ro, rw, context, etc. Also, virtiofs has its own options.
 dax[=always,never,inode]
   Enable direct access for files. See :ref:`virtiofs-dax`.
 
+negative_dentry_timeout=N
+  Set the time in seconds to keep negative dentry cache. Same as the FUSE's
+  mount option.
+
 atime behavior
 ^^^^^^^^^^^^^^
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..bbbd840510f9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -99,11 +99,13 @@ static const struct constant_table dax_param_enums[] = {
 enum {
 	OPT_DAX,
 	OPT_DAX_ENUM,
+	OPT_NEGATIVE_DENTRY_TIMEOUT,
 };
 
 static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	fsparam_flag("dax", OPT_DAX),
 	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
+	fsparam_u32 ("negative_dentry_timeout", OPT_NEGATIVE_DENTRY_TIMEOUT),
 	{}
 };
 
@@ -125,6 +127,9 @@ static int virtio_fs_parse_param(struct fs_context *fsc,
 	case OPT_DAX_ENUM:
 		ctx->dax_mode = result.uint_32;
 		break;
+	case OPT_NEGATIVE_DENTRY_TIMEOUT:
+		ctx->negative_dentry_timeout = result.uint_32;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1416,6 +1421,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	struct super_block *sb;
 	struct fuse_conn *fc = NULL;
 	struct fuse_mount *fm;
+	struct fuse_fs_context *ffc;
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
@@ -1468,6 +1474,8 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 
 		sb->s_flags |= SB_ACTIVE;
 	}
+	ffc = fsc->fs_private;
+	fm->negative_dentry_timeout = ffc->negative_dentry_timeout;
 
 	WARN_ON(fsc->root);
 	fsc->root = dget(sb->s_root);
-- 
2.41.0.185.g7c58973941-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
