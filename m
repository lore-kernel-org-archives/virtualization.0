From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile, and a sysfs
	cpu attribute
Date: Fri, 20 May 2011 10:26:57 -0400
Message-ID: <4DD67A31.90802__37544.289409607$1305901761$gmane$org@tilera.com>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105191541.11939.arnd@arndb.de> <4DD5334D.4060800@tilera.com>
	<201105191722.17685.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105191722.17685.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 5/19/2011 11:22 AM, Arnd Bergmann wrote:
> On Thursday 19 May 2011, Chris Metcalf wrote:
>>>> /proc/tile/board
>>>>   Information on part numbers, serial numbers, etc., of the
>>>>   hardware that the kernel is executing on
>>>>
>>>> /proc/tile/switch
>>>>   The type of control path for the onboard network switch, if any.
>> These two report information about the hardware, not the hypervisor.  For
>> example:
>>
>> # cat /proc/tile/board
>> board_part: 402-00002-05
>> board_serial: NBS-5002-00012
>> chip_serial: P62338.01.110
>> chip_revision: A0
>> board_revision: 2.2
>> board_description: Tilera TILExpressPro-64, TILEPro64 processor (866 MHz-capable), 1 10GbE, 6 1GbE
>> # cat /proc/tile/switch
>> control: mdio gbe/0
> I think it's ok to have it below /sys/hypervisor, because the information
> is provided through a hypervisor ABI, even though it describes something
> else. This is more like /sys/firmware, but the boundaries between that
> and /sys/hypervisor are not clearly defined when running virtualized anyway.

I'll create a /sys/hypervisor/board/ and report the attributes there.

>>>> /proc/tile/hardwall
>>>>   Information on the set of currently active hardwalls (note that
>>>>   the implementation is already present in arch/tile/kernel/hardwall.c;
>>>>   this change just enables it)
>> This one is not a hypervisor-related file.  It just lists information about
>> the set of Linux hardwalls currently active.  Again, it's not primarily
>> intended for programmatic use, but as a diagnostic tool.
> same here, I'd still put it into the hypervisor structure.

Since /proc/tile/hardwall has no connection to the hypervisor whatsoever,
I'm reluctant to put it under /sys/hypervisor.

Perhaps in this case it would be reasonable to just have the hardwall
subsystem put the file in /proc/driver/hardwall, or even /proc/hardwall? 
Or I could make the /dev/hardwall char device dump out the ASCII text that
we currently get from /proc/hardwall if you read from it, which is a little
weird but not inconceivable.  For example it currently shows things like this:

# cat /proc/tile/hardwall
2x2 1,1 pids: 484@2,1 479@1,1
2x2 0,3 pids:

In this example "2x2 1,1" is a 2x2 grid of cpus starting at grid (x,y)
position (1,1), with task 484 bound to the cpu at (x,y) position (2,1).

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
