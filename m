From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 17 Sep 2009 15:06:20 +0200
Message-ID: <87tyz1en5f.fsf__23365.3320618489$1253193062$gmane$org@pike.pond.sub.org>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
	<20090916112332.6bf981a5@linux.intel.com>
	<4AB164A0.8000402@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AB164A0.8000402@codemonkey.ws> (Anthony Liguori's message of
	"Wed\, 16 Sep 2009 17\:20\:16 -0500")
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> writes:

> Alan Cox wrote:
>>> This device is very much a serial port.  I don't see any reason not
>>> to treat it like one.
>>>     
>>
>> Here are a few
>>
>> - You don't need POSIX multi-open semantics, hangup and the like
>>   
>
> We do actually want hangup and a few other of the tty specific ops.  The 
> only thing we really don't want is a baud rate.

And a line discipline, and messing with the controlling terminal, and
group/session ID, and window size, and software flow control, ...

>> - Seek makes sense on some kinds of fixed attributes
>>   
>
> I don't think we're dealing with fixed attributes.  These are streams.  
> Fundamentally, this is a paravirtual uart.  The improvement over a 
> standard uart is that there can be a larger number of ports, ports can 
> have some identification associated with them, and we are not 
> constrained to the emulated hardware interface which doesn't exist on 
> certain platforms (like s390).
[...]

Well, really fundamentally, this is just a reliable full-duplex byte
stream, with connect and hangup notification.  To me, that sounds more
like TCP with an address family almost, but not quite AF_UNIX, but that
case was thrown out of court long ago, so here we are.
