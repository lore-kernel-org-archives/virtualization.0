From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 11:53:17 +0100
Message-ID: <CAFEAcA9E8TYUA-kiTSaoLGHyGsbGgSrbBukg=0mE=_VtTXR34g@mail.gmail.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <20130529082440.GE4472@redhat.com>
	<CAFEAcA_ezTD_mg7tVOM5P4Od3VxOxPB6eKWTUknY3Fh=Gq6V6g@mail.gmail.com>
	<20130529100809.GO4472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529100809.GO4472@redhat.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 29 May 2013 11:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, May 29, 2013 at 10:00:33AM +0100, Peter Maydell wrote:
>> Asserting is definitely the wrong thing here, since the
>> guest can trigger it.
>
> So?

So "guest should not be able to crash QEMU" is a standard
rule: assert() is for QEMU bugs, not guest bugs.
Virtio isn't any different to any other device model.

> It's a driver bug. It can reset or crash guest with the same effect,
> and it likely will if we let it continue.

Letting a misbehaving guest crash itself is fine. Killing
QEMU isn't.

> assert makes sure we don't let it escalate into some
> hard to debug security problem.

If you want to make guest bugs easier to spot and debug
this is what qemu_log_mask(LOG_GUEST_ERROR,...) is for.

>> If you really want to use offsetof like this you're
>> going to need to decorate the structs with QEMU_PACKED.

> Nope.
> These structs are carefully designed not to have any padding.

...on every compiler and OS combination that QEMU builds for?

> And if there was a bug and there was some padding, we still
> can't fix it with PACKED because this structure
> is used to interact with the guest code which does not
> have the packed attribute.

The guest code has to use a set of structure offsets and
sizes which is fixed by the virtio ABI -- how it implements
this is up to the guest (and if it misimplements it that is
a guest bug and not our problem). Note also that the ABI
is not defined by a set of C source struct definitions
(except in as far as they are accompanied by a set of
restrictions on alignment, padding, etc that completely
determine the numerical alignments and offsets).
How QEMU implements the set of offsets and sizes specified
by the ABI is definitely our problem, and is exactly what
this discussion is about. The simplest and safest way to
get the offsets right on all platforms is just to use a set
of #defines, which is why that's what almost all of our
device models do. Where we do define a struct matching
guest memory layout, we tag it with QEMU_PACKED as our
best means of ensuring consistency on all hosts.

thanks
-- PMM
