From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Wed, 5 Aug 2009 19:32:04 +0100
Message-ID: <20090805183204.GI3501__28007.1158231751$1249497487$gmane$org@amd.home.annexia.org>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A77410D.4090804@codemonkey.ws>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 03, 2009 at 02:57:01PM -0500, Anthony Liguori wrote:
> Richard W.M. Jones wrote:
>> On Mon, Jul 27, 2009 at 06:44:28PM -0500, Anthony Liguori wrote:
>>   
>>> It really suggests that you need _one_ vmchannel that's exposed to   
>>> userspace with a single userspace daemon that consumes it.
>>>     
>>
>> ... or a more flexible API.  I don't like having fixed /dev/vmch*
>> devices either.
>>   
>
> Have you considered using a usb serial device?  Something attractive  
> about it is that a productid/vendorid can be specified which means that  
> you can use that as a method of enumerating devices.
>
> Hot add/remove is supported automagically.

[ Meant to reply to this two days ago :-( ]

We're using -net channel ^W guestfwd in libguestfs now.  Apart from
the problem with using the "new syntax", which I hope to get around
to resolving some day, it performs quite well.

The userspace API is somewhat annoying.

Hot add/remove isn't a concern for us right now, nor is migration.
Since we can throw up new qemu-based appliances in a few seconds.

Rich.

-- 
Richard Jones, Emerging Technologies, Red Hat  http://et.redhat.com/~rjones
New in Fedora 11: Fedora Windows cross-compiler. Compile Windows
programs, test, and build Windows installers. Over 70 libraries supprt'd
http://fedoraproject.org/wiki/MinGW http://www.annexia.org/fedora_mingw
