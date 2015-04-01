From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 1/6] virtio_balloon: transitional interface
Date: Wed, 1 Apr 2015 13:52:44 +0200
Message-ID: <20150401135244.5a8d7ad1.cornelia.huck__27809.2139088132$1427889193$gmane$org@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<1427884468-23930-2-git-send-email-mst@redhat.com>
	<20150401124539-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150401124539-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Pawel Moll <pawel.moll@arm.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Apr 2015 12:49:02 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 01, 2015 at 12:35:45PM +0200, Michael S. Tsirkin wrote:
> > Virtio 1.0 doesn't include a modern balloon device.
> > But it's not a big change to support a transitional
> > balloon device: this has the advantage of supporting
> > existing drivers, transparently.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/uapi/linux/virtio_balloon.h | 11 ++++++++--
> >  drivers/virtio/virtio_balloon.c     | 43 +++++++++++++++++++++++++++++--------
> >  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> So all in all 32 LOC added, and 9 out of these
> deal with endian-ness differences.
> 
> Seems like a small cost for guests to pay for a clean spec, no?
> 

I'm not opposed to this per se, but I'm not totally convinced of the
usefulness :)

Seeing the qemu side would be helpful.
