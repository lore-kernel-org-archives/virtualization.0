From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 0/1] s390 preparation for vcpu preempted check
Date: Thu, 29 Sep 2016 17:51:04 +0200
Message-ID: <1475164265-246160-1-git-send-email-borntraeger__37235.8805420392$1475164274$gmane$org@de.ibm.com>
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
To: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patch should enable s390 support for the upcoming vcpu
preempt check support, but it should compile and work fine 
without that patch set as well.

Christian Borntraeger (1):
  s390/spinlock: Provide vcpu_is_preempted

 arch/s390/include/asm/spinlock.h |  3 +++
 arch/s390/kernel/smp.c           |  9 +++++++--
 arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
 3 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.5.5
