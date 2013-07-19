From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH V2 0/2] [BUGFIX] virtio/console: Fix two bugs of splice_write
Date: Fri, 19 Jul 2013 18:19:51 +0900
Message-ID: <20130719091951.9698.95194.stgit@yunodevel>
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
To: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, yrl.pp-manager.tt@hitachi.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This patch set fixes two bugs of splice_write in the virtio-console driver.

[BUG1] Although pipe->nrbufs is empty, the driver tries to do splice_write.
       => This induces oops in sg_init_table().

[BUG2] No lock for competition of splice_write.
       => This induces oops in splice_from_pipe_feed() by bug of any user
          application.

These reports are written in each patch.

Changes in V2:
- Fix a locking problem for error

Thanks!

---

Yoshihiro YUNOMAE (2):
      [BUGFIX] virtio/console: Quit from splice_write if pipe->nrbufs is 0
      [BUGFIX] virtio/console: Add pipe_lock/unlock for splice_write


 drivers/char/virtio_console.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
Yoshihiro YUNOMAE
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: yoshihiro.yunomae.ez@hitachi.com
