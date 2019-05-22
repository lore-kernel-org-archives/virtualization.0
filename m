From: Johannes Berg <johannes@sipsolutions.net>
Subject: custom virt-io support (in user-mode-linux)
Date: Wed, 22 May 2019 15:02:38 +0200
Message-ID: <0952696452f5ff4e38d2417029243fc60efa33d6.camel__24638.3580424421$1558532386$gmane$org@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

While my main interest is mostly in UML right now [1] I've CC'ed the
qemu and virtualization lists because something similar might actually
apply to other types of virtualization.

I'm thinking about adding virt-io support to UML, but the tricky part is
that while I want to use the virt-io basics (because it's a nice
interface from the 'inside'), I don't actually want the stock drivers
that are part of the kernel now (like virtio-net etc.) but rather
something that integrates with wifi (probably building on hwsim).

The 'inside' interfaces aren't really a problem - just have a specific
device ID for this, and then write a normal virtio kernel driver for it.

The 'outside' interfaces are where my thinking breaks down right now.

Looking at lkl, the outside is just all implemented in lkl as code that
gets linked to the library, so in UML terms it'd just be extra 'outside'
code like the timer handling or other netdev stuff we have today.
Looking at qemu, it's of course also implemented there, and then
interfaces with the real network, console abstraction, etc.

However, like I said above, I really need something very custom and not
likely to make it upstream to any project (because what point is that if
you cannot connect to the rest of the environment I'm building), so I'm
thinking that perhaps it should be possible to write an abstract
'outside' that lets you interact with it really from out-of-process?
Perhaps through some kind of shared memory segment? I think that gets
tricky with virt-io doing DMA (I think it does?) though, so that part
would have to be implemented directly and not out-of-process?

But really that's why I'm asking - is there a better way than to just
link the device-side virt-io code into the same binary (be it lkl lib,
uml binary, qemu binary)?

Thanks,
johannes

[1] Actually, I've considered using qemu, but it doesn't have
virtualized time and doesn't seem to support TSC virtualization. I guess
I could remove TSC from the guest CPU and add a virtualized HPET, but
I've yet to convince myself this works - on UML I made virtual time as a
prototype already:
https://patchwork.ozlabs.org/patch/1095814/
(though my real goal isn't to just skip time forward when the host goes
idle, it's to sync with other simulated components)
