From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] virtio-gpu/2d: add docs/specs/virtio-gpu.txt
Date: Thu, 11 Sep 2014 17:09:33 +0200
Message-ID: <1410448173-12960-3-git-send-email-kraxel@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/virtio-gpu.txt | 165 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 docs/specs/virtio-gpu.txt

diff --git a/docs/specs/virtio-gpu.txt b/docs/specs/virtio-gpu.txt
new file mode 100644
index 0000000..9455383
--- /dev/null
+++ b/docs/specs/virtio-gpu.txt
@@ -0,0 +1,165 @@
+virtio-gpu specification
+========================
+
+virtio-gpu is a virtio based graphics adapter.  It can operate in 2D
+mode and in 3D (virgl) mode.  3D mode will offload rendering ops to
+the host gpu and therefore requires a gpu with 3D support on the host
+machine.
+
+The initial version will have 2D mode only.  It provides support for
+ARGB Hardware cursors and multiple scanouts (aka heads).
+
+
+features
+--------
+
+There are no feature bits (yet).
+There will be one in the future for 3D mode support.
+
+
+config space
+------------
+
+struct virtgpu_config {
+        uint32_t events_read;
+        uint32_t events_clear;
+        uint32_t num_scanouts;
+        uint32_t reserved;
+};
+
+The two members events_read and events_clear are used to signal events
+to the driver.  Currently one event is defined for a display
+change. When a config space interrupt is received the driver should
+read the events_read field.  The events processed should be written to
+the events_clear field.  The device will clear the bits in events_read
+then, mimicing write-to-clear behavior.
+
+num_scanouts specifies the number of scanouts supported by the device.
+
+The fourth field is reserved (3D mode will need this in the future).
+
+
+virt queues
+-----------
+
+The virtio-gpu exposes 2 virtio queues to the guest:
+
+ (1) control vq - guest->host queue for sending commands and getting
+     responses when required.
+ (2) cursor vq - guest->host queue for sending cursor position and
+     resource updates
+
+Both queues have the same format.  Each request and each response have
+a fixed header (struct virtgpu_ctrl_hdr), followed by command specific
+data fieds.  The separate cursor queue is the "fast track" for
+cursor-related commands, so they go though without being possibly
+delayed by other commands in the control queue.
+
+
+drive virtio-gpu in 2D mode
+---------------------------
+
+The virtio-gpu is based around the concept of resources private to the
+host, the guest must DMA transfer into these resources. This is a
+design requirement in order to interface with future 3D rendering. In
+the unaccelerated there is no support for DMA transfers from
+resources, just to them.
+
+Resources are initially simple 2D resources, consisting of a width,
+height and format along with an identifier. The guest must then attach
+backing store to the resources in order for DMA transfers to
+work. This is like a GART in a real GPU.
+
+A typical guest user would create a 2D resource using
+VIRTGPU_CMD_RESOURCE_CREATE_2D, attach backing store using
+VIRTGPU_CMD_RESOURCE_ATTACH_BACKING, then attach the resource to a
+scanout using VIRTGPU_CMD_SET_SCANOUT, then use
+VIRTGPU_CMD_TRANSFER_SEND_2D to send updates to the resource, and
+finally VIRTGPU_CMD_RESOURCE_FLUSH to flush the scanout buffers to
+screen.
+
+
+control queue commands (2D)
+---------------------------
+
+VIRTGPU_CMD_GET_DISPLAY_INFO:
+  Command: none (just struct virtgpu_ctrl_hdr).
+  Returns: struct virtgpu_resp_display_info.
+
+  Retrieve the current output configuration.
+
+VIRTGPU_CMD_RESOURCE_CREATE_2D:
+  Command: struct virtgpu_resource_create_2d
+
+  Create a 2D resource on the host.
+
+  This creates a 2D resource on the host with the specified width,
+  height and format. Only a small subset of formats are support. The
+  resource ids are generated by the guest.
+
+VIRTGPU_CMD_RESOURCE_UNREF:
+  Command: struct virtgpu_resource_unref
+
+  Destroy a resource.
+
+  This informs the host that a resource is no longer required by the
+  guest.
+
+VIRTGPU_CMD_SET_SCANOUT:
+  Command: struct virtgpu_set_scanout
+
+  Set the scanout parameters for a single output.
+
+  This sets the scanout parameters for a single scanout. The
+  resource_id is the resource to be scanned out from, along with a
+  rectangle specified by x, y, width and height.
+
+VIRTGPU_CMD_RESOURCE_FLUSH:
+  Command: struct virtgpu_resource_flush
+
+  Flush a scanout resource.
+
+  This flushes a resource to screen, it takes a rectangle and a
+  resource id, and flushes any scanouts the resource is being used on.
+
+VIRTGPU_CMD_TRANSFER_TO_HOST_2D:
+  Command: struct virtgpu_transfer_to_host_2d
+
+  Transfer from guest memory to host resource.
+
+  This takes a resource id along with an destination offset into the
+  resource, and a box to transfer from the host backing for the
+  resource.
+
+VIRTGPU_CMD_RESOURCE_ATTACH_BACKING:
+  Command: struct virtgpu_resource_attach_backing
+
+  Assign backing pages to a resource.
+
+  This assign an array of guest pages (struct virtgpu_mem_entry) as
+  the backing store for a resource. These pages are then used for the
+  transfer operations for that resource from that point on.
+
+VIRTGPU_CMD_RESOURCE_INVAL_BACKING:
+  Command: struct virtgpu_resource_inval_backing
+
+  Detach backing pages from a resource.
+
+  This detaches any backing pages from a resource, to be used in case of
+  guest swapping or object destruction.
+
+
+cursor queue commands
+---------------------
+
+VIRTGPU_CMD_UPDATE_CURSOR
+  Command: struct virtgpu_update_cursor
+
+  Update cursor from the specified resource id.  The driver must
+  transfer the cursor into the resource beforehand (using control
+  queue commands)
+
+VIRTGPU_CMD_MOVE_CURSOR
+  Command: struct virtgpu_update_cursor
+
+  Move cursor.  Only virtgpu_update_cursor.pos field is used.
-- 
1.8.3.1
