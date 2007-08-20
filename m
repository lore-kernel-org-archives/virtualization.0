From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Mon, 20 Aug 2007 17:12:32 +0300
Message-ID: <46C9A150.60101__19600.3414843746$1187619245$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net><1187313953.6449.70.camel@localhost.localdomain><46C80C5B.7070009@qumranet.com>
	<1187617806.4363.179.camel@ghaskins-t60p.haskins.net>
	<64F9B87B6B770947A9F8391472E032160D4649E2@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E032160D4649E2@ehost011-8.exch011.intermedia.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dor Laor <dor.laor@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
>>>>         2) We either need huge descriptors or some chaining
>>>>         
>> mechanism to
>>     
>>>>         handle scatter-gather.
>>>>
>>>>         
>>> Or, my preference, have a small sglist in the descriptor;
>>>       
>> Define "small" ;)
>>
>> There a certainly patterns that cannot/will-not take advantage of SG
>> (for instance, your typical network rx path), and therefore the sg
>> entries are wasted in some cases.  Since they need to be (IMHO) u64,
>> they suck down at least 8 bytes a piece.  Because of this I elected to
>> use the model of one pointer per descriptor, with an external
>>     
> descriptor
>   
>> for SG.  What are your thoughts on this?
>>     
>
> Using Rusty's code there is no waste.
> Each descriptor has a flag (head|next). Next flag stands for pointer to
> the
> next descriptor with u32 next index. So the waste is 4 bytes.
> Sg descriptors are chained on the same descriptor ring.
>   

Block I/O can easily require 256 sglist entries, eating up your ring.


-- 
error compiling committee.c: too many arguments to function
