From: Frank Swiderski <fes@google.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Wed, 27 Jun 2012 09:08:37 -0700
Message-ID: <CAK+C7kXSL=nqb1ZzY9MLB_02G_J-p3PCqaLf8CNJWcV8nsz=2w@mail.gmail.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<20120626214106.GC14054@redhat.com>
	<87lij91myw.fsf@rustcorp.com.au>
	<CAK+C7kWRsDcsB-W9m=Hn65xekvb-uOZC4oAMT0z48CC5q00oJw@mail.gmail.com>
	<20120627160644.GD21393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120627160644.GD21393@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mikew@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 27, 2012 at 9:06 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Jun 27, 2012 at 08:48:55AM -0700, Frank Swiderski wrote:
>> On Tue, Jun 26, 2012 at 7:56 PM, Rusty Russell <rusty@rustcorp.com.au> w=
rote:
>> > On Wed, 27 Jun 2012 00:41:06 +0300, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
>> >> On Tue, Jun 26, 2012 at 01:32:58PM -0700, Frank Swiderski wrote:
>> >> > This implementation of a virtio balloon driver uses the page cache =
to
>> >> > "store" pages that have been released to the host. =A0The communica=
tion
>> >> > (outside of target counts) is one way--the guest notifies the host =
when
>> >> > it adds a page to the page cache, allowing the host to madvise(2) w=
ith
>> >> > MADV_DONTNEED. =A0Reclaim in the guest is therefore automatic and i=
mplicit
>> >> > (via the regular page reclaim). =A0This means that inflating the ba=
lloon
>> >> > is similar to the existing balloon mechanism, but the deflate is
>> >> > different--it re-uses existing Linux kernel functionality to
>> >> > automatically reclaim.
>> >> >
>> >> > Signed-off-by: Frank Swiderski <fes@google.com>
>> >>
>> >> I'm pondering this:
>> >>
>> >> Should it really be a separate driver/device ID?
>> >> If it behaves the same from host POV, maybe it
>> >> should be up to the guest how to inflate/deflate
>> >> the balloon internally?
>> >
>> > Well, it shouldn't steal ID 10, either way :) =A0Either use a complete=
ly
>> > bogus number, or ask for an id.
>> >
>> > But AFAICT this should be a an alternate driver of for the same device:
>> > it's not really a separate device, is it?
>> >
>> > Cheers,
>> > Rusty.
>>
>> Apologies, Rusty. =A0Asking for an ID is in the virtio spec, and I
>> completely neglected that step. =A0Though as you and others have pointed
>> out, this probably fits better as a different driver for the same
>> device. =A0Since it changes whether or not the deflate operation is
>> necessary, it also seems that how this should look is different
>> behavior based on a feature bit in the device.
>>
>> If that sounds reasonable, then what I'll do with this patch is merge
>> it with the existing virtio balloon driver with a feature bit for
>> determining which behavior to use.
>>
>> I also think the idea of a generic balloon that the different balloon
>> drivers use for the inflate/deflate operations is interesting and
>> useful, though I think the suggestion of pending that until later is
>> correct.
>>
>> Sounds reasonable?
>>
>> Regards,
>> fes
>
> I think a spec patch would be a good spec at this point.
> You can get the spec from Rusty, or a mirror
> from my git:
>
> git://git.kernel.org/pub/scm/virt/kvm/mst/virtio-spec.git
>
>
>


Got it, thanks, will do.

Regards,
fes
