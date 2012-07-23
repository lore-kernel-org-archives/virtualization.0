From: Sasha Levin <levinsasha928@gmail.com>
Subject: [RFC 0/2] virtio: provide a way for host to monitor critical events
	in the device
Date: Mon, 23 Jul 2012 22:32:39 +0200
Message-ID: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
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
To: rusty@rustcorp.com.au, mst@redhat.com, penberg@kernel.org, asias.hejun@gmail.com
Cc: kvm@vger.kernel.org, wency@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, anthony@codemonkey.ws, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

As it was discussed recently, there's currently no way for the guest to notify
the host about panics. Further more, there's no reasonable way to notify the
host of other critical events such as an OOM kill.

This short patch series introduces a new device named virtio-notifier which
does two simple things:

 1. Provide a simple interface for the guest to notify the host of critical
 events. This is easily expandible to add support for any events we may find
 interesting for the host to know about.

 2. Provide an "echo" interface for the host to ping the guest. This allows
 the host to ping the guest at intervals chosen by the host, and act
 accordingly if no response has been received.

Sasha Levin (2):
  virtio: Introduce virtio-notifier
  kvm tools: support virtio-notifier

 drivers/virtio/Kconfig                  |   11 ++
 drivers/virtio/Makefile                 |    1 +
 drivers/virtio/virtio_notifier.c        |  135 ++++++++++++++++++++
 include/linux/virtio_ids.h              |    1 +
 include/linux/virtio_notifier.h         |   15 +++
 tools/kvm/Makefile                      |    1 +
 tools/kvm/builtin-run.c                 |    6 +
 tools/kvm/include/kvm/virtio-notifier.h |    9 ++
 tools/kvm/include/kvm/virtio-pci-dev.h  |    1 +
 tools/kvm/virtio/notifier.c             |  203 +++++++++++++++++++++++++++++++
 10 files changed, 383 insertions(+), 0 deletions(-)
 create mode 100644 drivers/virtio/virtio_notifier.c
 create mode 100644 include/linux/virtio_notifier.h
 create mode 100644 tools/kvm/include/kvm/virtio-notifier.h
 create mode 100644 tools/kvm/virtio/notifier.c

-- 
1.7.8.6
