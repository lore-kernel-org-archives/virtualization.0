From: "Denis V. Lunev" <den@parallels.com>
Subject: [PATCH 0/2] shrink virtio baloon on OOM in guest
Date: Wed,  8 Oct 2014 14:21:07 +0400
Message-ID: <1412763669-2980-1-git-send-email-den@parallels.com>
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
Cc: den@openvz.org, virtualization@lists.linux-foundation.org, Raushaniya Maksudova <rmaksudova@parallels.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Excessive virtio_balloon inflation can cause invocation of OOM-killer, when
Linux is under severe memory pressure. Various mechanisms are responsible for
correct virtio_balloon memory management. Nevertheless it is often the case
that these control tools does not have enough time to react on fast changing
memory load. As a result OS runs out of memory and invokes OOM-killer.
The balancing of memory by use of the virtio balloon should not cause the
termination of processes while there are pages in the balloon. Now there is
no way for virtio balloon driver to free memory at the last moment before
some process get killed by OOM-killer.

This does not provide a security breach as baloon itself is running
inside guest OS and is working in the cooperation with the host. Thus
some improvements from guest side should be considered as normal.

To solve the problem, introduce a virtio_balloon callback which is expected
to be called from the oom notifier call chain in out_of_memory() function.
If virtio balloon could release some memory, it will make the system to
return and retry the allocation that forced the out of memory killer to run.

Patch 1 of this series adds support for implementation of virtio_balloon
callback, so now leak_balloon() function returns number of freed pages.
Patch 2 implements virtio_balloon callback itself.

Signed-off-by: Raushaniya Maksudova <rmaksudova@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Rusty Russell <rusty@rustcorp.com.au>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: virtualization@lists.linux-foundation.org
