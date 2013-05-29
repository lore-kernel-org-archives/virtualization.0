From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 09:27:02 +0200
Message-ID: <51A5ADC6.3090002@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<20130528173257.GC30296@redhat.com>
	<51A4ECDE.1020207@redhat.com> <87mwremmm8.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87mwremmm8.fsf@rustcorp.com.au>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 29/05/2013 06:33, Rusty Russell ha scritto:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> Il 28/05/2013 19:32, Michael S. Tsirkin ha scritto:
>>>>>>> +
>>>>>>> +    switch (addr) {
>>>>>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>>>>>> +        return proxy->device_feature_select;
>>>>>
>>>>> Oh dear no...  Please use defines like the rest of QEMU.
>>> Any good reason not to use offsetof?
>>
>> I'm not sure it's portable to use it in case labels.  IIRC, the
>> definition ((int)&(((T *)0)->field)) is not a valid C integer constant
>> expression.  Laszlo?
> 
> It's defined to yield an integer constant expression in the ISO standard
> (and I think ANSI too, though that's not at hand):

It's not in C89.  The oldest compiler QEMU cares about is GCC 4.2.  I
don't know if it has a builtin offsetof, probably it does.  But I'm not
sure about other users of virtio headers.

Paolo

> 
>     7.19, para 3:
> 
>         ...offsetof(type, member-designator)
>         which expands to an integer constant expression that has type
>         size_t, ...
> 
> The real question is whether compilers qemu cares about meet the
> standard (there's some evidence that older compilers fail this).  If
> not, we'll have to define them as raw offsets...
> 
> Cheers,
> Rusty.
> 
