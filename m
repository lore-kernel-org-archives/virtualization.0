From: Sasha Levin <levinsasha928@gmail.com>
Subject: [RFC 0/5] virtio-pci,
	kvm tools: Support new virtio-pci spec in kvm tools
Date: Tue, 15 Nov 2011 01:43:12 +0200
Message-ID: <1321314197-5265-1-git-send-email-levinsasha928@gmail.com>
References: <20111114181854.GA24953@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111114181854.GA24953@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, Sasha Levin <levinsasha928@gmail.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch series contains two fixes for the RFC patch send by Michael. These
patches are pretty basic and should probably be merged into the next version
of that patch.

Other two patches add support to the new virtio-pci spec in KVM tools, allowing
for easy testing of any future virtio-pci kernel side patches. The usermode code
isn't complete, but it's working properly and should be enough for functionality
testing.

Michael S. Tsirkin (1):
  virtio-pci: flexible configuration layout

Sasha Levin (4):
  virtio-pci: Fix compilation issue
  iomap: Don't ignore offset
  kvm tools: Free up the MSI-X PBA BAR
  kvm tools: Support new virtio-pci configuration layout

 drivers/virtio/virtio_pci.c        |  184 ++++++++++++++++++++++--
 include/asm-generic/io.h           |    4 +
 include/asm-generic/iomap.h        |   11 ++
 include/linux/pci_regs.h           |    4 +
 include/linux/virtio_pci.h         |   41 ++++++
 lib/iomap.c                        |   41 +++++-
 tools/kvm/include/kvm/pci.h        |   13 ++-
 tools/kvm/include/kvm/virtio-pci.h |    5 +-
 tools/kvm/virtio/pci.c             |  275 ++++++++++++++++++++++++++++++++----
 9 files changed, 530 insertions(+), 48 deletions(-)

-- 
1.7.8.rc1
