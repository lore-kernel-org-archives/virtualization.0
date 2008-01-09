From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH] cpu hotplug driver: kernel module
Date: Wed,  9 Jan 2008 08:21:05 -0200
Message-ID: <11998740731943-git-send-email-gcosta__12538.3047307425$1199874714$gmane$org@redhat.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11998740663306-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: virtualization@lists.linux-foundation.org, marcelot@redhat.com, anthony@codemonkey.ws, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/virtio/Kconfig      |    6 +
 drivers/virtio/Makefile     |    1 +
 drivers/virtio/virtio_cpu.c |  226 +++++++++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci.c |    1 +
 kernel/cpu.c                |    2 +
 5 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 drivers/virtio/virtio_cpu.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 73a414c..6665d4d 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -23,3 +23,9 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config VIRTIO_CPU
+	tristate "virtio-cpu"
+	depends on VIRTIO_PCI && EXPERIMENTAL
+	---help---
+	  I'll obviously put a better description later
+
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index cc84999..057ebcc 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
+obj-$(CONFIG_VIRTIO_CPU) += virtio_cpu.o
diff --git a/drivers/virtio/virtio_cpu.c b/drivers/virtio/virtio_cpu.c
new file mode 100644
index 0000000..8dc0c7d
--- /dev/null
+++ b/drivers/virtio/virtio_cpu.c
@@ -0,0 +1,226 @@
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+
+#include <linux/cpu.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/freezer.h>
+
+#define VIRTIO_ID_CPU 4
+
+#define CMD_CPU_SET 1
+
+struct virtio_hotplug_hdr {
+	u8 cmd;
+	u8 status;
+};
+
+struct hotplug_buf {
+	struct virtio_hotplug_hdr hdr;
+	u32 arg;
+};
+
+struct virtio_hotplug {
+	struct virtio_device *dev;
+	struct virtqueue *cmd_receive;
+	struct task_struct *hotplug_thread;
+	wait_queue_head_t hotplug_wait;
+	u32 hotplug_target;
+	int thread_started;
+};
+
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_CPU, VIRTIO_DEV_ANY_ID},
+	{ 0 },
+};
+
+void *__alloc_virtio_buf(int size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+#define alloc_hotplug_buf() (__alloc_virtio_buf(sizeof(struct hotplug_buf)))
+
+static int __send_hotplug_buf(u8 cmd, struct hotplug_buf *buf,
+			      struct virtqueue *vq)
+{
+	struct scatterlist sg[2];
+	int err = 0;
+	
+	sg_init_table(sg, 2);
+
+	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
+	sg_set_buf(&sg[1], &buf->arg, sizeof(buf->arg));
+	
+	err = vq->vq_ops->add_buf(vq, sg, 0, 2, buf);
+	if (err)
+		return err;
+
+	vq->vq_ops->kick(vq);
+
+	return 0;
+} 
+
+/* Prepare the virtio driver to receive a command. */
+static int prepare_to_receive(struct virtio_hotplug *v)
+{
+	void *buf = alloc_hotplug_buf();
+
+	if (!buf)
+		return -ENOMEM;
+
+	return __send_hotplug_buf(0, buf, v->cmd_receive);
+}
+
+static void hotplug_add_cpus(struct virtio_hotplug *v)
+{
+	struct sys_device *dev;
+	struct virtqueue *vq = v->cmd_receive;
+	struct hotplug_buf *buf;
+	int i, len;
+	int err;
+
+	while ((buf = vq->vq_ops->get_buf(vq, &len)) != NULL) {
+		switch (buf->hdr.cmd) {
+		case CMD_CPU_SET:
+			v->hotplug_target = buf->arg;
+
+			if (v->hotplug_target > num_present_cpus())
+				v->hotplug_target = num_present_cpus();
+			break;
+		default:
+			printk("%s: Unrecognized command %d\n",
+				__func__, buf->hdr.cmd);
+			break;	
+		}
+	}
+	kfree(buf);
+
+
+	while ((i = num_online_cpus()) < v->hotplug_target) {
+		err = cpu_up(i);
+		dev = get_cpu_sysdev(i);
+		if (!err) {
+			if (dev)
+				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+		}
+	}
+
+	while ((i = num_online_cpus()) > v->hotplug_target) {
+		i--;
+		dev = get_cpu_sysdev(i);
+		err = cpu_down(i);
+		if (!err) {
+			if (dev)
+				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+		}
+	}
+}
+
+static int virtio_do_hotplug(void *p)
+{
+	struct virtio_hotplug *v = p;
+	DEFINE_WAIT(wait);
+	set_freezable();
+
+	for (;;) {
+		prepare_to_receive(v);
+		prepare_to_wait(&v->hotplug_wait, &wait, TASK_UNINTERRUPTIBLE);
+		v->thread_started = 1;
+		schedule();
+		finish_wait(&v->hotplug_wait, &wait);
+
+		try_to_freeze();
+
+		if (kthread_should_stop())
+			break;
+
+		hotplug_add_cpus(v);
+		v->hotplug_target = 0;
+	}
+	return 0;
+}
+
+/* We need a separate thread because cpu_up() and cpu_down() cannot
+ * be called in interrupt context */
+static bool hotplug_get_cmd(struct virtqueue *vq)
+{
+	struct virtio_hotplug *v = vq->vdev->priv;
+
+	wake_up(&v->hotplug_wait);
+	return true;
+
+}
+
+static int virtio_cpu_probe(struct virtio_device *vdev)
+{
+	int err;
+	struct virtio_hotplug *v;
+
+	v = kzalloc(sizeof(*v), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	
+	if (IS_ERR(v->cmd_receive)) {
+		printk("%s: Couldn't find cmd_receive queue\n", __func__);
+		return PTR_ERR(v->cmd_receive);
+	}
+	
+	vdev->priv = v;
+
+	init_waitqueue_head(&v->hotplug_wait);
+
+	v->thread_started = 0;
+	v->hotplug_thread = kthread_run(virtio_do_hotplug, v, 
+				     "virtio_hotplugd\n");
+
+	if (IS_ERR(v->hotplug_thread)) {
+		err = PTR_ERR(v->hotplug_thread);
+		goto out;
+	}
+
+	v->cmd_receive = vdev->config->find_vq(vdev, 0, hotplug_get_cmd);
+
+	printk("Registered virtio hotplug driver\n");
+	return 0;
+out:
+	vdev->config->del_vq(v->cmd_receive);
+	return err;
+}
+
+static void virtio_cpu_remove(struct virtio_device *vdev)
+{
+	struct virtio_hotplug *v = vdev->priv;
+	kthread_stop(v->hotplug_thread);
+	vdev->config->del_vq(v->cmd_receive);
+	kfree(v);
+}
+
+
+static struct virtio_driver virtio_cpu = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = virtio_cpu_probe,
+	.remove = __devexit_p(virtio_cpu_remove),
+};
+
+static int __init virtio_cpu_init(void)
+{
+	return register_virtio_driver(&virtio_cpu);
+}
+
+static void __exit virtio_cpu_exit(void)
+{
+	unregister_virtio_driver(&virtio_cpu);
+}
+
+module_init(virtio_cpu_init);
+module_exit(virtio_cpu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Glauber de Oliveira Costa");
+MODULE_DESCRIPTION("virtio driver for cpu hotplugging");
+MODULE_VERSION("1");
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index e1fa68d..8d5a719 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -67,6 +67,7 @@ static struct pci_device_id virtio_pci_id_table[] = {
 	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
+	{ 0x2523, 0x2325, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* cpu hotplug driver */
 	{ 0 },
 };
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6b3a0c1..c432c28 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -219,6 +219,7 @@ int cpu_down(unsigned int cpu)
 	mutex_unlock(&cpu_add_remove_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(cpu_down);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
 /* Requires cpu_add_remove_lock to be held */
@@ -284,6 +285,7 @@ int __cpuinit cpu_up(unsigned int cpu)
 	mutex_unlock(&cpu_add_remove_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(cpu_up);
 
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_t frozen_cpus;
-- 
1.5.0.6
