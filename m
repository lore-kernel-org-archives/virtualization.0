From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2 V4] virtio-spec: dynamic network offloads configuration
Date: Wed, 22 May 2013 08:55:57 +0930
Message-ID: <87sj1fykxm.fsf@rustcorp.com.au>
References: <1365062118-907-1-git-send-email-dmitry@daynix.com>
	<1365062118-907-3-git-send-email-dmitry@daynix.com>
	<519A2897.9020207@redhat.com> <20130520134840.GB12441@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130520134840.GB12441@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Yan Vugenfirer <yan@daynix.com>, Ronen Hod <rhod@redhat.com>, Dmitry Fleytman <dfleytma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Mon, May 20, 2013 at 03:43:51PM +0200, Paolo Bonzini wrote:
>> Is there a story behind skipping virtio-net feature bits 2..4?
>> 
>> Paolo
>
> Bits 3-4 now :)
> I'm curious too.

Not a good one :)

The year is 2007.  virtio_net was the posterchild of free expression and
crazy experimentation.  We were all so very young...

The original host TSO bits in virtio_net were like so:

 #define VIRTIO_NET_F_TSO4      1
 #define VIRTIO_NET_F_UFO       2
 #define VIRTIO_NET_F_TSO4_ECN  3
 #define VIRTIO_NET_F_TSO6      4

But I decided we might as well offer all or nothing, and if you couldn't
handle one, you could just do it in software:

 #define VIRTIO_NET_F_GSO       6

Reading the git commits, it seems Linux didn't do UFO in software (at
the time, at least), so the bits were split out again, with the explicit
_HOST_ in the names:

 #define VIRTIO_NET_F_HOST_TSO4 11      /* Host can handle TSOv4 in. */
 #define VIRTIO_NET_F_HOST_TSO6 12      /* Host can handle TSOv6 in. */
 #define VIRTIO_NET_F_HOST_ECN  13      /* Host can handle TSO[6] w/ ECN in. */
 #define VIRTIO_NET_F_HOST_UFO  14      /* Host can handle UFO in. */

This was all before there was a host implementation, so we were playing.

ie. the bits are perfectly fine for reuse.

Cheers,
Rusty.
