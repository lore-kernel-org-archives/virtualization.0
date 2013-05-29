From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 04:02:10 +0200
Message-ID: <51A561A2.30308@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<20130528173257.GC30296@redhat.com> <51A4ECDE.1020207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51A4ECDE.1020207@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/28/13 19:43, Paolo Bonzini wrote:
> Il 28/05/2013 19:32, Michael S. Tsirkin ha scritto:
>>>>>> +
>>>>>> +    switch (addr) {
>>>>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>>>>> +        return proxy->device_feature_select;
>>>>
>>>> Oh dear no...  Please use defines like the rest of QEMU.
>> Any good reason not to use offsetof?
> 
> I'm not sure it's portable to use it in case labels.  IIRC, the
> definition ((int)&(((T *)0)->field)) is not a valid C integer constant
> expression.  Laszlo?

As long as we use the offsetof() that comes with the C implementation
(ie. we don't hack it up ourselves), we should be safe; ISO C99
elegantly defines offsetof() in "7.17 Common definitions <stddef.h>" p3
as

  The macros are [...]

    offsetof(type, member-designator)

  which expands to an integer constant expression that has type
  *size_t*, the value of which is the offset in bytes, to the structure
  member (designated by /member-designator/), from the beginning of its
  structure (designated by /type/). The type and member designator shall
  be such that given

    static type t;

  then the expression &(t.member-designator) evaluates to an address
  constant. (If the specified member is a bit-field, the behavior is
  undefined.)

("Address constant" is described in 6.6p9 but quoting even that here
doesn't seem necesary.)

From 6.8.4.2p3, "The expression of each case label shall be an integer
constant expression [...]".

So,
(a) if we use the standard offsetof(),
(b) and you can also write, for example,

  static struct virtio_pci_common_cfg t;
  static void *p = &t.device_feature_select;

then the construct seems valid.

(Consistently with the above mention of UB if the specified member is a
bit-field: the address-of operator's constraints also forbid a bit-field
object as operand.)

Laszlo
