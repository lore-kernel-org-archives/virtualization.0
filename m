From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] virtio: fix complaint by sparse
Date: Sun, 27 Nov 2016 04:53:07 +0200
Message-ID: <20161127045247-mutt-send-email-mst@kernel.org>
References: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020D979FA1E@SZXEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020D979FA1E@SZXEMA503-MBS.china.huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

this is in my tree, will be in the next pull request.

On Sat, Nov 26, 2016 at 09:36:50AM +0000, Gonglei (Arei) wrote:
> Ping...?
> 
> > -----Original Message-----
> > From: Gonglei (Arei)
> > Sent: Tuesday, November 22, 2016 1:52 PM
> > To: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Cc: mst@redhat.com; jasowang@redhat.com; Gonglei (Arei)
> > Subject: [PATCH 0/2] virtio: fix complaint by sparse
> > 
> > I found some warnings reported by sparse in the virtio code
> > when I checked virtio-crypto's driver stuff. Let's fix them.
> > 
> > Gonglei (2):
> >   virtio_pci_modern: fix complaint by sparse
> >   virtio_ring: fix complaint by sparse
> > 
> >  drivers/virtio/virtio_pci_modern.c | 8 ++++----
> >  drivers/virtio/virtio_ring.c       | 4 ++--
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > --
> > 1.8.3.1
> > 
