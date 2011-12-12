From: Don Dutile <ddutile@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Mon, 12 Dec 2011 13:10:08 -0500
Message-ID: <4EE64380.2090305@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
	<87zkf3fiu2.fsf@rustcorp.com.au>	<20111211094256.GB11504@redhat.com>	<87boreohhs.fsf@rustcorp.com.au>
	<20111212114912.GA7946@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111212114912.GA7946@redhat.com>
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
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/12/2011 06:49 AM, Michael S. Tsirkin wrote:
> On Mon, Dec 12, 2011 at 09:15:03AM +1030, Rusty Russell wrote:
>> On Sun, 11 Dec 2011 11:42:56 +0200, "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>>> On Thu, Dec 08, 2011 at 09:09:33PM +1030, Rusty Russell wrote:
>>>> +/* There is no iowrite64.  We use two 32-bit ops. */
>>>> +static void iowrite64(u64 val, const __le64 *addr)
>>>> +{
>>>> +	iowrite32((u32)val, (__le32 *)addr);
>>>> +	iowrite32(val>>  32, (__le32 *)addr + 1);
>>>> +}
>>>> +
>>>
>>> Let's put addr_lo/addr_hi in the structure then,
>>> to make the fact this field is not atomic explicit?
>>
>> Good point, assuming I haven't missed something.
>>
>> Are 64-bit accesses actually unknown in PCI-land?  Or is this a limited
>> availability thing?
>>
>> Thanks,
>> Rusty.
>
> I think PCI can optionally support atomic 64 bit accesses, but not all
> architectures can generate them.
>
yes. PCI(e) support atomic 64-bit ops; it's dependent on CPU & chipset interface
to PCI that determines ability to generate a 64-bit length xaction.
