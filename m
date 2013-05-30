From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 30 May 2013 10:55:24 +0300
Message-ID: <20130530075524.GA27487@redhat.com>
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

Hmm you want to have both in the header?

That would confuse users for sure :)

I guess we could put in a big comment explaning
why do we have both, and which version should
userspace use. I tried to write it:

/*
 * On all known C compilers, you can use the
 * offsetof macro to find the correct offset of each field -
 * if your compiler doesn't implement this correctly, use the
 * integer versions below, instead.
 * In that case please don't use the structures above, to avoid confusion.
 */


-- 
MST
