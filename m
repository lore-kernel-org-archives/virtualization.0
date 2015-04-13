From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-balloon: virtio 1 support
Date: Mon, 13 Apr 2015 13:49:42 +0200
Message-ID: <20150413134908-mutt-send-email-mst@redhat.com>
References: <1428849904-28953-1-git-send-email-mst@redhat.com>
	<1428849904-28953-2-git-send-email-mst@redhat.com>
	<20150413100258.1f2c636f.cornelia.huck@de.ibm.com>
	<20150413132110-mutt-send-email-mst@redhat.com>
	<20150413133521.274fd658.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150413133521.274fd658.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 13, 2015 at 01:35:21PM +0200, Cornelia Huck wrote:
> On Mon, 13 Apr 2015 13:26:31 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 13, 2015 at 10:02:58AM +0200, Cornelia Huck wrote:
> 
> > > Also, doesn't get_features need to be modified as well so that
> > > VERSION_1 is advertised?
> > 
> > virtio_pci_device_plugged seems to set it ATM. I'll re-test to confirm.
> 
> Indeed, pci sets it, but ccw does not. And virtio-net, for example,
> sets it explicitly as well. We need to unify this :)

I'm inclined to set it in transport and black-list in specific devices.

-- 
MST
