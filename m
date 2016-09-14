From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/11] virtio-console: Fine-tuning for 14 function
	implementations
Date: Wed, 14 Sep 2016 15:56:03 +0200
Message-ID: <020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Sep 2016 15:43:21 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (11):
  Use kmalloc_array() in init_vqs()
  Less function calls in init_vqs() after error detection
  Rename a jump label in init()
  Rename jump labels in virtcons_probe()
  Rename jump labels in add_port()
  Rename a jump label in port_fops_open()
  Rename a jump label in port_fops_splice_write()
  Rename jump labels in port_fops_write()
  Rename a jump label in __send_to_port()
  Rename jump labels in alloc_buf()
  Rename a jump label in five functions

 drivers/char/virtio_console.c | 155 ++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 68 deletions(-)

-- 
2.10.0
