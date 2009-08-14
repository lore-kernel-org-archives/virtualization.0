From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Fri, 14 Aug 2009 19:11:38 +0530
Message-ID: <20090814134138.GA27898__40950.8539749824$1250257464$gmane$org@amit-x200.redhat.com>
References: <4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
	<4A803E07.7080407@redhat.com> <4A8051F3.7040400@codemonkey.ws>
	<20090814081518.GA7418@amit-x200.redhat.com>
	<4A8566B8.8030808@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8566B8.8030808@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) Aug 14 2009 [08:29:28], Anthony Liguori wrote:
> Amit Shah wrote:
>> On (Mon) Aug 10 2009 [11:59:31], Anthony Liguori wrote:
>>   
>>> However, as I've mentioned repeatedly, the reason I won't merge   
>>> virtio-serial is that it duplicates functionality with 
>>> virtio-console.   If the two are converged, I'm happy to merge it.  
>>> I'm not opposed to  having more functionality.
>>>     
>>
>> The guest code sort-of ends up looking like this after merging
>> virtio_console into virtio_serial. Diff is against virtio_serial in my
>> git tree, but that should be pretty close to the last submission I made
>> at
>>
>> http://patchwork.kernel.org/patch/39335/
>>
>> or the tree at
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/amit/vs-kernel.git
>>
>> I've merged bits from virtio_console.c into virtio_serial.c. If needed,
>> virtio_serial can be renamed to virtio_console. The VIRITIO_ID also
>> needs to change to that of virtio_console's.
>>
>> Similar changes are needed for userspace.
>>
>> Since there's support for only one console as of now, I've assigned port
>> #2 as the console port so that we hook into hvc when a port is found at
>> that location.
>>
>> One issue that crops up for put_chars: a copy of the buffer to be sent
>> has to be made as we don't wait for host to ack the buffer before we
>> move on.
>>
>> The biggest loss so far is Rusty's excellent comments: they will have to
>> be reworked and added for the whole of the new file.
>>
>> Is this approach acceptable?
>>   
>
> I think we want to keep virtio_console.c and definitely continue using  
> the virtio_console id.  It looks like you are still creating character  
> devices as opposed to tty devices.  Is this just an incremental step or  
> are you choosing to not do tty devices for a reason (as if so, what's  
> that reason)?

Just an incremental step. In fact, I haven't yet thought about exposing
a tty device and any problems that might come up. I'll get to doing that
too, of course.

Currently I plan to:
- finish sending connect/disconnect notifications
- finish merge of virtio-console and serial
- look at tty

		Amit
