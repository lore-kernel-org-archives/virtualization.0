Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B65CDD0
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142317; cv=none; b=IV8HR/aipCwaj3fnLIakAASqarf4vb0ZZS/OjHKhBBOTulDE2o6fVB4qX4Rk61/9LnJCqboLiP40fQT1KZXArTG3aNRrKRSFpso5w0jaBaYDLAuPso+lTPK9h0CgDPf67g6w12SOepOS0BV3x/p4bXcKexECDjTd+CY1+HqrdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142317; c=relaxed/simple;
	bh=xjDegKdXPQfY8Xa8sV7JljW/gEP3Y8iqlVUVdjV33Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWZ/QJ+58zxihaS1p4/TwhSzsjvcOk1rFozcdPduyrjwJOhLI7xxIEyPzJ1FwCi00oEwsWFfEvQEFRWaXvSbfgJj30rogVl/pAqiInojrIFX27ZIkKmeKHYFcLBfXCmu/n4KF1pZidBB4ZANpyBWaOg+iZWqq64pzxMZrs4lNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQwM56792z4f3jZV
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 22:38:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C350F1A0568
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 22:38:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5gvCtmAU4WLA--.35655S4;
	Fri, 26 Apr 2024 22:38:26 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v3 0/2] virtiofs: fix the warning for kernel direct IO
Date: Fri, 26 Apr 2024 22:39:01 +0800
Message-Id: <20240426143903.1305919-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5gvCtmAU4WLA--.35655S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5Kw18ZrWkur48Gw48JFb_yoW8trWxpr
	WrGa15XrsrJryfJrZ3A3WkuFyFkwn5JF47G393Ww1rZrW3XF1I9rnFyF4Y9ry7Ary8AF1Y
	qr4SqF1qgryqv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to fix the warning related to an abnormal size
parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
Beside the abnormal size parameter for kmalloc, the gfp parameter is
also questionable: GFP_ATOMIC is used even when the allocation occurs
in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
allocation is initiated by the kworker. For more details, please check
the individual patches.

As usual, comments are always welcome.

Change Log:

v3:
 * introduce use_pages_for_kvec_io for virtiofs. When the option is
   enabled, fuse will use iov_iter_extract_pages() to construct a page
   array and pass the pages array instead of a pointer to virtiofs.
   The benefit is twofold: the length of the data passed to virtiofs is
   limited by max_pages, and there is no memory copy compared with v2.

v2: https://lore.kernel.org/linux-fsdevel/20240228144126.2864064-1-houtao@huaweicloud.com/
  * limit the length of ITER_KVEC dio by max_pages instead of the
    newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
    dio being consistent with other rw operations.
  * replace kmalloc-allocated bounce buffer by using a bounce buffer
    backed by scattered pages when the length of the bounce buffer for
    KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
    fragmented memory, the KVEC_ITER dio can be handled normally by
    virtiofs. (Bernd Schubert)
  * merge the GFP_NOFS patch [1] into this patch-set and use
    memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
    (Benjamin Coddington)

v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/

[1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/

Hou Tao (2):
  virtiofs: use pages instead of pointer for kernel direct IO
  virtiofs: use GFP_NOFS when enqueuing request through kworker

 fs/fuse/file.c      | 12 ++++++++----
 fs/fuse/fuse_i.h    |  3 +++
 fs/fuse/virtio_fs.c | 25 ++++++++++++++++---------
 3 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.29.2

