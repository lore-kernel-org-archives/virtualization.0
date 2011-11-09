From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC] virtio-spec: flexible configuration layout
Date: Wed, 9 Nov 2011 22:52:08 +0200
Message-ID: <20111109205208.GA28599@redhat.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<20111109195901.GA28155@redhat.com> <1320870287.3730.6.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320870287.3730.6.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, penberg@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 09, 2011 at 10:24:47PM +0200, Sasha Levin wrote:
> On Wed, 2011-11-09 at 21:59 +0200, Michael S. Tsirkin wrote:
> 
> [snip]
> 
> > +\begin_layout Enumerate
> > +Reset the device.
> > + This is not required on initial start up.
> > +\end_layout
> > +
> > +\begin_layout Enumerate
> > +The ACKNOWLEDGE status bit is set: we have noticed the device.
> > +\end_layout
> > +
> > +\begin_layout Enumerate
> > +The DRIVER status bit is set: we know how to drive the device.
> > +\end_layout
> > +
> > +\begin_layout Enumerate
> > +
> > +\change_inserted 1986246365 1320838089
> > +PCI capability list scan, detecting virtio configuration layout using Virtio
> > + Structure PCI capabilities.
> 
> Does the legacy space always gets mapped from BAR0?
> 
> If yes,

Yes and this is repeated in several places. Not clear? How can this
be made clearer?

> It'll be a bit harder deprecating it in the future.

Harder than ... what ?
IMO there's no way to put legacy anywhere except the first BAR
without breaking existing guests.

> If not, this should actually be #1. Previous 3 bullets here were already
> setting the status byte in the device config.
> 
> [snip]
> 
> > +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> > +\begin_inset Text
> > +
> > +\begin_layout Plain Layout
> > +
> > +\change_inserted 1986246365 1320786225
> > +28 bytes
> 
> This is the new virtio header min size, shouldn't it be 32? (20 + 4
> (msi-x) + 4 (guest feature) + 4 (device features)).

Good catch, I'll correct this.

> -- 
> 
> Sasha.
