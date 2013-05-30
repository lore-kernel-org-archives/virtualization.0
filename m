From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 30 May 2013 10:43:08 +0300
Message-ID: <20130530074308.GA27703@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com> <51A60575.1090407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A60575.1090407@redhat.com>
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

On Wed, May 29, 2013 at 03:41:09PM +0200, Paolo Bonzini wrote:
> Il 29/05/2013 15:24, Michael S. Tsirkin ha scritto:
> > You expect a compiler to pad this structure:
> > 
> > struct foo {
> > 	uint8_t a;
> > 	uint8_t b;
> > 	uint16_t c;
> > 	uint32_t d;
> > };
> > 
> > I'm guessing any compiler that decides to waste memory in this way
> > will quickly get dropped by users and then we won't worry
> > about building QEMU with it.
> 
> You know the virtio-pci config structures are padded, but not all of
> them are.  For example, virtio_balloon_stat is not padded and indeed has
> an __attribute__((__packed__)) in the spec.
> 
> For this reason I prefer to have the attribute everywhere.  So people
> don't have to wonder why it's here and not there.
> 
> Paolo

BTW we don't even do this consistently everywhere in QEMU.

It would have been better to have a rule to avoid packed
as much as possible, then we'd have found the misaligned field bug
in balloon before it's too late.

That would be a good rule to adopt I think:
any pack if something is misaligned, and document
the reason.

-- 
MST
