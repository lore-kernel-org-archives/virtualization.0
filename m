From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: virtio PCI on KVM without IO BARs
Date: Tue, 05 Mar 2013 23:14:31 -0800
Message-ID: <5136ECD7.3020501@zytor.com>
References: <20130228152433.GA13832@redhat.com> <5136882C.8040700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5136882C.8040700@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/05/2013 04:05 PM, H. Peter Anvin wrote:
> On 02/28/2013 07:24 AM, Michael S. Tsirkin wrote:
>>
>> 3. hypervisor assigned IO address
>> 	qemu can reserve IO addresses and assign to virtio devices.
>> 	2 bytes per device (for notification and ISR access) will be
>> 	enough. So we can reserve 4K and this gets us 2000 devices.
>>         From KVM perspective, nothing changes.
>> 	We'll want some capability in the device to let guest know
>> 	this is what it should do, and pass the io address.
>> 	One way to reserve the addresses is by using the bridge.
>> 	Pros: no need for host kernel support
>> 	Pros: regular PIO so fast
>> 	Cons: does not help assigned devices, breaks nested virt
>>
>> Simply counting pros/cons, option 3 seems best. It's also the
>> easiest to implement.
>>
> 
> The problem here is the 4K I/O window for IO device BARs in bridges.
> Why not simply add a (possibly proprietary) capability to the PCI bridge
> to allow a much narrower window?  That fits much more nicely into the
> device resource assignment on the guest side, and could even be
> implemented on a real hardware device -- we can offer it to the PCI-SIG
> for standardization, even.
> 

Just a correction: I'm of course not talking about BARs but of the
bridge windows.  The BARs are not a problem; an I/O BAR can cover as
little as four bytes.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
