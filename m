From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: memory corruption in HYPERVISOR_physdev_op()
Date: Fri, 14 Sep 2012 14:24:27 +0300
Message-ID: <20120914112427.GA1454@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Tang Liang <liang.tang@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hi Jeremy,

My static analyzer complains about potential memory corruption in
HYPERVISOR_physdev_op()

arch/x86/include/asm/xen/hypercall.h
   389  static inline int
   390  HYPERVISOR_physdev_op(int cmd, void *arg)
   391  {
   392          int rc = _hypercall2(int, physdev_op, cmd, arg);
   393          if (unlikely(rc == -ENOSYS)) {
   394                  struct physdev_op op;
   395                  op.cmd = cmd;
   396                  memcpy(&op.u, arg, sizeof(op.u));
   397                  rc = _hypercall1(int, physdev_op_compat, &op);
   398                  memcpy(arg, &op.u, sizeof(op.u));
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Some of the arg buffers are not as large as sizeof(op.u) which is either
12 or 16 depending on the size of longs in struct physdev_apic.

   399          }
   400          return rc;
   401  }

One example of this is in xen_initdom_restore_msi_irqs().

arch/x86/pci/xen.c
   337                  struct physdev_pci_device restore_ext;
   338  
   339                  restore_ext.seg = pci_domain_nr(dev->bus);
   340                  restore_ext.bus = dev->bus->number;
   341                  restore_ext.devfn = dev->devfn;
   342                  ret = HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi_ext,
   343                                          &restore_ext);
                                                ^^^^^^^^^^^^
There are only 4 bytes here.

   344                  if (ret == -ENOSYS)
                            ^^^^^^^^^^^^^^
If we hit this condition, we have corrupted some memory.

   345                          pci_seg_supported = false;

regards,
dan carpenter
