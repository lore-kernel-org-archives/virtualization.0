From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio: hint if callbacks surprisingly might sleep
Date: Wed, 13 Feb 2019 14:44:14 +0100
Message-ID: <20190213144414.6543cd22.cohuck__24779.1737945349$1550131235$gmane$org@redhat.com>
References: <20190131125314.29647-1-cohuck@redhat.com>
	<20190131102713-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190131102713-mutt-send-email-mst@kernel.org>
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
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 31 Jan 2019 10:27:53 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 31, 2019 at 01:53:14PM +0100, Cornelia Huck wrote:
> > A virtio transport is free to implement some of the callbacks in
> > virtio_config_ops in a matter that they cannot be called from
> > atomic context (e.g. virtio-ccw, which maps a lot of the callbacks
> > to channel I/O, which is an inherently asynchronous mechanism).
> > This can be very surprising for developers using the much more
> > common virtio-pci transport, just to find out that things break
> > when used on s390.
> > 
> > The documentation for virtio_config_ops now contains a comment
> > explaining this, but it makes sense to add a might_sleep() annotation
> > to various wrapper functions in the virtio core to avoid surprises
> > later.
> > 
> > Note that annotations are NOT added to two classes of calls:
> > - direct calls from device drivers (all current callers should be
> >   fine, however)
> > - calls which clearly won't be made from atomic context (such as
> >   those ultimately coming in via the driver core)
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> 
> Makes sense to me. I don't think we should push our luck in
> this release though, better defer until the merge window.

Friendly ping, as we're quite close to the release of 5.0 now.
