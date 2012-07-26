From: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
Subject: [vmw_vmci 06/11] Apply dynamic array code
Date: Thu, 26 Jul 2012 16:39:35 -0700
Message-ID: <1343345980-32397-7-git-send-email-astiegmann@vmware.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, vm-crosstalk@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, cschamp@vmware.com, gregkh@linuxfoundation.org
List-Id: virtualization@lists.linuxfoundation.org

This code adds support for dynamic arrays that will grow if they
need to.

Signed-off-by: Andrew Stiegmann (stieg) <astiegmann@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_handle_array.c |  174 +++++++++++++++++++++++++++++
 drivers/misc/vmw_vmci/vmci_handle_array.h |   50 ++++++++
 2 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.h

diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.c b/drivers/misc/vmw_vmci/vmci_handle_array.c
new file mode 100644
index 0000000..e23e82b
--- /dev/null
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.c
@@ -0,0 +1,174 @@
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <linux/slab.h>
+
+#include "vmci_common_int.h"
+#include "vmci_handle_array.h"
+
+static unsigned handle_arr_calc_size(uint32_t c)
+{
+	/*
+	 * Decrement c because vmci_handle_arr already includes
+	 * one vmci_handle entry.
+	 */
+	return sizeof(struct vmci_handle_arr) +
+		--c  * sizeof(struct vmci_handle);
+}
+
+struct vmci_handle_arr *vmci_handle_arr_create(uint32_t capacity)
+{
+	struct vmci_handle_arr *array;
+	uint32_t arr_size;
+
+	if (capacity == 0)
+		capacity = VMCI_HANDLE_ARRAY_DEFAULT_SIZE;
+
+	arr_size = handle_arr_calc_size(capacity);
+	array = kmalloc(arr_size, GFP_ATOMIC);
+	if (!array)
+		return NULL;
+
+	array->capacity = capacity;
+	array->size = 0;
+
+	return array;
+}
+
+void vmci_handle_arr_destroy(struct vmci_handle_arr *array)
+{
+	kfree(array);
+}
+
+void vmci_handle_arr_append_entry(struct vmci_handle_arr **arrayPtr,
+				  struct vmci_handle handle)
+{
+	struct vmci_handle_arr *array;
+
+	ASSERT(arrayPtr && *arrayPtr);
+	array = *arrayPtr;
+
+	if (unlikely(array->size >= array->capacity)) {
+		/* reallocate. */
+		struct vmci_handle_arr *newArray;
+		const uint32_t arraySize =
+			handle_arr_calc_size(array->capacity *
+					     VMCI_ARR_CAP_MULT);
+
+		newArray = kmalloc(arraySize, GFP_ATOMIC);
+		if (!newArray)
+			return;
+
+		memcpy(newArray, array, arraySize);
+		newArray->capacity *= VMCI_ARR_CAP_MULT;
+		kfree(array);
+		*arrayPtr = newArray;
+		array = newArray;
+	}
+
+	array->entries[array->size] = handle;
+	array->size++;
+}
+
+/*
+ * Handle that was removed, VMCI_INVALID_HANDLE if entry not found.
+ */
+struct vmci_handle vmci_handle_arr_remove_entry(struct vmci_handle_arr *array,
+						struct vmci_handle entryHandle)
+{
+	uint32_t i;
+	struct vmci_handle handle = VMCI_INVALID_HANDLE;
+
+	ASSERT(array);
+	for (i = 0; i < array->size; i++) {
+		if (VMCI_HANDLE_EQUAL(array->entries[i], entryHandle)) {
+			handle = array->entries[i];
+			array->size--;
+			array->entries[i] = array->entries[array->size];
+			array->entries[array->size] = VMCI_INVALID_HANDLE;
+			break;
+		}
+	}
+
+	return handle;
+}
+
+/*
+ * Handle that was removed, VMCI_INVALID_HANDLE if array was empty.
+ */
+struct vmci_handle vmci_handle_arr_remove_tail(struct vmci_handle_arr *array)
+{
+	struct vmci_handle handle = VMCI_INVALID_HANDLE;
+
+	if (array->size) {
+		array->size--;
+		handle = array->entries[array->size];
+		array->entries[array->size] = VMCI_INVALID_HANDLE;
+	}
+
+	return handle;
+}
+
+/*
+ * Handle at given index, VMCI_INVALID_HANDLE if invalid index.
+ */
+struct vmci_handle
+vmci_handle_arr_get_entry(const struct vmci_handle_arr *array,
+			  uint32_t index)
+{
+	ASSERT(array);
+
+	if (unlikely(index >= array->size))
+		return VMCI_INVALID_HANDLE;
+
+	return array->entries[index];
+}
+
+uint32_t vmci_handle_arr_get_size(const struct vmci_handle_arr *array)
+{
+	ASSERT(array);
+	return array->size;
+}
+
+bool vmci_handle_arr_has_entry(const struct vmci_handle_arr *array,
+			       struct vmci_handle entryHandle)
+{
+	uint32_t i;
+
+	ASSERT(array);
+	for (i = 0; i < array->size; i++)
+		if (VMCI_HANDLE_EQUAL(array->entries[i], entryHandle))
+			return true;
+
+	return false;
+}
+
+/*
+ * NULL if the array is empty. Otherwise, a pointer to the array
+ * of VMCI handles in the handle array.
+ */
+struct vmci_handle *vmci_handle_arr_get_handles(struct vmci_handle_arr *array)
+{
+	ASSERT(array);
+
+	if (array->size)
+		return array->entries;
+
+	return NULL;
+}
diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.h b/drivers/misc/vmw_vmci/vmci_handle_array.h
new file mode 100644
index 0000000..966a6fd
--- /dev/null
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.h
@@ -0,0 +1,50 @@
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef _VMCI_HANDLE_ARRAY_H_
+#define _VMCI_HANDLE_ARRAY_H_
+
+#include <linux/slab.h>
+#include <linux/vmw_vmci_defs.h>
+
+#define VMCI_HANDLE_ARRAY_DEFAULT_SIZE 4
+#define VMCI_ARR_CAP_MULT 2	/* Array capacity multiplier */
+
+struct vmci_handle_arr {
+	uint32_t capacity;
+	uint32_t size;
+	struct vmci_handle entries[1];
+};
+
+struct vmci_handle_arr *vmci_handle_arr_create(uint32_t capacity);
+void vmci_handle_arr_destroy(struct vmci_handle_arr *array);
+void vmci_handle_arr_append_entry(struct vmci_handle_arr **arrayPtr,
+				  struct vmci_handle handle);
+struct vmci_handle vmci_handle_arr_remove_entry(struct vmci_handle_arr *array,
+						struct vmci_handle entryHandle);
+struct vmci_handle vmci_handle_arr_remove_tail(struct vmci_handle_arr *array);
+struct vmci_handle
+vmci_handle_arr_get_entry(const struct vmci_handle_arr *array,
+			  uint32_t index);
+uint32_t vmci_handle_arr_get_size(const struct vmci_handle_arr *array);
+bool vmci_handle_arr_has_entry(const struct vmci_handle_arr *array,
+			       struct vmci_handle entryHandle);
+struct vmci_handle *vmci_handle_arr_get_handles(struct vmci_handle_arr *array);
+
+#endif /* _VMCI_HANDLE_ARRAY_H_ */
-- 
1.7.0.4
