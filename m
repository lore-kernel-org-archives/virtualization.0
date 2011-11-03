From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: flexible configuration layout
Date: Thu, 3 Nov 2011 15:53:17 +0200
Message-ID: <20111103135316.GN18296@redhat.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com> <4EB26ED0.3080409@redhat.com>
	<20111103121139.GF18296@redhat.com> <4EB29926.9030509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4EB29926.9030509@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 03:37:42PM +0200, Avi Kivity wrote:
> On 11/03/2011 02:11 PM, Michael S. Tsirkin wrote:
> > On Thu, Nov 03, 2011 at 12:37:04PM +0200, Avi Kivity wrote:
> > > On 11/03/2011 01:31 AM, Michael S. Tsirkin wrote:
> > > > Add a flexible mechanism to specify virtio configuration layout, using
> > > > pci vendor-specific capability.  A separate capability is used for each
> > > > of common, device specific and data-path accesses.
> > > >
> > > >
> > > 
> > > How about posting the spec change instead of patches?
> >
> > We need both of course but I typically start with patches.
> > Easier to see whether it's even possible to implement the
> > spec without overhauling all of the code.
> 
> Patches are okay for someone familiar with the code.  For others, they
> require more effort.

Yes. It's just that I needed to convince myself that the approach is good,
and that meant writing the supporting code. Since I had the code
I didn't see a reason not to send it :)

> -- 
> error compiling committee.c: too many arguments to function
