From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio/ringtest: fix up need_event math
Date: Fri, 27 Oct 2017 16:16:37 +0300
Message-ID: <20171027161336-mutt-send-email-mst@kernel.org>
References: <1508982452-27245-1-git-send-email-mst@redhat.com>
	<20171026103647.588ac89b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171026103647.588ac89b.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 26, 2017 at 10:36:47AM +0200, Cornelia Huck wrote:
> On Thu, 26 Oct 2017 04:48:01 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > last kicked event index must be updated unconditionally:
> > even if we don't need to kick, we do not want to re-check
> > the same entry for events.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  tools/virtio/ringtest/ring.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Actually it seems to sometimes trigger stalls when host and guest
are on the same physical core. To trigger:

./ring --sleep --host-affinity 0 --guest-affinity 0

This worries me since it's similar to what vhost does.

Still debugging - anyone see anything suspicious?


> I think virtio_ring_0_9 has the same issue?

I think it does, posted a patch.

-- 
MST
