From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 41/78] KVM: introspection: add KVMI_VM_CHECK_COMMAND and KVMI_VM_CHECK_EVENT
Date: Fri,  7 Feb 2020 20:15:59 +0200
Message-ID: <20200207181636.1065-42-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

These commands can be used by the introspection tool to check what
introspection commands and events are supported (by KVMi) and allowed
(by userspace).

The introspection tool will get one of the following error codes:
  * -KVM_ENOSYS (unsupported command/event)
  * -KVM_PERM (disallowed command/event)
  * -KVM_EINVAL (the padding space, used for future extensions,
                 is not zero)
  * 0 (the command/event is supported and allowed)

These commands can be seen as alternative methods to KVMI_GET_VERSION
in checking if the introspection supports a specific command/event.

As with the KVMI_GET_VERSION command, these two commands can never be
disallowed by userspace.

Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 Documentation/virt/kvm/kvmi.rst               | 62 +++++++++++++++++++
 include/uapi/linux/kvmi.h                     | 16 ++++-
 .../testing/selftests/kvm/x86_64/kvmi_test.c  | 55 ++++++++++++++++
 virt/kvm/introspection/kvmi.c                 |  8 ++-
 virt/kvm/introspection/kvmi_int.h             |  2 +
 virt/kvm/introspection/kvmi_msg.c             | 46 +++++++++++++-
 6 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/kvmi.rst b/Documentation/virt/kvm/kvmi.rst
index 36f8cd4a836d..9205f51fa5a0 100644
--- a/Documentation/virt/kvm/kvmi.rst
+++ b/Documentation/virt/kvm/kvmi.rst
@@ -251,3 +251,65 @@ Returns the introspection API version.
 
 This command is always allowed and successful (if the introspection is
 built in kernel).
+
+2. KVMI_VM_CHECK_COMMAND
+------------------------
+
+:Architectures: all
+:Versions: >= 1
+:Parameters:
+
+::
+
+	struct kvmi_vm_check_command {
+		__u16 id;
+		__u16 padding1;
+		__u32 padding2;
+	};
+
+:Returns:
+
+::
+
+	struct kvmi_error_code;
+
+Checks if the command specified by ``id`` is allowed.
+
+This command is always allowed.
+
+:Errors:
+
+* -KVM_EPERM - the command specified by ``id`` is disallowed
+* -KVM_EINVAL - padding is not zero
+* -KVM_EINVAL - the command specified by ``id`` is not known
+
+3. KVMI_VM_CHECK_EVENT
+----------------------
+
+:Architectures: all
+:Versions: >= 1
+:Parameters:
+
+::
+
+	struct kvmi_vm_check_event {
+		__u16 id;
+		__u16 padding1;
+		__u32 padding2;
+	};
+
+:Returns:
+
+::
+
+	struct kvmi_error_code;
+
+Checks if the event specified by ``id`` is allowed.
+
+This command is always allowed.
+
+:Errors:
+
+* -KVM_EPERM - the event specified by ``id`` is disallowed
+* -KVM_EINVAL - padding is not zero
+* -KVM_EINVAL - the event specified by ``id`` is not known
diff --git a/include/uapi/linux/kvmi.h b/include/uapi/linux/kvmi.h
index ee817cb05cc6..ba550e9fae2e 100644
--- a/include/uapi/linux/kvmi.h
+++ b/include/uapi/linux/kvmi.h
@@ -14,7 +14,9 @@ enum {
 };
 
 enum {
-	KVMI_GET_VERSION = 2,
+	KVMI_GET_VERSION      = 2,
+	KVMI_VM_CHECK_COMMAND = 3,
+	KVMI_VM_CHECK_EVENT   = 4,
 
 	KVMI_NUM_MESSAGES
 };
@@ -43,4 +45,16 @@ struct kvmi_get_version_reply {
 	__u32 padding;
 };
 
+struct kvmi_vm_check_command {
+	__u16 id;
+	__u16 padding1;
+	__u32 padding2;
+};
+
+struct kvmi_vm_check_event {
+	__u16 id;
+	__u16 padding1;
+	__u32 padding2;
+};
+
 #endif /* _UAPI__LINUX_KVMI_H */
diff --git a/tools/testing/selftests/kvm/x86_64/kvmi_test.c b/tools/testing/selftests/kvm/x86_64/kvmi_test.c
index 733e82478f6e..e3e51fe3f85f 100644
--- a/tools/testing/selftests/kvm/x86_64/kvmi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvmi_test.c
@@ -201,6 +201,59 @@ static void test_cmd_get_version(void)
 	DEBUG("KVMI version: %u\n", rpl.version);
 }
 
+static int cmd_check_command(__u16 id)
+{
+	struct {
+		struct kvmi_msg_hdr hdr;
+		struct kvmi_vm_check_command cmd;
+	} req = {};
+
+	req.cmd.id = id;
+
+	return do_command(KVMI_VM_CHECK_COMMAND, &req.hdr, sizeof(req), NULL,
+			     0);
+}
+
+static void test_cmd_check_command(void)
+{
+	__u16 valid_id = KVMI_GET_VERSION;
+	__u16 invalid_id = 0xffff;
+	int r;
+
+	r = cmd_check_command(valid_id);
+	TEST_ASSERT(r == 0,
+		"KVMI_VM_CHECK_COMMAND failed, error %d (%s)\n",
+		-r, kvm_strerror(-r));
+
+	r = cmd_check_command(invalid_id);
+	TEST_ASSERT(r == -KVM_EINVAL,
+		"KVMI_VM_CHECK_COMMAND didn't failed with -KVM_EINVAL, error %d (%s)\n",
+		-r, kvm_strerror(-r));
+}
+
+static int cmd_check_event(__u16 id)
+{
+	struct {
+		struct kvmi_msg_hdr hdr;
+		struct kvmi_vm_check_event cmd;
+	} req = {};
+
+	req.cmd.id = id;
+
+	return do_command(KVMI_VM_CHECK_EVENT, &req.hdr, sizeof(req), NULL, 0);
+}
+
+static void test_cmd_check_event(void)
+{
+	__u16 invalid_id = 0xffff;
+	int r;
+
+	r = cmd_check_event(invalid_id);
+	TEST_ASSERT(r == -KVM_EINVAL,
+		"KVMI_VM_CHECK_EVENT didn't failed with -KVM_EINVAL, error %d (%s)\n",
+		-r, kvm_strerror(-r));
+}
+
 static void test_introspection(struct kvm_vm *vm)
 {
 	setup_socket();
@@ -208,6 +261,8 @@ static void test_introspection(struct kvm_vm *vm)
 
 	test_cmd_invalid();
 	test_cmd_get_version();
+	test_cmd_check_command();
+	test_cmd_check_event();
 
 	unhook_introspection(vm);
 }
diff --git a/virt/kvm/introspection/kvmi.c b/virt/kvm/introspection/kvmi.c
index 8597b6ef0cfb..8f8e18696794 100644
--- a/virt/kvm/introspection/kvmi.c
+++ b/virt/kvm/introspection/kvmi.c
@@ -77,6 +77,8 @@ alloc_kvmi(struct kvm *kvm, const struct kvm_introspection_hook *hook)
 	memcpy(&kvmi->uuid, &hook->uuid, sizeof(kvmi->uuid));
 
 	set_bit(KVMI_GET_VERSION, kvmi->cmd_allow_mask);
+	set_bit(KVMI_VM_CHECK_COMMAND, kvmi->cmd_allow_mask);
+	set_bit(KVMI_VM_CHECK_EVENT, kvmi->cmd_allow_mask);
 
 	kvmi->kvm = kvm;
 
@@ -304,10 +306,14 @@ int kvmi_ioctl_command(struct kvm *kvm, void __user *argp)
 	if (!allow) {
 		DECLARE_BITMAP(always_allowed, KVMI_NUM_COMMANDS);
 
-		if (id == KVMI_GET_VERSION)
+		if (id == KVMI_GET_VERSION
+				|| id == KVMI_VM_CHECK_COMMAND
+				|| id == KVMI_VM_CHECK_EVENT)
 			return -EPERM;
 
 		set_bit(KVMI_GET_VERSION, always_allowed);
+		set_bit(KVMI_VM_CHECK_COMMAND, always_allowed);
+		set_bit(KVMI_VM_CHECK_EVENT, always_allowed);
 
 		bitmap_andnot(requested, requested, always_allowed,
 			      KVMI_NUM_COMMANDS);
diff --git a/virt/kvm/introspection/kvmi_int.h b/virt/kvm/introspection/kvmi_int.h
index 947af4615fa5..feb83b8d0f12 100644
--- a/virt/kvm/introspection/kvmi_int.h
+++ b/virt/kvm/introspection/kvmi_int.h
@@ -22,6 +22,8 @@
 
 #define KVMI_KNOWN_COMMANDS ( \
 			  BIT(KVMI_GET_VERSION) \
+			| BIT(KVMI_VM_CHECK_COMMAND) \
+			| BIT(KVMI_VM_CHECK_EVENT) \
 		)
 
 #define KVMI(kvm) ((struct kvm_introspection *)((kvm)->kvmi))
diff --git a/virt/kvm/introspection/kvmi_msg.c b/virt/kvm/introspection/kvmi_msg.c
index 81e42c65da16..b7da5cc7286f 100644
--- a/virt/kvm/introspection/kvmi_msg.c
+++ b/virt/kvm/introspection/kvmi_msg.c
@@ -9,7 +9,9 @@
 #include "kvmi_int.h"
 
 static const char *const msg_IDs[] = {
-	[KVMI_GET_VERSION] = "KVMI_GET_VERSION",
+	[KVMI_GET_VERSION]      = "KVMI_GET_VERSION",
+	[KVMI_VM_CHECK_COMMAND] = "KVMI_VM_CHECK_COMMAND",
+	[KVMI_VM_CHECK_EVENT]   = "KVMI_VM_CHECK_EVENT",
 };
 
 static bool is_known_message(u16 id)
@@ -128,12 +130,52 @@ static int handle_get_version(struct kvm_introspection *kvmi,
 	return kvmi_msg_vm_reply(kvmi, msg, 0, &rpl, sizeof(rpl));
 }
 
+static int handle_check_command(struct kvm_introspection *kvmi,
+				const struct kvmi_msg_hdr *msg,
+				const void *_req)
+{
+	const struct kvmi_vm_check_command *req = _req;
+	int ec = 0;
+
+	if (req->padding1 || req->padding2)
+		ec = -KVM_EINVAL;
+	else if (req->id >= KVMI_NUM_COMMANDS)
+		ec = -KVM_EINVAL;
+	else if (!is_command_allowed(kvmi, req->id))
+		ec = -KVM_EPERM;
+
+	return kvmi_msg_vm_reply(kvmi, msg, ec, NULL, 0);
+}
+
+static bool is_event_allowed(struct kvm_introspection *kvmi, int id)
+{
+	return test_bit(id, kvmi->event_allow_mask);
+}
+
+static int handle_check_event(struct kvm_introspection *kvmi,
+			      const struct kvmi_msg_hdr *msg, const void *_req)
+{
+	const struct kvmi_vm_check_event *req = _req;
+	int ec = 0;
+
+	if (req->padding1 || req->padding2)
+		ec = -KVM_EINVAL;
+	else if (req->id >= KVMI_NUM_EVENTS)
+		ec = -KVM_EINVAL;
+	else if (!is_event_allowed(kvmi, req->id))
+		ec = -KVM_EPERM;
+
+	return kvmi_msg_vm_reply(kvmi, msg, ec, NULL, 0);
+}
+
 /*
  * These commands are executed by the receiving thread/worker.
  */
 static int(*const msg_vm[])(struct kvm_introspection *,
 			    const struct kvmi_msg_hdr *, const void *) = {
-	[KVMI_GET_VERSION] = handle_get_version,
+	[KVMI_GET_VERSION]      = handle_get_version,
+	[KVMI_VM_CHECK_COMMAND] = handle_check_command,
+	[KVMI_VM_CHECK_EVENT]   = handle_check_event,
 };
 
 static bool is_vm_message(u16 id)
