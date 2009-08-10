From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Mon, 10 Aug 2009 17:34:31 +0200
Message-ID: <4A803E07.7080407__42489.8700126961$1249919845$gmane$org@redhat.com>
References: <20090805175713.GB28738@shareable.org>	<4A79C8D9.5030606@codemonkey.ws>	<20090806103843.GC9222@amit-x200.redhat.com>	<4A7ADAC4.70902@codemonkey.ws>	<20090806134103.GC11733@amit-x200.redhat.com>	<4A7AE169.4000606@codemonkey.ws>	<20090806140404.GA12083@amit-x200.redhat.com>	<20090806173740.GA1178@shareable.org>	<20090807063800.GA16769@amit-x200.redhat.com>	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A802CA7.9020701@codemonkey.ws>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/09 16:20, Anthony Liguori wrote:
> Gerd Hoffmann wrote:
>> Do we really want design a daemon and a protocol for such a simple thing?
>
> Yes, because we also need (c) the ability to write cross platform
> software that targets vmchannel.
>
> So having a library interface is going to be extremely desirable.

You don't need a daemon for that though.

> Also, see the previous discussion about security. How do you sanely
> delegate /dev/vmchannel/org/qemu/clipboard to the current Xorg user?

pam_console (I think that is the name of the beast).
Or is it handled by hal these days?

The piece of software which does the very same thing already for sound 
and other devices.

>> Especially as requiring a daemon for that adds a few problems you
>> don't have without them. Access control for example: For device nodes
>> you can just use standard unix permissions and acls.
>
> But how do you set those permissions in the first place?

See above.  There are other devices which need that too.  There are 
existing solutions for this problem.

>> You can easily do stuff like adding the logged in desktop user to the
>> /dev/vmchannel/org/qemu/clipboard acl using existing solutions. With a
>> daemon you have to hop through a number of loops to archive the same.
>>
>> Can't we simply have guest apps open "/dev/vmchannel/$protocol" ?
>
> /dev interfaces are only simple to kernel developers :-) Besides, why do
> something that can be clearly done in userspace within the kernel?

Ok, lets rip out the in-kernel ioapic code then.  It can (and has been) 
done in userspace.

> It
> just increases the possibility of kernel bugs.

The daemon increases the possibility of userspace bugs.

Seriously:  Attaching a name tag to virtio-serial devices and have them 
exposed via sysfs is probably *much* less code than a vmchannel daemon.

Also multiplexing over one device introduces a number of problems you 
have to take care of on both sides (qemu+daemon) of the connection.  For 
example:  When the communication stalls in one protocol the others 
should keep on going of course.  With one device per protocol and thus 
one virtqueue per protocol the problem doesn't exist in the first place.

> You can have a /var/run/vmchannel/$protocol.sock unix domain socket and
> it has all the same properties that you describe. It also Just Works
> with standard tools like socat.

bash: socat: command not found

> If we really want
> vmchannel to be used by application developers, then we really need a
> libvmchannel.

We need a sane solution developed and merged and not a new idea each week.

cheers,
   Gerd
