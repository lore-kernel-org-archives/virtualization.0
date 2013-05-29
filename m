From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 09:18:45 -0500
Message-ID: <8738t5q37e.fsf__47644.4963053384$1369837169$gmane$org@codemonkey.ws>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com> <51A60575.1090407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 29/05/2013 15:24, Michael S. Tsirkin ha scritto:
>> You expect a compiler to pad this structure:
>> 
>> struct foo {
>> 	uint8_t a;
>> 	uint8_t b;
>> 	uint16_t c;
>> 	uint32_t d;
>> };
>> 
>> I'm guessing any compiler that decides to waste memory in this way
>> will quickly get dropped by users and then we won't worry
>> about building QEMU with it.
>
> You know the virtio-pci config structures are padded, but not all of
> them are.  For example, virtio_balloon_stat is not padded and indeed has
> an __attribute__((__packed__)) in the spec.

Not that these structures are actually used for something.

We store the config in these structures so they are actually used for
something.

The proposed structures only serve as a way to express offsets.  You
would never actually have a variable of this type.

Regards,

Anthony Liguori

>
> For this reason I prefer to have the attribute everywhere.  So people
> don't have to wonder why it's here and not there.
>
> Paolo
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
