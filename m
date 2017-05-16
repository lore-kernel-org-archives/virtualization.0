From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] S390-virtio: Adjustments for three function
	implementations
Date: Tue, 16 May 2017 17:50:43 +0200
Message-ID: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5__45805.1842441366$1494950619$gmane$org@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:43:21 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete error messages for failed memory allocations in two functions
  Improve a size determination in virtio_ccw_setup_vq()
  Adjust a null pointer check in two functions

 drivers/s390/virtio/virtio_ccw.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.13.0
