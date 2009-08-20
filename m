From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 20 Aug 2009 16:49:47 +0930
Message-ID: <200908201649.48082.rusty__19893.4912602001$1250752846$gmane$org@rustcorp.com.au>
References: <20090810192304.GA16781@redhat.com> <4A808840.70704@codemonkey.ws>
	<20090812173548.GA29981@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090812173548.GA29981@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 13 Aug 2009 03:05:48 am Michael S. Tsirkin wrote:
> On Mon, Aug 10, 2009 at 03:51:12PM -0500, Anthony Liguori wrote:
> > Any rough idea on performance?  Better or worse than userspace?
> 
> Well, I definitely see some gain in latency.
...
> Part of it might be that tx mitigation does not come into play with vhost. I
> need to disable it in qemu and see.

A simple test I've found reasonably indicative when looking at base performance (before stuff like TSO get involved) is to do pings.  Throughput with "ping -s 1024 -l 120 -c 1000000 -f -q" and latency with "ping -c 1000000 -f -q".

(You may need to cut -l down if your ring is too small).

Cheers,
Rusty.
