From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: switch to modern accessors for 1.0
Date: Mon, 2 Mar 2015 13:16:51 +0100
Message-ID: <20150302121651.GC12040@redhat.com>
References: <1425296404-12903-1-git-send-email-mst@redhat.com>
	<1425296404-12903-2-git-send-email-mst@redhat.com>
	<20150302125655.50a9063a.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150302125655.50a9063a.cornelia.huck@de.ibm.com>
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

On Mon, Mar 02, 2015 at 12:56:55PM +0100, Cornelia Huck wrote:
> On Mon, 2 Mar 2015 12:40:28 +0100
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > virtio 1.0 config space is in LE format for all
> > devices, use modern wrappers when accessed through
> > the 1.0 BAR.
> > 
> > Reported-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Not that I'm deeply familiar with pci :), but this looks good to me.
> 
> (This is on top of your pci branch, btw?)

virtio 1.0 branch
