From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 17:02:34 +0300
Message-ID: <20090825140234.GA14129__1157.09703318334$1251209112$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<4A93E1DF.5080004@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A93E1DF.5080004@codemonkey.ws>
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
Cc: Mark McLoughlin <markmc@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 08:06:39AM -0500, Anthony Liguori wrote:
> Avi Kivity wrote:
>>> I think this is likely going to be needed regardless.  I also think  
>>> the tap compatibility suggestion would simplify the consumption of  
>>> this in userspace.
>>
>> What about veth pairs?
>
> Does veth support GSO and checksum offload?

AFAIK, no. But again, improving veth is a separate project :)

>>> I'd like some time to look at get_state/set_state ioctl()s along with 
>>> dirty tracking support.  It's a much better model for live migration  
>>> IMHO.
>>
>> My preference is ring proxying.  Not we'll need ring proxying (or at  
>> least event proxying) for non-MSI guests.
>
> I avoided suggested ring proxying because I didn't want to suggest that  
> merging should be contingent on it.

Happily, the proposed interface supports is.

> Regards,
>
> Anthony Liguori
