From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 30 May 2013 08:55:38 +0300
Message-ID: <20130530055538.GA9952@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wqqhktjx.fsf@rustcorp.com.au>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 30, 2013 at 01:28:26PM +0930, Rusty Russell wrote:
> Anthony Liguori <aliguori@us.ibm.com> writes:
> > Rusty Russell <rusty@rustcorp.com.au> writes:
> >
> >> Anthony Liguori <aliguori@us.ibm.com> writes:
> >>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> >>>> +        return proxy->device_feature_select;
> >>>
> >>> Oh dear no...  Please use defines like the rest of QEMU.
> >>
> >> It is pretty ugly.
> >
> > I think beauty is in the eye of the beholder here...
> >
> > Pretty much every device we have has a switch statement like this.
> > Consistency wins when it comes to qualitative arguments like this.
> 
> I was agreeing with you here, actually.
> 
> >> Yet the structure definitions are descriptive, capturing layout, size
> >> and endianness in natural a format readable by any C programmer.
> >
> >>From an API design point of view, here are the problems I see:
> >
> > 1) C makes no guarantees about structure layout beyond the first
> >    member.  Yes, if it's naturally aligned or has a packed attribute,
> >    GCC does the right thing.  But this isn't kernel land anymore,
> >    portability matters and there are more compilers than GCC.
> 
> [ I argued in detail here, then deleted.  Damn bikeshedding... ]
> 
> I think the best thing is to add the decoded integer versions as macros,
> and have a heap of BUILD_BUG_ON() in the kernel source to make sure they
> match.

On the qemu side, fine with me, all I want is ability to stay
close to kernel headers.
Let's have XXX_SIZE macros as well, so access size can be
easily validated?

On the kernel side, for 'struct virtio_pci_cap',
since we only ever do offsetof on this struct,
it might be easier to just use the numeric constants
directly.


-- 
MST
