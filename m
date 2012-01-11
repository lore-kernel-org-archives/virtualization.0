From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 08:47:25 +0000
Message-ID: <CAJSP0QU_viNks2jv003c8+gYWFkyW=FvZpU5w6wyroeEyFkXsA@mail.gmail.com>
References: <20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8762gj6q5r.fsf@rustcorp.com.au>
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
Cc: Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 12:25 AM, Rusty Russell <rusty@rustcorp.com.au> wro=
te:
> On Tue, 10 Jan 2012 19:03:36 +0200, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
>> On Wed, Dec 21, 2011 at 11:03:25AM +1030, Rusty Russell wrote:
>> > Yes. =A0The idea that we can alter fields in the device-specific config
>> > area is flawed. =A0There may be cases where it doesn't matter, but as =
an
>> > idea it was holed to begin with.
>> >
>> > We can reduce probability by doing a double read to check, but there a=
re
>> > still cases where it will fail.
>>
>> Okay - want me to propose an interface for that?
>
> Had a brief chat with BenH (CC'd).
>
> I think we should deprecate writing to the config space. =A0Only balloon
> does it AFAICT, and I can't quite figure out *why* it has an 'active'
> field. =A0This solves half the problem, of sync guest writes. =A0For the
> other half, I suggest a generation counter; odd means inconsistent. =A0The
> guest can poll.
>
> BenH also convinced me we should finally make the config space LE if
> we're going to change things. =A0Since PCI is the most common transport,
> guest-endian confuses people. =A0And it sucks for really weird machines.
>
> We should also change the ring (to a single ring, I think). =A0Descriptors
> to 24 bytes long (8 byte cookie, 8 byte addr, 4 byte len, 4 byte flags).
> We might be able to squeeze it into 20 bytes but that means packing. =A0We
> should support inline, chained or indirect. =A0Let the other side ack by
> setting flag, cookie and len (if written).
>
> Moreover, I think we should make all these changes at once (at least, in
> the spec). =A0That makes it a big change, and it'll take longer to
> develop, but makes it easy in the long run to differentiate legacy and
> modern virtio.

This is also an opportunity to stop using CPU physical addresses in
the ring and instead perform DMA like a normal PCI device (use bus
addresses).

Stefan
