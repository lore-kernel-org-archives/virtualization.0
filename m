From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] virtio-spec: Define virtio-mmio registers as LE
Date: Fri, 01 Mar 2013 11:21:06 +0000
Message-ID: <51308F22.7040303@arm.com>
References: <87wqubkalj.fsf@rustcorp.com.au>
	<1360839247-9131-1-git-send-email-pawel.moll@arm.com>
	<513085EA.8070007@arm.com> <1362135005.3052.26.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362135005.3052.26.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <Pawel.Moll@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/13 10:50, Pawel Moll wrote:
> On Fri, 2013-03-01 at 10:41 +0000, Marc Zyngier wrote:
>> On 14/02/13 10:54, Pawel Moll wrote:
>>> To solve the never-ending confusions between hosts and guests
>>> of different endianess, define all virtio-mmio registers as LE.
>>>
>>> This change should be safe at this stage, because no known
>>> working mixed-endian system exists so there is virtually no
>>> risk of breaking compatibility.
>>>
>>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>>
>> Shouldn't we exclude the config space? PCI defines it as guest-endian,
>> and the above tends to indicate that it should be LE with MMIO.
> 
> The spec says: "Device-specific configuration space starts at an offset
> 0x100 and is accessed with byte alignment. Its meaning and size depends
> on the device and the driver."
> 
> I would hope that "accessed with byte alignment" is enough of a clue in
> this subject, but if you think otherwise I can add a sentence stating
> this explicitly.

Well, it was unclear enough for me to get confused... ;-) It would make
sense to have a wording similar to the one in the PCI section.

> Having said that, Rusty was contemplating enforcing LE config space in
> the new PCI layout...

I wouldn't complain about that, and would like to see a similar thing on
MMIO.

	M.
-- 
Jazz is not dead. It just smells funny...
