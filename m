From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Qemu and virtio 1.0
Date: Mon, 2 Mar 2015 13:00:32 +0100
Message-ID: <20150302130032.2f9f667e.cornelia.huck@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<877fv6mxkp.fsf@rustcorp.com.au>
	<20150302114343.GA12040@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150302114343.GA12040@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2 Mar 2015 12:43:43 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 25, 2015 at 02:50:22PM +1030, Rusty Russell wrote:
> > OK, I am trying to experiment with virtio 1.0 support using the
> > latest kernel and MST's qemu tree:
> > 
> >         https://git.kernel.org/cgit/virt/kvm/mst/qemu.git/?h=virtio-1.0
> > 
> > The first issue is that the device config endian was wrong (see
> > attached patch).
> > 
> > I'm now setting up a BE guest on my x86 laptop, and a BE and LE guest
> > on a BE powerpc machine, to check that all combinations work correctly.
> > If others test too, that would be appreciated!
> > 
> > Cheers,
> > Rusty.
> 
> Thanks a lot for finding this!
> The issue is certainly there, though I think looking
> at guest features is not the right thing to do:
> drivers can access config before acking features.

Ah right. I'm just wondering what the device-specific accessors (in net
and so on) will do?
