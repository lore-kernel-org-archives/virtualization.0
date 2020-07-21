From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 43/84] KVM: introspection: add KVMI_VM_GET_INFO
Date: Wed, 22 Jul 2020 00:08:41 +0300
Message-ID: <20200721210922.7646-44-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mihai Donțu <mdontu@bitdefender.com>

For now, this command returns only the number of online vCPUs.

The introspection tool uses the vCPU index to specify to which vCPU
the introspection command applies to.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 Documentation/virt/kvm/kvmi.rst               | 18 ++++++++++
 include/uapi/linux/kvmi.h                     |  6 ++++
 .../testing/selftests/kvm/x86_64/kvmi_test.c  | 35 +++++++++++++++++--
 virt/kvm/introspection/kvmi_msg.c             | 13 +++++++
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/kvmi.rst b/Documentation/virt/kvm/kvmi.rst
index a2cda3268da0..a81f22cb8c18 100644
--- a/Documentation/virt/kvm/kvmi.rst
+++ b/Documentation/virt/kvm/kvmi.rst
@@ -323,3 +323,21 @@ This command is always allowed.
 * -KVM_ENOENT - the event specified by ``id`` is unsupported
 * -KVM_EPERM - the event specified by ``id`` is disallowed
 * -KVM_EINVAL - the padding is not zero
+
+4. KVMI_VM_GET_INFO
+-------------------
+
+:Architectures: all
+:Versions: >= 1
+:Parameters: none
+:Returns:
+
+::
+
+	struct kvmi_error_code;
+	struct kvmi_vm_get_info_reply {
+		__u32 vcpu_count;
+		__u32 padding[3];
+	};
+
+Returns the number of online vCPUs.
diff --git a/include/uapi/linux/kvmi.h b/include/uapi/linux/kvmi.h
index e55a0fa66ac5..eabaf7cea1df 100644
--- a/include/uapi/linux/kvmi.h
+++ b/include/uapi/linux/kvmi.h
@@ -17,6 +17,7 @@ enum {
 	KVMI_GET_VERSION      = 1,
 	KVMI_VM_CHECK_COMMAND = 2,
 	KVMI_VM_CHECK_EVENT   = 3,
+	KVMI_VM_GET_INFO      = 4,
 
 	KVMI_NUM_MESSAGES
 };
@@ -63,4 +64,9 @@ struct kvmi_vm_check_event {
 	__u32 padding2;
 };
 
+struct kvmi_vm_get_info_reply {
+	__u32 vcpu_count;
+	__u32 padding[3];
+};
+
 #endif /* _UAPI__LINUX_KVMI_H */
diff --git a/tools/testing/selftests/kvm/x86_64/kvmi_test.c b/tools/testing/selftests/kvm/x86_64/kvmi_test.c
index 28216c4e8b9d..1f4a165ab640 100644
--- a/tools/testing/selftests/kvm/x86_64/kvmi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvmi_test.c
@@ -84,6 +84,16 @@ static void set_command_perm(struct kvm_vm *vm, __s32 id, __u32 allow,
 		 "KVM_INTROSPECTION_COMMAND");
 }
 
+static void disallow_command(struct kvm_vm *vm, __s32 id)
+{
+	set_command_perm(vm, id, 0, 0);
+}
+
+static void allow_command(struct kvm_vm *vm, __s32 id)
+{
+	set_command_perm(vm, id, 1, 0);
+}
+
 static void hook_introspection(struct kvm_vm *vm)
 {
 	__u32 allow = 1, disallow = 0, allow_inval = 2;
@@ -258,14 +268,18 @@ static void cmd_vm_check_command(__u16 id, __u16 padding, int expected_err)
 		-r, kvm_strerror(-r), expected_err);
 }
 
-static void test_cmd_vm_check_command(void)
+static void test_cmd_vm_check_command(struct kvm_vm *vm)
 {
-	__u16 valid_id = KVMI_GET_VERSION, invalid_id = 0xffff;
+	__u16 valid_id = KVMI_VM_GET_INFO, invalid_id = 0xffff;
 	__u16 padding = 1, no_padding = 0;
 
 	cmd_vm_check_command(valid_id, no_padding, 0);
 	cmd_vm_check_command(valid_id, padding, -KVM_EINVAL);
 	cmd_vm_check_command(invalid_id, no_padding, -KVM_ENOENT);
+
+	disallow_command(vm, valid_id);
+	cmd_vm_check_command(valid_id, no_padding, -KVM_EPERM);
+	allow_command(vm, valid_id);
 }
 
 static void cmd_vm_check_event(__u16 id, __u16 padding, int expected_err)
@@ -295,6 +309,20 @@ static void test_cmd_vm_check_event(void)
 	cmd_vm_check_event(invalid_id, no_padding, -KVM_ENOENT);
 }
 
+static void test_cmd_vm_get_info(void)
+{
+	struct kvmi_vm_get_info_reply rpl;
+	struct kvmi_msg_hdr req;
+
+	test_vm_command(KVMI_VM_GET_INFO, &req, sizeof(req), &rpl,
+			sizeof(rpl));
+	TEST_ASSERT(rpl.vcpu_count == 1,
+		    "Unexpected number of vCPU count %u\n",
+		    rpl.vcpu_count);
+
+	pr_info("vcpu count: %u\n", rpl.vcpu_count);
+}
+
 static void test_introspection(struct kvm_vm *vm)
 {
 	setup_socket();
@@ -302,8 +330,9 @@ static void test_introspection(struct kvm_vm *vm)
 
 	test_cmd_invalid();
 	test_cmd_get_version();
-	test_cmd_vm_check_command();
+	test_cmd_vm_check_command(vm);
 	test_cmd_vm_check_event();
+	test_cmd_vm_get_info();
 
 	unhook_introspection(vm);
 }
diff --git a/virt/kvm/introspection/kvmi_msg.c b/virt/kvm/introspection/kvmi_msg.c
index 86c356afc154..3df18f7965c0 100644
--- a/virt/kvm/introspection/kvmi_msg.c
+++ b/virt/kvm/introspection/kvmi_msg.c
@@ -150,6 +150,18 @@ static int handle_vm_check_event(struct kvm_introspection *kvmi,
 	return kvmi_msg_vm_reply(kvmi, msg, ec, NULL, 0);
 }
 
+static int handle_vm_get_info(struct kvm_introspection *kvmi,
+			      const struct kvmi_msg_hdr *msg,
+			      const void *req)
+{
+	struct kvmi_vm_get_info_reply rpl;
+
+	memset(&rpl, 0, sizeof(rpl));
+	rpl.vcpu_count = atomic_read(&kvmi->kvm->online_vcpus);
+
+	return kvmi_msg_vm_reply(kvmi, msg, 0, &rpl, sizeof(rpl));
+}
+
 /*
  * These commands are executed by the receiving thread.
  */
@@ -158,6 +170,7 @@ static int(*const msg_vm[])(struct kvm_introspection *,
 	[KVMI_GET_VERSION]      = handle_get_version,
 	[KVMI_VM_CHECK_COMMAND] = handle_vm_check_command,
 	[KVMI_VM_CHECK_EVENT]   = handle_vm_check_event,
+	[KVMI_VM_GET_INFO]      = handle_vm_get_info,
 };
 
 static bool is_vm_command(u16 id)
