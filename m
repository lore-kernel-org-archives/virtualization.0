From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 4 Nov 2009 14:37:28 +0100
Message-ID: <20091104133728.GN31511__25193.5845277787$1257342286$gmane$org@one.firstfloor.org>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com>
	<878wema6o0.fsf@basil.nowhere.org>
	<20091104121009.GF8398@redhat.com>
	<20091104125957.GL31511@one.firstfloor.org>
	<20091104130828.GC8920@redhat.com>
	<20091104131533.GM31511@one.firstfloor.org>
	<20091104131735.GD8920@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091104131735.GD8920@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 03:17:36PM +0200, Michael S. Tsirkin wrote:
> On Wed, Nov 04, 2009 at 02:15:33PM +0100, Andi Kleen wrote:
> > On Wed, Nov 04, 2009 at 03:08:28PM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Nov 04, 2009 at 01:59:57PM +0100, Andi Kleen wrote:
> > > > > Fine?
> > > > 
> > > > I cannot say -- are there paths that could drop the device beforehand?
> > > 
> > > Do you mean drop the mm reference?
> > 
> > No the reference to the device, which owns the mm for you.
> 
> The device is created when file is open and destroyed
> when file is closed. So I think the fs code handles the
> reference counting for me: it won't call file cleanup
> callback while some userspace process has the file open.
> Right?

Yes.

But the semantics when someone inherits such a fd through exec
or through file descriptor passing would be surely "interesting"
You would still do IO on the old VM.

I guess it would be a good way to confuse memory accounting schemes 
or administrators @)

It would be all saner if this was all a single atomic step.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
