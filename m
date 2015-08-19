From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 0/2] virtio_balloon: do not change memory amount visible via
	/proc/meminfo
Date: Thu, 20 Aug 2015 00:49:47 +0300
Message-ID: <1440020989-10824-1-git-send-email-den@openvz.org>
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
Cc: "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Though there is a problem in this setup. The end-user and hosting provider
have signed SLA agreement in which some amount of memory is guaranted for
the guest. The good thing is that this memory will be given to the guest
when the guest will really need it (f.e. with OOM in guest and with
VIRTIO_BALLOON_F_DEFLATE_ON_OOM configuration flag set). The bad thing
is that end-user does not know this.

Balloon by default reduce the amount of memory exposed to the end-user
each time when the page is stolen from guest or returned back by using
adjust_managed_page_count and thus /proc/meminfo shows reduced amount
of memory.

Fortunately the solution is simple, we should just avoid to call
adjust_managed_page_count with VIRTIO_BALLOON_F_DEFLATE_ON_OOM set.

Please note that neither VMWare ballon nor HyperV balloon do not care
about proper handling of adjust_managed_page_count at all.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
