From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 14:01:18 +0930
Message-ID: <87ppwammp5.fsf@rustcorp.com.au>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bo7vvxej.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>> +        return proxy->device_feature_select;
>
> Oh dear no...  Please use defines like the rest of QEMU.

It is pretty ugly.

Yet the structure definitions are descriptive, capturing layout, size
and endianness in natural a format readable by any C programmer.

So AFAICT the question is, do we put the required

#define VIRTIO_PCI_CFG_FEATURE_SEL \
         (offsetof(struct virtio_pci_common_cfg, device_feature_select))

etc. in the kernel headers or qemu?

> Haven't looked at the proposed new ring layout yet.

No change, but there's an open question on whether we should nail it to
little endian (or define the endian by the transport).

Of course, I can't rule out that the 1.0 standard *may* decide to frob
the ring layout somehow, but I'd think it would require a compelling
reason.  I suggest that's 2.0 material...

Cheers,
Rusty.
