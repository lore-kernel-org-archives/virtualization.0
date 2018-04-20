From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/6] virtio-console: spec compliance fixes
Date: Fri, 20 Apr 2018 21:18:00 +0300
Message-ID: <1524248223-393618-1-git-send-email-mst__4178.76649084992$1524248180$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Turns out virtio console tries to take a buffer out of an active vq.
Works by sheer luck, and is explicitly forbidden by spec.  And while
going over it I saw that error handling is also broken -
failure is easy to trigger if I force allocations to fail.

Lightly tested.

Michael S. Tsirkin (6):
  virtio_console: don't tie bufs to a vq
  virtio: add ability to iterate over vqs
  virtio_console: free buffers after reset
  virtio_console: drop custom control queue cleanup
  virtio_console: move removal code
  virtio_console: reset on out of memory

 drivers/char/virtio_console.c | 155 ++++++++++++++++++++----------------------
 include/linux/virtio.h        |   3 +
 2 files changed, 75 insertions(+), 83 deletions(-)

-- 
MST
