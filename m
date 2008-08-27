From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Virtio File System.
Date: Wed, 27 Aug 2008 11:14:30 -0500
Message-ID: <48B57D66.5030503__39166.5828567513$1219854434$gmane$org@codemonkey.ws>
References: <S1752885AbYH0IaB/20080827083001Z+28@vger.kernel.org>	
	<20080827104423.GA2670@scottrix.co.uk>
	<48B53399.1030809@qumranet.com>
	<a4e6962a0808270619w26f8a8c7g97dfe6d1af72d0e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a4e6962a0808270619w26f8a8c7g97dfe6d1af72d0e1@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: scott.kvm@scottrix.co.uk, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric Van Hensbergen wrote:
> On Wed, Aug 27, 2008 at 5:59 AM, Avi Kivity <avi@qumranet.com> wrote:
>   
>>> I was wondering if anyone had thought about creating a virtio file system,
>>>       
>> There was some work using the plan 9 filesystem protocol over virtio.  Not
>> sure where that stands.  You could base your work off that.
>>
>>     
>
> There is still work ongoing, but its mostly in short bursts.  Its
> operational under Linux, but I have not tested under the most recent
> kernel/kvm combination.  I presented some initial performance studies
> at KVM Forum -- the slides are available:
> http://kvm.qumranet.com/kvmwiki/KvmForum2008
>
> The client code is already in kernel mainstream, there are patches for
> an in-qemu-server, but they have not been merged yet -- I think you
> can find them in the archives on the KVM mailing list.  I'd be happy
> to answer any questions on the code.  There's plenty of room for
> optimizations on both the client and server side, as well as more
> complete support for the full Linux VFS interface.
>
>   
>>> I have started to play with the idea a little myself, but my biggest
>>> problem is that I have no clue how to write filesystem drives in my Guest
>>> OS, Window XP, or even if it is possible to get a Windows FileSystem driver
>>> to talk directly to a PCI device, or if some kind of dummy block device
>>> would be needed.
>>>
>>>       
>
> Windows is a tougher nut to crack here -- there is actually a 9P
> filesystem driver for Windows (that works over TCP/IP) available from
> Rangboom, but the license terms under which it was developed means
> that it is closed source.  I'm not sure if we could entice Rangboom to
> add virtio support to their existing driver....
>   

If someone is enterprising, then 
http://uranus.it.swin.edu.au/~jn/linux/ext2ifs.htm is probably a good 
start as an example of how to build an IFS driver for Windows.

Would probably want to implement extensions to the 9p protocol to 
support this too.  And mapping file system semantics between Windows and 
Unix is hugely complicated.  In all honesty, CIFS over virtio-net is a 
better solution since Samba has already done the hard work of getting 
the details right.

Regards,

Anthony Liguori

>          -eric
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
