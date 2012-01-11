From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] vhost-net: add module alias
Date: Wed, 11 Jan 2012 21:02:38 +0400
Message-ID: <4F0DC0AE.5010106__40250.2729245045$1326410114$gmane$org@msgid.tls.msk.ru>
References: <20120110205400.6c1cb306@nehalam.linuxnetplumber.net>
	<4F0D3543.7020401@msgid.tls.msk.ru>
	<20120111085857.0753322f@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111085857.0753322f@nehalam.linuxnetplumber.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Kay Sievers <kay.sievers@vrfy.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11.01.2012 20:58, Stephen Hemminger wrote:
> On Wed, 11 Jan 2012 11:07:47 +0400
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> On 11.01.2012 08:54, Stephen Hemminger wrote:
>>> By adding the a module alias, programs (or users) won't have to explicitly
>>> call modprobe. Vhost-net will always be available if built into the kernel.
>>> It does require assigning a permanent minor number for depmod to work.
>>> Choose one next to TUN since this driver is related to it.
>>
>> Why do you think a statically-allocated device number will do any good
>> at all?  Static /dev is gone almost completely, at least on the systems
>> where whole virt stuff makes any sense, so you don't have pre-created
>> vhost-net device anymore, and hence this allocation makes no sense.
>> Just IMHO anyway.
[]
> See also: https://lkml.org/lkml/2010/5/21/134

Aha.  So udev pre-creates statically-allocated devnodes nowadays:

 Udev will pick up the depmod created file on startup and create all the
 static device nodes which the kernel modules specify, so that these modules
 get automatically loaded when the device node is accessed...

This was the part I missed.  Now it all looks logically.

Thanks,

/mjt
