From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: vhost-net todo list
Date: Wed, 16 Sep 2009 13:04:38 +0300
Message-ID: <20090916100438.GA30036__18388.7499770664$1253095639$gmane$org@redhat.com>
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
To: anthony@codemonkey.ws, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Some people asked about getting involved with vhost.

Here's a short list of projects.

vhost-net driver projects
- profiling would be very helpful, I have not done any yet
- tap support - working on it now
- merged buffers - working on it now
- scalability/fairness for large # of guests - working on it now
- logging support with dirty page tracking in kernel - working on it now
- indirect buffers - worth it?
- vm exit mitigation for TX (worth it?
  naive implementation does not seem to help)
- interrupt mitigation for RX
- level triggered interrupts - what's the best thing
  to do here?

qemu projects
- migration support
- level triggered interrupts - what's the best thing
  to do here?
- upstream support for injecting interrupts from kernel,
  from qemu-kvm.git to qemu.git
  (this is a vhost dependency, without it vhost
   can't be upstreamed, or it can, but without real benefit)
- general cleanup and upstreaming

projects involing networking stack
- export socket from tap so vhost can use it - working on it now
- extend raw sockets to support GSO/checksum offloading,
  and teach vhost to use that capability
  [one way to do this: virtio net header support]
  will allow working with e.g. macvlan

long term projects
- multiqueue (involves all of vhost, qemu, virtio,
  networking stack)

- More testing is always good

-- 
MST
