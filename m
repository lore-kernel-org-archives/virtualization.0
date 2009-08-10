From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for
	host-guest	communication
Date: Mon, 10 Aug 2009 11:47:54 +0200
Message-ID: <4A7FECCA.8080804__49863.8628669598$1249897834$gmane$org@redhat.com>
References: <20090805175713.GB28738@shareable.org>	<4A79C8D9.5030606@codemonkey.ws>	<20090806103843.GC9222@amit-x200.redhat.com>	<4A7ADAC4.70902@codemonkey.ws>	<20090806134103.GC11733@amit-x200.redhat.com>	<4A7AE169.4000606@codemonkey.ws>	<20090806140404.GA12083@amit-x200.redhat.com>	<20090806173740.GA1178@shareable.org>	<20090807063800.GA16769@amit-x200.redhat.com>	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810065508.GA4499@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/09 08:55, Amit Shah wrote:
>> Bad example.  Quite a lot of modern devices drivers are using dynamic
>> major/minor numbers because they have proven to be such a pain in the
>> butt.  That's why we have more sophisticated mechanisms like udev for
>> userspace to make use of.
>
> Let me explain how we came to this numbering: we first had support for
> 'naming' ports and the names were obtained by userspace programs by an
> ioctl. Rusty suggested to use some numbering scheme where some ports
> could exist at predefined locations so that we wouldn't need the naming
> and the ioctls around it.

I think the naming is very important.  The guest needs to know who is 
listening on the other end of the line.  I think a sysfs attribute (as 
suggested by Jamie IIRC) will work nicely here.  So each device gets a 
property called 'class' or 'protocol' or something simliar named, 
therein a string which specifies the protocol it speaks.


Host side would look like this:

   -virtioserial port=4,protocol=clipboard

... in case the protocol is implemented in qemu or like this:

   -virtioserial port=2,protocol=libguestfs,char=unix:something

... for stuff provided by external apps.


Within the guest the two lines above would create vmch4 and vmch2, both 
having a protocol attribute, and udev then can create symlinks named by 
protocol, i.e.

   /dev/vmchannel/clipboard  symlinked to /dev/vmch4    and
   /dev/vmchannel/libguestfs symlinked to /dev/vmch2

The port=<nr> attribute can be optional and dynamically auto-allocated 
by default.


>> So for instance, I could have an "com.ibm.my-awesome-channel" and never
>> have to worry about conflicts.

reverse fqdn name space is a good idea.  We don't need a central 
protocol name registry then.  The examples above would then become 
something like this:

   protocol=orq.qemu.clipboard    and
   protocol=org.libguestfs.fish

... and within the guest

   /dev/vmchannel/org/qemu/clipboard  and
   /dev/vmchannel/org/libguestfs/fish


> There are some other problems with usb too: It's not transparent to
> users. Any hotplug event could alert users and that's not desired. It's
> a system-only thing and should also remain that way.

I think virtio-serial is the better way to handle vmchannel.  Unlike usb 
virtio is designed to work nicely in a virtual environment.

But vmchannel-over-usbserial should be easy too though in case some 
guests lacks virtio backports or something.  I think you can just stick 
a name like "vmchannel:orq.qemu.clipboard" into the usbserial product 
name, then have udev match that and create
   /dev/vmchannel/org/qemu/clipboard symlinking to /dev/ttyUSB<nr>

Voila, you can switch transports and the apps don't even notice.

cheers,
   Gerd
