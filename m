From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] vhost/scsi: Adjustments for five function implementations
Date: Sat, 20 May 2017 16:30:15 +0200
Message-ID: <bafa65e4-08fe-efdb-d836-7657e8a64749__17873.9823321395$1495290945$gmane$org@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 May 2017 16:25:04 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve a size determination in four functions
  Delete error messages for failed memory allocations in five functions

 drivers/vhost/scsi.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

-- 
2.13.0
