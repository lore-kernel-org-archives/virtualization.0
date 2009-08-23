From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv3 3/4] qemu-kvm: vhost-net implementation
Date: Sun, 23 Aug 2009 12:58:06 +0300
Message-ID: <4A9112AE.4070402__38596.1195141592$1251021545$gmane$org@redhat.com>
References: <cover.1250512448.git.mst@redhat.com>	
	<20090817123724.GD10700@redhat.com>
	<1250791027.3080.130.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1250791027.3080.130.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/20/2009 08:57 PM, Mark McLoughlin wrote:
>    - I think /dev/vhost makes more sense - we shouldn't need to add
>      another character device if we implement kernel backends for other
>      virtio devices
>    

I'm of the opposite opinion - vhost-net and vhost-blk are related, but 
they're a lot more different than they are similar.

>    - I'd really like vhost to support a 'tap' mode, so that we can still
>      use a bridge if a NIC isn't available to be assigned. It would
>      result in this stuff getting much more testing. Options I see:
>
>         1) Add tap-like functionality to vhost
>         2) Add VHOST_NET_SET_TAP
>         3) Just tell people to set up a tap and bind a raw socket too it
>
>       IMHO, (2) makes the most sense - it should be much less exta kernel
>      code than (1), and it would be much more convenient than (3)
>    

What about connecting vhost-net to one end of a veth pair, and 
conencting the other end to a bridge?

>    - Distros will also need some way to have the module loaded if its
>      not built-in; best I can think of in Fedora is to stick it in
>      /etc/sysconfig/modules/kvm.modules
>
>      What would be nicer is if loading the kvm module could cause vhost
>      to be loaded. It's nice that vhost can be used without kvm, but I
>      think if kvm is loaded it's just very convenient to load vhost too.
>      See also the problems we've cause with needing mkinitrd/dracut
>      hacks by not having KVM_GUEST require VIRTIO_PCI
>    

Given that new userspace and a new kernel is needed, I don't see an 
issue with the /etc/sysconfig fix.

>> 2. disable tso, gso, lro, jumbo frames on the card
>>     (disabling lro + jumbo frames should be sufficient,
>>      haven't tested this)
>>      
> And this.
>
> If we leave that up to the user or the management app, we need to expose
> to them what features vhost supports so that they can know in future to
> stop disabling them.
>    

I imagine the merged version will support all those goodies.

-- 
error compiling committee.c: too many arguments to function
