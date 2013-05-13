From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] vhost cleanups and separate module
Date: Mon, 13 May 2013 10:35:01 +0930
Message-ID: <87r4hb3d1e.fsf@rustcorp.com.au>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
	<87sj20prhj.fsf@rustcorp.com.au>
	<20130506091911.GB10601@redhat.com>
	<87zjw7o0vz.fsf@rustcorp.com.au>
	<20130507124433.GD21361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130507124433.GD21361@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, May 07, 2013 at 02:13:44PM +0930, Rusty Russell wrote:
>> AFAICT we should always do zero copy.
>
> It seems not to be a win for small packets.
> I speculate the issue is that ring space isn't released as promptly.
> Further, we can't do it safely for guest to guest and guest to host.
> And if we try, net core just does a packet copy later (which is less
> efficient). So there's a hack in place to detect that and suppress zero
> copy.

AFAICT there are two places we should copy.  One is small packets:
latency plus refcount/callbacks aren't a win.  The other is weird
packets (eg. more than 1000 segements), which we currently drop.

>> Though I do wonder if we should
>> use a dedicated hook to get an skb into the tun driver and generate it
>> ourselves, rather than going sg -> iov -> skb.
>> 
>> Cheers,
>> Rusty.
>
> I think we'd have to export two interfaces:
> - alloc_skb()
>   .... add frags ...
> - send_skb
>
> the code to add frags could maybe use some
> library functions ...

I think we just need send_skb for the socket.  We can build the skb
ourselves.  But yes that frag-handling code should be factored out.

I'll see how I go.

Cheers,
Rusty.
