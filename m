From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Tue, 10 Jan 2012 19:03:36 +0200
Message-ID: <20120110170334.GA18404@redhat.com>
References: <20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878vm6daqy.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 21, 2011 at 11:03:25AM +1030, Rusty Russell wrote:
> On Tue, 20 Dec 2011 13:37:18 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Dec 19, 2011 at 09:38:42PM +1030, Rusty Russell wrote:
> > > On Mon, 19 Dec 2011 11:13:26 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > Actually, the host doesn't need anything, since it can always lock out
> > > the guest while it updates the area.
> > > It's the guest which can't do atomic updates.
> > 
> > There are 2 cases
> > - updates by guest accesses by host
> > - accesses by guest updates by host
> > 
> > Both are problematic because the guest accesses are split.
> > Consider the example I gave at the beginning was with capacity read
> > by guest. Host can not solve it without guest changes, right?
> 
> Indeed, my brain fart.  Let's pretend I didn't say that, and you didn't
> have to explain it to me in baby words :)
> 
> > > > The counter can be in guest memory, right? So we don't pay extra
> > > > exits.
> > > 
> > > Could be, but I'm not delighted about the design.
> > 
> > OK, so this is an argument for always using a control vq, right?
> 
> Yes.  The idea that we can alter fields in the device-specific config
> area is flawed.  There may be cases where it doesn't matter, but as an
> idea it was holed to begin with.
> 
> We can reduce probability by doing a double read to check, but there are
> still cases where it will fail.

Okay - want me to propose an interface for that?
