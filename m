From: George Zhang <georgezhang@vmware.com>
Subject: [PATCH 06/11] vmci_handle_array.patch: VMCI array of vmci_handle.
Date: Thu, 30 Aug 2012 09:41:17 -0700
Message-ID: <15333E71B3DDCB48A90165AD57993F285685DB43DC__42910.1039575928$1346779737$gmane$org@exch-mbx-114.vmware.com>
References: <20120824171042.4775.36871.stgit@promb-2n-dhcp175.eng.vmware.com>,
	<20120824171617.4775.63033.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120824171617.4775.63033.stgit@promb-2n-dhcp175.eng.vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Signed-off-by: George Zhang <georgezhang@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_handle_array.c |  163 +++++++++++++++++++++++++++++
 drivers/misc/vmw_vmci/vmci_handle_array.h |   46 ++++++++
 2 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.h

diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.c b/drivers/misc/vmw_vmci/vmci_handle_array.c
new file mode 100644
index 0000000..34ed126
--- /dev/null
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.c
@@ -0,0 +1,163 @@
+/*
+ * VMware VMCI Driver
+ *
+ * Copyright (C) 2012 VMware, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation version 2 and no later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+
+#include <linux/slab.h>
+#include "vmci_handle_array.h"
+
+static size_t handle_arr_calc_size(size_t capacity)
+{
+       return sizeof(struct vmci_handle_arr) +
+               capacity * sizeof(struct vmci_handle);
+}
+
+struct vmci_handle_arr *vmci_handle_arr_create(size_t capacity)
+{
+       struct vmci_handle_arr *array;
+
+       if (capacity == 0)
+               capacity = VMCI_HANDLE_ARRAY_DEFAULT_SIZE;
+
+       array = kmalloc(handle_arr_calc_size(capacity), GFP_ATOMIC);
+       if (!array)
+               return NULL;
+
+       array->capacity = capacity;
+       array->size = 0;
+
+       return array;
+}
+
+void vmci_handle_arr_destroy(struct vmci_handle_arr *array)
+{
+       kfree(array);
+}
+
+void vmci_handle_arr_append_entry(struct vmci_handle_arr **arrayPtr,
+                                 struct vmci_handle handle)
+{
+       struct vmci_handle_arr *array;
+
+       BUG_ON(!arrayPtr || !*arrayPtr);
+       array = *arrayPtr;
+
+       if (unlikely(array->size >= array->capacity)) {
+               /* reallocate. */
+               struct vmci_handle_arr *new_array;
+               size_t new_capacity = array->capacity * VMCI_ARR_CAP_MULT;
+               size_t new_size = handle_arr_calc_size(new_capacity);
+
+               new_array = krealloc(array, new_size, GFP_ATOMIC);
+               if (!new_array)
+                       return;
+
+               new_array->capacity = new_capacity;
+               *arrayPtr = array = new_array;
+       }
+
+       array->entries[array->size] = handle;
+       array->size++;
+}
+
+/*
+ * Handle that was removed, VMCI_INVALID_HANDLE if entry not found.
+ */
+struct vmci_handle vmci_handle_arr_remove_entry(struct vmci_handle_arr *array,
+                                               struct vmci_handle entryHandle)
+{
+       struct vmci_handle handle = VMCI_INVALID_HANDLE;
+       size_t i;
+
+       BUG_ON(!array);
+
+       for (i = 0; i < array->size; i++) {
+               if (VMCI_HANDLE_EQUAL(array->entries[i], entryHandle)) {
+                       handle = array->entries[i];
+                       array->size--;
+                       array->entries[i] = array->entries[array->size];
+                       array->entries[array->size] = VMCI_INVALID_HANDLE;
+                       break;
+               }
+       }
+
+       return handle;
+}
+
+/*
+ * Handle that was removed, VMCI_INVALID_HANDLE if array was empty.
+ */
+struct vmci_handle vmci_handle_arr_remove_tail(struct vmci_handle_arr *array)
+{
+       struct vmci_handle handle = VMCI_INVALID_HANDLE;
+
+       BUG_ON(!array);
+
+       if (array->size) {
+               array->size--;
+               handle = array->entries[array->size];
+               array->entries[array->size] = VMCI_INVALID_HANDLE;
+       }
+
+       return handle;
+}
+
+/*
+ * Handle at given index, VMCI_INVALID_HANDLE if invalid index.
+ */
+struct vmci_handle
+vmci_handle_arr_get_entry(const struct vmci_handle_arr *array,
+                         size_t index)
+{
+       BUG_ON(!array);
+
+       if (unlikely(index >= array->size))
+               return VMCI_INVALID_HANDLE;
+
+       return array->entries[index];
+}
+
+size_t vmci_handle_arr_get_size(const struct vmci_handle_arr *array)
+{
+       BUG_ON(!array);
+
+       return array->size;
+}
+
+bool vmci_handle_arr_has_entry(const struct vmci_handle_arr *array,
+                              struct vmci_handle entryHandle)
+{
+       size_t i;
+
+       BUG_ON(!array);
+
+       for (i = 0; i < array->size; i++)
+               if (VMCI_HANDLE_EQUAL(array->entries[i], entryHandle))
+                       return true;
+
+       return false;
+}
+
+/*
+ * NULL if the array is empty. Otherwise, a pointer to the array
+ * of VMCI handles in the handle array.
+ */
+struct vmci_handle *vmci_handle_arr_get_handles(struct vmci_handle_arr *array)
+{
+       BUG_ON(!array);
+
+       if (array->size)
+               return array->entries;
+
+       return NULL;
+}
diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.h b/drivers/misc/vmw_vmci/vmci_handle_array.h
new file mode 100644
index 0000000..f3442a3
--- /dev/null
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.h
@@ -0,0 +1,46 @@
+/*
+ * VMware VMCI Driver
+ *
+ * Copyright (C) 2012 VMware, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation version 2 and no later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef _VMCI_HANDLE_ARRAY_H_
+#define _VMCI_HANDLE_ARRAY_H_
+
+#include <linux/vmw_vmci_defs.h>
+#include <linux/types.h>
+
+#define VMCI_HANDLE_ARRAY_DEFAULT_SIZE 4
+#define VMCI_ARR_CAP_MULT 2    /* Array capacity multiplier */
+
+struct vmci_handle_arr {
+       size_t capacity;
+       size_t size;
+       struct vmci_handle entries[];
+};
+
+struct vmci_handle_arr *vmci_handle_arr_create(size_t capacity);
+void vmci_handle_arr_destroy(struct vmci_handle_arr *array);
+void vmci_handle_arr_append_entry(struct vmci_handle_arr **arrayPtr,
+                                 struct vmci_handle handle);
+struct vmci_handle vmci_handle_arr_remove_entry(struct vmci_handle_arr *array,
+                                               struct vmci_handle entryHandle);
+struct vmci_handle vmci_handle_arr_remove_tail(struct vmci_handle_arr *array);
+struct vmci_handle
+vmci_handle_arr_get_entry(const struct vmci_handle_arr *array,
+                         size_t index);
+size_t vmci_handle_arr_get_size(const struct vmci_handle_arr *array);
+bool vmci_handle_arr_has_entry(const struct vmci_handle_arr *array,
+                              struct vmci_handle entryHandle);
+struct vmci_handle *vmci_handle_arr_get_handles(struct vmci_handle_arr *array);
+
+#endif /* _VMCI_HANDLE_ARRAY_H_ */
