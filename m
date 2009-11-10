From: Amit Shah <amit.shah@redhat.com>
Subject: virtio_console: support for multiple ports, console and generic.
Date: Tue, 10 Nov 2009 15:11:26 +0530
Message-ID: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
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
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hey Rusty,

This is the way I did the split; patches 1..7 are preparation for
multiple ports.

Patch 8 adds multiport support. It's the big one since we have to put
the header in and retain support for multiple consoles and console
resizing.

Patch 9 adds port hotplug

Patch 10 adds sysfs entries and 12 adds debugfs.

Patches 13, 14 and 15 add throttling, caching and unplug features.

There's also a one-device restriction; which would be addressed once I
use vdev->priv.

My main aim is to get comments on the send_buf and fill_readbuf
functions, the input/output workqueues and hotplug.

Amit
