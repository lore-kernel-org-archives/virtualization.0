From: Gleb Natapov <gleb@redhat.com>
Subject: Make virtio vq size configurable by a guest.
Date: Mon, 20 Jun 2011 16:16:24 +0300
Message-ID: <20110620131624.GZ491@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Currently in virtio host dictates the size and layout of vq that should
be used.  To talk to a device that has one vq with 128 elements guest
needs to allocate at least 2 pages. Usually this is not a problem, but
sometimes guest runs in a resource restricted environment and then it may
not have enough memory to initialize all virtio devices present in the
system. One such environment is a BIOS. Seabios currently has virtio block
support. Since the BIOS should be able to access the disk even after OS
is launched vq should be allocated from a special memory region that will
be marked as unavailable to an OS, but such memory is scarce. Because vq
is so huge only a couple of virtio disks can be initialized by the BIOS.

It would be nice if a guest will be able to tell to a host what vq size
should be used instead. BIOS issues only one request at a time anyway,
so it needs only one element in vq. It does not care about performance
to much either, so it can tell to a host to not align used index to a
page boundary. This way vq of one element shouldn't take more then a couple
hundreds of bytes.

--
			Gleb.
