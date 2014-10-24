From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Fri, 24 Oct 2014 14:37:08 +0200
Message-ID: <20141024143708.2f1982b2.cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141023214158.GA29716@redhat.com>
	<20141024103839.7162b93f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141024103839.7162b93f.cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 24 Oct 2014 10:38:39 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Fri, 24 Oct 2014 00:42:20 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Oct 07, 2014 at 04:39:56PM +0200, Cornelia Huck wrote:
> > > This patchset aims to get us some way to implement virtio-1 compliant
> > > and transitional devices in qemu. Branch available at
> > > 
> > > git://github.com/cohuck/qemu virtio-1
> > > 
> > > I've mainly focused on:
> > > - endianness handling
> > > - extended feature bits
> > > - virtio-ccw new/changed commands
> > 
> > So issues identified so far:
> 
> Thanks for taking a look.
> 
> > - devices not converted yet should not advertize 1.0
> 
> Neither should an uncoverted transport. So we either can
> - have transport set the bit and rely on devices ->get_features
>   callback to mask it out
>   (virtio-ccw has to change the calling order for get_features, btw.)
> - have device set the bit and the transport mask it out later. Feels a
>   bit weird, as virtio-1 is a transport feature bit.
> 
> I'm tending towards the first option; smth like this (on top of my
> branch):

(...)

OK, I played around with this patch on top and the vhost-next branch as
guest. It seems to work reasonably well so far: a virtio-blk device
used virtio-1, a virtio-balloon device legacy.

One thing I noticed, though, is that I may need to think about
virtio-ccw revision vs. virtio version again. As a device can refuse
virtio-1 after the driver negotiated revision 1, we're operating a
legacy device with (some) standard ccws. Probably not a big deal, as
(a) both driver and device already have indicated that they support
revision 1 which those ccws are tied to and (b) some legacy
devices/drivers already support standard ccws (adapter interrupt
support). I might want to clarify the standard a bit, let me think
about that over the weekend.
