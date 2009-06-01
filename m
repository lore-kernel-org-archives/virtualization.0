From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: find_vqs operation starting at arbitrary index
Date: Mon, 1 Jun 2009 12:45:03 +0300
Message-ID: <20090601094503.GD5061@redhat.com>
References: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
	<20090601081106.GA5061@redhat.com>
	<20090601083510.GB17119@amit-x200.pnq.redhat.com>
	<20090601084327.GB5061@redhat.com>
	<20090601085128.GA19999@amit-x200.pnq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090601085128.GA19999@amit-x200.pnq.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 01, 2009 at 02:21:28PM +0530, Amit Shah wrote:
> On (Mon) Jun 01 2009 [11:43:27], Michael S. Tsirkin wrote:
> > On Mon, Jun 01, 2009 at 02:05:10PM +0530, Amit Shah wrote:
> > > On (Mon) Jun 01 2009 [11:11:06], Michael S. Tsirkin wrote:
> > > > On Mon, Jun 01, 2009 at 01:33:48PM +0530, Amit Shah wrote:
> > > > > Hello,
> > > > > 
> > > > > The recent find_vqs operation doesn't allow for a vq to be found at an
> > > > > arbitrary location; it's meant to be called once at startup to find all
> > > > > possible queues and never called again.
> > > > > 
> > > > > This doesn't work for devices which can have queues hot-plugged at
> > > > > run-time. This can be made to work by passing the 'start_index' value as
> > > > > was done earlier for find_vq, but I doubt something like the following
> > > > > will work. The MSI vectors might need some changing as well.

Another possible approach would be to add enable_vq/disable_vq operations
(or possibly resize_vq).
Thus you would create an empty queue (size 0) upfront, and associate it with
a vector, and then enable it/set the real size when you really want to use it.
disable/resize to 0 when you don't need it anymore.


Actually, resizing queues might come in handy for virtio_net:
I think tx queue length might be tunable by user,
and maybe we can even auto-tune rx queue size to avoid packet loss.
