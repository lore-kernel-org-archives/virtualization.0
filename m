From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Tue, 28 May 2013 19:43:58 +0200
Message-ID: <51A4ECDE.1020207@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<20130528173257.GC30296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528173257.GC30296@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 28/05/2013 19:32, Michael S. Tsirkin ha scritto:
>>> > > +
>>> > > +    switch (addr) {
>>> > > +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>> > > +        return proxy->device_feature_select;
>> > 
>> > Oh dear no...  Please use defines like the rest of QEMU.
> Any good reason not to use offsetof?

I'm not sure it's portable to use it in case labels.  IIRC, the
definition ((int)&(((T *)0)->field)) is not a valid C integer constant
expression.  Laszlo?

> I see about 138 examples in qemu.

Almost all of them are about fields in the host, not the guest, and none
of them are in case statements.

Paolo

> 
> Anyway, that's the way Rusty wrote it in the kernel header -
> I started with defines.
> If you convince Rusty to switch I can switch too,
> but I prefer reusing same structures as linux even if
> for now I've given up on reusing same headers.
> 
> 
