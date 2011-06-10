From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Fri, 10 Jun 2011 13:14:02 +0100
Message-ID: <BANLkTimqrZYnnVq5KTh3s68_o3Lfr9oWeA__17421.5113198899$1307708242$gmane$org@mail.gmail.com>
References: <4DEE2B15.4090809@redhat.com> <87lixbgax9.fsf@rustcorp.com.au>
	<4DF06F4F.8050308@redhat.com> <87lix9dioo.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lix9dioo.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 10, 2011 at 12:33 PM, Rusty Russell <rusty@rustcorp.com.au> wro=
te:
> On Thu, 09 Jun 2011 08:59:27 +0200, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>> On 06/09/2011 01:28 AM, Rusty Russell wrote:
>> >> > =A0after some preliminary discussion on the QEMU mailing list, I pr=
esent a
>> >> > =A0draft specification for a virtio-based SCSI host (controller, HB=
A, you
>> >> > =A0name it).
>> >
>> > OK, I'm impressed. =A0This is very well written and it doesn't make an=
y of
>> > the obvious mistakes wrt. virtio.
>>
>> Thanks very much, and thanks to those who corrected my early mistakes.
>>
>> > I assume you have an implementation, as well?
>>
>> Unfortunately not; "we're working on it", which means I should start in
>> July when I come back from vacation.
>>
>> Do you prefer to wait for one before I make a patch to the LyX source?
>> In the meanwhile, can you reserve a subsystem ID for me?
>>
>> Paolo
>
> Sure, you can have the next subsystem ID.
>
> It's a pain to patch once it's in LyX, so let's get the implementation
> base on what you posted here an see how much it changes first...

Paolo, I'll switch the Linux guest LLD and QEMU virtio-scsi skeleton
that I have to comply with the spec.  Does this sound good or did you
want to write these from scratch?

Stefan
