From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 14:32:28 +0530
Message-ID: <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180802235332-mutt-send-email-mst@kernel.org>
	<b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
	<20180803220812-mutt-send-email-mst@kernel.org>
	<01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
	<20180805032355-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180805032355-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
>> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
>>>>>> Please go through these patches and review whether this approach broadly
>>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
>>>>>> the patches or the approach in general. Thank you.
>>>>>
>>>>> Jason did some work on profiling this. Unfortunately he reports
>>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
>>>>
>>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
>>>> guest and measure PPS on tap on host.
>>>>
>>>> Thanks
>>>
>>> Could you supply host configuration involved please?
>>
>> I wonder how much of that could be caused by Spectre mitigations
>> blowing up indirect function calls...
>>
>> Cheers,
>> Ben.
> 
> I won't be surprised. If yes I suggested a way to mitigate the overhead.

Did we get better results (lower regression due to indirect calls) with
the suggested mitigation ? Just curious.
