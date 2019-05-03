From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 01/10] virtio/s390: use vring_create_virtqueue
Date: Fri, 3 May 2019 16:04:48 -0400
Message-ID: <20190503160421-mutt-send-email-mst@kernel.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-2-pasic@linux.ibm.com>
	<20190503111724.70c6ec37.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190503111724.70c6ec37.cohuck@redhat.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 03, 2019 at 11:17:24AM +0200, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:36 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > The commit 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> > establishes a new way of allocating virtqueues (as a part of the effort
> > that taught DMA to virtio rings).
> > 
> > In the future we will want virtio-ccw to use the DMA API as well.
> > 
> > Let us switch from the legacy method of allocating virtqueues to
> > vring_create_virtqueue() as the first step into that direction.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 30 +++++++++++-------------------
> >  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> I'd vote for merging this patch right away for 5.2.

So which tree is this going through? mine?

-- 
MST
