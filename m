From: Avi Kivity <avi@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 18:57:34 +0300
Message-ID: <4A9409EE.3030906__6145.7302574583$1251216040$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<20090825064604.GB10429@redhat.com>
	<4A93E235.5040008@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A93E235.5040008@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Mark McLoughlin <markmc@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/25/2009 04:08 PM, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>>> My preference is ring proxying.  Not we'll need ring proxying (or 
>>> at  least event proxying) for non-MSI guests.
>>
>> Exactly, that's what I meant earlier. That's enough, isn't it, Anthony?
>
> It is if we have a working implementation that demonstrates the 
> userspace interface is sufficient.  Once it goes into the upstream 
> kernel, we need to have backwards compatibility code in QEMU forever 
> to support that kernel version.

Not at all.  We still have pure userspace support, so if we don't like 
the first two versions of vhost, we can simply not support them.  Of 
course I'm not advocating merging something known bad or untested, just 
pointing out that the cost of an error is not that bad.

-- 
error compiling committee.c: too many arguments to function
