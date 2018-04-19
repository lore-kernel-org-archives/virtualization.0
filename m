From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 net 2/3] virtio_net: fix adding vids on big-endian
Date: Thu, 19 Apr 2018 17:56:04 +0300
Message-ID: <20180419175456-mutt-send-email-mst__29191.3084256977$1524149645$gmane$org@kernel.org>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
	<1524115776-334953-3-git-send-email-mst@redhat.com>
	<20180419152641.092865f3.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180419152641.092865f3.cohuck@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 19, 2018 at 03:26:41PM +0200, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 08:30:49 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Programming vids (adding or removing them) still passes
> > guest-endian values in the DMA buffer. That's wrong
> > if guest is big-endian and when virtio 1 is enabled.
> > 
> > Note: this is on top of a previous patch:
> > 	virtio_net: split out ctrl buffer
> > 
> > Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Ouch. Have you seen any bug reports for that?

No, but then vlans within VMs aren't used too often
(as opposed to attaching vlans by the HV).

-- 
MST
