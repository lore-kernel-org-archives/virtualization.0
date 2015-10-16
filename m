From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 0/9] Hyper-V synthetic interrupt controller
Date: Fri, 16 Oct 2015 10:07:44 +0300
Message-ID: <1444979273-6587-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patchset implements the KVM part of the synthetic interrupt
controller (SynIC) which is a building block of the Hyper-V
paravirtualized device bus (vmbus).

SynIC is a lapic extension, which is controlled via MSRs and maintains
for each vCPU
 - 16 synthetic interrupt "lines" (SINT's); each can be configured to
   trigger a specific interrupt vector optionally with auto-EOI
   semantics
 - a message page in the guest memory with 16 256-byte per-SINT message
   slots
 - an event flag page in the guest memory with 16 2048-bit per-SINT
   event flag areas

The host triggers a SINT whenever it delivers a new message to the
corresponding slot or flips an event flag bit in the corresponding area.
The guest informs the host that it can try delivering a message by
explicitly asserting EOI in lapic or writing to End-Of-Message (EOM)
MSR.

The userspace (qemu) triggers interrupts and receives EOM notifications
via irqfd with resampler; for that, a GSI is allocated for each
configured SINT, and irq_routing api is extended to support GSI-SINT
mapping.

Besides, a new vcpu exit is introduced to notify the userspace of the
changes in SynIC configuraion triggered by guest writing to the
corresponding MSRs.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>

Changes v2:
* irqchip/eventfd preparation improvements to support
  arch specific routing entries like Hyper-V SynIC ones.
* add Hyper-V SynIC vectors into EOI exit bitmap.
* do not use posted interrupts in case of Hyper-V SynIC
  AutoEOI vectors
