From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Tue, 04 Sep 2012 19:34:19 +0300
Message-ID: <50462D8B.7040004@redhat.com>
References: <1346325718-11151-1-git-send-email-levinsasha928@gmail.com>
	<1346325718-11151-2-git-send-email-levinsasha928@gmail.com>
	<20120830133820.GC21132@redhat.com> <50408587.5030603@gmail.com>
	<20120831095628.GB24244@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120831095628.GB24244@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Sasha Levin <levinsasha928@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/31/2012 12:56 PM, Michael S. Tsirkin wrote:
> On Fri, Aug 31, 2012 at 11:36:07AM +0200, Sasha Levin wrote:
>> On 08/30/2012 03:38 PM, Michael S. Tsirkin wrote:
>> >> +static unsigned int indirect_alloc_thresh = 16;
>> > Why 16?  Please make is MAX_SG + 1 this makes some sense.
>> 
>> Wouldn't MAX_SG mean we always allocate from the cache? Isn't the memory waste
>> too big in this case?
> 
> Sorry. I really meant MAX_SKB_FRAGS + 1. MAX_SKB_FRAGS is 17 so gets us
> threshold of 18. It is less than the size of an skb+shinfo itself so -
> does it look too big to you? Also why do you think 16 is not too big but
> 18 is?  If there's a reason then I am fine with 16 too but then please
> put it in code comment near where the value is set.
> 
> Yes this means virtio net always allocates from cache
> but this is a good thing, isn't it? Gets us more consistent
> performance.

kmalloc() also goes to a cache.  Is there a measurable difference?

Ugh, there's an ugly loop in __find_general_cachep(), which really wants
to be replaced with fls().

-- 
error compiling committee.c: too many arguments to function
