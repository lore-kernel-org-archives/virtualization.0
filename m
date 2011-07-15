From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 004/117] Staging: hv: Add code to parse struct hv_vmbus_device_id table
Date: Fri, 15 Jul 2011 10:45:52 -0700
Message-ID: <1310752065-27895-4-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add code to parse struct hv_vmbus_device_id table.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 scripts/mod/file2alias.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e26e2fb..b74d21a 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -735,6 +735,27 @@ static int do_virtio_entry(const char *filename, struct virtio_device_id *id,
 	return 1;
 }
 
+/*
+ * Looks like: vmbus:guid
+ * Each byte of the guid will be represented by two hex characters
+ * in the name.
+ */
+
+static int do_vmbus_entry(const char *filename, struct hv_vmbus_device_id *id,
+			  char *alias)
+{
+	int i;
+	char guid_name[((sizeof(struct hv_vmbus_device_id) + 1)) * 2];
+
+	for (i = 0; i < (sizeof(struct hv_vmbus_device_id) * 2); i += 2)
+		sprintf(&guid_name[i], "%02x", id->guid[i/2]);
+
+	strcpy(alias, "vmbus:");
+	strcat(alias, guid_name);
+
+	return 1;
+}
+
 /* Looks like: i2c:S */
 static int do_i2c_entry(const char *filename, struct i2c_device_id *id,
 			char *alias)
@@ -994,6 +1015,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		do_table(symval, sym->st_size,
 			 sizeof(struct virtio_device_id), "virtio",
 			 do_virtio_entry, mod);
+	else if (sym_is(symname, "__mod_vmbus_device_table"))
+		do_table(symval, sym->st_size,
+			 sizeof(struct hv_vmbus_device_id), "vmbus",
+			 do_vmbus_entry, mod);
 	else if (sym_is(symname, "__mod_i2c_device_table"))
 		do_table(symval, sym->st_size,
 			 sizeof(struct i2c_device_id), "i2c",
-- 
1.7.4.1
