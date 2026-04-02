Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428D3DB64D
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126689; cv=none; b=SjpQvPzRPCeoTCbDnWzRGwf+31UX9DB38FnLAbuQIRQsJggOj/tXWaW1gpH5Je1K6cZI0RsDtODW06K2UzPHXFPmqTvoki6BuG/ByVz8C44LsyIAVc2svIWPDQp1IDTp1uQRUt9zm0C41XKr9GoHS9jp/5R6NbO/ejGbISlaA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126689; c=relaxed/simple;
	bh=A61Bs9tjmjcN78QEKkkZcCcKjs6of1/ymWeZVUhbUbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MemFw2ktr0+13z9Dghs1CbeCPMLlVfwRxfrCRprwo8Hdywi9roEDMOC2LJnct1b/1aWmL/xLnCQNXHLHQaCLf+wXifTK+fIdx2MMAp/osS11LgiqG9WApxesNTrWDmWkz5jwyN2oyekGBOghzXwndxDnTqzMJbKQSC5aC27hrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1dbdb822e8011f1aa26b74ffac11d73-20260402
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0baf6350-75ce-4dfa-81be-6b51c1b926ec,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0baf6350-75ce-4dfa-81be-6b51c1b926ec,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:18755920918767482a1e6305bc8f1969,BulkI
	D:26040218443816DT8OO7,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1dbdb822e8011f1aa26b74ffac11d73-20260402
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1049121907; Thu, 02 Apr 2026 18:44:37 +0800
From: Li Wang <liwang@kylinos.cn>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2 0/3] virtiofs: hiprio FORGET robustness and no-reply request completion
Date: Thu,  2 Apr 2026 18:44:04 +0800
Message-Id: <20260402104407.11495-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes virtiofs completion for FUSE requests that do not use a
reply descriptor, tightens hiprio FORGET handling when virtqueue submission
fails transiently, and prevents the hiprio worker from stalling when one
FORGET must be dropped after an unrecoverable error.

The first patch addresses correctness: completing a no-reply request must
not interpret the reply header fields, otherwise it will cause underflow, 
and the bounce buffer allocated for the absent out header must be freed.

The host may complete virtio requests without an out descriptor (e.g.
FUSE_FORGET). The completion path must not run copy_args_from_argbuf(),
which expects a valid fuse_out_header from the reply path. This series also
ensures virtio_fs_verify_response() runs only for real replies (FR_ISREPLY),
and frees req->argbuf on the no-reply path to avoid a per-request leak.

Changes since v1
------------------------------
Patch 1: v1 only guarded copy_args_from_argbuf() with FR_ISREPLY. v2 also
kfree(req->argbuf) when !FR_ISREPLY (the buffer was allocated in
copy_args_to_argbuf for an out header that never arrives), and gates
virtio_fs_verify_response() in virtio_fs_requests_done_work() on FR_ISREPLY
so uninitialized fuse_out_header is never verified.

Patch 2: behavior matches v1. The commit message is expanded to explain 
transient GFP_ATOMIC exhaustion and why dropping the FORGET would skew 
nlookup and leak kernel state.

Patch 3: behavior matches v1. The commit message documents the
return-value contract with virtio_fs_hiprio_dispatch_work() and the stall
risk on the nonzero path.

Commit messages were rewritten for clearer rationale.

Li Wang (3):
  virtiofs: Complete no-reply virtio requests without parsing the out
    header
  virtiofs: Retry hiprio FORGET when virtqueue_add_outbuf() returns
    -ENOMEM
  virtiofs: Do not stall hiprio FORGET dispatch after dropping one
    request

 fs/fuse/virtio_fs.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1
