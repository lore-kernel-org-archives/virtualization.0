From: Henning Schild <henning.schild@siemens.com>
Subject: Using virtio for inter-VM communication
Date: Tue, 10 Jun 2014 18:48:18 +0200
Message-ID: <20140610184818.2e490419__33633.1446808346$1402420414$gmane$org@nbschild1>
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
To: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Henning Schild <henning.schild@siemens.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

i am working on the jailhouse[1] project and am currently looking at
inter-VM communication. We want to connect guests directly with virtual
consoles based on shared memory. The code complexity in the hypervisor
should be minimal, it should just make the shared memory discoverable
and provide a signaling mechanism.

We would like to reuse virtio so that Linux-guests will eventually just
work without having to patch them. Having looked at virtio it seems to
be focused on host<->guest communication and does not consider direct
guest<->guest communication. I.e. the queues use guest-physical
addressing, which is only meaningful for the guest and the host.

In a first prototype i implemented a ivshmem[2] device for the
hypervisor. That way we can share memory between virtual machines.
Ivshmem is nice and simple but does not seem to be used anymore. And it
does not define higher level devices, like a console.

At this point i could:
- define a console on top of ivshmem
- see how i can get a virtio console to work between guests on shared
memory

Is anyone already using something like that? I guess zero-copy virtio
devices in Xen would be a similar case. I read a suggestion from may
2010 to introduce a virtio feature bit for shared memory
(VIRTIO_F_RING_SHMEM_ADDR). But that did not make it into the
virtio-spec.

regards,
Henning

[1] jailhouse
https://github.com/siemens/jailhouse

[2] ivshmem
https://gitorious.org/nahanni
