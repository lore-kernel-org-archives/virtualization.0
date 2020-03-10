From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 08/24] scsi: add host tagset busy iterator
Date: Wed, 11 Mar 2020 00:25:34 +0800
Message-ID: <1583857550-12049-9-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-scsi-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.de>

Add an iterator scsi_host_tagset_busy_iter() to easily traverse all
busy commands. No locking is done here; this need to be ensured by
the caller.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hosts.c     | 27 +++++++++++++++++++++++++++
 include/scsi/scsi_host.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 1d669e47b692..97704a630f8e 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -650,3 +650,30 @@ void scsi_flush_work(struct Scsi_Host *shost)
 	flush_workqueue(shost->work_q);
 }
 EXPORT_SYMBOL_GPL(scsi_flush_work);
+
+struct scsi_host_tagset_busy_iter_data {
+	scsi_host_busy_iter_fn *fn;
+	void *priv;
+};
+
+static bool scsi_host_tagset_busy_iter_fn(struct request *req, void *priv,
+					  bool reserved)
+{
+	struct scsi_host_tagset_busy_iter_data *iter_data = priv;
+	struct scsi_cmnd *sc = blk_mq_rq_to_pdu(req);
+
+	return iter_data->fn(sc, iter_data->priv, reserved);
+}
+
+void scsi_host_tagset_busy_iter(struct Scsi_Host *shost,
+				scsi_host_busy_iter_fn *fn, void *priv)
+{
+	struct scsi_host_tagset_busy_iter_data iter_data = {
+		.fn = fn,
+		.priv = priv,
+	};
+
+	blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_tagset_busy_iter_fn,
+				&iter_data);
+}
+EXPORT_SYMBOL_GPL(scsi_host_tagset_busy_iter);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 2258a4f7b4d8..663aef22437a 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -767,6 +767,11 @@ static inline int scsi_host_scan_allowed(struct Scsi_Host *shost)
 extern void scsi_unblock_requests(struct Scsi_Host *);
 extern void scsi_block_requests(struct Scsi_Host *);
 
+typedef bool (scsi_host_busy_iter_fn)(struct scsi_cmnd *, void *, bool);
+
+void scsi_host_tagset_busy_iter(struct Scsi_Host *,
+				scsi_host_busy_iter_fn *fn, void *priv);
+
 struct class_container;
 
 /*
-- 
2.17.1
