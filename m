From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/2] virtio: console: Trivial fixes based on review comments
Date: Mon,  8 Mar 2010 14:16:58 +0530
Message-ID: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@linux-foundation.org, quintela@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello,

Here are a couple of small fixes for the virtio_console code, it's mostly
stylistic fixes.

Michael, can you push these to Linus? Thanks.

Amit Shah (2):
  virtio: console: Fix type of 'len' as unsigned int
  virtio: console: Use better variable names for fill_queue operation

 drivers/char/virtio_console.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)
