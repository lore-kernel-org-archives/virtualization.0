From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 09:46:04 +0300
Message-ID: <20090825064604.GB10429__17634.4188316309$1251182887$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A936525.5030300@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 07:14:29AM +0300, Avi Kivity wrote:
> On 08/25/2009 05:22 AM, Anthony Liguori wrote:
>>
>> I think 2.6.32 is pushing it. 
>
> 2.6.32 is pushing it, but we need to push it.
>
>> I think some time is needed to flush out the userspace interface.  In  
>> particular, I don't think Mark's comments have been adequately  
>> addressed.  If a version were merged without GSO support, some  
>> mechanism to do feature detection would be needed in the userspace API. 
>> 
>
> I don't see any point  in merging without gso (unless it beats userspace  
> with gso, which I don't think will happen).  In any case we'll need  
> feature negotiation.
>
>> I think this is likely going to be needed regardless.  I also think  
>> the tap compatibility suggestion would simplify the consumption of  
>> this in userspace.
>
> What about veth pairs?
>
>> I'd like some time to look at get_state/set_state ioctl()s along with  
>> dirty tracking support.  It's a much better model for live migration  
>> IMHO.
>
> My preference is ring proxying.  Not we'll need ring proxying (or at  
> least event proxying) for non-MSI guests.

Exactly, that's what I meant earlier. That's enough, isn't it, Anthony?

>> I think so more thorough benchmarking would be good too.  In  
>> particular, netperf/iperf runs would be nice.
>
> Definitely.
>
> -- 
> I have a truly marvellous patch that fixes the bug which this
> signature is too narrow to contain.
