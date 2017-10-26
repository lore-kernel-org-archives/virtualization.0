From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio/ringtest: fix up need_event math
Date: Thu, 26 Oct 2017 10:36:47 +0200
Message-ID: <20171026103647.588ac89b.cohuck__15668.2243956768$1509080745$gmane$org@redhat.com>
References: <1508982452-27245-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1508982452-27245-1-git-send-email-mst@redhat.com>
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

On Thu, 26 Oct 2017 04:48:01 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> last kicked event index must be updated unconditionally:
> even if we don't need to kick, we do not want to re-check
> the same entry for events.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tools/virtio/ringtest/ring.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

I think virtio_ring_0_9 has the same issue?
