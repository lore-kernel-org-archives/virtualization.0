From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 14/15] virtio-iommu: implement basic debug commands
Date: Fri,  7 Apr 2017 20:24:54 +0100
Message-ID: <20170407192455.26814-15-jean-philippe.brucker__11502.4300794632$1491593286$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Using debug printf with the virtual IOMMU can be extremely verbose. To
ease debugging, add a few commands that can be sent via IPC. Format for
commands is "cmd [iommu [address_space]]" (or cmd:[iommu:[address_space]])

    $ lkvm debug -a -i list
    iommu 0 "viommu-vfio"
      ioas 1
        device 0x2                      # PCI bus
      ioas 2
        device 0x3
    iommu 1 "viommu-virtio"
      ioas 3
        device 0x10003                  # MMIO bus
      ioas 4
        device 0x6

    $ lkvm debug -a -i stats:0          # stats for viommu-vfio
    iommu 0 "viommu-virtio"
      kicks                 510         # virtio kicks from driver
      requests              510         # requests received
      ioas 3
        maps                1           # number of map requests
        unmaps              0           #     "    unmap   "
        resident            8192        # bytes currently mapped
        accesses            1           # number of device accesses
      ioas 4
        maps                290
        unmaps              4
        resident            1335296
        accesses            982

    $ lkvm debug -a -i "print 1, 2"     # Start debug print for
      ...                               # ioas 2 in iommu 1
      ...
      Info: VIOMMU map 0xffffffff000 -> 0x8f4e0000 (4096) to IOAS 2
      ...
    $ lkvm debug -a -i noprint          # Stop all debug print

We don't use atomics for statistics at the moment, since there is no
concurrent write on most of them. Only 'accesses' might be incremented
concurrently, so we might get imprecise values.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/iommu.h |  17 +++
 iommu.c             |  56 +++++++++-
 virtio/iommu.c      | 312 ++++++++++++++++++++++++++++++++++++++++++++++++----
 virtio/mmio.c       |   1 +
 virtio/pci.c        |   1 +
 5 files changed, 362 insertions(+), 25 deletions(-)

diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 60857fa5..70a09306 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -11,7 +11,20 @@
 #define IOMMU_PROT_WRITE	0x2
 #define IOMMU_PROT_EXEC		0x4
 
+enum iommu_debug_action {
+	IOMMU_DEBUG_LIST,
+	IOMMU_DEBUG_STATS,
+	IOMMU_DEBUG_SET_PRINT,
+	IOMMU_DEBUG_DUMP,
+
+	IOMMU_DEBUG_NUM_ACTIONS,
+};
+
+#define IOMMU_DEBUG_SELECTOR_INVALID	((unsigned int)-1)
+
 struct iommu_debug_params {
+	enum iommu_debug_action		action;
+	unsigned int			selector[2];
 	bool				print_enabled;
 };
 
@@ -31,6 +44,8 @@ struct iommu_ops {
 	int (*detach)(void *, struct device_header *);
 	int (*map)(void *, u64 virt_addr, u64 phys_addr, u64 size, int prot);
 	int (*unmap)(void *, u64 virt_addr, u64 size, int flags);
+
+	int (*debug_address_space)(void *, int fd, struct iommu_debug_params *);
 };
 
 struct iommu_properties {
@@ -74,6 +89,8 @@ static inline struct device_header *iommu_get_device(u32 device_id)
 
 void *iommu_alloc_address_space(struct device_header *dev);
 void iommu_free_address_space(void *address_space);
+int iommu_debug_address_space(void *address_space, int fd,
+			      struct iommu_debug_params *params);
 
 int iommu_map(void *address_space, u64 virt_addr, u64 phys_addr, u64 size,
 	      int prot);
diff --git a/iommu.c b/iommu.c
index 2220e4b2..bc9fc631 100644
--- a/iommu.c
+++ b/iommu.c
@@ -9,6 +9,10 @@
 #include "kvm/mutex.h"
 #include "kvm/rbtree-interval.h"
 
+struct iommu_ioas_stats {
+	u64			accesses;
+};
+
 struct iommu_mapping {
 	struct rb_int_node	iova_range;
 	u64			phys;
@@ -18,8 +22,31 @@ struct iommu_mapping {
 struct iommu_ioas {
 	struct rb_root		mappings;
 	struct mutex		mutex;
+
+	struct iommu_ioas_stats	stats;
+	bool			debug_enabled;
 };
 
+static void iommu_dump(struct iommu_ioas *ioas, int fd)
+{
+	struct rb_node *node;
+	struct iommu_mapping *map;
+
+	mutex_lock(&ioas->mutex);
+
+	dprintf(fd, "START IOMMU DUMP [[[\n"); /* You did ask for it. */
+	for (node = rb_first(&ioas->mappings); node; node = rb_next(node)) {
+		struct rb_int_node *int_node = rb_int(node);
+		map = container_of(int_node, struct iommu_mapping, iova_range);
+
+		dprintf(fd, "%#llx-%#llx -> %#llx %#x\n", int_node->low,
+			int_node->high, map->phys, map->prot);
+	}
+	dprintf(fd, "]]] END IOMMU DUMP\n");
+
+	mutex_unlock(&ioas->mutex);
+}
+
 void *iommu_alloc_address_space(struct device_header *unused)
 {
 	struct iommu_ioas *ioas = calloc(1, sizeof(*ioas));
@@ -33,6 +60,27 @@ void *iommu_alloc_address_space(struct device_header *unused)
 	return ioas;
 }
 
+int iommu_debug_address_space(void *address_space, int fd,
+			      struct iommu_debug_params *params)
+{
+	struct iommu_ioas *ioas = address_space;
+
+	switch (params->action) {
+	case IOMMU_DEBUG_STATS:
+		dprintf(fd, "    accesses            %llu\n", ioas->stats.accesses);
+		break;
+	case IOMMU_DEBUG_SET_PRINT:
+		ioas->debug_enabled = params->print_enabled;
+		break;
+	case IOMMU_DEBUG_DUMP:
+		iommu_dump(ioas, fd);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 void iommu_free_address_space(void *address_space)
 {
 	struct iommu_ioas *ioas = address_space;
@@ -157,8 +205,12 @@ u64 iommu_access(void *address_space, u64 addr, size_t size, size_t *out_size,
 	out_addr = map->phys + (addr - node->low);
 	*out_size = min_t(size_t, node->high - addr + 1, size);
 
-	pr_debug("access %llx %zu/%zu %x -> %#llx", addr, *out_size, size,
-		 prot, out_addr);
+	if (ioas->debug_enabled)
+		pr_info("access %llx %zu/%zu %s%s -> %#llx", addr, *out_size,
+			size, prot & IOMMU_PROT_READ ? "R" : "",
+			prot & IOMMU_PROT_WRITE ? "W" : "", out_addr);
+
+	ioas->stats.accesses++;
 out_unlock:
 	mutex_unlock(&ioas->mutex);
 
diff --git a/virtio/iommu.c b/virtio/iommu.c
index 5973cef1..153b537a 100644
--- a/virtio/iommu.c
+++ b/virtio/iommu.c
@@ -20,6 +20,17 @@
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE	256
 
+struct viommu_ioas_stats {
+	u64				map;
+	u64				unmap;
+	u64				resident;
+};
+
+struct viommu_stats {
+	u64				kicks;
+	u64				requests;
+};
+
 struct viommu_endpoint {
 	struct device_header		*dev;
 	struct viommu_ioas		*ioas;
@@ -36,9 +47,14 @@ struct viommu_ioas {
 
 	struct iommu_ops		*ops;
 	void				*priv;
+
+	bool				debug_enabled;
+	struct viommu_ioas_stats	stats;
 };
 
 struct viommu_dev {
+	u32				id;
+
 	struct virtio_device		vdev;
 	struct virtio_iommu_config	config;
 
@@ -49,29 +65,77 @@ struct viommu_dev {
 	struct thread_pool__job		job;
 
 	struct rb_root			address_spaces;
+	struct mutex			address_spaces_mutex;
 	struct kvm			*kvm;
+
+	struct list_head		list;
+
+	bool				debug_enabled;
+	struct viommu_stats		stats;
 };
 
 static int compat_id = -1;
 
+static long long viommu_ids;
+static LIST_HEAD(viommus);
+static DEFINE_MUTEX(viommus_mutex);
+
+#define ioas_debug(ioas, fmt, ...)					\
+	do {								\
+		if ((ioas)->debug_enabled)				\
+			pr_info("ioas[%d] " fmt, (ioas)->id, ##__VA_ARGS__); \
+	} while (0)
+
 static struct viommu_ioas *viommu_find_ioas(struct viommu_dev *viommu,
 					    u32 ioasid)
 {
 	struct rb_node *node;
-	struct viommu_ioas *ioas;
+	struct viommu_ioas *ioas, *found = NULL;
 
+	mutex_lock(&viommu->address_spaces_mutex);
 	node = viommu->address_spaces.rb_node;
 	while (node) {
 		ioas = container_of(node, struct viommu_ioas, node);
-		if (ioas->id > ioasid)
+		if (ioas->id > ioasid) {
 			node = node->rb_left;
-		else if (ioas->id < ioasid)
+		} else if (ioas->id < ioasid) {
 			node = node->rb_right;
-		else
-			return ioas;
+		} else {
+			found = ioas;
+			break;
+		}
 	}
+	mutex_unlock(&viommu->address_spaces_mutex);
 
-	return NULL;
+	return found;
+}
+
+static int viommu_for_each_ioas(struct viommu_dev *viommu,
+				int (*fun)(struct viommu_dev *viommu,
+					   struct viommu_ioas *ioas,
+					   void *data),
+				void *data)
+{
+	int ret;
+	struct viommu_ioas *ioas;
+	struct rb_node *node, *next;
+
+	mutex_lock(&viommu->address_spaces_mutex);
+	node = rb_first(&viommu->address_spaces);
+	while (node) {
+		next = rb_next(node);
+		ioas = container_of(node, struct viommu_ioas, node);
+
+		ret = fun(viommu, ioas, data);
+		if (ret)
+			break;
+
+		node = next;
+	}
+
+	mutex_unlock(&viommu->address_spaces_mutex);
+
+	return ret;
 }
 
 static struct viommu_ioas *viommu_alloc_ioas(struct viommu_dev *viommu,
@@ -99,9 +163,12 @@ static struct viommu_ioas *viommu_alloc_ioas(struct viommu_dev *viommu,
 	new_ioas->id		= ioasid;
 	new_ioas->ops		= ops;
 	new_ioas->priv		= ops->alloc_address_space(device);
+	new_ioas->debug_enabled	= viommu->debug_enabled;
 
 	/* A NULL priv pointer is valid. */
 
+	mutex_lock(&viommu->address_spaces_mutex);
+
 	node = &viommu->address_spaces.rb_node;
 	while (*node) {
 		ioas = container_of(*node, struct viommu_ioas, node);
@@ -114,6 +181,7 @@ static struct viommu_ioas *viommu_alloc_ioas(struct viommu_dev *viommu,
 		} else {
 			pr_err("IOAS exists!");
 			free(new_ioas);
+			mutex_unlock(&viommu->address_spaces_mutex);
 			return NULL;
 		}
 	}
@@ -121,6 +189,8 @@ static struct viommu_ioas *viommu_alloc_ioas(struct viommu_dev *viommu,
 	rb_link_node(&new_ioas->node, parent, node);
 	rb_insert_color(&new_ioas->node, &viommu->address_spaces);
 
+	mutex_unlock(&viommu->address_spaces_mutex);
+
 	return new_ioas;
 }
 
@@ -130,7 +200,9 @@ static void viommu_free_ioas(struct viommu_dev *viommu,
 	if (ioas->priv)
 		ioas->ops->free_address_space(ioas->priv);
 
+	mutex_lock(&viommu->address_spaces_mutex);
 	rb_erase(&ioas->node, &viommu->address_spaces);
+	mutex_unlock(&viommu->address_spaces_mutex);
 	free(ioas);
 }
 
@@ -178,8 +250,7 @@ static int viommu_detach_device(struct viommu_dev *viommu,
 	if (!ioas)
 		return -EINVAL;
 
-	pr_debug("detaching device %#lx from IOAS %u",
-		 device_to_iommu_id(device), ioas->id);
+	ioas_debug(ioas, "detaching device %#lx", device_to_iommu_id(device));
 
 	ret = device->iommu_ops->detach(ioas->priv, device);
 	if (!ret)
@@ -208,8 +279,6 @@ static int viommu_handle_attach(struct viommu_dev *viommu,
 		return -ENODEV;
 	}
 
-	pr_debug("attaching device %#x to IOAS %u", device_id, ioasid);
-
 	vdev = device->iommu_data;
 	if (!vdev) {
 		vdev = viommu_alloc_device(device);
@@ -240,6 +309,9 @@ static int viommu_handle_attach(struct viommu_dev *viommu,
 	if (ret && ioas->nr_devices == 0)
 		viommu_free_ioas(viommu, ioas);
 
+	if (!ret)
+		ioas_debug(ioas, "attached device %#x", device_id);
+
 	return ret;
 }
 
@@ -267,6 +339,7 @@ static int viommu_handle_detach(struct viommu_dev *viommu,
 static int viommu_handle_map(struct viommu_dev *viommu,
 			     struct virtio_iommu_req_map *map)
 {
+	int ret;
 	int prot = 0;
 	struct viommu_ioas *ioas;
 
@@ -294,15 +367,21 @@ static int viommu_handle_map(struct viommu_dev *viommu,
 	if (flags & VIRTIO_IOMMU_MAP_F_EXEC)
 		prot |= IOMMU_PROT_EXEC;
 
-	pr_debug("map %#llx -> %#llx (%llu) to IOAS %u", virt_addr,
-		 phys_addr, size, ioasid);
+	ioas_debug(ioas, "map   %#llx -> %#llx (%llu)", virt_addr, phys_addr, size);
+
+	ret = ioas->ops->map(ioas->priv, virt_addr, phys_addr, size, prot);
+	if (!ret) {
+		ioas->stats.resident += size;
+		ioas->stats.map++;
+	}
 
-	return ioas->ops->map(ioas->priv, virt_addr, phys_addr, size, prot);
+	return ret;
 }
 
 static int viommu_handle_unmap(struct viommu_dev *viommu,
 			       struct virtio_iommu_req_unmap *unmap)
 {
+	int ret;
 	struct viommu_ioas *ioas;
 
 	u32 ioasid	= le32_to_cpu(unmap->address_space);
@@ -315,10 +394,15 @@ static int viommu_handle_unmap(struct viommu_dev *viommu,
 		return -ESRCH;
 	}
 
-	pr_debug("unmap %#llx (%llu) from IOAS %u", virt_addr, size,
-		 ioasid);
+	ioas_debug(ioas, "unmap %#llx (%llu)", virt_addr, size);
+
+	ret = ioas->ops->unmap(ioas->priv, virt_addr, size, 0);
+	if (!ret) {
+		ioas->stats.resident -= size;
+		ioas->stats.unmap++;
+	}
 
-	return ioas->ops->unmap(ioas->priv, virt_addr, size, 0);
+	return ret;
 }
 
 static size_t viommu_get_req_len(union virtio_iommu_req *req)
@@ -407,6 +491,8 @@ static ssize_t viommu_dispatch_commands(struct viommu_dev *viommu,
 			continue;
 		}
 
+		viommu->stats.requests++;
+
 		req = iov[i].iov_base;
 		op = req->head.type;
 		expected_len = viommu_get_req_len(req) - sizeof(*tail);
@@ -458,6 +544,8 @@ static void viommu_command(struct kvm *kvm, void *dev)
 
 	vq = &viommu->vq;
 
+	viommu->stats.kicks++;
+
 	while (virt_queue__available(vq)) {
 		head = virt_queue__get_iov(vq, iov, &out, &in, kvm);
 
@@ -594,6 +682,7 @@ void *viommu_register(struct kvm *kvm, struct iommu_properties *props)
 
 	viommu->queue_size		= VIOMMU_DEFAULT_QUEUE_SIZE;
 	viommu->address_spaces		= (struct rb_root)RB_ROOT;
+	viommu->address_spaces_mutex	= (struct mutex)MUTEX_INITIALIZER;
 	viommu->properties		= props;
 
 	viommu->config.page_sizes	= props->pgsize_mask ?: pgsize_mask;
@@ -607,6 +696,11 @@ void *viommu_register(struct kvm *kvm, struct iommu_properties *props)
 		return NULL;
 	}
 
+	mutex_lock(&viommus_mutex);
+	viommu->id = viommu_ids++;
+	list_add_tail(&viommu->list, &viommus);
+	mutex_unlock(&viommus_mutex);
+
 	pr_info("Loaded virtual IOMMU %s", props->name);
 
 	if (compat_id == -1)
@@ -616,21 +710,193 @@ void *viommu_register(struct kvm *kvm, struct iommu_properties *props)
 	return viommu;
 }
 
-void viommu_unregister(struct kvm *kvm, void *viommu)
+void viommu_unregister(struct kvm *kvm, void *dev)
 {
+	struct viommu_dev *viommu = dev;
+
+	mutex_lock(&viommus_mutex);
+	list_del(&viommu->list);
+	mutex_unlock(&viommus_mutex);
+
 	free(viommu);
 }
 
+const char *debug_usage =
+"  list [iommu [ioas]]            list iommus and address spaces\n"
+"  stats [iommu [ioas]]           display statistics\n"
+"  dump  [iommu [ioas]]           dump mappings\n"
+"  print [iommu [ioas]]           enable debug print\n"
+"  noprint [iommu [ioas]]         disable debug print\n"
+;
+
 int viommu_parse_debug_string(const char *cmdline, struct iommu_debug_params *params)
 {
-	/* show instances numbers */
-	/* send command to instance */
-	/* - dump mappings */
-	/* - statistics */
-	return -ENOSYS;
+	int pos = 0;
+	int ret = -EINVAL;
+	char *cur, *args = strdup(cmdline);
+	params->action = IOMMU_DEBUG_NUM_ACTIONS;
+
+	if (!args)
+		return -ENOMEM;
+
+	params->selector[0] = IOMMU_DEBUG_SELECTOR_INVALID;
+	params->selector[1] = IOMMU_DEBUG_SELECTOR_INVALID;
+
+	cur = strtok(args, " ,:");
+	while (cur) {
+		if (pos > 2)
+			break;
+
+		if (pos > 0) {
+			errno = 0;
+			params->selector[pos - 1] = strtoul(cur, NULL, 0);
+			if (errno) {
+				ret = -errno;
+				pr_err("Invalid number '%s'", cur);
+				break;
+			}
+		} else if (strncmp(cur, "list", 4) == 0) {
+			params->action = IOMMU_DEBUG_LIST;
+		} else if (strncmp(cur, "stats", 5) == 0) {
+			params->action = IOMMU_DEBUG_STATS;
+		} else if (strncmp(cur, "dump", 4) == 0) {
+			params->action = IOMMU_DEBUG_DUMP;
+		} else if (strncmp(cur, "print", 5) == 0) {
+			params->action = IOMMU_DEBUG_SET_PRINT;
+			params->print_enabled = true;
+		} else if (strncmp(cur, "noprint", 7) == 0) {
+			params->action = IOMMU_DEBUG_SET_PRINT;
+			params->print_enabled = false;
+		} else {
+			pr_err("Invalid command '%s'", cur);
+			break;
+		}
+
+		cur = strtok(NULL, " ,:");
+		pos++;
+		ret = 0;
+	}
+
+	free(args);
+
+	if (cur && cur[0])
+		pr_err("Ignoring argument '%s'", cur);
+
+	if (ret)
+		pr_info("Usage:\n%s", debug_usage);
+
+	return ret;
+}
+
+struct viommu_debug_context {
+	int				sock;
+	struct iommu_debug_params	*params;
+	bool				disp;
+};
+
+static int viommu_debug_ioas(struct viommu_dev *viommu,
+			     struct viommu_ioas *ioas,
+			     void *data)
+{
+	int ret = 0;
+	struct viommu_endpoint *vdev;
+	struct viommu_debug_context *ctx = data;
+
+	if (ctx->disp)
+		dprintf(ctx->sock, "  ioas %u\n", ioas->id);
+
+	switch (ctx->params->action) {
+	case IOMMU_DEBUG_LIST:
+		mutex_lock(&ioas->devices_mutex);
+		list_for_each_entry(vdev, &ioas->devices, list) {
+			dprintf(ctx->sock, "    device 0x%lx\n",
+				device_to_iommu_id(vdev->dev));
+		}
+		mutex_unlock(&ioas->devices_mutex);
+		break;
+	case IOMMU_DEBUG_STATS:
+		dprintf(ctx->sock, "    maps                %llu\n",
+			ioas->stats.map);
+		dprintf(ctx->sock, "    unmaps              %llu\n",
+			ioas->stats.unmap);
+		dprintf(ctx->sock, "    resident            %llu\n",
+			ioas->stats.resident);
+		break;
+	case IOMMU_DEBUG_SET_PRINT:
+		ioas->debug_enabled = ctx->params->print_enabled;
+		break;
+	default:
+		ret = -ENOSYS;
+
+	}
+
+	if (ioas->ops->debug_address_space)
+		ret = ioas->ops->debug_address_space(ioas->priv, ctx->sock,
+						     ctx->params);
+
+	return ret;
+}
+
+static int viommu_debug_iommu(struct viommu_dev *viommu,
+			      struct viommu_debug_context *ctx)
+{
+	struct viommu_ioas *ioas;
+
+	if (ctx->disp)
+		dprintf(ctx->sock, "iommu %u \"%s\"\n", viommu->id,
+			viommu->properties->name);
+
+	if (ctx->params->selector[1] != IOMMU_DEBUG_SELECTOR_INVALID) {
+		ioas = viommu_find_ioas(viommu, ctx->params->selector[1]);
+		return ioas ? viommu_debug_ioas(viommu, ioas, ctx) : -ESRCH;
+	}
+
+	switch (ctx->params->action) {
+	case IOMMU_DEBUG_STATS:
+		dprintf(ctx->sock, "  kicks                 %llu\n",
+			viommu->stats.kicks);
+		dprintf(ctx->sock, "  requests              %llu\n",
+			viommu->stats.requests);
+		break;
+	case IOMMU_DEBUG_SET_PRINT:
+		viommu->debug_enabled = ctx->params->print_enabled;
+		break;
+	default:
+		break;
+	}
+
+	return viommu_for_each_ioas(viommu, viommu_debug_ioas, ctx);
 }
 
 int viommu_debug(int sock, struct iommu_debug_params *params)
 {
-	return -ENOSYS;
+	int ret = -ESRCH;
+	bool match;
+	struct viommu_dev *viommu;
+	bool any = (params->selector[0] == IOMMU_DEBUG_SELECTOR_INVALID);
+
+	struct viommu_debug_context ctx = {
+		.sock		= sock,
+		.params		= params,
+	};
+
+	if (params->action == IOMMU_DEBUG_LIST ||
+	    params->action == IOMMU_DEBUG_STATS)
+		ctx.disp = true;
+
+	mutex_lock(&viommus_mutex);
+	list_for_each_entry(viommu, &viommus, list) {
+		match = (params->selector[0] == viommu->id);
+		if (match || any) {
+			ret = viommu_debug_iommu(viommu, &ctx);
+			if (ret || match)
+				break;
+		}
+	}
+	mutex_unlock(&viommus_mutex);
+
+	if (ret)
+		dprintf(sock, "error: %s\n", strerror(-ret));
+
+	return ret;
 }
diff --git a/virtio/mmio.c b/virtio/mmio.c
index 699d4403..7d39120a 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -307,6 +307,7 @@ static struct iommu_ops virtio_mmio_iommu_ops = {
 	.get_properties		= virtio__iommu_get_properties,
 	.alloc_address_space	= iommu_alloc_address_space,
 	.free_address_space	= iommu_free_address_space,
+	.debug_address_space	= iommu_debug_address_space,
 	.attach			= virtio_mmio_iommu_attach,
 	.detach			= virtio_mmio_iommu_detach,
 	.map			= iommu_map,
diff --git a/virtio/pci.c b/virtio/pci.c
index c9f0e558..c5d30eb2 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -442,6 +442,7 @@ static struct iommu_ops virtio_pci_iommu_ops = {
 	.get_properties		= virtio__iommu_get_properties,
 	.alloc_address_space	= iommu_alloc_address_space,
 	.free_address_space	= iommu_free_address_space,
+	.debug_address_space	= iommu_debug_address_space,
 	.attach			= virtio_pci_iommu_attach,
 	.detach			= virtio_pci_iommu_detach,
 	.map			= iommu_map,
-- 
2.12.1
