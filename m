From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Mon, 03 Jun 2013 09:47:05 +0930
Message-ID: <8761xwujy6.fsf@rustcorp.com.au>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au>
	<20130530075524.GA27487@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130530075524.GA27487@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, May 30, 2013 at 01:28:26PM +0930, Rusty Russell wrote:
>> >> Yet the structure definitions are descriptive, capturing layout, size
>> >> and endianness in natural a format readable by any C programmer.
>> >
>> >>From an API design point of view, here are the problems I see:
>> >
>> > 1) C makes no guarantees about structure layout beyond the first
>> >    member.  Yes, if it's naturally aligned or has a packed attribute,
>> >    GCC does the right thing.  But this isn't kernel land anymore,
>> >    portability matters and there are more compilers than GCC.
>> 
>> [ I argued in detail here, then deleted.  Damn bikeshedding... ]
>> 
>> I think the best thing is to add the decoded integer versions as macros,
>> and have a heap of BUILD_BUG_ON() in the kernel source to make sure they
>> match.
>
> Hmm you want to have both in the header?
>
> That would confuse users for sure :)
>
> I guess we could put in a big comment explaning
> why do we have both, and which version should
> userspace use. I tried to write it:
>
> /*
>  * On all known C compilers, you can use the
>  * offsetof macro to find the correct offset of each field -
>  * if your compiler doesn't implement this correctly, use the
>  * integer versions below, instead.
>  * In that case please don't use the structures above, to avoid confusion.
>  */

My version was a little less verbose :)

Subject: virtio_pci: macros for PCI layout offsets.

QEMU wants it, so why not?  Trust, but verify.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 24bcd9b..6510009 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -453,6 +453,64 @@ static void __iomem *map_capability(struct pci_dev *dev, int off, size_t minlen,
 	return p;
 }
 
+/* This is part of the ABI.  Don't screw with it. */
+static inline void check_offsets(void)
+{
+	/* Note: disk space was harmed in compilation of this function. */
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_VNDR !=
+		     offsetof(struct virtio_pci_cap, cap_vndr));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_NEXT !=
+		     offsetof(struct virtio_pci_cap, cap_next));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_LEN !=
+		     offsetof(struct virtio_pci_cap, cap_len));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_TYPE_AND_BAR !=
+		     offsetof(struct virtio_pci_cap, type_and_bar));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_OFFSET !=
+		     offsetof(struct virtio_pci_cap, offset));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_LENGTH !=
+		     offsetof(struct virtio_pci_cap, length));
+	BUILD_BUG_ON(VIRTIO_PCI_NOTIFY_CAP_MULT !=
+		     offsetof(struct virtio_pci_notify_cap,
+			      notify_off_multiplier));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DFSELECT != 
+		     offsetof(struct virtio_pci_common_cfg,
+			      device_feature_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DF != 
+		     offsetof(struct virtio_pci_common_cfg, device_feature));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GFSELECT != 
+		     offsetof(struct virtio_pci_common_cfg,
+			      guest_feature_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GF != 
+		     offsetof(struct virtio_pci_common_cfg, guest_feature));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_MSIX != 
+		     offsetof(struct virtio_pci_common_cfg, msix_config));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_NUMQ != 
+		     offsetof(struct virtio_pci_common_cfg, num_queues));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_STATUS != 
+		     offsetof(struct virtio_pci_common_cfg, device_status));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SELECT != 
+		     offsetof(struct virtio_pci_common_cfg, queue_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SIZE != 
+		     offsetof(struct virtio_pci_common_cfg, queue_size));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_MSIX != 
+		     offsetof(struct virtio_pci_common_cfg, queue_msix_vector));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_ENABLE != 
+		     offsetof(struct virtio_pci_common_cfg, queue_enable));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_NOFF != 
+		     offsetof(struct virtio_pci_common_cfg, queue_notify_off));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCLO != 
+		     offsetof(struct virtio_pci_common_cfg, queue_desc_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCHI != 
+		     offsetof(struct virtio_pci_common_cfg, queue_desc_hi));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILLO != 
+		     offsetof(struct virtio_pci_common_cfg, queue_avail_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILHI != 
+		     offsetof(struct virtio_pci_common_cfg, queue_avail_hi));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDLO != 
+		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI != 
+		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
+}
 
 /* the PCI probing function */
 static int virtio_pci_probe(struct pci_dev *pci_dev,
@@ -461,6 +519,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	struct virtio_pci_device *vp_dev;
 	int err, common, isr, notify, device;
 
+	check_offsets();
+
 	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
 		return -ENODEV;
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e1a25ad..9fb7ea4 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -171,4 +171,34 @@ struct virtio_pci_common_cfg {
 	__le32 queue_used_lo;		/* read-write */
 	__le32 queue_used_hi;		/* read-write */
 };
+
+/* Macro versions of offsets for the Old Timers! */
+#define VIRTIO_PCI_CAP_VNDR		0
+#define VIRTIO_PCI_CAP_NEXT		1
+#define VIRTIO_PCI_CAP_LEN		2
+#define VIRTIO_PCI_CAP_TYPE_AND_BAR	3
+#define VIRTIO_PCI_CAP_OFFSET		4
+#define VIRTIO_PCI_CAP_LENGTH		8
+
+#define VIRTIO_PCI_NOTIFY_CAP_MULT	12
+
+#define VIRTIO_PCI_COMMON_DFSELECT	0
+#define VIRTIO_PCI_COMMON_DF		4
+#define VIRTIO_PCI_COMMON_GFSELECT	8
+#define VIRTIO_PCI_COMMON_GF		12
+#define VIRTIO_PCI_COMMON_MSIX		16
+#define VIRTIO_PCI_COMMON_NUMQ		18
+#define VIRTIO_PCI_COMMON_STATUS	20
+#define VIRTIO_PCI_COMMON_Q_SELECT	22
+#define VIRTIO_PCI_COMMON_Q_SIZE	24
+#define VIRTIO_PCI_COMMON_Q_MSIX	26
+#define VIRTIO_PCI_COMMON_Q_ENABLE	28
+#define VIRTIO_PCI_COMMON_Q_NOFF	30
+#define VIRTIO_PCI_COMMON_Q_DESCLO	32
+#define VIRTIO_PCI_COMMON_Q_DESCHI	36
+#define VIRTIO_PCI_COMMON_Q_AVAILLO	40
+#define VIRTIO_PCI_COMMON_Q_AVAILHI	44
+#define VIRTIO_PCI_COMMON_Q_USEDLO	48
+#define VIRTIO_PCI_COMMON_Q_USEDHI	52
+
 #endif /* _UAPI_LINUX_VIRTIO_PCI_H */
