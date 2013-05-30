From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: updated: kvm networking todo wiki
Date: Thu, 30 May 2013 14:53:59 +0930
Message-ID: <87r4gpkplc.fsf__13946.6406930753$1369892088$gmane$org@rustcorp.com.au>
References: <20130523085034.GA16142@redhat.com> <519F35B7.6010408@redhat.com>
	<20130524113542.GA7046@redhat.com> <8738tctrox.fsf@codemonkey.ws>
	<20130524140024.GA12024@redhat.com>
	<87li6yodgq.fsf@rustcorp.com.au> <87k3miq6sw.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3miq6sw.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, herbert@gondor.hengli.com.au
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> writes:
> Rusty Russell <rusty@rustcorp.com.au> writes:
>> On Fri, May 24, 2013 at 08:47:58AM -0500, Anthony Liguori wrote:
>>> FWIW, I think what's more interesting is using vhost-net as a networking
>>> backend with virtio-net in QEMU being what's guest facing.
>>> 
>>> In theory, this gives you the best of both worlds: QEMU acts as a first
>>> line of defense against a malicious guest while still getting the
>>> performance advantages of vhost-net (zero-copy).
>>>
>> It would be an interesting idea if we didn't already have the vhost
>> model where we don't need the userspace bounce.
>
> The model is very interesting for QEMU because then we can use vhost as
> a backend for other types of network adapters (like vmxnet3 or even
> e1000).
>
> It also helps for things like fault tolerance where we need to be able
> to control packet flow within QEMU.

(CC's reduced, context added, Dmitry Fleytman added for vmxnet3 thoughts).

Then I'm really confused as to what this would look like.  A zero copy
sendmsg?  We should be able to implement that today.

On the receive side, what can we do better than readv?  If we need to
return to userspace to tell the guest that we've got a new packet, we
don't win on latency.  We might reduce syscall overhead with a
multi-dimensional readv to read multiple packets at once?

Confused,
Rusty.
