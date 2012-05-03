From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: using cache for virtio allocations?
Date: Thu, 3 May 2012 07:51:18 +0200
Message-ID: <CA+1xoqeWJ_nhoZQ+wRdZnB=b=mDFauWJgcjQ3-+ZorJt=bdoAQ@mail.gmail.com>
References: <20120503052943.GF8266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120503052943.GF8266@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 3, 2012 at 7:29 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Sasha, didn't you have a patch to allocate
> things using cache in virtio core?
> What happened to it?
>
> Thanks,
> MST

It got stuck due to several things, and I got sidetracked, sorry. Here
are the outstanding issues:

1. Since now we can allocate a descriptor either using kmalloc or from
the cache, we need a new flag in vring_desc to know how to free it, it
seems a bit too intrusive, and I couldn't thing of a better
alternative.

2. Rusty has pointed out that no one is going to modify the default
value we set, and we don't really have a good default value to put
there (at least, we haven't agreed on a specific value). Also, you
have noted that it should be a per-device value, which complicates
this question further since we probably want a different value for
each device type.

While the first one can be solved easily with a blessing from the
maintainers, the second one will require testing on various platforms,
configurations and devices to select either the best "magic" value, or
the best algorithm to play with threshold.
