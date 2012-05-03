From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: using cache for virtio allocations?
Date: Thu, 3 May 2012 10:32:44 +0300
Message-ID: <20120503073244.GI8266@redhat.com>
References: <20120503052943.GF8266@redhat.com>
	<CA+1xoqeWJ_nhoZQ+wRdZnB=b=mDFauWJgcjQ3-+ZorJt=bdoAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+1xoqeWJ_nhoZQ+wRdZnB=b=mDFauWJgcjQ3-+ZorJt=bdoAQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2012 at 07:51:18AM +0200, Sasha Levin wrote:
> On Thu, May 3, 2012 at 7:29 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Sasha, didn't you have a patch to allocate
> > things using cache in virtio core?
> > What happened to it?
> >
> > Thanks,
> > MST
> 
> It got stuck due to several things, and I got sidetracked, sorry. Here
> are the outstanding issues:
> 
> 1. Since now we can allocate a descriptor either using kmalloc or from
> the cache, we need a new flag in vring_desc to know how to free it, it
> seems a bit too intrusive,
> and I couldn't thing of a better
> alternative.

Since that is guest visible it does not sound great, I agree.

Three ideas:
1. The logic looks at descriptor size so can we just read
   desc.len before free and rerun the same math?
2. For -net the requests are up to max_skb_frags + 2 in size, right?
   Does it make sense to just use cache for net, always?
   That would mean a per device flag.
3. Allocate a bit more and stick extra data before the 1st descriptor.

> 2. Rusty has pointed out that no one is going to modify the default
> value we set, and we don't really have a good default value to put
> there (at least, we haven't agreed on a specific value). Also, you
> have noted that it should be a per-device value, which complicates
> this question further since we probably want a different value for
> each device type.
> 
> While the first one can be solved easily with a blessing from the
> maintainers, the second one will require testing on various platforms,
> configurations and devices to select either the best "magic" value, or
> the best algorithm to play with threshold.

Not sure about platforms but for devices that's right.
But this really only means we only change what we tested.
eg see what is good for net and change net in a way
that others will keep using old code.

-- 
MST
