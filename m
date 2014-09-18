From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH] blk-mq: Avoid race condition with uninitialized requests
Date: Thu, 18 Sep 2014 11:04:30 +0200
Message-ID: <1411031071-40390-1-git-send-email-dahi@linux.vnet.ibm.com>
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
To: tom.leiming@gmail.com, axboe@kernel.dk
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, dahi@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patch should fix the bug reported in https://lkml.org/lkml/2014/9/11/249.

Test is still pending.

David Hildenbrand (1):
  blk-mq: Avoid race condition with uninitialized requests

 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.8.5.5
