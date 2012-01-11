From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 09:28:27 -0600
Message-ID: <4F0DAA9B.7060703@codemonkey.ws>
References: <87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au> <4F0D8EFA.3010503@codemonkey.ws>
	<20120111151230.GA20570@redhat.com>
	<4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111152129.GB20570@redhat.com>
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
Cc: Pawel Moll <pawel.moll@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/2012 09:21 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 11, 2012 at 09:15:49AM -0600, Anthony Liguori wrote:
>>> This is similar to what we have now. But it's still buggy: e.g. if guest
>>> updates MAC byte by byte, we have no way to know when it's done doing
>>> so.
>>
>> This is no different than a normal network card.  You have to use a
>> secondary register to trigger an update.
>>
>> Regards,
>>
>> Anthony Liguori
>
> Possible but doesn't let us layer nicely to allow unchanged drivers
> that work with all transports (new pci, old pci, non pci).

If we declare config space LE, then we have to touch all drivers.  There's no 
way around it because the virtio API is byte-based, not word based.

This is why I'm suggesting making the virtio API (and then the virtio-pci ABI) 
word based.  It gives us the flexibility to make endianness a property of the 
transport and not a property of the devices.

Regards,

Anthony Liguori
