From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 15 Sep 2009 15:32:38 +0300
Message-ID: <4AAF8966.3040602__23252.8249071494$1253018038$gmane$org@redhat.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com> <20090914164750.GB3745@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090914164750.GB3745@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/14/2009 07:47 PM, Michael S. Tsirkin wrote:
> On Mon, Sep 14, 2009 at 12:08:55PM -0400, Gregory Haskins wrote:
>    
>> For Ira's example, the addresses would represent a physical address on
>> the PCI boards, and would follow any kind of relevant rules for
>> converting a "GPA" to a host accessible address (even if indirectly, via
>> a dma controller).
>>      
> I don't think limiting addresses to PCI physical addresses will work
> well.  From what I rememeber, Ira's x86 can not initiate burst
> transactions on PCI, and it's the ppc that initiates all DMA.
>    

vhost-net would run on the PPC then.

>>>   But we can't let the guest specify physical addresses.
>>>        
>> Agreed.  Neither your proposal nor mine operate this way afaict.
>>      
> But this seems to be what Ira needs.
>    

In Ira's scenario, the "guest" (x86 host) specifies x86 physical 
addresses, and the ppc dmas to them.  It's the virtio model without any 
change.  A normal guest also specifis physical addresses.

-- 
error compiling committee.c: too many arguments to function
