From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 4 Nov 2009 15:17:36 +0200
Message-ID: <20091104131735.GD8920__31829.4766279452$1257340869$gmane$org@redhat.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com>
	<878wema6o0.fsf@basil.nowhere.org>
	<20091104121009.GF8398@redhat.com>
	<20091104125957.GL31511@one.firstfloor.org>
	<20091104130828.GC8920@redhat.com>
	<20091104131533.GM31511@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091104131533.GM31511@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 02:15:33PM +0100, Andi Kleen wrote:
> On Wed, Nov 04, 2009 at 03:08:28PM +0200, Michael S. Tsirkin wrote:
> > On Wed, Nov 04, 2009 at 01:59:57PM +0100, Andi Kleen wrote:
> > > > Fine?
> > > 
> > > I cannot say -- are there paths that could drop the device beforehand?
> > 
> > Do you mean drop the mm reference?
> 
> No the reference to the device, which owns the mm for you.

The device is created when file is open and destroyed
when file is closed. So I think the fs code handles the
reference counting for me: it won't call file cleanup
callback while some userspace process has the file open.
Right?

> > 
> > > (as in do you hold a reference to it?)
> > 
> > By design I think I always have a reference to mm before I use it.
> > 
> > This works like this:
> > ioctl SET_OWNER - calls get_task_mm, I think this gets a reference to mm
> > ioctl SET_BACKEND - checks that SET_OWNER was run, starts virtqueue
> > ioctl RESET_OWNER - stops virtqueues, drops the reference to mm
> > file close - stops virtqueues, if we still have it then drops mm
> > 
> > This is why I think I can call use_mm/unuse_mm while virtqueue is running,
> > safely.
> > Makes sense?
> 
> Do you protect against another thread doing RESET_OWNER in parallel while
> RESET_OWNER runs?

Yes, I have a mutex in the device for that. Same with SET_BACKEND.

> -Andi
> 
> -- 
> ak@linux.intel.com -- Speaking for myself only.
