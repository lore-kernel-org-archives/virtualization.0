From: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH] virtio/ringtest: virtio_ring: fix up need_event math
Date: Mon, 30 Oct 2017 14:00:25 +0100
Message-ID: <20171030130025.vmhzygf2cmwozhg3__10839.5244497389$1509368465$gmane$org@localhost.localdomain>
References: <1509109839-553-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1509109839-553-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 27, 2017 at 01:11:13PM +0000, Michael S. Tsirkin wrote:
>last kicked event index must be updated unconditionally:
>even if we don't need to kick, we do not want to re-check
>the same entry for events.
>
>Reported-by: Cornelia Huck <cohuck@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> tools/virtio/ringtest/virtio_ring_0_9.c | 24 ++++++++++++++----------
> 1 file changed, 14 insertions(+), 10 deletions(-)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>
