From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 15:37:11 +0300
Message-ID: <20130529123711.GU4472@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <20130529082440.GE4472@redhat.com>
	<CAFEAcA_ezTD_mg7tVOM5P4Od3VxOxPB6eKWTUknY3Fh=Gq6V6g@mail.gmail.com>
	<20130529100809.GO4472@redhat.com>
	<CAFEAcA9E8TYUA-kiTSaoLGHyGsbGgSrbBukg=0mE=_VtTXR34g@mail.gmail.com>
	<20130529121615.GR4472@redhat.com> <51A5F470.4070407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A5F470.4070407@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 02:28:32PM +0200, Paolo Bonzini wrote:
> Il 29/05/2013 14:16, Michael S. Tsirkin ha scritto:
> >>>> > >> If you really want to use offsetof like this you're
> >>>> > >> going to need to decorate the structs with QEMU_PACKED.
> >> > 
> >>> > > Nope.
> >>> > > These structs are carefully designed not to have any padding.
> >> > 
> >> > ...on every compiler and OS combination that QEMU builds for?
> > Yes. All the way back to EGCS and before.
> > GCC has been like this for many many years.
> 
> I would still prefer to have QEMU_PACKED (or __attribute((__packed__))
> in the kernel).
> 
> >>> > > And if there was a bug and there was some padding, we still
> >>> > > can't fix it with PACKED because this structure
> >>> > > is used to interact with the guest code which does not
> >>> > > have the packed attribute.
> >> > 
> >> > The guest code has to use a set of structure offsets and
> >> > sizes which is fixed by the virtio ABI -- how it implements
> >> > this is up to the guest (and if it misimplements it that is
> >> > a guest bug and not our problem).
> 
> On the other hand, encouraging both userspace and guest to reuse a
> single set of headers means that the bad offset becomes a spec bug more
> than a guest bug.

Heh

> > Deviating from driver in random ways is an endless source
> > of hard to debug issues, and it's a very practical
> > consideration because virtio spec is constantly
> > being extended (unlike hardware which is mostly fixed).
> 
> Agreed---but the driver should use __attribute__((__packed__)) too.
> 
> Paolo

For these specific structures I don't mind, we never dereference them
anyway. If you do dereference a structure, using packed is generally
a mistake. In particular because GCC generates code that is
much slower.

You can also get nasty surprises e.g.

struct foo {
	char a;
	int b;
} __attribute__((packed));

struct foo foo;
int *a = &foo.a;

Last line compiles fine but isn't legal C.

So I think there are two cases with packed:
1. it does not change logical behaviour but results in bad code
   generated
2. it does change logical behaviour and leads to unsafe code

There aren't many good reasons to use packed: if you
must treat unaligned data, best to use constants.

-- 
MST
